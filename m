From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH] cpufreq: cpufreq-cpu0: do not allow transitions with
 regulators suspended
Date: Thu, 14 Nov 2013 22:16:00 +0530
Message-ID: <5284FE48.8040802@linaro.org>
References: <1382638087-32054-1-git-send-email-nm@ti.com> <CAKohponJOOfGX4BHn76LTBDTm58+2QxPf_rv1i4avVfrWhfkRg@mail.gmail.com> <52824522.7020401@ti.com> <CAKohpomB=wnct88wrTvW-qixLQPQGjVrCVF3V-BSbY7mhsSYQg@mail.gmail.com> <20131113151645.GA17828@kahuna> <52842671.40703@linaro.org> <5284DDB9.7040502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:33602 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323Ab3KNQqI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2013 11:46:08 -0500
Received: by mail-qe0-f53.google.com with SMTP id cy11so1399964qeb.40
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2013 08:46:07 -0800 (PST)
In-Reply-To: <5284DDB9.7040502@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>

On Thursday 14 November 2013 07:57 PM, Nishanth Menon wrote:
> I am guessing this is a little too early for restarting policy here
> considering syscore_ops->resume is pretty early..

Yeah, looks like that..

> http://pastebin.mozilla.org/3602746 is the equivalent patch for v3.12
> http://pastebin.mozilla.org/3602747 is the result.

Can you try this instead of last diff I sent?


diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index dc67fa0..e70e906 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1324,6 +1324,15 @@ static void handle_update(struct work_struct *work)
                container_of(work, struct cpufreq_policy, update);
        unsigned int cpu = policy->cpu;
        pr_debug("handle_update for cpu %u called\n", cpu);
+
+       if (has_target() && !policy->governor_enabled) {
+               if ((ret = __cpufreq_governor(policy, CPUFREQ_GOV_START)) ||
+                       (ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS))) {
+                       pr_err("%s: Failed to start governor\n", __func__);
+                       goto fail;
+               }
+       }
+
        cpufreq_update_policy(cpu);
 }


