Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B9E3D3302;
	Wed,  5 Aug 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961473; cv=none; b=Yi71xxno2Qs4QQzqADuLVF0ldbfM5isoK5GqNJEvjeFam43ayjG3+VsCeD4La9V9veVN13FDliFVQywXuoot2z32XVifKOAc+IwEArLIKB8joLZqsDY40VRM9hdxgDvN6eNU1cMf2e+MNPcY0CDz1Cb4ymm1I4l/1ItfocW19ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961473; c=relaxed/simple;
	bh=IIE3u8srsOWgIOJO0YdejbZre3in0zRoedz1p4ZgRxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r14TfsoQzFMIb6RDLAkv892kUesvBGFT0z91M62JvC79P9kcCpHcmyBf587f/s7Wiz0EyiSw6bk6ylW0LiFLvQ3ShDIYwXrqnrFJpyhCbySLBpivcT7MGG3S3Ot2Gb5ui+voQZFxAFOJjMDS24S5J+MQqHXd09HtpeIgm+WpAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gCkftO02; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gCkftO02"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=C3x0mMXb8xK4Txc32OTX6BYPYD69PgClixHyFbpA0Z0=; b=gCkftO02aV/1Vjxl8lS9/zysvT
	uHAHnNEcYRIPnxOJGYEgsYEMEP8wL/sNnzp0/rkhXZdUSsz+Q5sNUHrSJq15c1jNliiidaughlBuR
	+TCTp/5aqAepN5gpodmK/bJZotBgIBY1AyXoZxZLyVr5YrX/8pJrPsLTvhz1soiXSKe4g2FfZmStr
	7TGpmg+Va+rcT0vqyxOh4rxoXWIO8oxPjGvBHGOiVpv65nV5arXWA3/vo20GaGTyicbIfQbolJHnd
	JgZfZbxF+wTTVfvIpupBrusyebI+IX8q9zXVlOGsokiwn9QrzgueEt1YGFG+Yfg9FlPf+Lb8UvrLe
	ENoqcW3g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wriA5-00000004Wd6-1xQd;
	Wed, 05 Aug 2026 20:24:25 +0000
Message-ID: <d6a18ccc-8c84-425c-873e-36d8729bd1f8@infradead.org>
Date: Wed, 5 Aug 2026 13:24:24 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: add stubs for notifier registration
 helpers
To: Elson Serrao <elson.serrao@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805185401.3625514-1-elson.serrao@oss.qualcomm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260805185401.3625514-1-elson.serrao@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/5/26 11:54 AM, Elson Serrao wrote:
> power_supply_reg_notifier() and power_supply_unreg_notifier() are declared
> unconditionally, with no fallback when CONFIG_POWER_SUPPLY is disabled.
> Any driver that calls them unconditionally fails to link:
> 
> ERROR: modpost: "power_supply_unreg_notifier" [drivers/usb/dwc3/dwc3.ko]
> undefined!
> ERROR: modpost: "power_supply_reg_notifier" [drivers/usb/dwc3/dwc3.ko]
> undefined!
> 
> Fix this by adding stub functions for these calls.
> 
> Fixes: 7c87ef27af79 ("usb: dwc3: avoid probe deferral when USB power supply is not available")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/a9dd53b3-0666-404a-99e0-76617ae3f944@infradead.org/
> Signed-off-by: Elson Serrao <elson.serrao@oss.qualcomm.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/power_supply.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index a9c056f13077..e749d2189335 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -816,15 +816,18 @@ struct power_supply_battery_info {
>  	int bti_resistance_tolerance;
>  };
>  
> +#if IS_ENABLED(CONFIG_POWER_SUPPLY)
>  extern int power_supply_reg_notifier(struct notifier_block *nb);
>  extern void power_supply_unreg_notifier(struct notifier_block *nb);
> -#if IS_ENABLED(CONFIG_POWER_SUPPLY)
>  extern struct power_supply *power_supply_get_by_name(const char *name);
>  extern int __must_check power_supply_get_system_batteries(struct device *dev,
>  							  struct power_supply ***psys);
>  extern void power_supply_put_system_batteries(struct power_supply **psys, int count);
>  extern void power_supply_put(struct power_supply *psy);
>  #else
> +static inline int power_supply_reg_notifier(struct notifier_block *nb)
> +{ return -EOPNOTSUPP; }
> +static inline void power_supply_unreg_notifier(struct notifier_block *nb) {}
>  static inline void power_supply_put(struct power_supply *psy) {}
>  static inline struct power_supply *power_supply_get_by_name(const char *name)
>  { return NULL; }

-- 
~Randy
