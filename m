Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EAB2AD3D
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137394; cv=pass; b=qbvc7zj04pjcNw0Sxv6WyrXbzi2OQR2Qe3xped3f/g5bYPskxBWa5zJta9zmbvpFC4//xl4EODt8kEJj1FGYCGF7Xe13A3q1Jm8Ez4qeAWXXwCZpoZULBuSEhlWPyp84B8VAV5ebZP5ubKlYfIqMsLZ+Ehnzg5E0A0/Hm98/yaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137394; c=relaxed/simple;
	bh=ef7494GHPVnuwouKcTUUpqp3TuY1Ebz0YzpEao9k4yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YH2xDapUiuYfqCAdIcZX/F1vh4WMTwI8xmcNGaNbcF1fUEBEOdRGiKExLl9fIg19lWYcxjqKfuPLcaQhep4VemkpQ7E3jnKLoX+JVTS9Qztwy1W8d9CbedFKCi3tgkaJdup+qHPRx7hQvkCeZzk2G46sI7KcSEV4VLHZ6TGpSu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZYfH/24A; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYfH/24A"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a4a8421b0so22392461fa.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 03:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773137390; cv=none;
        d=google.com; s=arc-20240605;
        b=FuNimh9VjKxXjzoYGYV4EFYZzXtjrqIyeKeZOTguxYbhkOd0BOq0Mq9q/nbSiDgjje
         4iZaJI1WXTzqtfiOhba6432s4GLAuOMWFECRzqtVO5XYuLrGjiH1TZCIrBVDXAad+VYM
         Fx8lXUwtVu6TYlVPbLHTNWPfjY1s9etMNJRbAji+Bo/ilTYCxhsyaPMj/mo14mKqBQvi
         cbUzJ7riAcS2aG1pLqhj2HXPDF/rNwCGEwRQU2foG0Xijvy7b1UAonVM4C6NqVmrTlQF
         zHs5y+1eNJ/vgaWoRnLUzB4T0CnjPBVdXS2nW5qaJ3IfSh7eWHXJETAt/CPZ8oCmQqc6
         bNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SbLNOepkKQDiOlPCygfK9diUY9EsFK1MZ4US030AgvM=;
        fh=UJGuBUrCzaOYAY8lWuAlo5ls29IV+Ne3FvPzouOuYKU=;
        b=jvo8i2D6o9JSec81HNSI33PRhWqVTSdPHgJhUn1lwBziRSMYtZZGM6JRmqYNZLfLAg
         eKY2UQNRwKq7D7gjfht52bVEDnqmeR/cBNkB1pt0YIqErchf4Zr0e61/MWQrkoEpJfzb
         FdzZOJjfEZxFx0wAuuGlCGCvF8dV6XdA8x//IM/T0cehW6nvtgS8i5ixtTll6Iq7FwCP
         uLhcj19KzUdl13772oisRkWsYgLqYkRlY8L2UqkQwpxGvvbk+hevAOEutly0MaPden3+
         C4VBx3nlxcGJPiIE1DN4g9U8TLsfv7ybOAjpIEHQQVAHu5tmysd93H6gH9bgOlY/HPbX
         1EfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773137390; x=1773742190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SbLNOepkKQDiOlPCygfK9diUY9EsFK1MZ4US030AgvM=;
        b=ZYfH/24ARk7u6epvkO6h5bzlMY/u2tIDF8eax/CvUZQla+wXVNJwugNfAd4IG+sW80
         R4jYFVNJV5YsXIfLT4FNgJ08tSs3yjn0089sWp18t0tLUwZZZiqmyOR68c+/UUN8pJjh
         QlA8cwx5NlqKyOmp5CqsUkZPWEhfyzByfcFexD4WGrMaRkUvfXPAcw7mG87Yh5kcX7cC
         P1foMRmG1nbzy8ZlWRGnDW4U9cO0M1wIf/YYxV828LmRqpeC3yN2YkRiw/eGINiB5XpV
         CSPxn5/JV9c7ZKDRf4JdFWoekexv5PdKYgwuExY7XQbiWvbJSvHplRg/Zg5WijcQeNVy
         txeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773137390; x=1773742190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbLNOepkKQDiOlPCygfK9diUY9EsFK1MZ4US030AgvM=;
        b=rbAtUeP3wHXJKBCjMNQi+1MDHWa/RcZR0IrGOVtSzbN96d2Wr8pCI5cVk8UTLKlHOa
         06K40R0YLyq2EAC1CIh02FGzOJn7tMFK/trAXRSL1Mctgfti4vYWTdfRciONaOjKLsIT
         CklHX8wPmX0AV33Ge2Bkg/wbvNB+Rt7vgeuEabk43KgmozaPkyeWdN+QW6DFhPxeazxs
         0e9jv/QFYfuiKbbSrAfBkG/ObjVx2P/EvCu5llOufegPM5H2zvl26Tyltt2odKc06FUY
         ivvi38fPdrjxzHaxMMsjBY07FoW+He1lffx9iywile+34K3RYD5tuV+CV2d4DEgaOMXP
         Bg6w==
