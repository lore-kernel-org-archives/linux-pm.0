Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915556;
	b=Dqi7oUkOv2t55L8ahEjSEJ02mNVHxngbl0odpiYU89NZfK6HJ7bwHdhOI/WrgKjc4fMv
	 eI9A+tLc4CzUp811riUnbmHYUerZGNqFlyZ41+8QFrjK8bEOvKXwgesbYsWNkO6v2dTAV
	 TkZqIhxa+MNr4dRgWwtoO2SFerb+v29kRi786V+E8IMgyxXMyXGXQnn/y+NGV2BONCqHf
	 v/rRm8SwgpBj5D+Z+knQE1fFhEhoF9Vb7Xc57Mr0W63HBnm9smZeOHASrPk/rnUhgHd0k
	 W8/yUjEhFk/9EZbj7MkvRhF8wWU24FupARTST8edX1D+oMfVKBLrfKclAmapJoEUejg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915556;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iunH9nIpKusdIuR/kgRshk7ZWuphGj/uL+hE3XXizS0=;
	b=H2o1JFAKDQg8V1DwOT7xcuj0A/zStvgSP8jETwFXQxU8PeE+fPUypqmHRfQ3tf7jgBjG
	 CX+qoDFKr//XdbEuATJ4rEeMYXG5k2q3lrFSquDm8+2xCBhOSsWC9RrTno3uj/EhKYlVh
	 J+DVvl63eo/yDBaHoFO1X6sUmtZMO2oOAsAfWl0FqhRE8ExfFkw8A78Dhr1wysV5oXPoc
	 pRNFK+j8LhgLAu0ixKOG3KOWyf79h0zD7O4ntHR3HaycH4pyKUs2GFZ9KPdRxDOgmsNOl
	 DUa2TTNOQS00PWv8JMxdttx9acxvj8E9o13/cvWhSkGkRYghsVsgsB3aFjrnRLTAnjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IxBzWrJd;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E88606A328;
	Thu,  5 Nov 2026 21:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00E88606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IxBzWrJd
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4826C1684;
	Thu,  5 Nov 2026 13:52:31 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 076343F628;
	Thu,  5 Nov 2026 13:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793915554; bh=hhCQeec8QAgZCY+4ikr8eXnJjOCk3Xwa00PThNKzsJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxBzWrJdHW7YZND62bvjHX+JlL2v7oZTnMXhQywL0m2o22OHjOcEs96cyUh8WgH7E
	 iw0sQ7WwkB8/cMcK0aD+WE2labnEUkCEHsFCWkUiesVWVqA53ot+/snudpn2SZu7U4
	 cOxtrono9qbpERyRE2EdwOHzqLM6dx27Cz/ZuK20=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumitg@nvidia.com,
	zhanjie9@hisilicon.com,
	superm1@kernel.org,
	zhangpengjie2@huawei.com,
	Christian Loehle <christian.loehle@arm.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Subject: [PATCH v3 1/2] cpufreq: Preserve global boost state on failed updates
Date: Thu,  5 Nov 2026 21:52:22 +0000
Message-Id: <20261105215223.1263415-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105215223.1263415-1-christian.loehle@arm.com>
References: <20261105215223.1263415-1-christian.loehle@arm.com>
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
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
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

