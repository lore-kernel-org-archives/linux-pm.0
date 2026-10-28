Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181776;
	b=Lt7fAxNPedkMp4UP3BAiUypUR6iv8VG2K68XZfDt/vdLXZ1Y8udo/raTMOB8miJLylLb
	 tHjw1htOtni7HItnh4upJ7kcuQrV/VsZaCvYy6T+pgS9q1K0glWmkjmhGuwp0x/QplLdT
	 cj7Y6ZU36TqHbsvFLF9il5sL31+CmHz0hy+YWIIwypRy0DLo5mMjBLPvwxd2s2j0IymhK
	 a37Wy1edvAPUmU4H4ut3Mw6RIJau+4S/NMLNMhncqhRbcgG+M22v+JYImZRFB9UQSj4J8
	 It26ngB/VGrVYo6WSXquZ4B7Fol7ywHtWKRbns3gyd5l6/OdmQfnY320t2TELvBxy2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181776;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=ddvx5f00z+VIk9kGMVictMEiXeJ0/JrB5XxYTj9h55Q=;
	b=ceoXUNhz0NC6lQbmq0pCfDrSHXbf1SgBvFjEVvuu0XWNbzPgGxGp8NNmOwRLX/OqPYVg
	 pJjLi5DLePSCAeEdwHXlkIvAJEOPn7GaU2dPLCc/pUw+tnH/ZLyGsHt/KkLf8ubXpyMb3
	 CGcP9DLfjFOWH55wZp4OOMzoVL3Dp48zdqSS+x9JevBCl518N6YlC+4PheztYN+NeF9km
	 ABi4Sp7v76HHq8kJXFsVUHjspSypL5hzRe2WcSnqsNqi6hE7rmdJe80mEZ23Rd2pPi5D/
	 0//A0GwYXVMplUnqaRsxiTCZXKIgyOZFpI6dZ6WibjgWvGQmgRrmi/TNuWut07o8Haw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3741606A31C;
	Wed, 28 Oct 2026 10:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3741606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwAnfdxFyOFq04SlAQ--.14102S2;
	Wed, 28 Oct 2026 18:02:45 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwJnVCyOFqaF3yAA--.16563S3;
	Wed, 28 Oct 2026 18:02:43 +0800 (CST)
From: xiong yining <xiongyining1480@phytium.com.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	xiong yining <xiongyining1480@phytium.com.cn>
Subject: [PATCH v2] selftests: cpufreq: stop CPU hotplug loop after cpufreq update test
Date: Wed, 28 Oct 2026 18:02:41 +0800
Message-Id: <20261028100241.189085-1-xiongyining1480@phytium.com.cn>
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
X-CM-TRANSID:AQAAf8DwJnVCyOFqaF3yAA--.16563S3
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQABCmrfqkkNCABOsX
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=xiongyinin
	g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF15Kw4rKw4kAF1kuF1xKrg_yoW5XrWUpF
	WkW3W5twn7CF1qyws3J34UW3y8X3Z3AF47Wrs0qr1Svw15JF90v3WfK3WxWFy3urWkZw4F
	9anYy3W09r4FyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Introduce a file-based stop flag to control the infinite hotplug loop.
After all cpufreq updates complete, create the stop flag file and
wait for the hotplug task to exit.

This makes hotplug run only during cpufreq sysfs write test,
align with test objective.

Signed-off-by: xiong yining <xiongyining1480@phytium.com.cn>
---
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
index e87ed7c8e5e5..b3ebead1c52a 100755
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
@@ -92,20 +94,34 @@ governor_race()
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
 {
 	local filepath="$CPUROOT/$1/cpufreq"
 
+	(
+		local quit=0
+		trap 'quit=1' SIGTERM
+		while [ "$quit" -eq 0 ]; do
+			reboot_cpu "$1"
+		done
+	) &
+	HOTPLUG_PID=$!
+
 	# switch to ondemand
 	__switch_governor_for_cpu $1 "ondemand"
 
-	for i in `seq 1 5000`
-	do
-		reboot_cpu $1
-	done &
-
 	local freqs=$(cat $filepath/scaling_available_frequencies)
 	local oldfreq=$(cat $filepath/scaling_min_freq)
 
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

