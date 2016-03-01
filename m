From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [BUG FIX] PM / cpu_domains: Check for NULL callbacks
Date: Tue, 1 Mar 2016 14:17:05 -0700
Message-ID: <20160301211705.GQ1440@linaro.org>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
 <1456866931-37851-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33565 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbcCAVRI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 16:17:08 -0500
Received: by mail-pf0-f177.google.com with SMTP id 124so58025117pfg.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 13:17:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456866931-37851-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Ignore this patch pls. This change has been folded in.

Thanks,
Lina

On Tue, Mar 01 2016 at 14:15 -0700, Lina Iyer wrote:
>Check for NULL platform callback before calling.
>
>Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>---
> drivers/base/power/cpu_domains.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
>index 7069411..bcaa474 100644
>--- a/drivers/base/power/cpu_domains.c
>+++ b/drivers/base/power/cpu_domains.c
>@@ -157,16 +157,22 @@ static int cpu_pd_power_on(struct generic_pm_domain *genpd)
> {
> 	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
>
>-	return pd->ops.power_on();
>+	if (pd->ops.power_on)
>+		return pd->ops.power_on();
>+
>+	return 0;
> }
>
> static int cpu_pd_power_off(struct generic_pm_domain *genpd)
> {
> 	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
>
>-	return pd->ops.power_off(genpd->state_idx,
>+	if (pd->ops.power_off)
>+		return pd->ops.power_off(genpd->state_idx,
> 			genpd->states[genpd->state_idx].param,
> 			pd->cpus);
>+
>+	return 0;
> }
>
> /**
>-- 
>2.1.4
>
