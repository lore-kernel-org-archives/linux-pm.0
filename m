From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC][PATCH 2/5] driver core: Functional dependencies tracking
 support
Date: Wed, 8 Jun 2016 19:35:35 +0100
Message-ID: <20160608183535.GP7510@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <2576341.476ZsjkPgF@vostro.rjw.lan>
 <1816598.SuJvGrVRJK@vostro.rjw.lan>
 <20160608124844.GH7510@sirena.org.uk>
 <CAJZ5v0ipDXrgx3=cFuxzofkXLMzErETuqSSnf8ugo5jnB0ynNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OxpYUbrsx40GOZXC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ipDXrgx3=cFuxzofkXLMzErETuqSSnf8ugo5jnB0ynNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org


--OxpYUbrsx40GOZXC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 08, 2016 at 08:12:34PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 8, 2016 at 2:48 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Jan 14, 2016 at 02:54:17AM +0100, Rafael J. Wysocki wrote:

> >> + * A side effect of the link creation is re-ordering of dpm_list and the
> >> + * devices_kset list by moving the consumer device and all devices depending
> >> + * on it to the ends of those lists.

> > How does this work in the scenario where a device instantiates a child
> > device then uses services that child provides to complete the
> > initializiation?  We do have that scenario currently for on chip
> > regulators to allow external regulators to be used.

> I'm not sure I understand the question correctly, but it that is the
> parent and a child, we don't need an extra link entity to represent
> that dependency, as parent-child dependencies are taken by the current
> code into account already.

A parent (especially a MFD) may create a child to fulfil a role that
could also be filled by a non-parent device, if that happens then
depending on what ends up creating these links (it's not 100% clear from
this series) it's likely that the link creation will also end up
registering a dependency unless we do something special.  Now I think
about it this does depend on how we create the children though, it's
less likely to be an issue if the dependencies are created by firmware
code.

--OxpYUbrsx40GOZXC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWGV2AAoJECTWi3JdVIfQ5wUH/j/HXaPAE8yz+ZWWW7k/yi9H
j7h0zWSYNVW9PDqSduBBsMOWoFKVDVk9B5QeymlMqQL3cbPQEa8pBJJ53la/TPTf
M1MocnlOmjkZEPLlRH7KqtsO7thhi+O2fsmizjmPk8RFufw1ttauOfdJA7NBrnk/
iLdlBsz1AkkQsAGQPbDZiVN9tIgdgl9CtYVJ7+DzzM0fTboQsN3DvYKUJ0s+TEDQ
OWSNNU9A/CDP82PTHVvyHF8hGBecoyYtyzwbcFEJ/1MkEb+HBNvsPoQ3rGGdb94F
5eABxpmxYS4OLRQ0OeCNoKI2WM0OYtAYUY49KEvAFWRX8wsrpvzlkdBGnTFAFvc=
=IrZy
-----END PGP SIGNATURE-----

--OxpYUbrsx40GOZXC--
