Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698033;
	b=P86CGCHQrKEVMapXutjG/22Bq/fTYscmQknEJiEln5f85L2kH7GM833YwOUjbWcQPbQV
	 1S/MGt/GEUwlZxmN8ckW7hebpt7OOjsTmscko7jGPAsu2cpGn7mHpOfBv+NKOQvSvNyNs
	 /wKiFZbrHVNpmSPb2v8HqMULXkgfO4Nm/Hy3o2pdtF04PQpJsin6LxXM8oRJwUd3GCn+u
	 jSjxEdqFV5aaGGcbPDeRMMSQ7wFB6mNY0kjDwworN09Oy4anGZV+A1RRVSA8xBOklqa13
	 Ifb3I6A5+wzcB8bS8mkiTdIcCpFfm5V0WqFRj0QPr26Z4erLMy7ctiMFnPfVofXz99Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Db7swx/z5fRcWKIKhx/36FX+1LnzR+96h9IjzqTpdvs=;
	b=Wmc3N9PME6a/5Wv4n7xCBIw9rRz4jA5FjytgHNuzd2E+eytXXFf0FqXQLYW+41kOOOZQ
	 KzlzabbUHXZYrEL6S/92b1/wXN/ABjB9DKGTMLNacStmJP/vFCqYiliAqVjm1BI6Ogxik
	 IfRBdip78lTugsLGd4mMwCZBbvyqicFUjlxeqpb4/dkoh0oP2wddQnrvxCSRyh34miEoW
	 TpoBfZwekRmzMrikZ5dEgDY1LZbGOvzA+WWho4jhy2DqHABbTmXgzIv+CIWw/gUcCF93g
	 Qobe5XRYWcm4xmE94S2NYkRhxXENg+car6KO8cvg6U9TXR6VEdgDCI4lQVFReHR77UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Vjg2M7n/";
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737EE606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 737EE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vjg2M7n/
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso2903298a12.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 05:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795698032; x=1796302832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Db7swx/z5fRcWKIKhx/36FX+1LnzR+96h9IjzqTpdvs=;
        b=Vjg2M7n/jvQqi8Iu5gHLylk8W4DSsHak/aphtHnbT9mabryXAmvjC/sAlK9iQIo6Rr
         s1WavyhtUn00ODNDDXumZuNMzeTRrHke+qEfRMh7QO73j0pYn6hTiZ0rAHRRhXmGOteF
         5neoTKx9c9ajzyj4JZXmwUFzS34FisGo7iq/rTpTv1hZSu/Hsb2zjzvp6BqXdjiYGwV6
         +uet5W3DYizwCp/l91AI2whL6qA97od71hcC00MkfRuCSJBUOinafAtkvjB546rLiroZ
         zHee/9MOFc/gKO7nKKB6EOANaJBU4JR3apm5u6oOtt2rbwiInYCVn8B0Cm65HRQ3WElv
         QxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795698032; x=1796302832;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Db7swx/z5fRcWKIKhx/36FX+1LnzR+96h9IjzqTpdvs=;
        b=p4/A7DdMFjmTAI/vSml7c4+Qz/JHekQ7wGoUhkMeydQBllxUFRePwDx2O8depXmRBg
         w/2OiXYbuSjatcMGzjey0TEdXqoGc5IBpkysl/NpkFhmOPgBPK9zj2fxP4wdjsi3oiXR
         A5mbW2hhs/uLclAFLw+xBrBndg/xHqd/mkm2avTrXakXwA1CgLEPEeHnWWKDtWmo7g43
         y7UxY7TL+v26CZRqjXLh3uvRwFSICprsKaYnhewQnofO4M7JOOPpu5QIcFx+9YtRUMMS
         Ms3bXrcTHG7gMYumKaQm0nT5p1L9Iynmk2Y3jsada3qCIgjJotXK2/M122VMsoiy7gxe
         v7oQ==
X-Forwarded-Encrypted: i=1; AL+hErEQkDk4ixdqxrCxyCcLJH65epns83BRdO3e9YM2sBWEQheDKVtryYzVJHgpQbPZXS1tLXRCvfu1yw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/LuCapw36JSnAv5hfT+Bc/kul7nbNwiNIpQtKlKrEJvG4qFevy
	qeOTqMwfr2+hZxO33PyNBlBteApaPN1RrUO241Sqo+cmWMiRT6etCOND
X-Gm-Gg: AZFdTZcNATOqAXtpDCAuaevclguBCecdfGFlnvKojhBTbuhDVHveiTsXWCAN46k5LzV
	aCgu9QC5vcepZDNGMcOo79Fu6MIDCj8ZkLwgQKSKTvnctmmrWV43qFkmkZp2tmdfVG9OUlhL3Fw
	Va5ojpc1j7J9xrCjSD2q1qGwo9qTUWRrqYD37lJprz9G8dS/C27DqK513dgMzx40rZHYckuDGdL
	QMHB3uPYkDqoLUZxcQjtq5Q22jkbSoR1q/IHo96zBnjCDOcHLVQh4slTB/ciXt2E5y8z6xp+NO2
	4m452jms3mLEKzEyM5QYKD0WQRgsfatsNB1P/aRAhBgt8PBAPk2qzgDeBx6C95SDW4dUIw6gn8E
	q8HNo1NHR7pu+Qe22ocr8gQNF3mvh3LiK8I0l6nXVPvZm2F/pHpCp1At0ppuosSrRMfc3Uixmap
	7dgWX/sOc6JHKRk8vtcB/ZAu4aOqwJwzczUNnoVtU+wZLT91aBcNddUNPRR4wI12UAZl3nIk3FJ
	0YoDd/p+Vi2tx+uFjFOYqxZ+DY1dzHWz1UBMKxQD430/HEKi1gxhh6LtP7pKu7mpIpKPd0XKZwv
	7SdoO8Mk2AXdBTNBbTopGdTaJqu6Dnc6kdKHFF1YcddUWN+fwGdS
