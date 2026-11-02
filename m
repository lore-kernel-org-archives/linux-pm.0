Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.224.82.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793584369;
	b=FbxBxDK36CA4l5NDbyUOALi40a5Vhvn/Vz3350hGkvLpKEW4+atflXMsRUCdrAs3Nrhl
	 mdehLOOhuckXpnoqHsSOFGOoDZB+dCqRkGUc8kAmD9uIz3bKG6anbaWkevmGKqZ/tiV3p
	 /mVYW/NplHyvpLayOwQRpayd/el2v4aeF5d/yXiFr15csMd+wrqLumupFnp5TCCMUqRRg
	 LFOdx6VryWbTefq4ef0u5k53Phc7G5MgondEeoAgg9MxzNINjJSuhyAHQtGx/m7VfLB3G
	 RYcCbWetOmIuXcsMfNqWuJ2m/ZeO+Y7kGoJmOFjogiz/IlW/RAUC8OZL4fiNhKjLbcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584369;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=tneePjoeL2yK6qrYSwwF6fPVIhSig+zNFAIr8myvBzw=;
	b=C9p1tI0L4wkX+X+29BgsIJsZUT8j330DgP6eJaEGSOtDBp0SEUk1kbgAjsZT/+Zltlmr
	 8NbydZtd35GXsZwFcO3pNsr27yH3PjTY3pGT0Yj7R/iaBbRc30gK3oHSAw2Afh+7VQecg
	 hpOaN+6tqVwmOLwS3UhpP9QlpmEAGC6994JMyZGsnEOFEa4xSKGc4R7m6RiZqYlXc+Ld1
	 ewqpAebXcnkoPE5tK4uBYiN1kUOTzd3lZqGl0XWMHyR5515ZWxEpew6wf9r6zl0P4Kh7D
	 Fh4B0GJBsOfwYc0nfZzdKcZPrJQULFlr5wqV0r84cYvIYhOQUTWXm9Xmp5yZUkiePdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=e9003h8k;
	arc=none smtp.remote-ip=156.224.82.167
