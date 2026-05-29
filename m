Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B7A3264E7;
	Fri, 29 May 2026 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061283; cv=none; b=Yxv27C7D8liTcEVRE1NGxn7/VpOd9u3U0XNu0XWrrvlOsoKTINKqC+6Bng5DzpRWP1sLyzwendIgrOJY8PHKTTNBQrZsk1xr1mMn6fB6tq+l26kodp9iQ4DZPHvXtntlu4m8JvMKBFdugUsrlmWQu6WY3rb4xh7QayNmKkfh7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061283; c=relaxed/simple;
	bh=8vbBA8zpJidr2ow8HudpSBHS9WleA2rXa/gnXU0xu+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSEoAMK7DBbFEVxO+qOrlx0XhlR09SEHXJmNLI7pJKpgOMXnQKYbBQxhienhq4hludHnUjlJh0Y1B9OU0wgXjSO/VULtENwEXhas9ffHlnT38nUnbKePQZ8fyTjoHTl+8eaM1obmiDvltMtnaTJ5unkd6X+bCOsviaeOyzroi1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qsR1gYXM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qsR1gYXM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7152220E3;
	Fri, 29 May 2026 06:27:55 -0700 (PDT)
Received: from [10.57.26.238] (unknown [10.57.26.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4021F3F905;
	Fri, 29 May 2026 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780061280; bh=8vbBA8zpJidr2ow8HudpSBHS9WleA2rXa/gnXU0xu+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qsR1gYXM1cOjWCrwsD539WkFkaY98RHzl7VCpjZgrjqNAW7Huyegj4HhtYugXsGLR
	 ZbMqoesLcKllZwYzWyu4JIkmEfm//m0lphDtAnjBoGBb+/NFddERWGMI6itOmDUFvI
	 Y08M7K/ly7IkzlIkgq6WVEHR7HlM17AMdd8mP0pw=
Message-ID: <a1d2999a-7d87-42d0-ad1b-65823eca3b9f@arm.com>
Date: Fri, 29 May 2026 14:27:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] thermal/core: Make cooling device OF node
 conditional on CONFIG_THERMAL_OF
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org,
 daniel.lezcano@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Avi Fishman <avifishman70@gmail.com>,
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
 Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
 Benjamin Fair <benjaminfair@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Amit Daniel Kachhap <amit.kachhap@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Amit Kucheria
 <amitk@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
 <20260526140802.1059293-16-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260526140802.1059293-16-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/26/26 15:08, Daniel Lezcano wrote:
> The device node pointer stored in struct thermal_cooling_device is
> only used by the OF-specific thermal code to associate cooling devices
> with thermal zones defined in device tree.
> 
> Now that OF and non-OF registration paths are separated and non-OF
> users no longer rely on devm_thermal_of_cooling_device_register() with
> a NULL device node, the np field is no longer required for non-OF
> configurations.
> 
> Make this field conditional on CONFIG_THERMAL_OF to reduce memory
> footprint and better reflect its usage.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   include/linux/thermal.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index fc3f4a098370..60e596e7d7ae 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -125,7 +125,6 @@ struct thermal_cooling_device {
>   	const char *type;
>   	unsigned long max_state;
>   	struct device device;
> -	struct device_node *np;
>   	void *devdata;
>   	void *stats;
>   	const struct thermal_cooling_device_ops *ops;
> @@ -133,6 +132,9 @@ struct thermal_cooling_device {
>   	struct mutex lock; /* protect thermal_instances list */
>   	struct list_head thermal_instances;
>   	struct list_head node;
> +#ifdef CONFIG_THERMAL_OF
> +	struct device_node *np;
> +#endif
>   #ifdef CONFIG_THERMAL_DEBUGFS
>   	struct thermal_debugfs *debugfs;
>   #endif



I've done compilation w/o THERMAL_OF set because it
was a bit odd...
It triggers an issue in the thermal_core.c at:
cdev->np which is left. This might break some bisect
in the suture if that would be the case.

drivers/thermal/thermal_core.c: In function 
‘thermal_of_cooling_device_register’:
drivers/thermal/thermal_core.c:1121:13: error: ‘struct 
thermal_cooling_device’ has no member named ‘np’
  1121 |         cdev->np = np;
       |             ^~
make[4]: *** [scripts/Makefile.build:289: 
drivers/thermal/thermal_core.o] Error 1
make[3]: *** [scripts/Makefile.build:548: drivers/thermal] Error 2
make[3]: *** Waiting for unfinished jobs....


Let's maybe change the order with patch 05/10 ?
