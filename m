Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704385;
	b=SgVZZQOXHFe0gAr79b7q4h9wnRz28v9wCGaX1AtHKVS9+N5gFMxz1Iw6UZ+nyk5MPGGM
	 Mn8Cer/sa9hx3hRyikrqWkDkKIGXArOAY5PGSVykqKYlO2oDk3CnXPdHvpw83aZ3YtRCC
	 TV7p6QGPftVhvdGsKtIj6aJzIN1RMuO9N9jeKiXTbgRYp4OMFtmS/iDHoEum1A+EYQQkj
	 VW7Mdq6W0SVAxi59RWv3Xjy576qv7u1OhqDCJrvAh6B0Psh2gyY6/Y3EAyS5TENQMPBCq
	 VtDDQWNfUVlxNSAoS2Pef7QCrxaKvpZsd4mLNVzl+YljoNshl7gHqLkDtIlbOne4CAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=D4Ti/c1K26HZ8SQG/WnnVKgfJOZ1KY26CoYAHnXmIG8=;
	b=l6cjCtu99He9ZD4oziPj1OMAVhBSXROgm4PFgD/bB+Vn6KgjayPlHGmYEuXoEyMTXyyX
	 S/mlyIISZ/j/W3ghdwXTYPyaPE+N8w8SGee4P0Z3Y9NpJFZDedjS0as7NyI06fY9J/hrN
	 zNMk9n4R22JTeCtZx+RWU/mgsXusKosc8ZD9UtfE4dCYaWicbEZSWEMQR0HDAbm5klPJy
	 VtzJL3pBrV9hKdFPszUg3Rqb4I4hV3rPCbAML0FPajv8bZOnKUq9p1bGGieipXgbBBiUd
	 FdKSkcBQ9pdd80MN2q9sDofIbngVLpayIcOlssEZ1z7Hi3SFK9WbCR5vo00evr/Nyog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T2FdWRJU;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DA606A327
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 615DA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T2FdWRJU
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so6515613eec.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794704385; x=1795309185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4Ti/c1K26HZ8SQG/WnnVKgfJOZ1KY26CoYAHnXmIG8=;
        b=T2FdWRJU8frQQgQke2EJMi2Fm4/4Di9P/QKqprSUh+KaHDLt2lqzkxrdSYdWSC7SGd
         RRWjV+Rp/NPstS3oHktHofYs6Wz92pToV9TcpBEEg/uihE4ukM/sfx3RaeEZnk+8EETp
         aP7CVqP6Q7A8iBrO+c+yZReh6GT/jHCh/15MijNtG9k4zP5BTNUCIdbCcYvCjLwRYUkH
         eS6dg7KbqDJspvk4BTqE1bTAi7l04fjaHyRPK0l8gZhC5v63TuAwAIDkY9jieXKy9ov6
         biDQvLYOYQmjQNl8vf2DM+pkHDEmN5Lx4dYHEuuGGs7KFUh7FJAAmUr/oKHWGeFrvwmZ
         h8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794704385; x=1795309185;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4Ti/c1K26HZ8SQG/WnnVKgfJOZ1KY26CoYAHnXmIG8=;
        b=0GtXExUvexJIjHBg0CqATL7cHaneJP481F+LkUclGkdSLa9WxILRzpV4SxydVGK+VW
         59dCUGBDuvN0r1w/NMtNp5Jgm+sZsYUq05J1O9gzpDTfo2iskb97zcD1yjm+jjXZKvt4
         cOQJT4PbYoIGiMBvQlba03obvfaae35E2odZkbNOH1E+W40IVKST0bKYVpIQyXs7v+ye
         MrK2rozktKy+HX35YV4O99ythK68oNw/6QaYFmB4D5ILYsfv5/JBNABOUWyBHk9iIN0W
         rIK+1H/B42Zf4JoOgzcaOdU5PbcvKPRp8p1tt0Oq+AjrQpTNe/clOL5muzXe/seBnBAC
         4nwg==
X-Forwarded-Encrypted: i=1; AL+hErHuthQ6P6P4czLrt2sFfv7FP7zr9UXq0VCPC6kl80Lcclut5hvNgGQ+/oZkXHr8sP75FKbAOnO3QA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+8lZbPFGkGyRtjAsTQOziLLds5x5t7EosQ0m1sfXaWX+8UMCuv
	6JD5QCSkmEHMrfaCUfN385ujg7LRDT84MqJUnj672GGaGLE/XBsQbJrN
