From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: proper RuntimePM for the adapter device
Date: Thu, 24 Dec 2015 09:41:06 +0100
Message-ID: <20151224084105.GA1548@katana>
References: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
 <CAKfKVtHt8BpakkffRp=_2GUxqK5JO0WCsizCrjtwH5hv+TWvWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfKVtHt8BpakkffRp=_2GUxqK5JO0WCsizCrjtwH5hv+TWvWg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > RuntimePM for the logical adapter device should be handled in a central=
 place
> > by the core, and not by drivers. This series does exactly that.
>=20
> This is good idea.

Thanks!

> Also maybe we can add a flag that the driver enables.
> that way for a short period till the driver removes the call
> the double call is not there.

The only driver I found was the s3c2410 and I fixed it. Is there another
one? Then, I'd update my series because I want a consistent state in one
go.


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWe6+hAAoJEBQN5MwUoCm2WoEP/39mpSOXPE8EUvE5e2ac3SQK
PLmwn5EB6X+WUuMFTH9879xLI9XEfzoxzXIL9UqRshnd/ZCqUEoxBhXhr+oe+9Ha
02O1xZG9taTqhUESZVS50ItyC+9eerT2r0AG2EUrinzlblo0E/hfrzfIFMROWN4f
XwhU/kThu85h1ZHy7tRj01LZhxi7DyiMNt0kaRHu+/Dgruv4vzy8Ft82OLz4Nv1m
uBw8k4TBcuhGnYGC+IA1hbcwC0me/mU+xx/OwQlzHyn8m7/Dkr2xOLW5ov0GrZSF
p0pfDWIKf0APRl2j5aBxuI6MqfZYBDS4WEc6jGcG7jfEtVywuSPSyAKtPek/3b+b
B1TqepkYLzvomRoQzM8GLE1sMbGmH8rgcLxg2FBdtM8jXSkf4uXPGBx23gmrzAXE
FIgslggCixRW58+nZt8OTctls5jJK7wyjK7tg0163ujgik7yefj0Nooc0U8U9PZu
3to6fjw9DI0auUhIx0h7qPF+6resmloRAITzGy4FtYxgpMb/+k/yoR9trkwEIA4w
cBX+MZeVUJR8xo8hGzbLzBBd2+PCCcnOvnCKHbiRn8hOBaSdUQ/9lIhssEL1CjLW
DbIlUhBnMMedauV0kJGlBAsxo63TZ0jxegTQh3UyQ8NK5hTiBurlwPS+dVtr/tjr
RZJU+LQJ75oYpdiIECkl
=qGZ+
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
