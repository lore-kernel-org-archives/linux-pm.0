Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59E3B8BC1
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356617; cv=none; b=TQs0gF1mf91Cva1XdNHkRfxv8YdiMCDY0z088sTzc3NCy3ioQRm1kYZwiXOdfNa4aXjrnlp6ntLGK07J4ayQcmeo2QwCvYDBlf6hjnRYwxzBTAYBUEyVT5kWBPtTIC6BHAZp2AdiySpRmsx7+U1dT+o8pba92d5tkXZxnofg+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356617; c=relaxed/simple;
	bh=ILTbhnV0RE8RxOqIaE3kIzQ4OPPAAIXIWP/eta1gc6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6kCOlwhNWpLQ5aYDGEkymIoULOWoXhlP0D8rVPJIuP60PqYZcpRQ8md8oMlm/DRhJg+isJQV7WJoeG+x66BT6s5y5iHGhH5FU3ghFSTOp1OsxdOMnv/Vdp6tk0/d8aD5Yz16WK+OIYDpc37AJjzeuMkULR+IdD2hOsEI4tRbgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mGTGi/dk; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mGTGi/dk"
Date: Mon, 10 Aug 2026 13:10:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786356613; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=DobonkKHbQh/ClkaZTujCkwfTDOpOzdUyok3g0FEPkk=;
	b=mGTGi/dkVMdLFqf7XTJ4YzCoxtr4WzQK3a99VR1goyWhit8hGBGG8dHLxQagLpPiersLh6
	DlObVrmdZQxg90ec5kP3N+ZUnrRvbwWWF5wU5H9TgcIj9C8re9dIFHKH6oQzaU5FhEtYuR
	ZsU2n7u9Kp2mjw0alA8S2oZZUU0GlPM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>,
	Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
	Markus Laine <markus.laine@fi.rohmeurope.com>
Subject: [PATCH 5/5] power: supply: bd99954: Drop bad register fields
Message-ID: <758fd430d02286a6f18603a8aecfe443f5ddeb8e.1786356145.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FDgWYpcmi0JC+/L6"
Content-Disposition: inline
In-Reply-To: <cover.1786356145.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--FDgWYpcmi0JC+/L6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The bd99954 driver creates regmap fields for all the registers. All the
fields for VBUS_UCD_FCTRL_SET (extended command 0x33) are accidentally
created for VCC_UCD_FCTRL_SET (extended command 0x2b), causing all
reads/writes for the fields to access wrong register. Luckily the fields
for VBUS_UCD_FCTRL_SET are unused.

Taking a look at the data-sheet:
https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/battery_mana=
gement/bd99954xxx-e.pdf

all the fields in the VBUS_UCD_FCTRL_SET are marked as:
"In normal operation, please don=E2=80=99t set these registers" with not mu=
ch of
additional documentation. As the fields are wrong and because there seems
to be no users of the fields - it is better to just drop them. This will
also decrease the memory footprint.

Drop incorrect VBUS_UCD_FCTRL_SET fields.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 0902f8366491 ("power: supply: Support ROHM bd99954 charger")
---
 drivers/power/supply/bd99954-charger.h | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/power/supply/bd99954-charger.h b/drivers/power/supply/=
bd99954-charger.h
index f58897925383..d053ac901274 100644
--- a/drivers/power/supply/bd99954-charger.h
+++ b/drivers/power/supply/bd99954-charger.h
@@ -279,17 +279,7 @@ enum bd9995x_fields {
 	F_VBUS_EXTID,
 	F_VBUS_IDRDET,
 	F_VBUS_INDO,
-	F_VBUS_UCDSWEN,
-	F_VBUS_RREF_EN,
-	F_VBUS_DPPU_EN,
-	F_VBUS_DPREF_EN,
-	F_VBUS_DMREF_EN,
-	F_VBUS_DPDET_EN,
-	F_VBUS_DMDET_EN,
-	F_VBUS_DPSINK_EN,
-	F_VBUS_DMSINK_EN,
-	F_VBUS_DP_BUFF_EN,
-	F_VBUS_DM_BUFF_EN,
+
 	F_VBUS_EXTCLKENBL,
 	F_VBUS_PLSTESTEN,
 	F_VBUS_UCDSWEN_TSTENB,
@@ -626,17 +616,6 @@ static const struct reg_field bd9995x_reg_fields[] =3D=
 {
 	    [F_VBUS_EXTID] =3D REG_FIELD(VBUS_IDD_STATUS, 5, 5),
 	    [F_VBUS_IDRDET] =3D REG_FIELD(VBUS_IDD_STATUS, 4, 4),
 	    [F_VBUS_INDO] =3D REG_FIELD(VBUS_IDD_STATUS, 0, 3),
-	    [F_VBUS_UCDSWEN] =3D REG_FIELD(VCC_UCD_FCTRL_SET, 10, 10),
-	    [F_VBUS_RREF_EN] =3D REG_FIELD(VCC_UCD_FCTRL_SET, 9, 9),
-	    [F_VBUS_DPPU_EN] =3D REG_FIELD(VCC_UCD_FCTRL_SET, 8, 8),
-	    [F_VBUS_DPREF_EN] =3D REG_FIELD(VCC_UCD_FCTRL_SET, 7, 7),
-	    [F_VBUS_DMREF_EN] =3D REG_FIELD(VCC_UCD_FCTRL_SET, 6, 6),
-	    [F_VBUS_DPDET_EN] =3D REG_FIELD(VCC_UCD_FCTRL_SET, 5, 5),
-	    [F_VBUS_DMDET_EN] =3D REG_FIELD(VCC_UCD_FCTRL_SET, 4, 4),
-	    [F_VBUS_DPSINK_EN] =3D REG_FIELD(VCC_UCD_FCTRL_SET, 3, 3),
-	    [F_VBUS_DMSINK_EN] =3D REG_FIELD(VCC_UCD_FCTRL_SET, 2, 2),
-	    [F_VBUS_DP_BUFF_EN] =3D REG_FIELD(VCC_UCD_FCTRL_SET, 1, 1),
-	    [F_VBUS_DM_BUFF_EN] =3D REG_FIELD(VCC_UCD_FCTRL_SET, 0, 0),
=20
 	    [F_VBUS_EXTCLKENBL] =3D REG_FIELD(VBUS_UCD_FCTRL_EN, 15, 15),
 	    [F_VBUS_PLSTESTEN] =3D REG_FIELD(VBUS_UCD_FCTRL_EN, 14, 14),
--=20
2.55.0


--FDgWYpcmi0JC+/L6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5o3sACgkQeFA3/03a
ocXGbQgAlA324O1076KdLYBevog+BuxVbn3j+yf0RP1EHdB/nnFXGwFSNjCdzzQR
bnYIst7fy6ANwDDpGCK2BxyeLlaiirKnZMQ6ySlRaqF9yOj2X6VfWESu3aWk3L1x
C/uKoZjDz7723QEEONPqXOmbavfWkFvar5uJLUKBIBEP5pHg4gL/Xu/b0JgGjEQy
VQktU6NA+C+54qsDXjYMCKZfN6+IItjapbforVrYGfjEZdKbYgIc9uCtKt9Z0hbx
dcBG8rmAphSUSBITE4HQM/0eU4bymeol/FgyofFZu/0CbCQe/sXW4a2q/1psRP/q
b4LqsFDkvQUNZlvob++QlokOxAle2w==
=+w25
-----END PGP SIGNATURE-----

--FDgWYpcmi0JC+/L6--
