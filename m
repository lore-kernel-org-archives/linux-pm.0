Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599238;
	b=V1tt144shMuz8vA0rjMSYrWe96wfNjI4EbbMMocxzeKh9J5G1cqReNM9gTKJnxkQRDZA
	 b21rnhjdOD8KsuU/cUGS+7G5WAFqEAGI2tcY7dFZ+mi7sEww76Zt2EW6VoJpACDuM+wpa
	 sTdgIbOYDJIsOePsme6nahI59aWvfHw+RbOXefD9oQRVv68g6WkdmDhlmFU5bltDIUX7K
	 pN4lwPYjsXA1Us2rv+H1T+lReqRyG3MRzEiwY9zE21RTJqOUKa4A4ZgRCvoMzj7BgblGy
	 IROsQQF9RtCuxFSAmQ7ExlWuy/c8bW834HbUe/K3oWUiBpjTMjAFEamPB4BtBATgsoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IeG8GW29CPTq2V+5DOuKsl8l1CpVGznlbRHng5hlVeQ=;
	b=SamXGrqyr3/4xnPu8IYIx6ZC5scX4hz4dRNbISSJ78YxGeRKxUE0H2ZiDdJkJePbd/f4
	 iR6AP9IUHckc9I6h18ZPDQLIVN2IapFjEfZTpCORY4O309hSy8DroblPYdh3lqx5020O1
	 SiSq9z4Dz38hnuAtMDXGj4szyQiIzvmFPwueiE9UP+Mmj9dhxcRzQn890J47a4befem8j
	 z1CnmrLzJ+IcDsgi+N6zpp7LJbZd8btVs208mrFDfL9edkYo1Bov7Sn4wJQL9lP+ZwaK2
	 L7q0Pa7eWosF5jIfDVhrqDSWvCpaIY7xq+MEql35RLCITnJtuwCGLUgGuVuHJwZO08w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGpcEftj;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE3606A32D
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 19:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1EE3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGpcEftj
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3720addb068so2185942eec.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 11:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794599237; x=1795204037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IeG8GW29CPTq2V+5DOuKsl8l1CpVGznlbRHng5hlVeQ=;
        b=FGpcEftjGf/8FeLN5xx8lCOAqwDTwoq4kDQD/mgzYbfy+mu5nR+BGXOJ0a/01GFvSx
         Eq53qQ35WUOg89/AJrzV5OQu5EVEf3qMAdin182glN9Yl0/NWgtVQYH//8aOcdKYqavQ
         lK10NcJw7FiG4CTWFP95gxEDOspGbopsMws5QHEQKGHGVPC2d6jLoeUeDBTfJvg+V8Mr
         Op7NpOmFiIIWblp6grKK+UhaJ5tTzIoVh7hSgqJYlYx9M4ot0z3Ae4T6pxW/hQzcQfPd
         GKjPKAbhFHA12Ato5S20OJM6PdX3IPwr/KngIqGmYk13Znt7ecuUm5ULe5biyqNw5LuW
         K9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599237; x=1795204037;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IeG8GW29CPTq2V+5DOuKsl8l1CpVGznlbRHng5hlVeQ=;
        b=mf7HZ45i+yw3Hc9SVYFDl2pN0391/qMddW2tXaUI/sl5mdAdTZf5EuYhnEIVaQxVRN
         i/hSvTnF68koR3lGoU5C6XhSPP6RJKWOC/aGBcICSKe/aOHqEJqP5L7A5qb3fv1jHAja
         590zWi5kQEscT15bEM+hGZY7WZsqSv9xDbdnbrfAQ9ra5VBwwYFE5i53Bp9ASOw9GJaL
         kNX6StKTCzM2V+R8xMK80sLyb19VTtxJO6YyMunNoyxdyxNVLthmEFHi3TVpYdMNGxV1
         wT3b7JYnh49gDbtg1hrw4mHBr6XRBbsfpQju/XUpz7GQf1d4720DfQKVAocqpqfuNkS5
         tL3Q==
X-Forwarded-Encrypted: i=1; AL+hErGZ8dHsEhIZQFjovjxWBMqBV5r+Od4WZ9Hznsavd+8JZPDj2OQFpjAMYJXOpx3k5ppLB1/yB5bOdA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/To4ztl6xPu+HfUryUHmHGGQthsoJY1OyiG3NyLF0Hu9Bu+N/2
	lVtDziZkU1/KQszvqbVWm9Mx235AliLny3lyGe5plmC+ezRCOdT2vShr
