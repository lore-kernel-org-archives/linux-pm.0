From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH Resend] cpufreq: tegra: update comment for clarity
Date: Tue, 10 Jun 2014 10:27:12 +0530
Message-ID: <3eb9a48877bbb208f3c1f3e121f8d78b1d306bd9.1402376112.git.viresh.kumar@linaro.org>
References: <594cf0e6982c471eb314fe4a00647bfaf59a3456.1402029512.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:60465 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaFJE5i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 00:57:38 -0400
Received: by mail-qc0-f181.google.com with SMTP id x3so1668298qcv.26
        for <linux-pm@vger.kernel.org>; Mon, 09 Jun 2014 21:57:37 -0700 (PDT)
In-Reply-To: <594cf0e6982c471eb314fe4a00647bfaf59a3456.1402029512.git.viresh.kumar@linaro.org>
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
tegra_target_intermediate().

Reviewed-by: Stephen Warren <swarren@nvidia.com>
Reported-and-reviewed-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Resend: Improved comment as suggested by Stephen.

 drivers/cpufreq/tegra-cpufreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cp=
ufreq.c
index a5fbc0a..8084c7f 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -71,9 +71,12 @@ static int tegra_target_intermediate(struct cpufreq_=
policy *policy,
 	/*
 	 * Take an extra reference to the main pll so it doesn't turn
 	 * off when we move the cpu off of it as enabling it again while we
-	 * switch to it from tegra_target() would take additional time. Thoug=
h
-	 * when target-freq is intermediate freq, we don't need to take this
-	 * reference.
+	 * switch to it from tegra_target() would take additional time.
+	 *
+	 * When target-freq is equal to intermediate freq we don't need to
+	 * switch to an intermediate freq and so this routine isn't called.
+	 * Also, we wouldn't be using pll_x anymore and must not take extra
+	 * reference to it, as it can be disabled now to save some power.
 	 */
 	clk_prepare_enable(pll_x_clk);
=20
--=20
2.0.0.rc2