X-Gm-Gg: AYBFou2inBu8jPk7Eha55QkgzeyDDqdIeGg2tvxPCEdV880ZseZGyZozdj+cTGmXozW
	N6IwUiqDnaHO+5Ebwfo4E2gxbrCHNRosyehZ76iMF33fy3bPXb8bai8rrmtrLzGIPYyzuoPrtsd
	whie4mNU8OL2QhpfODmt4v4nhHMJlt3T8UF/v4dBFzkFcYo6lCPS59AJJa6VnvcPfBuF1UhfIx2
	X4N7ShVVDxTYdXIVc3+nhE6d6mjgusYfZpC9DFaDv7OILLw/lvnMtqNVitMwFEbfspVlWenVGYJ
	rBu/R5ucCnRBZD07bsFwmvEO0riQZBZekhNvZWPHMJb9eIeUoS8HeRdMxx5GyKzMi0fBQlA/eTn
	+iYK0RZYkrZPr1VmKOefyuhb7zkxuRHwvgppSbveFzx60b7zf02tDEeivIVUSLDHLZPka3LwnuG
	VonnxM2kD6ZC6WBMv4NgK7qcPTwj1QYpmxWQlNpLRqEkZDMQykeKwQWqdh3c3e26XHijvMGWvDZ
	7d3SioqtADH8mQZ/8yJymxqu5zIUrTXHSVpuvsSNVR06hpVq6G1t5ICkEPmEndMcNPeKLN7S82D
	4EsvTtcfDb37+P3vzQVIEbrERyfbzp2ZYfPbbHe6RHh5akQOgjAWvwBnME6P+71c5UE=
X-Received: by 2002:a05:7300:e9c8:20b0:36d:a466:9d0b with SMTP id 5a478bee46e88-37966a5c202mr7670296eec.19.1794704384537;
        Sat, 14 Nov 2026 16:59:44 -0800 (PST)
Received: from [192.168.35.43] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm35687984eec.21.2026.11.14.16.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 16:59:44 -0800 (PST)
Message-ID: <03c0c33e-9619-4641-92bd-ffd0459f11db@gmail.com>
Date: Sun, 15 Nov 2026 09:59:39 +0900
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
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH v2 6/7] PM / devfreq: rockchip-dfi: prepare support for v4
 DDRMON
Content-Language: ko
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com
References: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
 <20260921-b4-rockchip-dfi-rk3576-support-v2-6-04f847016321@collabora.com>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260921-b4-rockchip-dfi-rk3576-support-v2-6-04f847016321@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 6:15 AM, Sebastian Reichel wrote:
