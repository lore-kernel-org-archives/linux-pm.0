Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1D4756B1
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252046; cv=none; b=Xwm7cIiFkF8UQxwYIS4mrx7KIBTVyOBh7tZktcdEvSv0NdzFEH5EZp5qejUByeBoupV6D0y0lO0TE73nPc+DPGzGJdmpwCVhtHbdpWbGEi7pm/srm68GxucYtSLpcHlDxF07sZzqf1A5rC4cR7lgl/7wua8AEkfUAta+yOzdQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252046; c=relaxed/simple;
	bh=otGD8El/usb5+EdYLvRCSLCI0HhgOOwUewbzGHi4nw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRzlJJxU3ImnpksB3grQ9t5r8AvIBwcnRaw45x1M4lzwIPbrOVW6xJm3hIk/O1kgrNUazE32zjPgn0bi5sIfp6CijOKtcpdpuijrRNeSfNiH46g4x9xGV7TFNwfZYaUscjQbDsrrWI8SMXEETL+GQoBQwVCHq8IR7lMz67/0ZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTu+qwoD; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTu+qwoD"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a59bc470d6so17467901fa.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790252043; x=1790856843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhr+KJXZzXoDkRQD5ZZRVZfYL8tC8NnQwJ47gS6L1EQ=;
        b=pTu+qwoDcb3s9ihKFMqI7NQwOEHuFvOgNt7q+p5D/awpOw5+FjgkvdixZVTTLXU0PF
         s88/18pigY/hzhXLLrYcXOYfG0pCf5yfkiyhaOorgFVae6OyxtA46VfatZz9gVjZ9kg1
         0CTb4JIL1kShApBn82ezMjYSZXrafXw1gCsUfo1KfZ+A9ADhs3h/aiBf/6qrhW5wCc1d
         5vWFJR65yTGqRFcLVs+85xlr01Nota2p0ZWGSeoa697oC4AZ3ArhGfG6UM5uEo9JkgaB
         nxi2NCfs2NE8XksrTnEMIq8peRXVaDWk20NOGdZZVRw0h5IOqScWcc/IOWyRi+2CNb7v
         1xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252043; x=1790856843;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rhr+KJXZzXoDkRQD5ZZRVZfYL8tC8NnQwJ47gS6L1EQ=;
        b=b61L+7R94WFMmU7SVxjqjLaacR2NlL4uSI85cDLd4n9dVrzW/X9/lFTLX/DExr9wcP
         s59x/qjkc8YqJ9rn1AqjD7eUdySVV7Y7haLq32r4YGT1+jiWZoWGnJhKRmFnngTYDEzo
         5XDDUbAISYGeFKTPWK9kXtLWW62QblcYxD9qAPn1e5PSY0/PhRdhIAvEKNuE0aXzSdoC
         7Y+g6i0gzf1F+KPdz6phRyPmSUlmEbGO/poSXbN6i0x6Uq3oZF2o32E7XwR+sA4YkEPm
         +AcJkpSUefCyy36rpMRHXL26C5/ac3tfGhUnQME4pDmKKEb5o08DmHPie++E11OErRz8
         uJZw==
X-Forwarded-Encrypted: i=1; AKwUvBx+jqEZX0zd2eniBPAlDb/XIkjixffl7wzIAusn7/vlfKLoVYudRB0jX7WJ80ZjqAD4dJ7leLzXRg==@vger.kernel.org
X-Gm-Message-State: AFuF++mRzqf0J3XGBxCBdtYDr81yj0rAf+30LSs+14SL8bYAVeeE0qJG
	+vzcXYSz4PoDbAbvk+rNLmOZ/j0zTMf1rFsnaFgeVSNBWs/Dg1rUmEOP
