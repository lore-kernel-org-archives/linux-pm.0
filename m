From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/4] cpufreq: Register cooling device after policy is ready
Date: Thu, 27 Nov 2014 06:07:48 +0530
Message-ID: <cover.1417048449.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:37763 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbaK0AiU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 19:38:20 -0500
Received: by mail-pd0-f169.google.com with SMTP id fp1so3789661pdb.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 16:38:19 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael/Eduardo,

Currently there is no callback for cpufreq drivers which is called once the
policy is ready to be used. There are some requirements where such a callback is
required.

One of them is registering a cooling device with the help of
of_cpufreq_cooling_register(). This routine tries to get 'struct cpufreq_policy'
for CPUs which isn't yet initialed at the time ->init() is called and so we face
issues while registering the cooling device.

Because we can't register cooling device from ->init(), we need a callback that
is called after the policy is ready to be used and hence ->ready() callback.

The first patch fixes few formatting issues, so that the third patch doesn't
throw any checkpatch warnings. Second one fixes a potential bug in cpufreq-dt
driver. Third one introduces ->ready() callback which will be used in the
fourth patch.

V1->V2:
- s/usable/ready
- dropped last three patches that broke thermal somehow.

Viresh Kumar (4):
  cpufreq: Fix formatting issues in 'struct cpufreq_driver'
  cpufreq-dt: pass 'policy->related_cpus' to
    of_cpufreq_cooling_register()
  cpufreq: Introduce ->ready() callback for cpufreq drivers
  cpufreq-dt: register cooling device from ->ready() callback

 drivers/cpufreq/cpufreq-dt.c | 51 +++++++++++++++++++++++++----------------
 drivers/cpufreq/cpufreq.c    |  5 ++++
 include/linux/cpufreq.h      | 54 ++++++++++++++++++++++++--------------------
 3 files changed, 66 insertions(+), 44 deletions(-)

-- 
2.0.3.693.g996b0fd