Received: from mail-m82167.xmail.ntesmail.com (mail-m82167.xmail.ntesmail.com [156.224.82.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFE606A324;
	Mon,  2 Nov 2026 01:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32CFE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=e9003h8k
Received: from [172.16.12.90] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 531adef43;
	Mon, 2 Nov 2026 09:52:34 +0800 (GMT+08:00)
Message-ID: <e0244072-2ace-4971-b237-dfea5806f114@rock-chips.com>
Date: Mon, 2 Nov 2026 09:52:32 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 11/15] accel/rocket: select the per-core clock and
 reset counts from match data
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com, royalnet026@gmail.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-12-gahing@gahingwoo.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20261101082307.151957-12-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa199f5564903a7kunm28e33d1690928b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSRhCVklDSx9IHkhLH0sdTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=e9003h8knr8hseqDVAmZLDsKePFZJoUfy4L3orybLa4qb80JWSlH6QDDGnueDDOkdRJdQDJA7AR/5PI3bTwMd12iobJIxPDYCV8/N5LCZZBTGRPdrPoqnXuMAcgZq6eTy+ZmUilbvt63z+HCK4Ll2pnWDp2meOLrFBe0F/ElZA8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=tneePjoeL2yK6qrYSwwF6fPVIhSig+zNFAIr8myvBzw=;
	h=date:mime-version:subject:message-id:from;

Hi Jiaxing,

On 11/1/2026 4:23 PM, Jiaxing Hu wrote:
> The RK3576 has the same RKNN block with a different number of clocks and
> resets. Take the counts from soc_data in the match data; RK3588 keeps four
> and two. Check soc before anything is allocated, since a device bound by
> name has no match data.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_core.c |  8 ++++----
>  drivers/accel/rocket/rocket_core.h |  7 +++++++
>  drivers/accel/rocket/rocket_drv.c  | 26 +++++++++++++++++++++++---
>  3 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
> index 5dd260bacbff..b202d15816a3 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -23,7 +23,7 @@ int rocket_core_init(struct rocket_core *core)
>  
>  	core->resets[0].id = "srst_a";
>  	core->resets[1].id = "srst_h";
> -	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core->resets),
> +	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->num_resets,
>  						    core->resets);
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
> @@ -32,7 +32,7 @@ int rocket_core_init(struct rocket_core *core)
>  	core->clks[1].id = "hclk";
>  	core->clks[2].id = "npu";
>  	core->clks[3].id = "pclk";
> -	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
> +	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
>  
> @@ -109,9 +109,9 @@ void rocket_core_fini(struct rocket_core *core)
>  
>  void rocket_core_reset(struct rocket_core *core)
>  {
> -	reset_control_bulk_assert(ARRAY_SIZE(core->resets), core->resets);
> +	reset_control_bulk_assert(core->soc->num_resets, core->resets);
>  
>  	udelay(10);
>  
> -	reset_control_bulk_deassert(ARRAY_SIZE(core->resets), core->resets);
> +	reset_control_bulk_deassert(core->soc->num_resets, core->resets);
>  }
> diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
> index f6d7382854ca..ba74c5339b94 100644
> --- a/drivers/accel/rocket/rocket_core.h
> +++ b/drivers/accel/rocket/rocket_core.h
> @@ -27,9 +27,16 @@
>  #define rocket_core_writel(core, reg, value) \
>  	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
>  
> +/* Per-SoC differences, selected by the of_device_id match data. */
> +struct rocket_soc_data {
> +	unsigned int num_clks;		/* clk_bulk count */
> +	unsigned int num_resets;	/* reset_bulk count */
> +};
> +
>  struct rocket_core {
>  	struct device *dev;
>  	struct rocket_device *rdev;
> +	const struct rocket_soc_data *soc;
>  	unsigned int index;
>  
>  	int irq;
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
> index 5d7805c41dc3..284af027f398 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -159,8 +159,22 @@ static const struct drm_driver rocket_drm_driver = {
>  
>  static int rocket_probe(struct platform_device *pdev)
>  {
> +	const struct rocket_soc_data *soc = of_device_get_match_data(&pdev->dev);
>  	int ret;
>  
> +	/*
> +	 * soc is dereferenced without a check by every one of its users, and
> +	 * rocket_core_init() below is the first of them. A device that bound
> +	 * by name rather than by compatible has no match data, so fail before
> +	 * anything is allocated rather than at the first dereference: the
> +	 * number of cores comes from a walk of matching DT nodes, and a device
> +	 * with no of_node was never counted by it.
> +	 */

You don't need these comments because everyone already knows that.

> +	if (!soc) {
> +		dev_err(&pdev->dev, "no match data for this device\n");
> +		return -ENODEV;
> +	}
> +
>  	if (rdev == NULL) {
>  		/* First core probing, initialize DRM device. */
>  		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
> @@ -179,6 +193,7 @@ static int rocket_probe(struct platform_device *pdev)
>  
>  	rdev->cores[core].rdev = rdev;
>  	rdev->cores[core].dev = &pdev->dev;
> +	rdev->cores[core].soc = soc;
>  	rdev->cores[core].index = core;
>  
>  	rdev->num_cores++;
> @@ -216,8 +231,13 @@ static void rocket_remove(struct platform_device *pdev)
>  	}
>  }
>  
> +static const struct rocket_soc_data rk3588_soc_data = {
> +	.num_clks = 4,
> +	.num_resets = 2,
> +};
> +
>  static const struct of_device_id dt_match[] = {
> -	{ .compatible = "rockchip,rk3588-rknn-core" },
> +	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);
> @@ -243,7 +263,7 @@ static int rocket_device_runtime_resume(struct device *dev)
>  	if (core < 0)
>  		return -ENODEV;
>  
> -	err = clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
> +	err = clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
>  	if (err) {
>  		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
>  		return err;
> @@ -263,7 +283,7 @@ static int rocket_device_runtime_suspend(struct device *dev)
>  	if (!rocket_job_is_idle(&rdev->cores[core]))
>  		return -EBUSY;
>  
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
> +	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
>  
>  	return 0;
>  }

-- 
Best, 
Chaoyi

