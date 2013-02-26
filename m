From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC] cpufreq: governor: Set MIN_LATENCY_MULTIPLIER to 20
Date: Tue, 26 Feb 2013 15:13:32 +0530
Message-ID: <472e2bac1fc4a2589651beddbfaf6da53500d12e.1361871582.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, trenn@suse.de
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Currently MIN_LATENCY_MULTIPLIER is set defined as 100 and so on a system w=
ith
transition latency of 1 ms, the minimum sampling time comes to be around 10=
0 ms.
That is quite big if you want to get better performance for your system.

Redefine MIN_LATENCY_MULTIPLIER to 20 so that we can support 20ms sampling =
rate
for such platforms.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---

Hi Guys,

I really don't know how this figure (100) came initially, but we really nee=
d to
have 20ms support for my platform: ARM TC2.

Pushed here:

http://git.linaro.org/gitweb?p=3Dpeople/vireshk/linux.git;a=3Dshortlog;h=3D=
refs/heads/cpufreq-fixes

 drivers/cpufreq/cpufreq_governor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_g=
overnor.h
index d2ac911..adb8e30 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -34,7 +34,7 @@
  */
 #define MIN_SAMPLING_RATE_RATIO=09=09=09(2)
 #define LATENCY_MULTIPLIER=09=09=09(1000)
-#define MIN_LATENCY_MULTIPLIER=09=09=09(100)
+#define MIN_LATENCY_MULTIPLIER=09=09=09(20)
 #define TRANSITION_LATENCY_LIMIT=09=09(10 * 1000 * 1000)
=20
 /* Ondemand Sampling types */
--=20
1.7.12.rc2.18.g61b472e
