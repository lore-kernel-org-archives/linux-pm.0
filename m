Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E8421A10
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544858; cv=none; b=dXuJDrv7yYKTfY1kVItOoPS+w2OEgFyINAIWbJuOMAPN8PtYx1qnbH7jLBOytt09flhON+zX9HJapwstY85LoczJd+95dJhIedSzJgKW0mGy8mVLlPCjx9AXa8QsxwsHpBMit7WLwgzzY3njsb8K4R2SqpthpEpDfczixy1Ccj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544858; c=relaxed/simple;
	bh=y6793pbAwZ271OXLJ0RTSBdIOA1+V6Kc21PRrmjbmOg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=boJmBDlF3QLG6pPbNvABu03OlUcZa/WbgFr7OPMgZJS075ohG8j8BaT/as/ILpPooK/zJPOVe4wU+zrf9XBiA1i4gRfuNDdpA7Y4IwwxdHuXl7EsVnjlxLpXiPj345Mad70a7By717x3gHFl8Yvyk1DJKr2cIK1AU+Wdrs/t2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bX6FTEe7; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bX6FTEe7"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774544852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0aDv3pXPzRA3fsboUtQWOUMKwDX2cc1CXV7e/p5wkw=;
	b=bX6FTEe74FQkmmro5vPJ3oUSL+4DVGfEVC9ep5hLXyac4bdeagUpYJ8fs7NETh78QHx5e4
	Mikk+rLRNEsuAUJ0fB/JaeqPrXIM15IcCmdL8fu0Puepr5o6bamD6HuPOa7rRm0ednA71s
	UrrZt0n74ITvJmWQPMeZPVXc3xuLyDs=
Date: Thu, 26 Mar 2026 17:07:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Frank Wunderlich" <frank.wunderlich@linux.dev>
Message-ID: <3e63a5483ce20ddf03e9dd9feabfec89ef902993@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] thermal/drivers/mediatek/lvts: add missing fields for
 mt7987
To: "Frank Wunderlich" <linux@fw-web.de>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Daniel Golle"
 <daniel@makrotopia.org>, "Laura Nao" <laura.nao@collabora.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260312202433.39092-1-linux@fw-web.de>
References: <20260312202433.39092-1-linux@fw-web.de>
X-Migadu-Flow: FLOW_OUT

Hi,

just a friedly reminder

@angelo do my mails get tagged as spam or similar?


Am 12. M=C3=A4rz 2026 um 21:24 schrieb "Frank Wunderlich" <linux@fw-web.d=
e mailto:linux@fw-web.de?to=3D%22Frank%20Wunderlich%22%20%3Clinux%40fw-we=
b.de%3E >:

>=20
>=20From: Frank Wunderlich <frank-w@public-files.de>
>=20
>=20Commit a4c40559499f ("thermal/drivers/mediatek/lvts: Add platform ops=
 to
> support alternative conversion logic") added new ops field which causes
> crash on mt7987.
>=20
>=20[ 1.518540] Internal error: Oops: 0000000096000005 [#1] SMP
> ...
> [ 1.564481] pc : lvts_get_temp+0x84/0xc4
> [ 1.564492] lr : lvts_get_temp+0x60/0xc4
> ...
> [ 1.620900] Call trace:
> [ 1.631753] lvts_get_temp+0x84/0xc4 (P)
> [ 1.645471] __thermal_zone_get_temp+0x24/0x11c
> [ 1.656502] __thermal_zone_device_update+0x9c/0x52c
>=20
>=20Add the new ops member added in 7.0-rc1 for mt7987 too.
>=20
>=20Commit 6931d597c5ef ("thermal/drivers/mediatek/lvts: Make number of
> calibration offsets configurable") introduced field num_cal_offsets
> in lvts_data. Add this for mt7987 too.
>=20
>=20Fixes: 78c24e67d6f8 ("thermal/drivers/mediatek/lvts_thermal: Add mt79=
87 support")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
>=20diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/therma=
l/mediatek/lvts_thermal.c
> index a9617d5e0077..1224ce0c1507 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -2026,6 +2026,8 @@ static const struct lvts_data mt7987_lvts_ap_data=
 =3D {
>  .temp_offset =3D LVTS_COEFF_B_MT7987,
>  .gt_calib_bit_offset =3D 32,
>  .def_calibration =3D 19380,
> + .num_cal_offsets =3D LVTS_NUM_CAL_OFFSETS_MT7988,
> + .ops =3D &lvts_platform_ops_mt7988,
>  };
>=20=20
>=20 static const struct lvts_data mt7988_lvts_ap_data =3D {
> --=20
>=202.43.0
>=20

regards=20Frank
