From: Thierry Reding <treding@nvidia.com>
Subject: Re: [RFD] Functional dependencies between devices
Date: Mon, 9 Nov 2015 13:32:04 +0100
Message-ID: <20151109123202.GC23941@ulmo.nvidia.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12557 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbKIMcO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2015 07:32:14 -0500
In-Reply-To: <1623682.7KVblAB3KQ@vostro.rjw.lan>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2015 at 04:24:14PM +0100, Rafael J. Wysocki wrote:
[...]
> There's a question about what if the supplier device is being unbound before
> the consumer one (for example, as a result of a hotplug event).  My current
> view on that is that the consumer needs to be force-unbound in that case too,
> but I guess I may be persuaded otherwise given sufficiently convincing
> arguments.

I think this would be a huge step towards making the kernel more robust
with little driver or subsystem code having to be duplicated. Currently
most provider/consumer subsystems are fragile in that there isn't proper
reference counting. Many subsystems will happily allow you to remove any
of the provider, regardless of whether or not it has consumers. Most of
the subsystems will make sure that modules can't be unloaded, but beyond
that won't be able to prevent drivers from being unbound (either when a
device is unplugged or unbound via sysfs). Even with proper reference
counting there is no easy way to deal with devices going away (you'd
need some sort of revoke semantics implemented for all providers, and
consumers must be able to handle that situation gracefully).

Implementing a force-unbind policy would make this a whole lot easier.
Dangling resources will automatically become a thing of the past. The
downside of course is that force-unbinding consumers may not always be
the most user-friendly course of action. Consider an SD/MMC slot that
uses a GPIO as card-detect pin. Unbinding the provider of the GPIO
would cause the SD/ MMC controller to be unbound, hence unmounting the
filesystem that it provided. That filesystem might have been the root
filesystem.

We discussed similar use-cases a while back and you proposed making the
force-unbind policy be two-staged: reject unbind (-EBUSY) if there are
any consumers, and force-unbind consumers if the provider was forcibly
unbound (or caused by hot-unplug of the backing device). That sounds
like a good compromise to me.

That said I can also imagine subsystems where a reliable mechanism is in
place to properly hotplug and -unplug providers. The good thing about
the functional dependencies mechanism you propose here is that it's an
optional mechanism that drivers use from ->probe(). Subsystems where a
better mechanism exists can simply choose to do without functional
dependencies.

Thierry

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWQJI4AAoJEN0jrNd/PrOhBswP/iBrNEri0doqa2JHW0LQuQ8j
JvDUgL8PcamaS0UX9vzrGHd1+6+Zy+p/gbpjTlbk2kNVU3oKRJArCS7SJTjRWiAS
ykTbYjMkewBrtBNpIpw2uVj+4Gqgt4jA0oar03Np2xKMWTiuOxWMZ/9qVxwAy4oa
dbEclL0fJ7Op8bEY2NKW+sLE6HJ75Hf0ci7qHUYPrbK1Z1P4FMQlewXj2U75ED54
9pTLK7PKBHHwNAQ+f80p4tNjZq3qzwGWZfmaIY0IZL0Ca5H0dpHlr90Y2u0zn/D9
sGhHE7Pfl282o5M4hb6E8H/fc1XFnttJ4MtnjBLqEsPaQwn+jC+34a0s5vNQ3D0O
q+gcPhV6OXca/65rvqcJen9MGyavyNvcZmXRnhnied1EwAlAdjdT7XEwJZqBwVhE
QxxUNMTxsuRX428L8cLnsZfGGtmbSwyIP6Yunc6kB3qimSv1vl5FZTUPfs2Jl9Nj
9gbIZZbeR1ZsYSLyWTmA7PDzWO6K3bzT3gn1PX1XoBafQIY54qRCfs/wjzimBl/T
xZT63/OP/G7WtbGQPgJc3tgII+IZGnTuxl+YbmN95MNlOKwXEmf6LBqeMPpKkak/
3nuBUFdCmLotsMpvdBa5p0ScYcoC4uAVjapeKl8mqIGaxK7JIZaKc0DGu8/0+evS
HGa4dk9MHErl9ifLcuCf
=GNRM
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
