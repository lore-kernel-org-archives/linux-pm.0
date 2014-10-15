From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix setting max_perf_pct in performance policy
Date: Thu, 16 Oct 2014 01:16:51 +0200
Message-ID: <1413415011-31290-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37483 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbaJOXSA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Oct 2014 19:18:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com

Code which changes policy to powersave changes also max_policy_pct base=
d on
max_freq. Code which change max_perf_pct has upper limit base on value
max_policy_pct. When policy is changing from powersave back to performa=
nce
then max_policy_pct is not changed. Which means that changing max_perf_=
pct is
not possible to high values if max_freq was too low in powersave policy=
=2E

Test case:

$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
800000
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
3300000
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
performance
$ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
100

$ echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governo=
r
$ echo 800000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
$ echo 20 > /sys/devices/system/cpu/intel_pstate/max_perf_pct

$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
powersave
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
800000
$ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
20

$ echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_gover=
nor
$ echo 3300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
$ echo 100 > /sys/devices/system/cpu/intel_pstate/max_perf_pct

$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
performance
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
3300000
$ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
24

And now intel_pstate driver allows to set maximal value for max_perf_pc=
t based
on max_policy_pct which is 24 for previous powersave max_freq 800000.

This patch will set default value for max_policy_pct when setting polic=
y to
performance so it will allow to set also max value for max_perf_pct.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/intel_pstate.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pst=
ate.c
index 0668b38..7547ab5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -714,6 +714,7 @@ static int intel_pstate_set_policy(struct cpufreq_p=
olicy *policy)
 	if (policy->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
 		limits.min_perf_pct =3D 100;
 		limits.min_perf =3D int_tofp(1);
+		limits.max_policy_pct =3D 100;
 		limits.max_perf_pct =3D 100;
 		limits.max_perf =3D int_tofp(1);
 		limits.no_turbo =3D limits.turbo_disabled;
--=20
1.7.9.5

