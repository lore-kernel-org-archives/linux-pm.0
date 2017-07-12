From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH] selftests: cpufreq: Check cpuinfo_cur_freq set as expected
Date: Wed, 12 Jul 2017 14:29:34 +0300
Message-ID: <704cfb6696840b3838576ea583b8ab8ed2265aaf.1499858779.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn3nam01on0047.outbound.protection.outlook.com ([104.47.33.47]:60048
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756241AbdGLL3y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Jul 2017 07:29:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kselftest@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Octavian Purdila <octavian.purdila@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This checks that the cpufreq driver actually sets the requested
frequency.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---

I've been looking at using kselftests for imx. This patch exposes an
issue with the imx6 cpufreq driver on imx6sx where frequencies are set
incorrectly because of clk mishandling. This is already caught by some
internal test scripts which also run against upstream but it's nice to
make this visible through kselftest.

I'm not sure it's correct to check that frequency matches exactly,
perhaps something like a 5% tolerance should be included for complex
drivers where the target freq is only a "hint"? I checked intel_pstate
but it doesn't even seem to expose an userspace governor for manual
frequency selection anyway.

Unfortunately cpufreq selftests don't seem to have a clear idea of
"pass" or "fail" results. This patch will just print some TAP-like
"ok" and "not ok" lines but failures are not actually propagated upwards
in a well-defined way.

Have you considered what it would take to TAP-ify the output of cpufreq
tests? Output is very complex so perhaps it might make sense to adopt some
sort of subtest syntax for kselftest, something like this:

http://tap4j.sourceforge.net/subtests.html

Sadly the TAP spec itself does not include support for subtests.

 tools/testing/selftests/cpufreq/cpufreq.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
index 1ed3832..323b5bb 100755
--- a/tools/testing/selftests/cpufreq/cpufreq.sh
+++ b/tools/testing/selftests/cpufreq/cpufreq.sh
@@ -151,6 +151,14 @@ test_all_frequencies()
 	# Set all frequencies one-by-one
 	for freq in $freqs; do
 		set_cpu_frequency $1 $freq
+
+		local cur_freq
+		cur_freq=`cat $CPUFREQROOT/$1/cpuinfo_cur_freq`
+		if [ $freq -ne $cur_freq ]; then
+			printf "not ok - frequency set $freq but got $cur_freq instead!\n"
+		else
+			printf "ok - frequency check $freq\n"
+		fi
 	done
 
 	printf "\n"
-- 
2.7.4
