Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610643;
	b=Nj6IuyEtWrGyxSU0FOHQtC2SVhd80teDtKv0GHSLBALijE6vLm53oyKJlVkoJTJQde1/
	 lJMoaCxyn9zIpU6qJHyQqJOIIZVCp8epQpocdp33P5Jkrv6NfXIemznjAmuH6Y/qmuHJ+
	 zwVvO7aObChWX9HtwbLzaCT/9XpVkSDPY0+22cpH7ZNTtoNmNYR9wY4gMDvpnkKEs88Hs
	 Sa2WOpJjPPSooiR+dwQn0H2DiP4T4Kv9bn3jiSvK3gOb/BgqnYGs9KsotNTCvyVy1gLpN
	 kG2dJM5hVZdU4x2nV5VviTJAVq4miVp2C2c19/e9Efo46ZlHHmnL0iQ71ZN2/nkKqkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=UQXefZbpyINO7gDBDyjwA6nRNyUzqCa+7+QTu56koVI=;
	b=HcxLl0evCZ0/k0twpVY+vOqh+42HkZlw9Qfg/7N2nQbZNcBznZZK8Mv9wGHEk78FYQYl
	 KZWf92cQrFhT31Mr3WIK+EG6wUIIpz3tfo9II3aMUli+HwArx/JTzKFyz63CfvfxCNcB6
	 anOAcH0SjwJ2VXfCrpK2M2SZHTZXrg1mKODBi+/KmljnhxLd72/y1DJIvSGpdkxb58D9/
	 Qd8n/62PMJGfziLwuQdfjg8SX9mKINM+BNF9QAUxYZSRkhxH/I3q51HXitMSIHGCrSNzn
	 rtpx7COc8GXYRIvPbZseNAdqeTSAhQ1qqNwe1EPN5v90ILHJyhSYa4Lo80HAsplSpqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dc7Xe3z3;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C366606A33B
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 22:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C366606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dc7Xe3z3
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-372bdb942dbso1685130eec.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 14:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794610641; x=1795215441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQXefZbpyINO7gDBDyjwA6nRNyUzqCa+7+QTu56koVI=;
        b=dc7Xe3z3l6rITAVAoMVHoSHNFqsQ3y2ODSiuZ0Y7COJxadDAULe7fhlaNqJfRVnbDl
         a9Z+YoaLO/8s+/S0noGDG6rmWspSzfXPSPPHtrVinBd5Xw4XO9kh7tnqVsJxfIaX8+tz
         TYrOCX9/Um/v9R94CGbOm3YxXbL1RbDVwLi+p8kTaWJUmIEFAUa6NfGDD7Np4dRQnnxI
         MGFqulnx0l8WMkYf7idKaZpK1CERc8JSYoc/tfleIAyLzt+Jr1fJBPb53/g5HIarGrl5
         ihJWpHronFta1R9jiwEGsLLx5LzksFoAOOtPL1QsNQkP9ur5vcdBjJFPfyYacK1or8KX
         txBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794610641; x=1795215441;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQXefZbpyINO7gDBDyjwA6nRNyUzqCa+7+QTu56koVI=;
        b=WubE5NzY+/qM6Ud1oVspplM8xf61FlBWLjm7zzvfk7k2wIr+tnIbuk5zVuWv9d2Tbp
         5MX2JmQzA5/xZHDvdUJzUxZYglpX6ER9aN3K2xnuB7I1utCLXfagMxqbhSKVJ3kQsRFq
         tdP5B5wji6eosAYXxZ+CjjaIdnWFLaKId9RJIJu9FrtcDjKAkTWmFP8KENKKcldv0adU
         +m1twwqeEM51Yf4l7qLaWt19ItQouOyF++Gm5voAlRC8K6x2Px1aSN6GcXD0ixWACKVJ
         hai74ctmxGANFV5799mPbCZDJg5WPX0pGdhVj+aOBZYVu36htVYCOBZg3n8tZIuwSvrs
         23yA==
X-Gm-Message-State: APuU4Z9M84vFqEf9hUmrbR+8AiskKrw1B3O085QpOVik3weMpq9l2fqY
	+r7/OvODGVl6yZFeq6msGXIcioOaRukYCYAETzCa51Kf/eRx3dN7uMSh4erMY0Nl6w==