X-Forwarded-Encrypted: i=1; AJvYcCXGkmb8ZbeCc5YEF7jqHKLUUx80xW56nFrdpDXmox3vsAOgZxpKngndXlNpfYWkI3H1wPA4Nk9KpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS1N4rXFjUAyQtnrEEZ27jelWquYchXCBCwKzcXtYWmg1HWQMv
	lL4DWKv/1Iqrm1ytawxU2pYFgFt5y3WZGGtLI/e24rl0gRscmln77NkYS/cd9KMfgA0NQrA9W7M
	9aZLWejk/yL/H0D6TmthlpCVMcrisawsyLZ9ZPGoZcw==
X-Gm-Gg: ATEYQzxg32jVSioomQx57tTlak7bAvRqXZQvHKPXQHAsinpys5VNnQK1Fofhe0EvE3A
	2uRKwopiaHpH6FvelIEx/e/VwTYQaEMd6xpmPL64sTYv+OsQCNN73uG0S4r7V+V0Dibky1O1qez
	J2XMCkc8LuW9If4LiyvvdtxMO+XsUMDU8+8A6lzJ7SHeNkPYZYNzpHYxOkFAOJQ2LyTY1zRCfox
	zGXeynaVJUwr/2DeHotWWT6hI3phMcTkUrUCKUmAA724/w+7jxSRQhMUDrgZszTw4XbDY7YY64k
	xonL2Lni
X-Received: by 2002:a05:651c:908:b0:386:8e44:5d3b with SMTP id
 38308e7fff4ca-38a40d76344mr40489171fa.19.1773137390036; Tue, 10 Mar 2026
 03:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
 <20260205-topic-lpm-pmdomain-device-constraints-v2-2-61f7be7d35ac@baylibre.com>
In-Reply-To: <20260205-topic-lpm-pmdomain-device-constraints-v2-2-61f7be7d35ac@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Mar 2026 11:09:12 +0100
X-Gm-Features: AaiRm53U5UxEWgdkFhCp5FpsW0sui0McRfHP-pSGkH6NdGtcQfHHXSpdbQUebbw
Message-ID: <CAPDyKFoJ_fSpnJ9O0K=RYOQUbXm6hNu+mWJVvT8EZsgTHABfcQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pmdomain: core: add genpd_for_each_child() helper
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Feb 2026 at 01:30, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>
> Add a new internal helper function genpd_for_each_child() that recursively
> iterates over all devices in a PM domain and its child domains (subdomains).
> This helper is useful for governors and other core PM domain code that needs
> to examine or apply operations to all devices within a domain hierarchy.
>
> The function takes a callback that is invoked for each device, and supports
> early termination if the callback returns a non-zero value.
>
> The helper is defined in a new internal header drivers/pmdomain/core.h and
> implemented in drivers/pmdomain/core.c, making it available to other PM
> domain subsystem components.

I think it's important to state that this isn't for pmdomain providers
to use, but only for the core and the governor. Perhaps add a comment
about that too in the function description.

That said, if there is only one user, perhaps adding a helper isn't
worth it after all?

>
> The first user of this helper is the cpu_system_power_down_ok() governor
> function, which uses it to check device QoS latency constraints across the
> entire domain hierarchy.
>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  drivers/pmdomain/core.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/pmdomain/core.h | 17 +++++++++++++++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index bf82775f6a67..41c987fc5c5a 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -24,6 +24,8 @@
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
>
> +#include "core.h"
> +
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>
> @@ -281,6 +283,46 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>         smp_mb__after_atomic();
>  }
>
> +/**
> + * genpd_for_each_child - Recursively iterate over all devices
> + *                        in a PM domain and its subdomains.
> + * @genpd: PM domain to iterate over.
> + * @fn: Callback function to invoke for each device.
> + * @data: Data to pass to the callback function.
> + *
> + * This function recursively walks through all devices in the given PM domain
> + * and all devices in its child PM domains (subdomains). For each device found,
> + * the callback function @fn is invoked with the device and @data as arguments.
> + *
> + * Returns: 0 on success, or the first non-zero value returned by @fn.
> + */
> +int genpd_for_each_child(struct generic_pm_domain *genpd,
> +                        int (*fn)(struct device *dev, void *data),
> +                        void *data)
> +{
> +       struct pm_domain_data *pdd;
> +       struct gpd_link *link;
> +       int ret;
> +
> +       /* First, iterate over all devices in this domain */
> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +               ret = fn(pdd->dev, data);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /* Then, recursively iterate over all child domains (subdomains) */
> +       list_for_each_entry(link, &genpd->parent_links, parent_node) {
> +               struct generic_pm_domain *child_pd = link->child;
> +
> +               ret = genpd_for_each_child(child_pd, fn, data);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  static struct dentry *genpd_debugfs_dir;
>
> diff --git a/drivers/pmdomain/core.h b/drivers/pmdomain/core.h
> new file mode 100644
> index 000000000000..7061891d31fb
> --- /dev/null
> +++ b/drivers/pmdomain/core.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Internal header for PM domain core
> + *
> + * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
> + */
> +
> +#ifndef __PM_DOMAIN_CORE_H__
> +#define __PM_DOMAIN_CORE_H__
> +
> +#include <linux/pm_domain.h>
> +
> +int genpd_for_each_child(struct generic_pm_domain *genpd,
> +                        int (*fn)(struct device *dev, void *data),
> +                        void *data);
> +
> +#endif /* __PM_DOMAIN_CORE_H__ */
>
> --
> 2.51.0
>

Kind regards
Uffe
