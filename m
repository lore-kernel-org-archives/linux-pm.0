Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7CB3DCD87
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691443; cv=pass; b=UhIbIZYFOYfHqdEWWFablJKo+/hP+x/kgQFGpN6uxDnIDS72KEeozZ22QTOez8b02/vUOsCWSjWpjDRbA4Qmvl3UGbFh7y5ppfm+cAOMhTea2XYF2+cnRZWVHAuLi60ESYz7TgJ52MHvNAccinRCgpKLAIhDoXtHE/finPpuIAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691443; c=relaxed/simple;
	bh=FKTf/d7nFmKcsSFUbAB3exdk2dVsrnMxmbCxkgyTBek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsDTQc9m0JitoPI5oR2Ybo3Ij5CM3/mIUec2ou9WteCaV8hBZR0s8QR4aBL5+R90PzVb4XlTJ1fd9JCH+PX2XuClscFg+8BC8/DTbu2KOWXPUBGgQY//k4ATa4FzQt8BiYBK3wq1mGt/x0tF6DoupmDbfmV3hrmJOCp1pBtCBi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I+YBlPFe; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I+YBlPFe"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81ed000b507so65938827b3.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 20:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784691437; cv=none;
        d=google.com; s=arc-20260327;
        b=WZdLKp65txEUYnh5Kx0hW3jNaLci7xSurnqSp8goNyW6veFpYAFh13SKfMki5dGMBa
         eaWyPwr+zboiVaJXYfIOLvslPwMKvMLrmJlnf+Cx1LcWxbJ35Oxa0sEI3UOkFYMWw19i
         lF45VNQhvsCucmS/rH0L7Us6IWqoXHVJVAJGQM8mwLVL5RHO5ppCptderNtdjdwhSKlh
         V42M5oPyGmnZ5kvIHGVLO+vy/s/zt8Q/1rVeYZTCMm+zxmNuTl6SHT/YJ8U31zxWHmMV
         iY/unw0VRHC+WabXy+fWi+oiCDIbFAGI/7xDrCGfGuMRDFuBXa/DElwzXEq+5ZPPyOMY
         BVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FKTf/d7nFmKcsSFUbAB3exdk2dVsrnMxmbCxkgyTBek=;
        fh=9Rq9sTcZOFURd22opOz70I0D++fKr2CAddg+IxEGsXY=;
        b=pLc6r7Kaz7ou8rMJ56gj6Ewh9hx1D3/gGGBu/OBlHWLanQiF1dv1iiTFC3sBcrptSd
         b72YfJKKBSsu7GM10Jk97naMOBp3tuYAr9x7VMqhOI+OpMYun2QwEOYU0murjwD728Zd
         1T1I5SJihSk7y517Vd1Uwg/7wzkHmD3fiFxebTw77+2cqTalls6xndAvXvcbGsvVNy+z
         s8f9oT4wq0Kfbz5SbkkZnQdVIPYN5zTTND4vQrSkds5oLn8sIJ+oerXL3HB9KNIVKF9M
         pDNSuo82q4MrKRoMjFZQ7+GZy/KT/8w4mWjDO1gnFXbgyTZC6+nxNRh9JVmjjQjHfk/T
         vN2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784691437; x=1785296237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FKTf/d7nFmKcsSFUbAB3exdk2dVsrnMxmbCxkgyTBek=;
        b=I+YBlPFetDH0VadtA+QUTCMaFJyWpmjAB32wo/PnbkoJXgZj4u5Mt8uZEg6pXgCJA7
         KUE1RSSMBOn/vnYvL3vgQ+HZwqFgQpBgQuwFgICTKMGyifTB4fC4gwrywyjw0OBk08e4
         ZkVpS5feb4wraETvzbXGQCGjPIgCKkis24DMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784691437; x=1785296237;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FKTf/d7nFmKcsSFUbAB3exdk2dVsrnMxmbCxkgyTBek=;
        b=IOuPkz6dn8Z8OwY4zOBDn44GMIhk3uWzIv6gNyH28+Qx07mfC6Qb/Oke3C8KZdJHeS
         ZCcQ+mbm8UY9zfiG10gkBDPVf1F+afUNqS0JJhiBYdRfY3/lHPIQ4AQMXhqtZJdsPszA
         dTuo9MReixbVWUtnI4sa+WKCqUgrJo4CGZz95RJc9Fno5T0ww5+aIIyV59UxsI3l3acU
         QYzzpzV9jmWXzK6YEl2cHl6M6zEVSIeHVrlrUmfN3irwiGGL6msnnnois2mFVQEnotjI
         bNUACDM93a0GQdBsyVWjaNBQM9nca7ZMleqqlKB9jc/kxcgCsLiDvEvaryyTjIiYAxzk
         d/Og==
