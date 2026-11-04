Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809026;
	b=hVYDIkjij/DivzNEXnDBG2jwhgIDgOxK3b1be/y/RzXk5MjemUJbeYGV5uE2rilcVx/2
	 JO34AEWhQT6ASWP1rEhJVrVi1JohfGQmyqYKJTlfyQDSYFPHN8d4kUVkVGotAHbjwHDU9
	 ViHzV4NIhyUegRTVCyFEL71m9CMJN+Jr0SfXUrAnYGjX3F5e1fDtWEhvlf67Mcv1zqbe0
	 DloVYF92Aj0N85QHNYWWjZc6fvP8hEH2d7pgCpZo+o7Oj2phzHEoKJtcPyIml8qAcvu92
	 UUrDjTce1YZUrqw8uVOXzQ+dTsTvONQ1tAyLaY1ezasIt5Pfz+n3syYxF6HTsTH4ezQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809026;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xRth4yeDFpzrxgf4NoUNAjDIGdLtIAMqrqUwOU1lcqQ=;
	b=FcCpDyMACrN00cO37pGr39R+kkdJ25O/aYuwGMk+FhqJWktpm10HHUH9wU0+B9EdCg1p
	 ALohfVIsoN1kcHIfhUTJksHYU0qn+OLMoLUEVX5wTmnWMHj9amVNTHcgXaLfX5Awm6OJ4
	 QpQ4mGLMMvpCKB6SYqZJNTB4zbgn3xB5l128vRkbQsh1zqGBjJhDSYVa8wiStnyEkFmko
	 e0EtN1Imb44Ip0aEJt7IaHJFoBu+4EXAAie91xBfY/KXxZ516Yctkn/2LOdU9XklaUUOp
	 GifitYqMLElyzqTrF6O7LaWFYI7SxzmSzSiYYsSRNPUzTwDzhAY5FpYs3R5ePVjxhHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MP3PW0NX;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E5F606D810;
	Wed,  4 Nov 2026 16:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63E5F606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MP3PW0NX
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A332E1BB2;
	Wed,  4 Nov 2026 08:17:01 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C78073F632;
	Wed,  4 Nov 2026 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793809024; bh=qIKE6fRAvvucF8X+oC+cTY3pdNWfornKDodJuwNdvmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MP3PW0NXkOkxOMAm+wWeViJbs3Qpafe7RVfxckrGxOZRq67r37reRQbtfiLzDzfaF
	 jpLjQzZt+ATmqn2/LrlKwtjdLP/kq6v5cpM4YFWtM8diJsS3oGDUohWDwsOoqgp3SH
	 XGary0VHU1DPDVGk0RlpxtIu/LAk2DElzv9GKUxo=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumit.gupta@nvidia.com,
	zhanjie9@hisilicon.com,
	superm1@kernel.org,
	zhangpengjie2@huawei.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] cpufreq: Preserve global boost state on failed updates
Date: Wed,  4 Nov 2026 16:16:57 +0000
Message-Id: <20261104161657.546370-1-christian.loehle@arm.com>
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

cpufreq_boost_trigger_state() restores the opposite of the requested
state when updating policy boost state fails. For example, a failed
write of 0 when global boost is already disabled enables the global
flag without enabling any policies.

Save the original global boost state using a mutex and restore it on
failure.

Fixes: 121baab7b88e ("cpufreq: Force sync policy boost with global boost on sysfs update")
Fixes: 6f19efc0a1ca ("cpufreq: Add boost frequency support in core")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
On a platform without boost_supported the unfixed behaviour is:
# cat /sys/devices/system/cpu/cpufreq/boost
0
# echo 1 > /sys/devices/system/cpu/cpufreq/boost
echo: write error: invalid argument
# cat /sys/devices/system/cpu/cpufreq/boost
0
# echo 0 > /sys/devices/system/cpu/cpufreq/boost
echo: write error: invalid argument
# cat /sys/devices/system/cpu/cpufreq/boost
1

 drivers/cpufreq/cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54dde8419bdc..d95c849f79c5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2810,18 +2810,24 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 }
 EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
 
+static DEFINE_MUTEX(cpufreq_boost_mutex);
+
 static int cpufreq_boost_trigger_state(int state)
 {
 	struct cpufreq_policy *policy;
 	unsigned long flags;
+	bool boost_enabled;
 	int ret = -EOPNOTSUPP;
 
+	guard(mutex)(&cpufreq_boost_mutex);
+
 	/*
 	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
 	 * make sure all policies are in sync with global boost flag.
 	 */
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
+	boost_enabled = cpufreq_driver->boost_enabled;
 	cpufreq_driver->boost_enabled = state;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
@@ -2841,7 +2847,7 @@ static int cpufreq_boost_trigger_state(int state)
 		return 0;
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	cpufreq_driver->boost_enabled = !state;
+	cpufreq_driver->boost_enabled = boost_enabled;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	pr_err("%s: Cannot %s BOOST\n",
-- 
2.34.1