X-Gm-Gg: AYBFou0v4OdJdFZqZFwse3quSPkf0Oa9j0/ogeJKxu6SumKII9gTYMW0HhHiEoEsDsc
	AiiYw1A6T8YcL3JkBzOrFOuJPt9BDEzhYqCEfyFlNeqqdsQuhCpM1XJET8MNqWNA1oJrmFCv73B
	z94kQYpxg/jf0rshzb/tVJyvo+2G1RFQYnkWYOCTKJ+bRPx+b65xDAoFXd4gykEC4osPWmVLscw
	D8cLP+4zSZv1ws9wZiQqgopzaPggPdA5tvBKjphINtTJ3/Cng7cwZ5RPrY5IIupzaCyrGj2ZHUO
	6Rc84FDq8oRpdMOBLvEvT8QLUc5m1uXTJsqKXZCNVQyCdO2e/IuZXYlX/XBR9a2JLmc9EOVsKot
	UyLQCuVDafuiUG+Fj0s2DbfcPMu/r9XmmhHu2jS62eGW0E/3xGVfvljE1O156WYpC7ZQxOyUPOw
	3ScOxJjZNkOHCgOhHdRWDn955jScMQxb7A2U/kS1Z+P/Qxm4TRVFjHa3Suxlk2NIZ6+pzqhm9p6
	c4aWaHbh0ieK/t2IaeI1UGZ4m2LqeEaTMZeaHgxMClRVbCiA/LXZvznda+rkhxpNHnBEz+EIs8W
	xDxOM2h3vAToRtciq0GZ/U0njgY0/Sdnyra1H86j+wkcKnYEa+AreRalm69s99RaNQ==
X-Received: by 2002:a05:693c:83cb:20b0:375:388:a6d5 with SMTP id 5a478bee46e88-379675fc8fbmr2832268eec.32.1794599236582;
        Fri, 13 Nov 2026 11:47:16 -0800 (PST)
Received: from [192.168.35.9] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955a1c5c2sm10172682eec.14.2026.11.13.11.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 11:47:16 -0800 (PST)
Message-ID: <953597c5-80f6-4ee7-b8db-ec7264d99e40@gmail.com>
Date: Sat, 14 Nov 2026 04:47:09 +0900
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
Subject: Re: [PATCH v2 2/5] devfreq: Use %pe to print error pointers
 symbolically
To: Sumeet Pawnikar <sumeet4linux@gmail.com>, rafael@kernel.org,
 krzk@kernel.org, amit.kachhap@gmail.com, daniel.lezcano@kernel.org,
 thara.gopinath@gmail.com, talel@amazon.com, hayashi.kunihiko@socionext.com,
 mhiramat@kernel.org, mmayer@broadcom.com, viresh.kumar@linaro.org,
 sumitg@nvidia.com, peter.griffin@linaro.org, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, Frank.Li@nxp.com,
 s.hauer@pengutronix.de, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, sven@kernel.org, j@jannau.net,
 marcan@marcan.st, casey.connolly@linaro.org, sre@kernel.org,
 wens@kernel.org, t.schramm@manjaro.org
Cc: bcm-kernel-feedback-list@broadcom.com, linux-samsung-soc@vger.kernel.org,
 kernel@pengutronix.de, imx@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260912191156.185448-1-sumeet4linux@gmail.com>
 <20260912191156.185448-3-sumeet4linux@gmail.com>
Content-Language: ko
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260912191156.185448-3-sumeet4linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/13/2026 4:11 AM, Sumeet Pawnikar wrote:
> Replace PTR_ERR() and %ld with %pe and pass the original pointer directly
> to dev_err(). The %pe format specifier prints a symbolic error name (e.g.
> -ENOMEM) when CONFIG_SYMBOLIC_ERRNAME is enabled, otherwise it falls back
> gracefully and prints the raw integer value. This makes messages more
> readable without any functional change.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/devfreq/imx-bus.c    | 4 ++--
>  drivers/devfreq/imx8m-ddrc.c | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index 49798f542d68..dba76d8b9e5a 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -75,8 +75,8 @@ static int imx_bus_init_icc(struct device *dev)
>  	priv->icc_pdev = platform_device_register_data(
>  			dev, icc_driver_name, -1, NULL, 0);
>  	if (IS_ERR(priv->icc_pdev)) {
> -		dev_err(dev, "failed to register icc provider %s: %ld\n",
> -				icc_driver_name, PTR_ERR(priv->icc_pdev));
> +		dev_err(dev, "failed to register icc provider %s: %pe\n",
> +				icc_driver_name, priv->icc_pdev);
>  		return PTR_ERR(priv->icc_pdev);
>  	}
>  
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index 52beeb5b7d65..28d7c595fa17 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -340,8 +340,7 @@ static int imx8m_ddrc_check_opps(struct device *dev)
>  	for (i = 0, freq = 0; i < opp_count; ++i, ++freq) {
>  		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
>  		if (IS_ERR(opp)) {
> -			dev_err(dev, "Failed enumerating OPPs: %ld\n",
> -				PTR_ERR(opp));
> +			dev_err(dev, "Failed enumerating OPPs: %pe\n", opp);
>  			return PTR_ERR(opp);
>  		}
>  		dev_pm_opp_put(opp);

Hi,

Applied it.

Thanks

