Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D83B47CF;
	Wed, 11 Mar 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221750; cv=none; b=jEN7DyfgDrwM3oeTSieoDEH6Kd2HKZXdGVmH1lW9FVG2YVwjfoj7lkQ9jtIeRPgjUg9368ejLQbHrtmucEMOLlLa6Zlb/brcYGa7NvVZg68z8HauXbswq5AMTyf0yd863rKld6A6GZiVbIB59DStIjsjxiSbQanF8UCA3DioeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221750; c=relaxed/simple;
	bh=OZdi9gkak4UPUWK0IKlhqWGeXKeTqlYLrSwjLN5yZtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHAqIbsth5jyyKk+DkIBKWeF5Cq4JMvnJ+BaUvikaBXWu6xBBYqSCHAzFQNhd6L+JQRD7Ch9oW88cQ7Cv178qFvNbcnO+tzerOAoTEQEsTgPOT80MWsipX6ONsXHrMQyzQxDDdEa6DZsaesyhniM9x3jaTPhZvJYLwwClpNUlME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WWVm+JLK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WWVm+JLK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773221747;
	bh=OZdi9gkak4UPUWK0IKlhqWGeXKeTqlYLrSwjLN5yZtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWVm+JLKRdZryLlwHsOckfGDgdCYiv0Uu+8TtPNJlx5342n7W4lfCvb1ih0+4FLIj
	 EXJuIhVH0c50PHP9hyrS/RqJQiwBdgq9aGzOcvnwEEB0vObPK2fveoGg+bFxmx+Yg7
	 prbw6LGi1NJYw5Y1m23kATABbPISplehakmS0gapdeAxo8PjmmbuRMTWvTTRS8GiYc
	 FILrnAzbgUFGNOzHz5ZBIXZMV3tGBXcz2mY4m2Ny4Ayui3INyDt0frQ1y9dqiZcfY+
	 AN+WCA3BfPO6R89MYOACon2c2WBNHH8/ycTFQEiZ4KCV3KRsxI+xHsyMwNiVLoOf17
	 9Hh/6R5v8FLUA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:fe32:28f4:51af:732e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A234617E0EC1;
	Wed, 11 Mar 2026 10:35:46 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: linux@fw-web.de
Cc: angelogioacchino.delregno@collabora.com,
	daniel.lezcano@linaro.org,
	daniel@makrotopia.org,
	frank-w@public-files.de,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	rafael@kernel.org,
	rui.zhang@intel.com
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts: fix mt7987 thermal crash
Date: Wed, 11 Mar 2026 10:35:19 +0100
Message-Id: <20260311093519.15810-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260309064439.4296-1-linux@fw-web.de>
References: <20260309064439.4296-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

On 3/9/26 07:44, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
>
> On mt7987 we see a crash due to missing ops entry.
>
> [    1.518540] Internal error: Oops: 0000000096000005 [#1]  SMP
> ...
> [    1.564481] pc : lvts_get_temp+0x84/0xc4
> [    1.564492] lr : lvts_get_temp+0x60/0xc4
> ...
> [    1.620900] Call trace:
> [    1.631753]  lvts_get_temp+0x84/0xc4 (P)
> [    1.645471]  __thermal_zone_get_temp+0x24/0x11c
> [    1.656502]  __thermal_zone_device_update+0x9c/0x52c
>
> Add the new ops member added in 7.0-rc1 for mt7987 too.
>
> Fixes: a4c40559499f ("thermal/drivers/mediatek/lvts: Add platform ops to support alternative conversion logic")

I think the Fixes tag should reference 
"thermal/drivers/mediatek/lvts_thermal: Add mt7987 support", as the 
commit introducing the ops also updated all existing data structs (seems 
like mt7987 support landed right after).

> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index a9617d5e0077..5671531d4c23 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -2026,6 +2026,7 @@ static const struct lvts_data mt7987_lvts_ap_data = {
>  	.temp_offset	= LVTS_COEFF_B_MT7987,
>  	.gt_calib_bit_offset = 32,
>  	.def_calibration = 19380,

You'll probably need to define num_cal_offsets too, since the number of 
calibration bytes was also made configurable (not sure if this is 
already addressed by a separate patch).

> +	.ops = &lvts_platform_ops_mt7988,
>  };
>  
>  static const struct lvts_data mt7988_lvts_ap_data = {

Best,

Laura