X-Received: by 2002:a17:90b:2cce:b0:3b0:a7b5:c046 with SMTP id 98e67ed59e1d1-3b41c9759cbmr21021163a91.54.1795698031561;
        Thu, 26 Nov 2026 05:00:31 -0800 (PST)
Received: from [192.168.35.43] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b0f482bdsm17077789a91.14.2026.11.26.05.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:00:30 -0800 (PST)
Message-ID: <772ec0ea-da77-42e3-a281-8b8b7f364bf9@gmail.com>
Date: Thu, 26 Nov 2026 22:00:25 +0900
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
Subject: Re: [PATCH v4 08/11] PM / devfreq: rockchip-dfi: make RK3588 use its
 clocks
Content-Language: ko
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
 <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-8-517a68c008fe@collabora.com>
From: Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-8-517a68c008fe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/19/2026 10:01 PM, Sebastian Reichel wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> So far, RK3588 doesn't have the pclks for DDRMON used in the driver, as
> they weren't modelled before.
> 
> However, they are now correctly modelled, so the driver should use them
> when possible.
> 
> Instead of unconditionally getting them for this SoC, add a new variant
> member that specifies whether the driver should let missing clocks
> slide. This is needed because we want old device trees to keep
> functioning, as otherwise we'd be introducing a breaking change for
> literally no functional difference here.
> 
> Fill out a clock name list for this variant as well, and hand it to it.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 2b9d9b26b11a..c51d7eeec394 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -117,6 +117,18 @@ struct rockchip_dfi {
>  	const struct rockchip_dfi_variant *variant;
>  };
>  
> +/**
> + * struct rockchip_dfi_variant
> + * @init: pointer to the variant-specific initialisation function
> + * @stride: address offset between the DDRMON per-channel instances
> + * @ctrl_single: whether only one DDRMON instance monitors multiple channels
> + * @max_channels: maximum number of memory channels for this SoC
> + * @clk_names: pointer to a constant array of constant clock name strings
> + * @num_clks: the number of elements in the @clk_names array
> + * @clocks_optional: whether not finding the clocks is non-fatal. Set if the
> + *                   DT binding for this variant didn't require clocks in the
> + *                   past, so that the driver remains compatible with old DTs.
> + */
>  struct rockchip_dfi_variant {
>  	int (*init)(struct rockchip_dfi *dfi);
>  	int stride;
> @@ -124,6 +136,7 @@ struct rockchip_dfi_variant {
>  	unsigned int max_channels;
>  	const char * const *clk_names;
>  	unsigned int num_clks;
> +	bool clocks_optional;
>  };
>  
>  static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
> @@ -806,6 +819,11 @@ static const char * const rk3399_clk_names[] = {
>  	"pclk_ddr_mon",
>  };
>  
> +static const char * const rk3588_clk_names[] = {
> +	"pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1", "pclk_ddr_mon_ch2",
> +	"pclk_ddr_mon_ch3",
> +};

For proper operation of this patch, the following patch should be applied.
The following patch is applied to other git?

https://lore.kernel.org/linux-rockchip/20260921-rockchip-dfi-cleanup-v2-6-43ff34ac8599@collabora.com/

> +
>  static const struct rockchip_dfi_variant rk3399_variant = {
>  	.init = rk3399_dfi_init,
>  	.stride = 0x14,
> @@ -826,6 +844,9 @@ static const struct rockchip_dfi_variant rk3588_variant = {
>  	.init = rk3588_dfi_init,
>  	.stride = 0x4000,
>  	.max_channels = 4,
> +	.clk_names = rk3588_clk_names,
> +	.num_clks = ARRAY_SIZE(rk3588_clk_names),
> +	.clocks_optional = true,
>  };
>  
>  static const struct of_device_id rockchip_dfi_id_match[] = {
> @@ -885,8 +906,12 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
>  		for (i = 0; i < dfi->variant->num_clks; i++)
>  			dfi->clocks[i].id = dfi->variant->clk_names[i];
>  
> -		ret = devm_clk_bulk_get(dev, dfi->variant->num_clks,
> -					dfi->clocks);
> +		if (dfi->variant->clocks_optional)
> +			ret = devm_clk_bulk_get_optional(dev, dfi->variant->num_clks,
> +							 dfi->clocks);
> +		else
> +			ret = devm_clk_bulk_get(dev, dfi->variant->num_clks,
> +						dfi->clocks);
>  		if (ret)
>  			return dev_err_probe(dev, ret, "failed to get clocks\n");
>  	}
> 


-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
