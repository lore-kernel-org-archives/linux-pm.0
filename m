Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118262652A2;
	Sat, 10 Oct 2026 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626546; cv=none; b=rEsHJYHLUAtCJpDzGMjaPSII8+HlIrP23dxbpH+yuGN0NYt3tiCslOzmBK/YOZPugWrcjr0o5b58m8+kwxaYyry0c9ynTCenpV/cr16B7KgOVX3M8ERxNJqfeqY+7Zur7oSp46VDV90PmD3rT6MR81UEmKe7nVzghVX8uS0l8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626546; c=relaxed/simple;
	bh=IMrmOgZabUK0WGVlDHkR/u5wBMroTUgziCMch07aPXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YoYZeAjrLDrqlybAIhraxyRYlSpYuwbtrwfu3LgtQU+PmG3WFyLEteEmQ79RMrPCvoHyaFi2czPHbGmvyIqh+JOKpI3O8r0CpkWxQSW4gbbdY6BgyEfy2ysr0FWgImqe9IP4RB7g5rt9T0LhhU/7tEALd+/JQaxCNtehpHcEcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwC3Dd0cDcpqktCoAA--.47164S2;
	Sat, 10 Oct 2026 18:02:04 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwS3IbDcpqpynqAA--.62344S3;
	Sat, 10 Oct 2026 18:02:03 +0800 (CST)
From: xiong yining <xiongyining1480@phytium.com.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	xiong yining <xiongyining1480@phytium.com.cn>
Subject: [PATCH] selftests: cpufreq: stop CPU hotplug loop after cpufreq update test
Date: Sat, 10 Oct 2026 18:01:48 +0800
Message-Id: <20261010100148.297720-1-xiongyining1480@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DwS3IbDcpqpynqAA--.62344S3
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQAECmrJQM0EVQAhsR
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=xiongyinin
	g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zr4xur4UAFWftF1DWFW3Wrg_yoW8Cw47pF
	WrGw48tr1IkFyqyws3J34UXrWrJan3AFW7ur4aqr1Svwn8JF90vFySgr17XryakFZ8XrWr
	Z34vy3WI9F1UArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
 tools/testing/selftests/cpufreq/special-tests.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cpufreq/special-tests.sh b/tools/testing/selftests/cpufreq/special-tests.sh
index e87ed7c8e5e5..14530c1b8d25 100755
--- a/tools/testing/selftests/cpufreq/special-tests.sh
+++ b/tools/testing/selftests/cpufreq/special-tests.sh
@@ -97,14 +97,20 @@ governor_race()
 hotplug_with_updates_cpu()
 {
 	local filepath="$CPUROOT/$1/cpufreq"
+	local stop_flag="/tmp/stop_hotplug_$1"
+	rm -f "$stop_flag"
 
 	# switch to ondemand
 	__switch_governor_for_cpu $1 "ondemand"
 
-	for i in `seq 1 5000`
+	while true
 	do
+		if [ -f "$stop_flag" ]; then
+			break
+		fi
 		reboot_cpu $1
 	done &
+	local hotplug_pid=$!
 
 	local freqs=$(cat $filepath/scaling_available_frequencies)
 	local oldfreq=$(cat $filepath/scaling_min_freq)
@@ -117,6 +123,10 @@ hotplug_with_updates_cpu()
 		done
 	done
 
+	touch "$stop_flag"
+	wait $hotplug_pid
+	rm -f "$stop_flag"
+
 	# restore old freq
 	echo $oldfreq > $filepath/scaling_min_freq
 }

base-commit: 28924df2a08f440c73991b83028032c901de2ae4
-- 
2.34.1

