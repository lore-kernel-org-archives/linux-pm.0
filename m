From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] add a printk_init variant storing
	format	strings in	__initdata
Date: Wed, 04 Jun 2008 12:51:08 +0200
Message-ID: <1212576668.14371.21.camel__11180.4138207392$1212576881$gmane$org@johannes.berg>
References: <20080529162257.03426e48.akpm@linux-foundation.org>
	<1212485252.0@pinky>
	<20080604011607.15dec5a7.akpm@linux-foundation.org>
	<1212569949.4042.56.camel@shinybook.infradead.org>
	<1212570622.14371.19.camel@johannes.berg>
	<1212571079.4042.66.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6815213458790666488=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1212571079.4042.66.camel@shinybook.infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz, Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============6815213458790666488==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iiRZEFidDKlbuGPL/ANX"


--=-iiRZEFidDKlbuGPL/ANX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-06-04 at 10:17 +0100, David Woodhouse wrote:
> On Wed, 2008-06-04 at 11:10 +0200, Johannes Berg wrote:
> > On Wed, 2008-06-04 at 09:59 +0100, David Woodhouse wrote:
> > > On Wed, 2008-06-04 at 01:16 -0700, Andrew Morton wrote:
> > > > We're going to want to be able to call printk_init() from modules.=20
> > > > Please fix and test that, if we decide to proceed.
> > >=20
> > > Can we fix that by making it an alias for printk in the module case?
> > >=20
> > > The only reason we need it to be __init is so that we get the section
> > > warnings when you use it from non-init code, right? Won't we get the
> > > warning when non-init code refers to the string in initdata anyway?
> >=20
> > In fact, wasn't the warning Andy showed such a warning?
>=20
> Hm, yes it was. Why do we need __printk_init() to be anything other than
> an alias for printk, then?

It looks to me like we wouldn't need it at all, just the printk_init()
macro that puts the format string into the right section.

johannes

--=-iiRZEFidDKlbuGPL/ANX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASEZzm6Vg1VMiehFYAQLShQ//X4m7jDVmXmXB+kZPS9uC4/iZM9/g34yT
v4FsJ1v+Po+Cydi3dHO7oJvD0k5Y9VZyuYIWo2EjFaxsNSCwm40a1ZgkQf7n3+fx
sHmMrqEoX1UE7/1WUBuGej3zDxVduXmfdw+baGxs/5GFuiqTCcrWOTb4AJ2LasvY
lNnEtvyIb9UW5xlUl6y+B91ze+oOk24euMaUgApxB4/S9bjRTzp1BdlpS5bN1ei6
h2rvUdY63SOGJhgvZd2Gbf73UQAoWbE2VxO1UgGk3eBc90BhRYsJo/1kZc3yEj8G
YA5x8BGWOropweNDBZDTxWK6iDIPGEy+Q3FVC1NpqGNGvIC5qyjuWTiuIYErmuWp
qk1aNGZgTS8Jxd0kvUPerptek2EVIjkqWtuebWMUjITX4vO8JQe3LOvud4ubfGD8
98mhlQruLVTjNcWnZISnyzvZ4F/iu+KoA3BRNVjKgG+O2tluuah9YbXZk03vOf81
bAgo0bV8KBO1/CJBXWUptya+VrnPQLJBAKUrfyAzGPzhbvAsNDmlNthmWKXem2je
H8hi/gyhj30MntZ8aR70N0IuDV2MCkq7bc4Vw4NeUEc1TqEFao5w1IgdeDtYUfDf
2wKgFsjSCDTkel8r/xzecO79RyFpN/kXfezUroOvk+Vk9Oymu6c6Cop6aCmH2lOe
pexxYjz7d5E=
=uyc0
-----END PGP SIGNATURE-----

--=-iiRZEFidDKlbuGPL/ANX--


--===============6815213458790666488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6815213458790666488==--
