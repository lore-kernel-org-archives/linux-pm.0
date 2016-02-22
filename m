From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: Thermal governors non-modularity
Date: Mon, 22 Feb 2016 10:56:57 -0800
Message-ID: <20160222185655.GA18736@localhost.localdomain>
References: <20160220140448.19b749dd@endymion>
 <744357E9AAD1214791ACBA4B0B9092633A963443@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33283 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbcBVS46 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 13:56:58 -0500
Received: by mail-pf0-f172.google.com with SMTP id q63so97012545pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2016 10:56:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092633A963443@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Jean Delvare <jdelvare@suse.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

On Mon, Feb 22, 2016 at 07:06:17AM +0000, Zhang, Rui wrote:
> I tried to use them as module in the first place, but failed for some rea=
son. I cannot recall the root cause, but I will try to check this and reply=
 to you later. :)
>=20

Yeah, there was bug in the boot sequencing that would leave fans on all
the time. Then you decided to make everything builtin:
http://marc.info/?l=3Dlinux-kernel&m=3D136085598604095&w=3D2



> Thanks,
> rui
>=20
> > -----Original Message-----
> > From: Jean Delvare [mailto:jdelvare@suse.de]
> > Sent: Saturday, February 20, 2016 9:05 PM
> > To: linux-pm@vger.kernel.org
> > Cc: Zhang, Rui <rui.zhang@intel.com>; Eduardo Valentin
> > <edubezval@gmail.com>
> > Subject: Thermal governors non-modularity
> > Importance: High
> >=20
> > Hi Rui, Eduardo,
> >=20
> > Is there any fundamental reason why thermal governors can't be built as
> > modules? We have more and more of them, 5 now, and the most recent is
> > fairly big... Would be much more practical if they could be built as mo=
dules
> > and loaded at run-time only as needed.

I agree here. We just to make sure we don't regress here.

BR,

> >=20
> > Thanks,
> > --
> > Jean Delvare
> > SUSE L3 Support

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWy1nzAAoJEMLUO4d9pOJWj6kH+gIRHM/tG1D2bHq6s/70DcLW
yYnrFDWIgIXu0give++0vXra6/rEcPtt2X8H92DYjjDddxR/Yu72qgJFeHeC4gtO
NJ6Mr8Q7x3MULkCMzX7wvQXX32A/Eqh8HkY6XY0H42NrrG3QpR5jSkVa+mLbdNZy
2KDbvdEt9D8cNlPieUCinn/T9Hsen1oqZdfiPqTpw4MglkvSfOPqwTAsqVVk3+8c
6fnLAx7V070dQJCGcczEj/yQXhoBs+RGjsg2449+PB4YFAQjk0C9AFat7yDifGeW
CqfAkYoQcB1mpMu5CtpU1MdzyyFfBt26qR7l0L5nsw0SWWJ5s8a9LlqBwWAUV24=
=sGIP
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
