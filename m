From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: tegra: update comment for clarity
Date: Fri,  6 Jun 2014 10:08:58 +0530
Message-ID: <594cf0e6982c471eb314fe4a00647bfaf59a3456.1402029512.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:64296 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbaFFEjH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jun 2014 00:39:07 -0400
Received: by mail-qa0-f42.google.com with SMTP id j5so2887333qaq.15
        for <linux-pm@vger.kernel.org>; Thu, 05 Jun 2014 21:39:06 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, swarren@nvidia.com, dianders@chromium.org, Viresh Kumar <viresh.kumar@linaro.org>

Tegra's driver got updated a bit (00917dd cpufreq: Tegra: implement int=
ermediate
frequency callbacks) and implements new 'intermediate freq' infrastruct=
ure of
core. Above commit updated comments about when to call
clk_prepare_enable(pll_x_clk) and Doug wasn't satisfied with those comm=
ents and
said this:

> The "Though when target-freq is intermediate freq, we don't need to
> take this reference." makes me think that this function is actually
> called when target-freq is intermediate freq. =C2=A0I don't think it =
is,
> right?

=46or better clarity just make that comment more explicit about when we=
 call
tegra_target_intermediate(). Wasn't sure if we actually need a commit f=
or this,
but anyway lets other decide if its worth enough :)

Reported-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cp=
ufreq.c
index a5fbc0a..48bc89b 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -73,7 +73,7 @@ static int tegra_target_intermediate(struct cpufreq_p=
olicy *policy,
 	 * off when we move the cpu off of it as enabling it again while we
 	 * switch to it from tegra_target() would take additional time. Thoug=
h
 	 * when target-freq is intermediate freq, we don't need to take this
-	 * reference.
+	 * reference and so this routine isn't called at all.
 	 */
 	clk_prepare_enable(pll_x_clk);
=20
--=20
2.0.0.rc2

