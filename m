From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Don't measure ->start|stop() latency
 in system PM callbacks
Date: Thu, 15 Oct 2015 14:39:45 -0600
Message-ID: <20151015203945.GJ921@linaro.org>
References: <1444921326-22574-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34143 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbbJOUjt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 16:39:49 -0400
Received: by payp3 with SMTP id p3so49625213pay.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 13:39:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444921326-22574-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Thu, Oct 15 2015 at 09:02 -0600, Ulf Hansson wrote:
>Measure latency does by itself contribute to an increased latency, thus we
>should avoid it when it isn't needed.
>
>Genpd measures latencies in the system PM phase for the ->start|stop()
>callbacks and is thus affecting the system PM suspend/resume time.
>Moreover these latencies are validated only at runtime PM suspend/resume.
>
>To this reasoning, let's decide to leave these measurements out of the
>system PM phase. There should be plenty of occasions during runtime PM to
>perform these measurements anyway.
>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Lina Iyer <lina.iyer@linaro.org>

Thanks,
Lina

>---
> drivers/base/power/domain.c | 19 ++++++++++++-------
> 1 file changed, 12 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index 6e1bcde..a1c3ec4 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -90,8 +90,12 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
> 	return pd_to_genpd(dev->pm_domain);
> }
>
>-static int genpd_stop_dev(struct generic_pm_domain *genpd, struct device *dev)
>+static int genpd_stop_dev(struct generic_pm_domain *genpd, struct device *dev,
>+			bool timed)
> {
>+	if (!timed)
>+		return GENPD_DEV_CALLBACK(genpd, int, stop, dev);
>+
> 	return GENPD_DEV_TIMED_CALLBACK(genpd, int, stop, dev,
> 					stop_latency_ns, "stop");
> }
>@@ -434,7 +438,7 @@ static int pm_genpd_runtime_suspend(struct device *dev)
> 	if (ret)
> 		return ret;
>
>-	ret = genpd_stop_dev(genpd, dev);
>+	ret = genpd_stop_dev(genpd, dev, true);
> 	if (ret) {
> 		genpd_restore_dev(genpd, dev, true);
> 		return ret;
>@@ -779,7 +783,7 @@ static int pm_genpd_suspend_noirq(struct device *dev)
> 	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
> 		return 0;
>
>-	genpd_stop_dev(genpd, dev);
>+	genpd_stop_dev(genpd, dev, false);
>
> 	/*
> 	 * Since all of the "noirq" callbacks are executed sequentially, it is
>@@ -820,7 +824,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
> 	pm_genpd_sync_poweron(genpd, true);
> 	genpd->suspended_count--;
>
>-	return genpd_start_dev(genpd, dev, true);
>+	return genpd_start_dev(genpd, dev, false);
> }
>
> /**
>@@ -928,7 +932,7 @@ static int pm_genpd_freeze_noirq(struct device *dev)
> 	if (IS_ERR(genpd))
> 		return -EINVAL;
>
>-	return genpd->suspend_power_off ? 0 : genpd_stop_dev(genpd, dev);
>+	return genpd->suspend_power_off ? 0 : genpd_stop_dev(genpd, dev, false);
> }
>
> /**
>@@ -948,7 +952,8 @@ static int pm_genpd_thaw_noirq(struct device *dev)
> 	if (IS_ERR(genpd))
> 		return -EINVAL;
>
>-	return genpd->suspend_power_off ? 0 : genpd_start_dev(genpd, dev, true);
>+	return genpd->suspend_power_off ?
>+		0 : genpd_start_dev(genpd, dev, false);
> }
>
> /**
>@@ -1042,7 +1047,7 @@ static int pm_genpd_restore_noirq(struct device *dev)
>
> 	pm_genpd_sync_poweron(genpd, true);
>
>-	return genpd_start_dev(genpd, dev, true);
>+	return genpd_start_dev(genpd, dev, false);
> }
>
> /**
>-- 
>1.9.1
>
