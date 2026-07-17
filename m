Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D63DD533;
	Fri, 17 Jul 2026 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273868; cv=none; b=PsgRbUuMAdXWhHpyG0xCiuRoWtLTFHMHpN0fK3fqc3BdKfDvQcAGdYXP34TYJDqB+2BBXMjucJK3M2foiIHPld6H2a6/Ddz4HY+DZnVJymkcgiWHsBxYet+PiGuFZdyklGTG5yIHU+fp+M5D/nto+k36Rz+kAl1GDitXqTgEJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273868; c=relaxed/simple;
	bh=qZkQOIOG8Kl3936adbYcP2Yh8w6XNbgYkOrvcA3q2GM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kSBA2uPTtJLLMbyQY++W4TXn1sZEnQ9bnxt52jRnl+4Dmm7d0qD7d88T+k6hLXbkO/oh5uEx5rpoamtKixGerkjGtDyn3T9AS3C4RWMW9pkJ40UR9sN+fjBex4JPaOgdIC20hMOkuYTVfhbp0B75wkwJry6GtJZkcAt49rlm1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kon2YfH/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kon2YfH/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6485BC2B9F5;
	Fri, 17 Jul 2026 07:37:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 943D660361;
	Fri, 17 Jul 2026 07:37:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC0A611BD3D44;
	Fri, 17 Jul 2026 09:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784273852; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Cdb0RCCdG1Y5r/It8CwrJzVJ0JbWRfQ0sD99bdj9c+M=;
	b=kon2YfH/dOK4tDt53OBaDo5FFMl+LDNwDVUop5ds1NRI/Wg1uSfOdRPoX//xppPkYw4F4k
	i7WIsxXBl1un2FVxbtH0z+MNg/Pxf/kDZFkkmQMF7GWX2KDvfCGfcNPlsGE/XeWd6UWU5+
	GU0KvK2Qz5NhcKTqLYeMaoODnDSsLW8zaf8j7HAZsl2HX2a+q1UNwnNfj8/t2YSHY0CoOJ
	iuHvYWwy+oF8TF5SvX8WUIAoCWzZZkD3fHymApMwuHuo/Ci0SwMn3oduihoRjpk8TrJJuw
	dKfxpFRA4xRbQoh0VoLeExcl0443IzDaZd45c4NSu8UobUALaKN9EhlqiiNUTA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  Daniel Lezcano
 <daniel.lezcano@kernel.org>,  Zhang Rui <rui.zhang@intel.com>,  Lukasz
 Luba <lukasz.luba@arm.com>,  Markus Mayer <mmayer@broadcom.com>,  Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
  Florian Fainelli <florian.fainelli@broadcom.com>,  Frank Li
 <Frank.Li@nxp.com>,  Sascha Hauer <s.hauer@pengutronix.de>,  Pengutronix
 Kernel Team <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,
  zhanghongchen <zhanghongchen@loongson.cn>,  Yinbo Zhu
 <zhuyinbo@loongson.cn>,  Amit Kucheria <amitk@kernel.org>,  Thara Gopinath
 <thara.gopinath@gmail.com>,  Niklas =?utf-8?Q?S=C3=B6derlund?=
 <niklas.soderlund@ragnatech.se>,  Geert Uytterhoeven
 <geert+renesas@glider.be>,  Magnus Damm <magnus.damm@gmail.com>,  John
 Madieu <john.madieu.xa@bp.renesas.com>,  Heiko Stuebner <heiko@sntech.de>,
  Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Peter Griffin <peter.griffin@linaro.org>,  Alim Akhtar
 <alim.akhtar@samsung.com>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
  Alexandre Torgue <alexandre.torgue@foss.st.com>,  Thierry Reding
 <thierry.reding@kernel.org>,  Jonathan Hunter <jonathanh@nvidia.com>,
  Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Laura Nao <laura.nao@collabora.com>,
  Fei Shao <fshao@chromium.org>,  Chen-Yu Tsai <wenst@chromium.org>,
  Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,  Frank Wunderlich
 <frank-w@public-files.de>,  Mikko Perttunen <mperttunen@nvidia.com>,
  Svyatoslav Ryhel <clamor95@gmail.com>,  linux-pm@vger.kernel.org (open
 list:THERMAL),  linux-kernel@vger.kernel.org (open list),
  linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM
 ARCHITECTURE),  imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE),  linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM
 MAILING LIST),  linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR
 THERMAL DRIVERS),  linux-rockchip@lists.infradead.org (open
 list:ARM/Rockchip SoC support),  linux-samsung-soc@vger.kernel.org (open
 list:SAMSUNG THERMAL DRIVER),  linux-stm32@st-md-mailman.stormreply.com
 (moderated list:ARM/STM32 ARCHITECTURE),  linux-tegra@vger.kernel.org
 (open list:TEGRA ARCHITECTURE SUPPORT),
  linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
 support:Keyword:mediatek),  Niklas S?derlund
 <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH v2] thermal/drivers: Remove redundant error messages on
 IRQ request failure
In-Reply-To: <20260717024733.374913-1-panchuang@vivo.com> (Pan Chuang's
	message of "Fri, 17 Jul 2026 10:47:10 +0800")
References: <20260717024733.374913-1-panchuang@vivo.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 17 Jul 2026 09:37:18 +0200
Message-ID: <87v7aekqxd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 17/07/2026 at 10:47:10 +08, Pan Chuang <panchuang@vivo.com> wrote:

> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
> automatically log detailed error messages on failure. Remove the
> now-redundant driver-specific dev_err() and dev_err_probe() calls.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

                       ^
There is an encoding issue here

>  drivers/thermal/armada_thermal.c                          | 5 +----

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

