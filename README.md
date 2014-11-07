# toxiproxy-ruby

[Toxiproxy](https://github.com/shopify/toxiproxy) is a proxy to simulate network
and system conditions. The Ruby API aims to make it simple to write tests that
assure your application behaves appropriate under harsh conditions. Please see
the Toxiproxy project for more details.

```
gem install toxiproxy
```

Make sure the Toxiproxy server is already running.

## Usage

For example, to simulate 1000ms latency on a database server you can use the
`latency` toxic with the `latency` argument (see the Toxiproxy project for a
list of all toxics):

```ruby
Toxiproxy[:mysql_master].downstream(:latency, latency: 1000) do
  Shop.first # this took at least 1s
end
```

You can also take an endpoint down for the duration of a block at the TCP level:

```ruby
Toxiproxy[:mysql_master].down do
  Shop.first # this'll raise
end
```

If you want to simulate all your Redis instances being down:

```ruby
Toxiproxy[/redis/].down do
  # any redis call will fail
end
```

If you want to simulate that your cache server is slow at incoming network
(upstream), but fast at outgoing (downstream), you can apply a toxic to just the
upstream:

```ruby
Toxiproxy[:cache].upstream(:latency, latency: 1000) do
  Cache.get(:omg) # will take at least a second
end
```
