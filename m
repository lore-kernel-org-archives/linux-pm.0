From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH] PM / Domains: Correct comment in
 irq_safe_dev_in_no_sleep_domain()
Date: Tue, 31 Jan 2017 09:17:54 -0700
Message-ID: <20170131161754.GC54379@linaro.org>
References: <1485878463-1672-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34233 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdAaQ1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 11:27:18 -0500
Received: by mail-pf0-f174.google.com with SMTP id e4so107624697pfg.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2017 08:26:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1485878463-1672-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Tue, Jan 31 2017 at 09:01 -0700, Ulf Hansson wrote:
>The earlier comment stated that the dev_warn_once() was going to be printed
>once per device. Let's fix that, as dev_warn_once() is printed only once,
>no matter of the device.
>
>Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Lina Iyer <lina.iyer@linaro.org>

>---
> drivers/base/power/domain.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index 6b23d82..271e208 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -130,7 +130,7 @@ static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>
> 	ret = pm_runtime_is_irq_safe(dev) && !genpd_is_irq_safe(genpd);
>
>-	/* Warn once for each IRQ safe dev in no sleep domain */
>+	/* Warn once if IRQ safe dev in no sleep domain */
> 	if (ret)
> 		dev_warn_once(dev, "PM domain %s will not be powered off\n",
> 				genpd->name);
>-- 
>1.9.1
>
