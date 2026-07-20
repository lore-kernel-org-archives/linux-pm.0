Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D7402429
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565552; cv=none; b=UjIfmKDkTAIMb2qw9wZddblNZf7qDQdm8GPfUyEh+V5BxIymVDMbxnl3D3mXUIOWQPva9qOQ9dYI2DmN8MwzREDHB1U5opCm+AQoZkO+n0FiLDMZ3unmPMtVSXQ/+69Rv1Zk+Jn/V/RYb7gnBy1jkRjce0yEJfOI04gZGhNiz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565552; c=relaxed/simple;
	bh=etbaRrKV9SXcQ0LSR17dLHpxASDluGBsvMGDWTKWOQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBt+CKqpqr2qbsPpzu4H8IZjMKKy3d/sAa8XzDDOivrOk2yb+lYjeHZSTdTrWNWnjIOpeTRs4bHEeENeb1TwY8w7+/CkPl6v1INJ4g8t4JAIFP55jsUQuapxyd3WM8l3PzQDUaSH9OZ1VhJ98XyjTQV2NsWuWOrY9936hXHOQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuNp9tLk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuNp9tLk"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2386438a91.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784565550; x=1785170350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5UAdbFVAlc/KWXDES5WRBnkuT7vHRyZvuqNjrJ7QtTA=;
        b=cuNp9tLkqKy5+LAuKnlw9TGWbP+anaQm/idoSePpUhKCDJoDzCLQT1gIDzBll7A3MD
         bOTDY2ev2birCatW3fg4q5xzSwHJqbzMLKfjDG1jr2RdWYZx4sigdZ4Id3Dvp4tGipm5
         HdtW6XJoTgCDa7UspRfCZDt4IgoFY5s6qDI+vaBfcw2nsYsUDFCwKibwgRjYgr6lLj+h
         4AJ5/bpV6d3bfa1ZLvw7hmwq1ivgRmqF2bLczfOppty3ON7JS4AJZFvUadFaY2qN50n4
         lv+w32DgH0la+MAenpnInO9u/A1w6OjNbcvvW96RYZ8FUXyUt1EI3E/OpsSqiqRjRWk6
         lTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784565550; x=1785170350;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5UAdbFVAlc/KWXDES5WRBnkuT7vHRyZvuqNjrJ7QtTA=;
        b=e1WzMVKP47Jb25JYGILna29iz/v75STD6LYpIky+qBQ58/jqEZHyqvSBkD8nXQ61dF
         fejrUgDrqzxUTgpIL4uL6I86F5Z0ZgStw+5GHe7PBBwXvkqGvN8CCtoi2qfTU+WFELqz
         Ggc2Lu9fqlejdYETAErHyz5tQDYOZxBNgnGr7Vh6dg+KmSitI8ybFI0YuXcM80r8Qu37
         KY94ceq5kNfyby3oNy9GMzdWWl0nyAlYbU+oUM2ee7FTr7ZrvPe/Vfg+i4JdXzB+yt0O
         R6+SGHr6l2e6Yhvj+1lFKDcPRCK3I2UsTZ/V2buujsc3bbeGFYchA5MiSt3GyvUxSajB
         whyg==
X-Forwarded-Encrypted: i=1; AHgh+RpgwH2uWNO4w4yDts9wOBD1xG8qtF4s3zveY3tX/xSbohTVWdWpKTh7Q/XIuYjCA51JFKwCrvQhTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfrd2+OVuprpbhR0YRl7A8j95t6acJJ70CU61GewDS63hJdyzt
	MWlQX67PYthl2HcBfHrsmgAU1Puhd/wEPScjrP14O7Biw+5csU8HouABG9IW0w==
X-Gm-Gg: AR+sD11gjH0AIcZaGCn6BCPyn7Daw6jerDCJmhGuhp/8J66p9Cbttej6Dkicug16Km1
	TbVVWs/LaBT68eofNdJ5eaaZhemGEqUDUWTGOSSbVv7E12BUevxOmlgJ8Dqwzwrg7YRh5jNLZ6Q
	m/2m1U619W/WLnUAvJtbxhivrumax4yxh9jOxQq3cLmC4kBpN7Vy97R9HBcqJcZPioC19qQKaeA
	wV6sWBnxlntrSdYc6DrYbO/2m5hvBExnpx1hURfwtxvmg8lvzk/qdwl7gg835EU+2Z1dl8c3p78
	z/tJ1516SDGCiuQApzqR1lFOxDqBqVF11y49kWmyLwzx0PbWUTYoxszPX/mXxdk0mYiyyNdFlaJ
	YLNXn1dW4NBXxqvrTEIoIHbn44njxxmYOo/L6Qe8KhZuluu7RlQTCtHLME9N1B+B1Rd2fyd6XCV
	1Znkuu017II99acfU=
