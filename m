Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600A381E9A;
	Tue, 15 Sep 2026 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510581; cv=none; b=tAqeM6YWqo46mQFVz0eLPO3qH2akKz1YLwERvk47pYmaVgrTUcsaZFcOJI0mc7q+LCqV5q/eLOkgl2+6gBBO8WaIeaURWONghZqoWBpB+FVDLa2qt/UfRQtbSw0ReL1dLBAr/LOYgPri4Cp0rIBh1fOlb0m1X8rSqP2qvIu9rxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510581; c=relaxed/simple;
	bh=EmKH6KiUSZxRiMwHBL4QhTCKnMvmgE4J54oV0G+Jfy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0AxptoKaB5h0dGpvpX2g7Y6XHu+EFqUYBQAypw2k3msFXuCpGpvosE4TKPAo4/R3C8nlzi3LKz55ePmLgSf7fKq2N4moEJS0JTvoulhCTe/h750c4u9cM0CPdcFYODYjiY4YHnI652z8XuA+Ixf0lwf31m46Ksb8Ld1qGtDMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InhHz+Ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InhHz+Ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5251F000FF;
	Tue, 15 Sep 2026 22:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789510579;
	bh=UhPDHluT/7gzM48yl+dDyK6JRkEp8vM7pbedAmIroa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=InhHz+Jik1bvSD7jhhu0ALuEukw8yIMdqVXZ9rbYOUTyhKjLYrGo7qcZY4g5Bskoa
	 QSSGPufVlSbG8U1NJ1AsgvOMlbq6rzi5qBuWmQeoigf8BWWWxMjMUzlfZNGb2FFFBU
	 cd0MucjjjED4grKEQAxxBvWm4st6oN5aboy5xmWkuSv3HEtyQtLYrPqE+qvsd+XWGE
	 0oOXePAYx/XwnI6oKlO8BM/pFlZk7AMEZxaXYNGjoFp1edu3YNc7VoO/Oxw3ufDRwx
	 9gSI0ib0dPv8LnjhvwbbqSBpY58bDt4ZNWyLBObyqq+RkC2cqJqAmE2gt8jonvDgCO
	 Z+WIB6/mLh0VA==
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thorsten Blum <blum@kernel.org>,
	Yury Norov <ynorov@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] thermal: intel: powerclamp: Simplify max_idle_set()
Date: Wed, 16 Sep 2026 00:15:49 +0200
Message-ID: <20260915221548.104852-4-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915221548.104852-3-blum@kernel.org>
References: <20260915221548.104852-3-blum@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=blum@kernel.org; h=from:subject; bh=EmKH6KiUSZxRiMwHBL4QhTCKnMvmgE4J54oV0G+Jfy8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkrD88RfBTHH6Qfq33hl0dbIv+Hba8mi+1y6Nq69OMxH emzkfFKHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRck+GP/y/BfLN2GVk8/je uggsPLiH9bzmEo9UxSqvI68DPojMrGH4K7qpa+cD8dsquk98yn9z/P+o8UZ8Y86T6smiqUYz5rR ZMgMA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use guard(mutex) and return errors directly to simplify the code.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 29 ++++++++----------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 8ceb1270646c..6ca6a082b222 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -210,41 +210,32 @@ MODULE_PARM_DESC(cpumask, "Mask of CPUs to use for idle injection.");
 static int max_idle_set(const char *arg, const struct kernel_param *kp)
 {
 	u8 new_max_idle;
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&powerclamp_lock);
+	guard(mutex)(&powerclamp_lock);
 
 	/* Can't set mask when cooling device is in use */
-	if (powerclamp_data.clamping) {
-		ret = -EAGAIN;
-		goto skip_limit_set;
-	}
+	if (powerclamp_data.clamping)
+		return -EAGAIN;
 
 	ret = kstrtou8(arg, 10, &new_max_idle);
 	if (ret)
-		goto skip_limit_set;
+		return ret;
 
-	if (new_max_idle > MAX_TARGET_RATIO) {
-		ret = -EINVAL;
-		goto skip_limit_set;
-	}
+	if (new_max_idle > MAX_TARGET_RATIO)
+		return -EINVAL;
 
 	if (!cpumask_available(idle_injection_cpu_mask)) {
 		ret = allocate_copy_idle_injection_mask(cpu_present_mask);
 		if (ret)
-			goto skip_limit_set;
+			return ret;
 	}
 
-	if (check_invalid(idle_injection_cpu_mask, new_max_idle)) {
-		ret = -EINVAL;
-		goto skip_limit_set;
-	}
+	if (check_invalid(idle_injection_cpu_mask, new_max_idle))
+		return -EINVAL;
 
 	max_idle = new_max_idle;
 
-skip_limit_set:
-	mutex_unlock(&powerclamp_lock);
-
 	return ret;
 }
 
