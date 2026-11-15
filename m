Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704416;
	b=SjfNSi0Nc8FuvkM9n5Z+Q7gQhN1rodIShDc9PE96tJSap1nEBgsd8qtrcFZca4h/PixM
	 FaRVCZeBcPGvnoYybAm/dSN1fhWqJOitGncuwjVFnpa7ZHqgkr4UtB4Ka/7KsHZUW1Ab9
	 HH/tFap6VxF4RARU6Mz+y6rOcNiBJ14EJsOnyC1q7k1VIPPS1KYAjUgAdmsQvdFCUQfQd
	 6jDqBR2KaEYkfeQfnQDt+ROOxDgemXm/CqVUpHKMwWPRNExTAT3yOI1rj0cHMWNwzlAfI
	 5/4p5ASU3w8m8GUFmmFBVNrDSSqmbLD2DYXlNH9ouPNDNd1bazMkuRItZkG4KRFdw6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5JVcksrPn6+Ig6tuNU22o2qjR3uSsPz6hcIi+8PBA4g=;
	b=mlFYe5DruDcksSFUUYzbqO+uG/92v759AYdmv12eubSOJwJN1JBIgdZsUPxSKpPv2gDq
	 edc+ZWYGa+7u7VMLP67husvPqsddadZA2gTlqe/dD+oW5a7YuuJikPTaDkNgZN7i17PXc
	 N7EFXtf0GQiYacpmeSS4ud7IR0YCFNml/+Oidc/sjZBB9wsNiN5vpYz9KTBcaLLl0Z9lL
	 +O/53sRvmfd4yXqRm5Do8OB3EmYKLyDOZjk8+/RptAFu6AwfhbvT/+gVfh6bTgusURLYE
	 TiRcGxTYDKfGijz1ta+zgptl6oGP28Qg3YeJWMLLCtHqhPItrdzkhVUlFploVJkYHmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XcrRPS93;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E03606A32F
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 01:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3E03606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XcrRPS93
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37d424f1ae8so504232eec.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 17:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794704414; x=1795309214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5JVcksrPn6+Ig6tuNU22o2qjR3uSsPz6hcIi+8PBA4g=;
        b=XcrRPS936P40vJno3XvqyDp8fAli9TuND9KYSi1V5lmSwLiBH63p01bDAcdtZA4bTX
         J/W9I4NXICyt47rJfltq6+b8mnoNn5sCp1YIjAjkpT9u5Uq0y6ipNma8gZPZn+k1AUdY
         z+fOIkNd+wcVt5uX2/wOLwR8dQN9cgCwc9KvVOlp7KrLJwqEGJLar9ZdARuOoIe3VvHT
         CiHYsCOxpMRDw4MP9d3JbSzEONnWzYdpfjGvRxRSWlE1W+CyGw/dHDcxOAcO1Lv8fXxC
         OEnkpOWaEGBrRwsieMLA9wlrMVLqI1ceO084+uugzp4XTcYP4wip3TWr4R2VBgYf+ooz
         DX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794704414; x=1795309214;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5JVcksrPn6+Ig6tuNU22o2qjR3uSsPz6hcIi+8PBA4g=;
        b=ncsxtEZaSFVhzHBaBNmYiu+RJosAfMUeHNQQh7CuziftHs70ZezYiuT+pfEEf/Puj1
         8/Qat25BufQ04bYk9qCpBdlMy3a4uKMljR/4IeYTsBA0Di7hGNk0IZ47JlWnOHDSqpad
         0oGIhNEGNZvXI9Ia8MleWGX+FhWrC3hIVjj+gy5OL7LeXUzDzTe3wG9aFaSShMEQM1hj
         MPGLNJK/3IEmQbdFciG6i6NXgTOOJ7YPp0qqCnJ457j4tijS0LNPNRYg4gUHO2uXxnGE
         nIGa/PX788GRLAI+gOx8hUpuXSq/fC/5RmoMoZvbaHPNpVPov+QtG5qz/gqALDWRrGE0
         4AHw==
X-Forwarded-Encrypted: i=1; AL+hErEaOJyaaqTd1xAbL+7KnJIVvYOsHCGXMG+N9iXaKI2MPNM502LYn15bFbWawk+11483umXz+RWwSg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8pjqsO4E2YmDfDQ22c33Vk8IMqvW6SHrMlRpjtmnY0wXufYIng
	7rhKcMyQLQxBe8j9Lqp4lVZfZ7pF5df760+07s9edqIrxauoPgs3gWfT
