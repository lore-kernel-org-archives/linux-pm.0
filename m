From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 Resend 0/4] CPUFreq: Bug fixes & cleanups
Date: Thu, 17 Jul 2014 10:48:24 +0530
Message-ID: <cover.1405573982.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:61601 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbaGQFTQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jul 2014 01:19:16 -0400
Received: by mail-qa0-f45.google.com with SMTP id cm18so1484608qab.4
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2014 22:19:15 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arvind.chauhan@arm.com, srivatsa@mit.edu, skannan@codeaurora.org, ybu@qti.qualcomm.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

As discussed here:
https://www.mail-archive.com/stable@vger.kernel.org/msg87645.html

This is another attempt to fix an important bug and cleanups around it.
First patch is the real fix (Accumulated all Reviewed/Tested-by's) and *should*
go in 3.16-rc*.

Others are useful cleanups around it to beautify the code, and can go later in
3.17.

Based over: 3.16-rc4

Viresh Kumar (4):
  cpufreq: move policy kobj to policy->cpu at resume
  cpufreq: don't restore policy->cpus on failure to move kobj
  cpufreq: propagate error returned by kobject_move()
  cpufreq: move policy kobj from update_policy_cpu()

 drivers/cpufreq/cpufreq.c | 68 +++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

-- 
2.0.0.rc2

