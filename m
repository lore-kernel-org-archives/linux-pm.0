From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 0/7] cpufreq: suspend early/resume late: dpm_{suspend|resume}()
Date: Mon, 17 Feb 2014 14:50:18 +0530
Message-ID: <CAKohpomhvuQQ0JN3wgLBnrSpFUjC9J9QwWZpD9nA6AFYw+paKA@mail.gmail.com>
References: <cover.1392273722.git.viresh.kumar@linaro.org>
	<52FE71BD.3020103@wwwdotorg.org>
	<2869027.iYHxWOSS2C@vostro.rjw.lan>
	<52FEAECA.5080905@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:57863 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbaBQJUT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2014 04:20:19 -0500
Received: by mail-ob0-f182.google.com with SMTP id wm4so16634805obc.41
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2014 01:20:19 -0800 (PST)
In-Reply-To: <52FEAECA.5080905@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Kgene Kim <kgene.kim@samsung.com>, jinchoi@broadcom.com, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>

On 15 February 2014 05:33, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/14/2014 03:23 PM, Rafael J. Wysocki wrote:

>> Well, it would be good to verify which part, then.
>
> Patch 2/7 appears to stop that message from being printed during
> suspend, and perhaps reduce the number of times it's printed during
> resume. Patch 7/7 stops the message being printed at all.
>
> Looking at patch 7, I wonder if it's simply because tegra_target() was
> modified never to return -EBUSY, so the bug is still there, but it's
> just been hidden.

No, the bug is removed now. Its hidden in current linus/master :)

>>> Also, I sometimes see the following during resume. I saw it twice with
>>> Linus's tree, but then I did 10 more reboot+suspend+resume cycles and
>>> couldn't repro it, and I saw it once with Linus's tree plus this series
>>> applied, then couldn't reproduce it in 5 more tries.
>
> Oops. I screwed up my re-testing (tested on the wrong board, without
> cpufreq active:-/). The message below is reproducible 100% of the time
> with or without this series.

Somehow I missed it. Following will fix it, sending a separate patch for it as
well:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2dfbb7e..48315e0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1326,8 +1326,7 @@ static int __cpufreq_remove_dev_prepare(struct
device *dev,
        up_read(&policy->rwsem);

        if (cpu != policy->cpu) {
-               if (!frozen)
-                       sysfs_remove_link(&dev->kobj, "cpufreq");
+               sysfs_remove_link(&dev->kobj, "cpufreq");
        } else if (cpus > 1) {
                new_cpu = cpufreq_nominate_new_policy_cpu(policy, cpu);
                if (new_cpu >= 0) {