X-Gm-Gg: AYBFou0/jDVNKZiovBXDNx4FNfb3RuSahtk+531AdvSnJqHzxgMWQexdjx8/On+RckT
	oqiRIdInWmAVVG5j3BStLsmLb43y8YzlrFnzD/OPn25rq4Evh8YjX5OTLDaWeGIe8KrjdsdI6h9
	29dPVJ7PoDhjv8ps0uVTdI7p5eC/pSnmLxMpcOqatkEo2KW4wwQu18d9tPDydqEvHn3BYMv2KA5
	Vjdmsf1JRFzKklLoZeP67wVhOM/tPRd7m4KqPdGn1b3FCBE8fuRVzJS7sW74gU+GjXbuq/tMckS
	9FYB6MjYDjFEpon/8iMGvTrvAjyl2K9dTv60Sry6K+Lsuq1wPv3Guv+TGTfaDWS1JBuxFR17eT6
	PwWv05iHt45WxP+4J38QM8PSsn+7/LraDJVPNJPtVobDKHGD/HmvTcNS1NmFc5e/40wSPmkLtMs
	H8yobrxmNIdzdazpKCDfTcaYLlJ/uyyIW5slH8H15gNextPj1/hxLN+F/86FzKjjl/556955s74
	GpeJUS9t7lGX/BRhYLNlFZqSiSil+znUnGt2gIEUFi0MUWtTW27KjJtbsILxDOrmX3nohPUIzp5
	A15kxhwfCfbhP5+fXAkDwOZ9eeDcEjIj05yFHWihlGQQN5TChHApJKp3BWvIIBcUdTQ=
X-Received: by 2002:a05:7300:7481:b0:375:c5e1:931d with SMTP id 5a478bee46e88-37966e3aff8mr9267695eec.25.1794704413837;
        Sat, 14 Nov 2026 17:00:13 -0800 (PST)
Received: from [192.168.35.43] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379560f5e06sm26895445eec.19.2026.11.14.17.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 17:00:13 -0800 (PST)
Message-ID: <c0b9ed82-3e30-4f53-809e-e7f35b0296d7@gmail.com>
Date: Sun, 15 Nov 2026 10:00:08 +0900
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
Subject: Re: [PATCH v2 7/7] PM / devfreq: rockchip-dfi: add RK3576 support
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
 <20260921-b4-rockchip-dfi-rk3576-support-v2-7-04f847016321@collabora.com>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260921-b4-rockchip-dfi-rk3576-support-v2-7-04f847016321@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 6:15 AM, Sebastian Reichel wrote:
> Add RK3576 support to the DFI driver exposing the same functionality
> as found on previous chips. This uses the RK3588 init for getting the
> DRAM type info from the GRF registers. In contrast to RK3588 it uses
> a newer DDRMON controller IP, though (version 0x40).
> 
> Co-developed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 8ba97af78e3d..a895e566b4b9 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -858,6 +858,10 @@ static const char * const rk3399_clk_names[] = {
>  	"pclk_ddr_mon",
>  };
>  
> +static const char * const rk3576_clk_names[] = {
> +	"pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1",
> +};
> +
>  static const char * const rk3588_clk_names[] = {
>  	"pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1", "pclk_ddr_mon_ch2",
>  	"pclk_ddr_mon_ch3",
> @@ -887,6 +891,18 @@ static const struct rockchip_dfi_variant rk3568_variant = {
>  	.reg_access = 0x2c,
>  };
>  
> +static const struct rockchip_dfi_variant rk3576_variant = {
> +	.init = rk3588_dfi_init,
> +	.stride = 0x10000,
> +	.max_channels = 2,
> +	.clk_names = rk3576_clk_names,
> +	.num_clks = ARRAY_SIZE(rk3576_clk_names),
> +	.reg_write_access = 0x28,
> +	.reg_read_access = 0x2c,
> +	.reg_access = 0x34,
> +	.reg_clock_cycles = 0x30,
> +};
> +
>  static const struct rockchip_dfi_variant rk3588_variant = {
>  	.init = rk3588_dfi_init,
>  	.stride = 0x4000,
> @@ -903,6 +919,7 @@ static const struct rockchip_dfi_variant rk3588_variant = {
>  static const struct of_device_id rockchip_dfi_id_match[] = {
>  	{ .compatible = "rockchip,rk3399-dfi", .data = &rk3399_variant },
>  	{ .compatible = "rockchip,rk3568-dfi", .data = &rk3568_variant },
> +	{ .compatible = "rockchip,rk3576-dfi", .data = &rk3576_variant },
>  	{ .compatible = "rockchip,rk3588-dfi", .data = &rk3588_variant },
>  	{ },
>  };
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
