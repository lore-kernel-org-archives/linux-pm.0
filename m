From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 3/3] platform/wmi: Expose the raw WDG data in sysfs
Date: Sun, 6 Aug 2017 23:36:24 +0200
Message-ID: <201708062336.25403@pali>
References: <cover.1501601667.git.luto@kernel.org> <20170802074903.GO25574@pali> <CALCETrVHGtA7nRaBCy9ZZ48Xu8hTKBgLdoGZeEHnHhPg3tdsxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8084597.pegFpD3WKC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33860 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdHFVg3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Aug 2017 17:36:29 -0400
In-Reply-To: <CALCETrVHGtA7nRaBCy9ZZ48Xu8hTKBgLdoGZeEHnHhPg3tdsxQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>

--nextPart8084597.pegFpD3WKC
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 04 August 2017 17:03:07 Andy Lutomirski wrote:
> On Wed, Aug 2, 2017 at 12:49 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> wrote:
> > On Tuesday 01 August 2017 19:22:32 Darren Hart wrote:
> >> Pali, how does the "magic number identifier" in the BMOF map to
> >> the object_id? Have we retained that information in what we
> >> export today?
> >=20
> > MOF describe C++ like object system and for particular structures
> > or methods there is GUID and WMI id.
> >=20
> > When you want to call WMI function implemented in ACPI you need to
> > know: * name of ACPI function
> > * instance number
> > * WMI id
> > * structure of input buffer
> >=20
> > Name of ACPI function is taken from _WDG where is mapping from GUID
> > to object_id and ACPI function consist of well-known prefix and
> > object_id as a suffix. GUID is present in MOF. Where to get
> > correct instance number is still question for me. WMI id and
> > structure of input buffer is described in MOF.
>=20
> I assume that any user API for making WMI calls will have userspace
> pass in either the GUID or maybe the MOF method name, not the object
> id.

So... When calling WMI method of some class it is really needed to
supply also instance id. On Windows caller needs to specify Instance
Name, e.g. ACPI\PNP0C14\0_0 which looks like correspondent to instance
id 0. ACPI\PNP0C14\0_2 is then to instance id 2.

Toshiba has triple (class, method, instance) in their BIOS WMI
documentation [1].

Therefore userspace would need to know instance count which is stored in
_WDG for doing WMI call.

Is there already exported instance count via sysfs?

[1] - https://aps2.toshiba-tro.de/kb0/TSB3803HR0000R01_TOSHIBA_BIOS_WMI_Int=
erface_Guide_-_13_Rev_1.1.pdf

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart8084597.pegFpD3WKC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlmHi9kACgkQi/DJPQPkQ1JQBwCfd21QUoHDRIrELrGgL55UoEB0
4EsAoJY+AiYjeh3P2wAUziX47dIMms2i
=+/wn
-----END PGP SIGNATURE-----

--nextPart8084597.pegFpD3WKC--