X-Gm-Gg: AYBFou2wyujcZLMhOMcsEoLkZe9Lb5A+3g+Muuu15w7KX70EbHKC34YcZyxESPl7lEj
	dDH4b//Rquwwy7ZeBGBj0WbGEllC5xkG3RceAY+GJ2cVsIIe17LzFJEissW90vlhP7GrRnfM/Tm
	2iGv9n985JWP72rgGK5TlbW8brDuE0WWENilzwyNdKQw+lR4F8toYgwPMVcUXGEezjeQ6c/PfQ3
	WWdyt1e5JUhJJM1yHLIic6rZfJdmLz4s/S4xZksayGn/SHyCUiXo1LjzrU28IODklebL94qyTOf
	dNs7oX+DqWHkQEQuIYllekpZ6iSOz946hDDL7vjwwtn1NbC1XT6vM7AZ2NH4bonPTnFkt3NEQrs
	hH3GShREVvvq3bGfixPzIop1cZM/xtvVJNS4DG9uE/gThtUWo+2pWCYVRjLAN/dSMBwCUag746N
	FtK12XWkfLB1QXU6SI315u3DTfrgzmH/xzg2/mVPBNeBQCebN1fpCAAcoqhXpatNRXNaeJ7zAsc
	PejWxeLjIqj/3Q/Du3HIpgYM2VyvKkx8T4x1/Wd7tSgWNEuw9IOr8E=
X-Received: by 2002:a05:651c:2107:b0:3a5:d0ad:7df2 with SMTP id 38308e7fff4ca-3a63c06d2d1mr5437961fa.6.1790252042323;
        Thu, 24 Sep 2026 05:14:02 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a63bf2c113sm7362221fa.11.2026.09.24.05.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 05:14:01 -0700 (PDT)
Message-ID: <8a08809f-a276-4c5b-9734-1bb6aca4f51c@gmail.com>
Date: Thu, 24 Sep 2026 15:14:00 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 4/6] reboot: extend psc_reason with power-on and reset
 causes
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 avaneesh.dwivedi@oss.qualcomm.com,
 Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260924-pscrr-framework-v15-0-7af87107e0d3@oss.qualcomm.com>
 <20260924-pscrr-framework-v15-4-7af87107e0d3@oss.qualcomm.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260924-pscrr-framework-v15-4-7af87107e0d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/09/2026 10:08, Faruque Ansari wrote:
> psc_reason covered only the protection reasons. Extend it to mirror the
> full POWER_ON_REASON_* vocabulary - power-on, watchdog, software,
> external, RTC, reset button, CPU clock and crystal failures - so a
> provider can report why the system last powered on, not only why it was
> shut down. New values are appended to keep the existing numeric ABI.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> changes v15:
> - add a static_assert() tying ARRAY_SIZE(psc_reason_descs) to
>    PSCR_REASON_COUNT, so a future enum addition without a matching
>    table entry fails the build instead of silently reading a hole
>    (Matti Vaittinen)
> - Add Reviewed-by tags from Matti Vaittinen.
> changes v12:
> - new patch
> ---
>   include/linux/reboot.h | 28 ++++++++++++++++++++++++++++
>   kernel/reboot.c        | 12 ++++++++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index 4c5327dd7645..13f004ad1066 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -225,9 +225,28 @@ extern void orderly_reboot(void);
>    *	management errors, or an unrecoverable hardware fault requiring
>    *	immediate response.
>    *
> + * @PSCR_POWER_ON: Regular cold power-on (e.g. via a PMIC power-on request).
> + *
> + * @PSCR_WATCHDOG: Reset caused by a watchdog timeout.
> + *
> + * @PSCR_SOFTWARE: Software-initiated reset or reboot.
> + *
> + * @PSCR_EXTERNAL: Reset asserted through an external pin or reset input.
> + *
> + * @PSCR_RTC: Wake-up or power-on triggered by the RTC.
> + *
> + * @PSCR_RESET_BUTTON: Reset triggered by a user reset button.
> + *
> + * @PSCR_CPU_CLK_FAIL: Reset caused by a CPU clock failure.
> + *
> + * @PSCR_XTAL_FAIL: Reset caused by a crystal oscillator failure.
> + *
>    * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
>    *	value is useful for range checking and potential future extensions
>    *	while maintaining compatibility.
> + *
> + * The reasons mirror the POWER_ON_REASON_* strings in
> + * <linux/power/power_on_reason.h>; keep the two in sync when extending.
>    */
>   enum psc_reason {
>   	PSCR_UNKNOWN,
> @@ -236,6 +255,15 @@ enum psc_reason {
>   	PSCR_REGULATOR_FAILURE,
>   	PSCR_OVER_TEMPERATURE,
>   	PSCR_EC_PANIC,
> +	/* Append new reasons here; the numeric order is ABI. */
> +	PSCR_POWER_ON,
> +	PSCR_WATCHDOG,
> +	PSCR_SOFTWARE,
> +	PSCR_EXTERNAL,
> +	PSCR_RTC,
> +	PSCR_RESET_BUTTON,
> +	PSCR_CPU_CLK_FAIL,
> +	PSCR_XTAL_FAIL,
>   
>   	/* Number of reasons */
>   	PSCR_REASON_COUNT,
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e53fb31bad06..7094c7a8f315 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -7,7 +7,9 @@
>   
>   #define pr_fmt(fmt)	"reboot: " fmt
>   
> +#include <linux/array_size.h>
>   #include <linux/atomic.h>
> +#include <linux/build_bug.h>
>   #include <linux/ctype.h>
>   #include <linux/export.h>
>   #include <linux/kexec.h>
> @@ -1102,7 +1104,17 @@ static const struct psc_reason_desc psc_reason_descs[] = {
>   	[PSCR_REGULATOR_FAILURE] = { "regulator-failure", POWER_ON_REASON_REGULATOR_FAILURE },
>   	[PSCR_OVER_TEMPERATURE]	 = { "over-temperature",  POWER_ON_REASON_OVER_TEMPERATURE },
>   	[PSCR_EC_PANIC]		 = { "ec-panic",	  POWER_ON_REASON_EC_PANIC },
> +	[PSCR_POWER_ON]		 = { "power-on",	  POWER_ON_REASON_REGULAR },
> +	[PSCR_WATCHDOG]		 = { "watchdog",	  POWER_ON_REASON_WATCHDOG },
> +	[PSCR_SOFTWARE]		 = { "software",	  POWER_ON_REASON_SOFTWARE },
> +	[PSCR_EXTERNAL]		 = { "external",	  POWER_ON_REASON_EXTERNAL },
> +	[PSCR_RTC]		 = { "rtc",		  POWER_ON_REASON_RTC },
> +	[PSCR_RESET_BUTTON]	 = { "reset-button",	  POWER_ON_REASON_RST_BTN },
> +	[PSCR_CPU_CLK_FAIL]	 = { "cpu-clock-failure", POWER_ON_REASON_CPU_CLK_FAIL },
> +	[PSCR_XTAL_FAIL]	 = { "crystal-failure",	  POWER_ON_REASON_XTAL_FAIL },
>   };
> +static_assert(ARRAY_SIZE(psc_reason_descs) == PSCR_REASON_COUNT,
> +	      "psc_reason_descs[] must have an entry for every psc_reason");

Thanks Faruque. This is better than nothing, but if I read it right, it 
won't still catch missing initializations when last item is initialized 
(but not all items). Eg:

enum {
	PSCR_REGULATOR_FAILURE,
	PSCR_OVER_TEMPERATURE,
	PSCR_EC_PANIC,
	...
	PSCR_REASON_COUNT
};

static const struct psc_reason_desc psc_reason_descs[] = {
	[ PSCR_REASON_COUNT - 1] = { "foo", BAR }
};

static_assert(ARRAY_SIZE(psc_reason_descs) == PSCR_REASON_COUNT,
	      "psc_reason_descs[] must have an entry for every psc_reason");

would pass the check, but accessors would crash to uninitialized 
entries. Hence, I would still prefer the run-time NULL checks.

Oh, and I just noticed there is comma following the 'PSCR_REASON_COUNT' 
in the enum. Since 'PSCR_REASON_COUNT' should always be kept as the last 
enum value, the comma should be omitted.

Other than this - I like the changes you implemented this series. Won't 
reply to other patches, but I think this is a very nice series!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