X-Gm-Gg: AYBFou1hf94CPZ4QISs0NDM2tv21sKxenhrtgohyY0kwbFTZvBjYHxMxvQKOvHu/GlU
	XLsnjxc8YRDfd4PZQhvH6ifKP8tJCdtuTrz2H1AliUDr0kZFwG9t2rwAKsMfnkvojHc83cXJiwK
	+j8znF3WvpMSjHIywh/QQ1DdtKwpzPWhAJy+aJhLU/7yoFNu7lTROnQDthJjlXvgVl68JBHPgtC
	UU5g0DiIXxtC8bs8glY6Yzww6hpuxgGNePl7T7ntMeF3UBDtKI8oQmLgaBFICRU5dxDlY0WX1yt
	s7Ixt6EklnwqvgcEIibI+255e7Rhbx1aciH6gOOMnHDH6usbIE8Q0sADMF9YHmAgVvp61nQxSXG
	EsYrp7jHMDJu8fO2JppZIJMT4JTZPuaFpVCdqiQuznrbReORE7RC0IH7DfJGvaDwerYQo7muzte
	AAIXxqNbKRElOunxQBP++eFMpYeaerZP2dQh4TvqzXOPANk1wjKWCVl29whSJ17yTv3vH39BrzZ
	JEm/Scp9rl65jTfoupAQ+JOijBoGHeiSxmtjPfAAi63Dz1yS+jOyyZ5z5siVeKb+yffACR7xALq
	HCuDAx5xt2rkgnYVD3RjimidT6/Q1W59koQ37ZdsdrFZbwspZitZu1QT2lO7AIGmBPYtrTrzWSE
	y7+am1cpRgUh/z/hKpU6ir5N0fVYVgwHCGPCxp/l7G61Wl9CgS3LfLEaHUVdV
X-Received: by 2002:a05:693c:414e:20b0:36c:49a7:86ac with SMTP id 5a478bee46e88-37968b8ee68mr3649203eec.37.1794610640558;
        Fri, 13 Nov 2026 14:57:20 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:9:8b75:c381:2810:3097? ([2a00:79e0:2e7c:9:8b75:c381:2810:3097])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm9566278eec.4.2026.11.13.14.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 14:57:20 -0800 (PST)
Message-ID: <0d02b1fc-a6a8-4250-9d59-b11a6d67cd21@google.com>
Date: Fri, 13 Nov 2026 14:57:16 -0800
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
Subject: Re: [PATCH] power: supply: max77759: initialize registration,
 configurations
To: Christian Loehle <christian.loehle@arm.com>, sre@kernel.org
Cc: linux-pm <linux-pm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e93f0875-7350-4208-b91a-4aeda1fa7cd7@arm.com>
From: Amit Sunil Dhamne <amitsd@google.com>
Content-Language: en-US
In-Reply-To: <e93f0875-7350-4208-b91a-4aeda1fa7cd7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 3:14 PM, Christian Loehle wrote:
> Booting a Pixel 6 with CONFIG_INIT_STACK_NONE can oops in
> internal_create_group() while probing the MAX77759 charger. The probe
> only initializes fwnode and drv_data in its automatic power_supply_config.
> The power-supply core copies the uninitialized attr_grp into dev->groups,
> allowing sysfs to follow an invalid attribute-group pointer.
> The local regulator_config is also only partly initialized. Its unused
> init_data, regmap and ena_gpiod fields can be consumed by regulator core.
> Parsing the device tree does not initialize all of these fields.
> 
> Zero-initialize them both configurations before used fields are
> assigned.
> 
> Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Amit Sunil Dhamne <amitsd@google.com>

> ---
>  drivers/power/supply/max77759_charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
> index a93adb266f01..e792327ff14f 100644
> --- a/drivers/power/supply/max77759_charger.c
> +++ b/drivers/power/supply/max77759_charger.c
> @@ -683,8 +683,8 @@ static void max_tcpci_unregister_psy_notifier(void *nb)
>  
>  static int max77759_charger_probe(struct platform_device *pdev)
>  {
> -	struct regulator_config chgin_otg_reg_cfg;
> -	struct power_supply_config psy_cfg;
> +	struct regulator_config chgin_otg_reg_cfg = {};
> +	struct power_supply_config psy_cfg = {};
>  	struct device *dev = &pdev->dev;
>  	struct max77759_charger *chg;
>  	int ret;

