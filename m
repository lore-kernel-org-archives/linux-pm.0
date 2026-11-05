Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869417;
	b=1pxi5TDg46pf2vypR/tNw8FoK+qpHfYr7K/IgUaGLzZXffP2q1mNgEugcEqqJEnpGRo7
	 rNq8/MfKv6CON1Px/VLdpnVm6n0UjrX5FWd72FTwyGCY1Fgl6BB+9wrZ0NAzYsQwzz9rD
	 OOwmGLAH+Nt5+SGzWwat2+UqRpBV2XhZYZBRQZPdkjR5CJGIBFjh4AsVpLvKZlLTTAgK3
	 7Pts07U/EKhDrzOLTEuvxqxBGsgftuHwY1m0bXMV3eyBFEuPMMxOckAEghbEFAEy1WQZL
	 HA0yI2vMNrnImH0KyNfJeKRZqKsQ0LNk5FThqoTrxKxvJxPgcpJzP6UuuHncZUQYGPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869417;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B2qEjDLNpDHxOrp/8HcWjCqMDofoflMsdeplAxdbHaM=;
	b=QPtdDhkIyf1argHEjd1YfyZU1EEN5rpcPRDe9x9nP9USWs3hZ7ATM3vIS35OZr46wJiD
	 55NUZiINPlqvbQirK42ZimCMTnoojIDOyrTspshu1DIRIsRRGeTNd5H3xvxa5sA4i9x0V
	 /aUhVg0k1ARDMoMR8a2/VqbMZKP6+s8trg+1KvGemWtubFAPxgFr5+4qEBIkwiGjdv/7n
	 0UtoRfEFu4QZ1ekVSVPCct/MISkTYQVbBRMhIE+ow7snKVMfb6i68J5E/P/Sio4WrX6jm
	 m+V0vu4mbyknbiAnHbrCqEnEqqUXhBPe4pbYkh6tNTzD0HUjdeOwP0Pt7rxk0WoqidA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LsrWsLs9;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3FF606D804;
	Thu,  5 Nov 2026 09:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C3FF606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LsrWsLs9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFB8419F6;
	Thu,  5 Nov 2026 01:03:32 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 256463F628;
	Thu,  5 Nov 2026 01:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793869416; bh=2aHkawPJ54ksfbdj56u4wumZRTlbFHDsgddiE47LzPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsrWsLs9JZZ8in2A2BW4OGjGOEq0B0JQxVG14VTQg78hkhqjqlC3RYTtnhoIEgoCE
	 OvTyHSs1G1PumwJHAjzlI8S7uD54e1lsCIsQ0QCzfMC92aacjdL7jiEsHRZM+C9XIc
	 hPU78K7gCJ7KN+bfHUH31wwGDjw2OpD5zpYZQ1sw=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumitg@nvidia.com,
	zhanjie9@hisilicon.com,
	superm1@kernel.org,
	zhangpengjie2@huawei.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 1/2] cpufreq: Preserve global boost state on failed updates
Date: Thu,  5 Nov 2026 09:03:10 +0000
Message-Id: <20261105090311.1026648-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105090311.1026648-1-christian.loehle@arm.com>
References: <20261105090311.1026648-1-christian.loehle@arm.com>
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

Save the original global boost state and restore it on failure.

Fixes: 121baab7b88e ("cpufreq: Force sync policy boost with global boost on sysfs update")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54dde8419bdc..23a77f5524df 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2814,6 +2814,7 @@ static int cpufreq_boost_trigger_state(int state)
 {
 	struct cpufreq_policy *policy;
 	unsigned long flags;
+	bool boost_enabled;
 	int ret = -EOPNOTSUPP;
 
 	/*
@@ -2822,6 +2823,7 @@ static int cpufreq_boost_trigger_state(int state)
 	 */
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
+	boost_enabled = cpufreq_driver->boost_enabled;
 	cpufreq_driver->boost_enabled = state;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
@@ -2841,7 +2843,7 @@ static int cpufreq_boost_trigger_state(int state)
 		return 0;
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	cpufreq_driver->boost_enabled = !state;
+	cpufreq_driver->boost_enabled = boost_enabled;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	pr_err("%s: Cannot %s BOOST\n",
-- 
2.34.1