X-Forwarded-Encrypted: i=1; AHgh+RqoUpaIofIIoQ3BImJJ6Y8dRWZRAdXeoGRF4IjXr8nDjDV5CI/PQ0w65u2i4pCMcLZ+ge/ImW1Bqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvC/L+SwdJ3eIv7wKpEt0+I9pKtxMYyGE5M/g9YKO2+sojHgMn
	mkBgH1gq1RU0iXP7nvJGZcbnzOQk+nproCtrKPav7oEq8SXv6aeMEAAjR5p/HsKXBas0Oz7QWe+
	WUT1po6VNzfzmPFlim7JbHC6oz35vZa/tleXS+ZYm
X-Gm-Gg: AR+sD115SfJ4qZIzPaYDcHPDYOg7IVEmlqThCAALAMBFQ7+jUwUbyA/DmT/ckGTAYog
	+9GlKElEwNAq77UoiSX68vjp6WDaC48EOGb7LyTDYWn0titJtLOvBYVtrbftdM5nEc/LIFCp21B
	nfup1WSKtCdjIySu0p56+8gpcMCf70IkZfmv8BjSRG3CPLlNEm2+6LP/GoSba5nZ0OAywg152VR
	bLJE5sgj/Hn496lLjqnUbgphIt5Z2CSOYZDAia6UHKtAdj6jx1id8ucJExGQuOEFXp7fJGaSZFo
	/vFpdg+RgxWHxzI=
X-Received: by 2002:a05:690c:6c0d:b0:812:996f:176f with SMTP id
 00721157ae682-81ef22d3ea4mr70445607b3.11.1784691436993; Tue, 21 Jul 2026
 20:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721105230.101906-1-angelogioacchino.delregno@collabora.com> <20260721105230.101906-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260721105230.101906-3-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 22 Jul 2026 11:37:05 +0800
X-Gm-Features: AUfX_my3u1BuHiEh3Upx2wok8eAOOGJ_r8yDp0XbplwggDqqh2JVTYtoDhYXOKI
Message-ID: <CAGXv+5GrPZCZ=jNRi1AtduyZoB8DF_FUZev2CXhu4WzGri6U3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal/drivers/mediatek/lvts_thermal: Make reset
 optional for MT8196
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, matthias.bgg@gmail.com, laura.nao@collabora.com, 
	fshao@chromium.org, jiapeng.chong@linux.alibaba.com, frank-w@public-files.de, 
	bchihi@baylibre.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 6:52=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Depending on the SoC+Firmware combination, the LVTS hardware may be
> may be actively used by one or even multiple concurrent MCUs!
> In this case, resetting it may produce either a severe slowdown of
> the entire system, or even a thermal protection AP reset, as some
> MCU(s) may be reading a very high or very low temperature while the
> LVTS is being reset.
>
> On those, don't fail if no reset is found as that may be omitted on
> purpose, but still check if there's one, because some board(s) may
> be running on a different bootchain with reduced firmwares or using
> firmwares with reduced functionality.
>
> So, use devm_reset_control_get_optional_exclusive() instead, as the
> LVTS controller always had only one reset and retrieving that by
> index, specifically, always made little sense anyway.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
