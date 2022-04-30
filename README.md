# website-gemini

This is a tiny low bandwidth site designed for [gemini](https://gemini.circumlunar.space) users.

## Scope

Today this website represents the "bare minimum" information from haiku-os.org and tries to link directly to important content directly.
Unfortunately, given the realities of the world we live in, most of the links go to (non-gemini) https endpoints.

The goal is to link directly to content at http though so users can navigate to the "important bits" via gemini.

## Usage

Start the container. It has everything it needs in it to serve the Gemini site (including the site)

## TODO

## Documentation

I'd like to see more of our documentation converted from Sphinx, Doxygen into native gemdoc so users could have
a rapid, low bandwidth copy of our api docs... however the tooling today is pretty weak to go from Sphinx + Doxygen to markdown to gemdoc

## TLS

We need to "borrow" the tls certificates for haiku-os.org somehow. These exist at netlify today so that's tricky.