X-Received: by 2002:a17:90b:28d0:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-38e4b3e1334mr14768016a91.4.1784565550253;
        Mon, 20 Jul 2026 09:39:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2dcdsm35474860c88.1.2026.07.20.09.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:39:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 09:39:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Srinivas Kandagatla <srini@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-arm-msm@vger.org,
	kernel@pengutronix.de, avaneesh.dwivedi@oss.qualcomm.com,
	Umang Chheda <umang.chheda@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] watchdog: pscrr: add watchdog pretimeout reason
 tracking
Message-ID: <5c824be9-59d8-4acb-a2a3-784182ba3c8c@roeck-us.net>
References: <20260714-pscrr-reboot-reason-v1-0-a09f23b12527@oss.qualcomm.com>
 <20260714-pscrr-reboot-reason-v1-2-a09f23b12527@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-pscrr-reboot-reason-v1-2-a09f23b12527@oss.qualcomm.com>

On Tue, Jul 14, 2026 at 03:22:35PM +0530, Faruque Ansari wrote:
> A watchdog pretimeout fires before the actual reset, giving the kernel
> a brief window to record what happened.  Without this change that
> window goes unused and the next boot sees PSCR_UNKNOWN, making it
> impossible to tell a watchdog-driven reset from any other cause.
> 
> Call set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) at the top of
> watchdog_notify_pretimeout() so the reason is recorded as soon as the
> pretimeout is signalled, before any governor action runs.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---
>  drivers/power/reset/pscrr.c            | 3 ++-
>  drivers/watchdog/watchdog_pretimeout.c | 3 +++
>  include/linux/power/power_on_reason.h  | 1 +
>  include/linux/reboot.h                 | 1 +
>  kernel/reboot.c                        | 1 +

This is a cross-subsystem change. As far as I can see it would
be easy to split it into two patches. Please do that.

Guenter

>  5 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
> index b5906f127e88..36642cf9f27c 100644
> --- a/drivers/power/reset/pscrr.c
> +++ b/drivers/power/reset/pscrr.c
> @@ -149,7 +149,8 @@ static int pscrr_panic_notifier(struct notifier_block *nb,
>  	if (!backend || !backend->ops || !backend->ops->write_reason)
>  		return NOTIFY_OK;
>  
> -	set_psc_reason(PSCR_KERNEL_PANIC);
> +	if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
> +		set_psc_reason(PSCR_KERNEL_PANIC);
>  	ret = backend->ops->write_reason(get_psc_reason());
>  	if (ret)
>  		pr_err("PSCRR: Failed to store reason %d (%s) at panic, err=%pe\n",
> diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
> index 02e09b9e396d..ea48d4eca4aa 100644
> --- a/drivers/watchdog/watchdog_pretimeout.c
> +++ b/drivers/watchdog/watchdog_pretimeout.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/list.h>
> +#include <linux/reboot.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
> @@ -103,6 +104,8 @@ void watchdog_notify_pretimeout(struct watchdog_device *wdd)
>  {
>  	unsigned long flags;
>  
> +	set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT);
> +
>  	spin_lock_irqsave(&pretimeout_lock, flags);
>  	if (!wdd->gov) {
>  		spin_unlock_irqrestore(&pretimeout_lock, flags);
> diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
> index 4ac1bdfdc211..c5846c0ccde4 100644
> --- a/include/linux/power/power_on_reason.h
> +++ b/include/linux/power/power_on_reason.h
> @@ -20,5 +20,6 @@
>  #define POWER_ON_REASON_OVER_TEMPERATURE "over temperature"
>  #define POWER_ON_REASON_EC_PANIC "EC panic"
>  #define POWER_ON_REASON_KERNEL_PANIC "kernel panic"
> +#define POWER_ON_REASON_WATCHDOG_PRETIMEOUT "watchdog pretimeout"
>  
>  #endif /* POWER_ON_REASON_H */
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index a492b1652038..fccbffc9dbef 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -237,6 +237,7 @@ enum psc_reason {
>  	PSCR_OVER_TEMPERATURE,
>  	PSCR_EC_PANIC,
>  	PSCR_KERNEL_PANIC,
> +	PSCR_WATCHDOG_PRETIMEOUT,
>  
>  	/* Number of reasons */
>  	PSCR_REASON_COUNT,
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index f1df52f8773a..629002a951c2 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -1066,6 +1066,7 @@ static const char * const pscr_reason_strs[] = {
>  	[PSCR_OVER_TEMPERATURE]   = POWER_ON_REASON_OVER_TEMPERATURE,
>  	[PSCR_EC_PANIC]           = POWER_ON_REASON_EC_PANIC,
>  	[PSCR_KERNEL_PANIC]       = POWER_ON_REASON_KERNEL_PANIC,
> +	[PSCR_WATCHDOG_PRETIMEOUT] = POWER_ON_REASON_WATCHDOG_PRETIMEOUT,
>  };
>  
>  /**
