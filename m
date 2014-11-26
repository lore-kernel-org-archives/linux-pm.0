From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/7] cpufreq: Register cooling device after policy is usable
Date: Wed, 26 Nov 2014 11:22:55 +0530
Message-ID: <cover.1416980447.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33603 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbaKZFxS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 00:53:18 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so2113195pdb.32
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 21:53:17 -0800 (PST)
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
is called after the policy is ready to be used and hence ->usable() callback.

The first patch fixes few formatting issues, so that the third patch doesn't
throw any checkpatch warnings. Second one fixes a potential bug in cpufreq-dt
driver. Third one introduces ->usable() callback which will be used in the
fourth patch.

Last three are fixes for cooling core, which may be applied separately by
Eduardo if he wants. Sent them in this series as they were sort of connected
with cpufreq in general.

Let me know if it still doesn't work properly.

--
viresh

Viresh Kumar (7):
  cpufreq: Fix formatting issues in 'struct cpufreq_driver'
  cpufreq-dt: pass 'policy->related_cpus' to
    of_cpufreq_cooling_register()
  cpufreq: Introduce ->usable() callback for cpufreq drivers
  cpufreq-dt: register cooling device from ->usable() callback
  cpu_cooling: Don't match min/max frequencies for all CPUs on cooling
    register
  cpu_cooling: don't iterate over all allowed_cpus to update cpufreq
    policy
  cpu_cooling: No need to check is_cpufreq_valid()

 drivers/cpufreq/cpufreq-dt.c  | 51 +++++++++++++++++++++++++---------------
 drivers/cpufreq/cpufreq.c     |  5 ++++
 drivers/thermal/cpu_cooling.c | 44 ++++-------------------------------
 include/linux/cpufreq.h       | 54 +++++++++++++++++++++++--------------------
 4 files changed, 70 insertions(+), 84 deletions(-)

-- 
2.0.3.693.g996b0fd