> Add support for the new control register layout found for DDRMON
> controllers having version 0x40. This prepares the driver for
> adding RK3576 support.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 85 ++++++++++++++++++++++++++----------
>  1 file changed, 62 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 8490219f61be..8ba97af78e3d 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -42,6 +42,19 @@
>  #define DDRMON_CTRL_TIMER_CNT_EN	BIT(0)
>  #define DDRMON_CTRL_LP5_BANK_MODE_MASK	GENMASK(8, 7)
>  
> +#define DDRMON_CTRL0	0x04
> +#define DDRMON_CTRL0_EXT_TRIGGER_EN		BIT(6)
> +#define DDRMON_CTRL0_DDR4			BIT(5)
> +#define DDRMON_CTRL0_LPDDR4			BIT(4)
> +#define DDRMON_CTRL0_HARDWARE_EN		BIT(3)
> +#define DDRMON_CTRL0_LPDDR23			BIT(2)
> +#define DDRMON_CTRL0_SOFTWARE_EN		BIT(1)
> +#define DDRMON_CTRL0_TIMER_CNT_EN		BIT(0)
> +#define DDRMON_CTRL0_HOT_RANK			GENMASK(8, 7)
> +
> +#define DDRMON_CTRL1	0x08
> +#define DDRMON_CTRL1_LPDDR5			BIT(0)
> +#define DDRMON_CTRL1_LP5_BANK_MODE_MASK		GENMASK(2, 1)
>  
>  #define PERF_EVENT_CYCLES		0x0
>  #define PERF_EVENT_READ_BYTES		0x1
> @@ -143,8 +156,6 @@ struct rockchip_dfi_variant {
>  
>  static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
>  {
> -	u32 ddrmon_ver;
> -
>  	switch (dfi->ddr_type) {
>  	case ROCKCHIP_DDRTYPE_LPDDR2:
>  	case ROCKCHIP_DDRTYPE_LPDDR3:
> @@ -159,26 +170,43 @@ static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
>  			FIELD_PREP_WM16(DDRMON_CTRL_LPDDR5, 0);
>  		break;
>  	case ROCKCHIP_DDRTYPE_LPDDR5:
> -		ddrmon_ver = readl_relaxed(dfi->regs);
> -		if (ddrmon_ver < 0x40) {
> -			*ctrl = FIELD_PREP_WM16(DDRMON_CTRL_LPDDR23, 0) |
> -				FIELD_PREP_WM16(DDRMON_CTRL_LPDDR4, 0) |
> -				FIELD_PREP_WM16(DDRMON_CTRL_LPDDR5, 1) |
> -				FIELD_PREP_WM16(DDRMON_CTRL_LP5_BANK_MODE_MASK,
> -						dfi->lp5_bank_mode);
> -			break;
> -		}
> -
> -		/*
> -		 * As it is unknown whether the unpleasant special case
> -		 * behaviour used by the vendor kernel is needed for any
> -		 * shipping hardware, ask users to report if they have
> -		 * some of that hardware.
> -		 */
> -		dev_err(&dfi->edev->dev,
> -			"unsupported DDRMON version 0x%04X, please let linux-rockchip know!\n",
> -			ddrmon_ver);
> +		*ctrl = FIELD_PREP_WM16(DDRMON_CTRL_LPDDR23, 0) |
> +			FIELD_PREP_WM16(DDRMON_CTRL_LPDDR4, 0) |
> +			FIELD_PREP_WM16(DDRMON_CTRL_LPDDR5, 1) |
> +			FIELD_PREP_WM16(DDRMON_CTRL_LP5_BANK_MODE_MASK,
> +					dfi->lp5_bank_mode);
> +		break;
> +	default:
> +		dev_err(&dfi->edev->dev, "unsupported memory type 0x%X\n",
> +			dfi->ddr_type);
>  		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_dfi_v4_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl0, u32 *ctrl1)
> +{
> +	switch (dfi->ddr_type) {
> +	case ROCKCHIP_DDRTYPE_LPDDR2:
> +	case ROCKCHIP_DDRTYPE_LPDDR3:
> +		*ctrl0 = FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR23, 1) |
> +			 FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR4, 0);
> +		*ctrl1 = FIELD_PREP_WM16(DDRMON_CTRL1_LPDDR5, 0);
> +		break;
> +	case ROCKCHIP_DDRTYPE_LPDDR4:
> +	case ROCKCHIP_DDRTYPE_LPDDR4X:
> +		*ctrl0 = FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR23, 0) |
> +			 FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR4, 1);
> +		*ctrl1 = FIELD_PREP_WM16(DDRMON_CTRL1_LPDDR5, 0);
> +		break;
> +	case ROCKCHIP_DDRTYPE_LPDDR5:
> +		*ctrl0 = FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR23, 0) |
> +			 FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR4, 0);
> +		*ctrl1 = FIELD_PREP_WM16(DDRMON_CTRL1_LPDDR5, 1) |
> +			 FIELD_PREP_WM16(DDRMON_CTRL_LP5_BANK_MODE_MASK,
> +					dfi->lp5_bank_mode);
> +		break;
>  	default:
>  		dev_err(&dfi->edev->dev, "unsupported memory type 0x%X\n",
>  			dfi->ddr_type);
> @@ -188,11 +216,12 @@ static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
>  	return 0;
>  }
>  
> +
>  static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
>  {
>  	void __iomem *dfi_regs = dfi->regs;
> +	u32 ctrl, ctrl1, ddrmon_ver;
>  	int i, ret = 0;
> -	u32 ctrl;
>  
>  	mutex_lock(&dfi->mutex);
>  
> @@ -207,10 +236,16 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
>  		goto out;
>  	}
>  
> -	ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl);
> +	ddrmon_ver = readl_relaxed(dfi->regs);
> +	if (ddrmon_ver < 0x40)
> +		ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl);
> +	else
> +		ret = rockchip_dfi_v4_ddrtype_to_ctrl(dfi, &ctrl, &ctrl1);
> +
>  	if (ret)
>  		goto out;
>  
> +
>  	for (i = 0; i < dfi->variant->max_channels; i++) {
>  
>  		if (!(dfi->channel_mask & BIT(i)))
> @@ -225,6 +260,10 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
>  		writel_relaxed(ctrl, dfi_regs + i * dfi->variant->stride +
>  			       DDRMON_CTRL);
>  
> +		if (ddrmon_ver >= 0x40)
> +			writel_relaxed(ctrl1, dfi_regs + i * dfi->variant->stride +
> +				       DDRMON_CTRL1);
> +
>  		/* enable count, use software mode */
>  		writel_relaxed(FIELD_PREP_WM16(DDRMON_CTRL_SOFTWARE_EN, 1),
>  			       dfi_regs + i * dfi->variant->stride + DDRMON_CTRL);
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
