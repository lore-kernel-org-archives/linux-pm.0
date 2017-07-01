From: =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: ondemand + p-state useful ?
Date: Sat, 1 Jul 2017 11:59:56 +0200
Message-ID: <77b02581-5620-a773-ba13-8eec217497a3@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gUsBIa49dWDxLI2l9EFqs71N9igVAsDCv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:55533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdGAKAL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Jul 2017 06:00:11 -0400
Received: from [192.168.178.24] ([78.54.161.103]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfVzj-1d6Xgl1baN-00P7av for
 <linux-pm@vger.kernel.org>; Sat, 01 Jul 2017 12:00:04 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gUsBIa49dWDxLI2l9EFqs71N9igVAsDCv
Content-Type: multipart/mixed; boundary="CtxcNcTQK1dh4MUhNLcTUxEUsXWKL68I9";
 protected-headers="v1"
From: =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
To: Linux PM list <linux-pm@vger.kernel.org>
Message-ID: <77b02581-5620-a773-ba13-8eec217497a3@gmx.de>
Subject: ondemand + p-state useful ?

--CtxcNcTQK1dh4MUhNLcTUxEUsXWKL68I9
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

I had few discussion with guys whether at an i5 (desktop) or an i7 (serve=
r) respectively it makes sense to have these defines

CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_X86_INTEL_PSTATE=3Dy

I was told that ondemand doesn't rules and performance is used, if pstate=
 is choosen.

But OTOH I see differences  when I run powertop or similar tools.
Especially the i5 has often a much lower frequency (800 MHz versus 1800 M=
Hz) when booting a kernel with ondemand+pstate instead of performance+pst=
ate.

May I asked here for an advice ?

--=20
Toralf
PGP C4EACDDE 0076E94E


--CtxcNcTQK1dh4MUhNLcTUxEUsXWKL68I9--

--gUsBIa49dWDxLI2l9EFqs71N9igVAsDCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iI0EAREIADUWIQQaN2+ZSp0CbxPiTc/E6s3eAHbpTgUCWVdyoxccdG9yYWxmLmZv
ZXJzdGVyQGdteC5kZQAKCRDE6s3eAHbpTsIwAP4ob0WgiQSAXcPF4ZW3GuC4Ots8
tSLzQTe6dZk2ExQbtwD+IjLwioB4fttiCmABPUVwafYsvbHdBV2I70i/oTyj9yM=
=GlTZ
-----END PGP SIGNATURE-----

--gUsBIa49dWDxLI2l9EFqs71N9igVAsDCv--
