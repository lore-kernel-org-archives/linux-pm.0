Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356943;
	b=1/fhMFuV9EADNOqeyVYUWqBhEfAcCY2ZghT2HpoWpNHXyN19YXLyj4006cTqpwWex6Ad
	 nx4nAA+AHlmjZC7li6GSCo4L5THNxrDwFVq1Gx5ntqptse5GP4jfG/3dYCoglkiAM4mhO
	 6Ikcv1J0BTD6sRLdc66Ja1q7SIhCNG3kL3LR6usl05+aVWIuo8LWL1LSEz3r8zBiwSnBS
	 u4x5I3e0X6dHaVSO4aohqBgF9a2+jUYNhxdzXEvapRy0YHGHRmrFbRoISwAqTNEA4zpb/
	 gguwA8O9DwUaAVb3WEVZHz3PGavunJOGl36EeyMjGowGJ8Ryc+8wNsbga3fFiSEG+5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356943;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=V91mG1ucI7P99bGc4LQseFhOC+7VxJiPPM+PptTC53o=;
	b=VvaVWUX9h0MmSDRV+b841y2gETW+uBvIsJh6TiSrMAIsjzFy+DhYXaksp+FaM2BKX+4+
	 nxRZuJlwnmNiVvqkpt7Q5brJ8/QFoq87cqmIZL2uQw9pKqtRVeyuaENltnphcLBhfGgyA
	 UqIxsoeLHjkZGZw4e09JORGDA6RJiMDjlOd0fdFAJs4wMVS0NaR0jz60qHz9TgPWoGhJx
	 o3XrH8kv63DGzmQ55ruc+CBaPxHCl7e0JfYfsLhtwHmQq4NeWWS3NANUjmkQTMJ8uCwps
	 GIpZpZ+q7BhMCWywV76aIueCeu76qTdYQU4e2EH15fhZIURX0xc8IrylfWVoB15DOIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80694606A31E;
	Fri, 30 Oct 2026 10:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80694606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwD36r6KdORqiF4HBQ--.9378S2;
	Fri, 30 Oct 2026 18:42:19 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8Dwj3KGdORqNXXzAA--.24040S3;
	Fri, 30 Oct 2026 18:42:15 +0800 (CST)
From: xiong yining <xiongyining1480@phytium.com.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	"zhongqiu . han" <zhongqiu.han@oss.qualcomm.com>,
	xiong yining <xiongyining1480@phytium.com.cn>
Subject: [PATCH v3] selftests: cpufreq: stop CPU hotplug loop after cpufreq update test
Date: Fri, 30 Oct 2026 18:42:13 +0800
Message-Id: <20261030104213.2030283-1-xiongyining1480@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Dwj3KGdORqNXXzAA--.24040S3
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQAECmrjns4IMwAOsj
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=xiongyinin
	g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF15Kw48tw15GFW7tr45GFg_yoW5Ww43pF
	WkGw45twn7CF1qyws3G34UX3y8X3Z3CF47Wrsaqr1Svw15JF9Iv3WSg3W7WFy3uFWkZw4F
	kanYy3W09rWYyrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Original test uses a fixed 5000 iteration loop to trigger CPU hotplug
for verifying cpufreq synchronization between CPU hotplug and sysfs
writes.

Two issues exist:
1. Background hotplug task keeps running after test completes, causing
redundant CPU on/offline operations.
2. When cpufreq frequency setup is slow, the hotplug loop may exit
before frequency updates finish, which breaks test purpose.

Use signal notification to terminate the infinite hotplug loop, and
add an EXIT trap to clean up the hotplug child when this test function
terminates abnormally.

This makes hotplug run only during cpufreq sysfs write test,
align with test objective.

Signed-off-by: xiong yining <xiongyining1480@phytium.com.cn>
---
Changes in v3:
- Start the hotplug child after governor switch and sysfs frequency reads,
to avoid -EBUSY errors when the target CPU is offline.

Changes in v2:
- Stop the hotplug child process by signal notification instead of
a stop file, avoiding the predictable temporary path.
- Add an exit trap so the hotplug child is also cleaned up when the
main shell terminates abnormally.
- Link to v1:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2662696.html

This addresses the security and robustness concerns raised by Sashiko.
---
 .../selftests/cpufreq/special-tests.sh        | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/cpufreq/special-tests.sh b/tools/testing/selftests/cpufreq/special-tests.sh
index e87ed7c8e5e5..0665da8f2444 100755
--- a/tools/testing/selftests/cpufreq/special-tests.sh
+++ b/tools/testing/selftests/cpufreq/special-tests.sh
@@ -16,6 +16,8 @@ source cpu.sh
 source cpufreq.sh
 source governor.sh
 
+HOTPLUG_PID=""
+
 # Test 1
 # $1: policy
 __simple_lockdep()
@@ -92,6 +94,16 @@ governor_race()
 	restore_all_governors
 }
 
+hotplug_cleanup()
+{
+	if [[ -n "$HOTPLUG_PID" ]]; then
+		kill -s SIGTERM "$HOTPLUG_PID"
+		wait "$HOTPLUG_PID"
+
+		HOTPLUG_PID=""
+	fi
+}
+
 # Test 4
 # $1: cpu
 hotplug_with_updates_cpu()
@@ -101,14 +113,18 @@ hotplug_with_updates_cpu()
 	# switch to ondemand
 	__switch_governor_for_cpu $1 "ondemand"
 
-	for i in `seq 1 5000`
-	do
-		reboot_cpu $1
-	done &
-
 	local freqs=$(cat $filepath/scaling_available_frequencies)
 	local oldfreq=$(cat $filepath/scaling_min_freq)
 
+	(
+		local quit=0
+		trap 'quit=1' SIGTERM
+		while [ "$quit" -eq 0 ]; do
+			reboot_cpu "$1"
+		done
+	) &
+	HOTPLUG_PID=$!
+
 	for j in `seq 1 5000`
 	do
 		# Set all frequencies one-by-one
@@ -117,14 +133,16 @@ hotplug_with_updates_cpu()
 		done
 	done
 
+	hotplug_cleanup
+
 	# restore old freq
 	echo $oldfreq > $filepath/scaling_min_freq
 }
 
 hotplug_with_updates()
 {
+	trap 'hotplug_cleanup' EXIT
 	save_all_governors
 	for_each_non_boot_cpu hotplug_with_updates_cpu
-	wait
 	restore_all_governors
 }
-- 
2.34.1

