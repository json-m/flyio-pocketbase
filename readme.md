### flyio-pocketbase

want to host [Pocketbase](https://pocketbase.io/) for free? this repo serves as a template to do so, using [Fly.io free tier](https://fly.io/docs/about/pricing/).

dockerfile compiles pocketbase in alpine build image so this runs under musl.

recommend reviewing https://fly.io/docs/languages-and-frameworks/dockerfile/

create free 3GB volume for data:

`flyctl volumes create zjpocketbase --region dfw --size 3`

this image is automatically mounted at `/opt/pocketbase/pb_data`

assign a v4+v6 address to your app:
`flyctl ips allocate-v4`
`flyctl ips allocate-v6`

then go create a certificate. lastly, `flyctl deploy` to go live.

i'll eventually create a proper how-to if anyone really cares/needs help. make sure you adjust fly.toml and any other names here to your own preferences.

