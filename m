Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7F2D47FF;
	Sat, 25 Jul 2026 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784938589; cv=pass; b=C07WQt4CF8hJJSAFsHxIwX4GLLQag9e9h+PXxIE0RzMMKT8C5I1k+REHKrWPX29Uw0aaWW+l1HpmatCntzrPEQUZQNE1GRBBmndnBw68ar4X9T7J7IWlbgPyS2wtAlHAgnre7Ha71qOjGm8LdEc13o7681qW4X1xbqTvyfzgjBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784938589; c=relaxed/simple;
	bh=XlnKVS//oDlsYtlTRhro6CtfzCZpPqbUyd5804LoMs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCVocAKyEmHnOL/+cHN1+bYXzr1k4KTFMetMtNHs9v9ERfYGHFlXk1iaIML3ypNG+hvTCD7VmG0pj3FP1UfNJ8jJIkT6np54hWoHtURTDwUKbDoyHRiok3PjNZUGBI29W/Uu7K0QFko81xYNaysmLXJ1OQG2Z9poTFZtwWd510Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=LKeGy6O+; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="LKeGy6O+"
ARC-Seal: i=1; a=rsa-sha256; t=1784938584; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A36JYfq4Xuk8AikDp4IJSDCAAYP5ssoC6+NRctI2mfj2K+VsoihVpkz4wH8pXna28pJAz8t76nGzrfXZSOStku3RQUyQ4ABZNtp6PPcv1NThU0XJnG8ydmIjM8E4SChGTKf+SHrVp7X5SwvOxTw2UCfcAu9jX8igy73rb4Spk6Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784938584; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xc+PH9PDtzEbyX3uIqARi++5QKHh5/elGkAzbvdy5DY=; 
	b=YK//sNwRtnc97pGhhkWswbfClRYOfaQdDherqp3YnCINVguIej+KOcxOqqr5fvWhPXg9GoMyKGniJaGbAAvu7MoVi0XYhM3J4fIfSq7YeksxDL6QXCfgfC8Qo/flTuj7EbNEv/iocyffsvY5wrtEkEgH0OZO9RyLOlbU8l3U4sw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784938584;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=xc+PH9PDtzEbyX3uIqARi++5QKHh5/elGkAzbvdy5DY=;
	b=LKeGy6O+3fBVJK+2DC6wLdNgI92V6j7sgZB8pYWzErVUue4Dsvk5H8rbnFIaFcBc
	g0Sel9eRyTg8ffv0CD2D2Hjp8T1ycPdUJ54+qJU8jtkWv5MdLA7gdHVKmmA/SIyjhRK
	yX6B6O9fX7rP86AMeKbOLyk1Mw7irhrIXiS1tbtI=
Received: by mx.zohomail.com with SMTPS id 1784938583470100.46801881263741;
	Fri, 24 Jul 2026 17:16:23 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 16C59181F16; Sat, 25 Jul 2026 02:16:21 +0200 (CEST)
Date: Sat, 25 Jul 2026 02:16:20 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: twl4030_charger: worker not cancelled on remove?
Message-ID: <amP-R95JDCAznCza@venus>
References: <20260702172128.2001753-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vizejdug7hgrgkgw"
Content-Disposition: inline
In-Reply-To: <20260702172128.2001753-1-maoyixie.tju@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.919.37
X-ZohoMailClient: External


--vizejdug7hgrgkgw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: twl4030_charger: worker not cancelled on remove?
MIME-Version: 1.0

Hello Maoyi,

On Fri, Jul 03, 2026 at 01:21:28AM +0800, Maoyi Xie wrote:
> twl4030_charger looks like it has the worker race on remove that bq25890
> fixed (commit 7e6fb67808ab). I would appreciate it if you could take a lo=
ok.
>=20
> The driver data is allocated with devm in probe:
>=20
> 	bci =3D devm_kzalloc(&pdev->dev, sizeof(*bci), GFP_KERNEL);
>=20
> It has two workers that both dereference bci:
>=20
> 	INIT_WORK(&bci->work, twl4030_bci_usb_work);
> 	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
>=20
> twl4030_bci_remove() disables charging and masks interrupts. It cancels
> neither worker. A worker still pending at remove runs after devm frees bc=
i,
> so it touches freed memory.
>=20
> bq25890 fixed the same shape by unregistering the USB notifier, then
> cancel_work_sync() on remove. twl4030 is different. Its notifier comes fr=
om
> devm_usb_get_phy_by_node(), so devm unregisters it after remove() returns.
> A plain cancel in remove() could then still race a reschedule. So a single
> cancel in remove() is not enough.
>=20
> current_worker does not depend on the notifier. It reschedules itself, so=
 it
> needs cancel_delayed_work_sync regardless.
>=20
> Does this look like a real bug? If it does, I am happy to send a patch. I=
 am
> not sure of the best shape here. One option is to move the phy off devm a=
nd
> mirror bq25890. Another is to coordinate the cancel differently. What wou=
ld
> you prefer?
>=20
> I do not have the hardware. The use-after-free is from a KASAN harness. It
> runs the worker after the bci free.

The proper fix is to use devm_delayed_work_autocancel() instead
of INIT_DELAYED_WORK() and devm_work_autocancel() instead of
INIT_WORK(), so that everything happens at the right time.

Greetings,

-- Sebastian

--vizejdug7hgrgkgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpkAFAACgkQ2O7X88g7
+ppq5A/9GSYARwF28QWmYIfkKE88qjoT9Sap45Ib1I2HaCf8p37rElH4YEA+dQpt
R8uPSdhV4U7w+X5Mbv/CaRkULFixCyi63r1Y7pBnh4k9UWJ6P9xn7qQuUzYndYp+
bYCWGpbiUXfOwTlp6B2eoCXJz5IeckLJz9+DfNWzztuMrGt6A5wyXeq0gEJho7Hf
OGFyrSywheJxvJtI0Utdf4iBA3WfHqe9penA1cgNE7PTg3x78NA7T7xsKFYbdgEr
BgqwH3nXjr+hq7hCwmw7iWGcuZCEfNRsWC8F1Eyyz1GlCaj0dqyqvmGT+YWAiOJh
ir5oZDWSY7Tb6RYeH0Mu1DFC8ljI5EZKtJKzl4JGR0Zp82mehj1yD61AqWY+27Xh
g1wDSnlli68OJ9VHo0MRioppjj20L8+VpQtZGrlHHS4b1n99OoV3paBq9/lfME+C
0V4umvyY5lqzTj9RHT/346P9QTOLhtuHIZbXIrNCzpw+YnMklI8ITbThH4KLypsU
C5MwsvJygI0sJzTWxebKo5tK0hse+CBvP0UrjIuJ2DendXj9zccLBCwqiuvqDbvZ
VdZb6NZemtfbiUPPBHhu483bMXJSVIubCMfKaILpkg6LNcUqF/arwvufdW0uUxuB
HDQVbX88xn0UpaVHSsB7CUD6uD3pySJLD6YAGAKHklRK0p81jCg=
=V3cu
-----END PGP SIGNATURE-----

--vizejdug7hgrgkgw--
