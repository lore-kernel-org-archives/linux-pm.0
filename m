Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349405;
	b=eWVeb95jNVXStCk5NVRMFJCG0rNjwjscZ1bVXqubD2gnXHwtmr9GtMacYGzuWNWwFmzQ
	 lbcLTTc7FaRYnRPLtpVX2+rIPn2Jwp4e+V+02RI+Cj8ZNcsQKYs8HB0AjIN3kStqfdcqg
	 Cv0tB4vQQlI4n2urYFn2voLhNXT+inN2kyvgwz+5sqjYI6yRMDgdprRDpAxy/+f1yLiXf
	 ZqqetO/ntdgjtV9Tw0Kzsoq2Kj/DRb36tCyK/LHB5z9pPmSzyFpNZw+dV/hpfAMLf9XfJ
	 aKiyfuEhrakVxEg+QCcWx4mcbPYl2ZO3GX+WSFCNvgm2xoU7yqH/uc1+r9ub2RBBtag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349405;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QJpeU3mIk9H3tdluWplJ4JH/q7Ot9S7T2YR2AtQqS60=;
	b=Kor7MFrHsTBkj15NWkC2jj/4HI2LwkzwRIWWrxWEQpINWQrfzRxvXHkhNIYLUGQhKPPI
	 MreebXwUBY9wFpU3JpOT85zTdzdk/VQw1NnGxtlgmxJb21xj0+RJOL4MwGy0eRNv9E1PT
	 /b1mid/bGdNa/MK+amfpclNJDo5gsGcxaxTtlB0gilSwUP2a7nJqvyboqOkaFjR1/CHOs
	 EAScCfjGZUWVzGOW41fTKoJreYxomf+i9R4fo1SNbdwLe4e/mDI+EqiJGVAb14cnIxVPi
	 vn3GkXefDT7rjsYfUsHXe/0/4CHB6j0zTlei0fbJNwzsbZ6O/+LU26Sv+hbgRYT58bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kLVjlHqT;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D583606A33C;
	Fri, 30 Oct 2026 08:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D583606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kLVjlHqT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A8E11E8D;
	Fri, 30 Oct 2026 01:36:40 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.79.231])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3AC73F673;
	Fri, 30 Oct 2026 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793349403; bh=us169U//VQGZafJRfAU3cNExT02omKnXb+PMt1WaD9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLVjlHqTPwIzE7VYha6jIkkVOS9JS7CTFBvt/K8pgq9PSg/Eo6WK18ZgeKeQ4xgKe
	 hX+19k8GUhge8yvDs23QvjZILdn/eLpEejXudw+DpXp8TdwAJH9wH6rylBEsJ3V05j
	 CPpzCPdj8xwPWKkyz+vhbSU1vYt2Yjt1+BOwZsB0=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 1/2] cpuidle: Skip miss accounting for timer broadcast fallbacks
Date: Fri, 30 Oct 2026 08:36:32 +0000
Message-Id: <20261030083633.1699270-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030083633.1699270-1-christian.loehle@arm.com>
References: <20261030083633.1699270-1-christian.loehle@arm.com>
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

A failed tick_broadcast_enter() can force a shallower state than the
governor selected. Exclude successful broadcast fallbacks from above/below
miss accounting while retaining their usage, residency and governor
feedback.

Fixes: 04dab58a39d4 ("cpuidle: Add 'above' and 'below' idle state metrics")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/cpuidle.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 2d2f40a2cb81..faa29f58738e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -222,6 +222,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 
 	struct cpuidle_state *target_state = &drv->states[index];
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
+	bool broadcast_failed = false;
 	ktime_t time_start, time_end;
 
 	instrumentation_begin();
@@ -232,6 +233,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 	 * CPU as a broadcast timer, this call may fail if it is not available.
 	 */
 	if (broadcast && tick_broadcast_enter()) {
+		broadcast_failed = true;
 		index = find_deepest_state(drv, dev, target_state->exit_latency_ns,
 					   CPUIDLE_FLAG_TIMER_STOP, false);
 
@@ -306,6 +308,13 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 		dev->states_usage[entered_state].time_ns += diff;
 		dev->states_usage[entered_state].usage++;
 
+		/*
+		 * The broadcast constraint forced a shallower state, do not
+		 * account for it as a cpu_idle_miss.
+		 */
+		if (broadcast_failed)
+			goto out;
+
 		if (diff < drv->states[entered_state].target_residency_ns) {
 			for (i = entered_state - 1; i >= 0; i--) {
 				if (dev->states_usage[i].disable)
@@ -338,6 +347,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 		dev->states_usage[index].rejected++;
 	}
 
+out:
 	instrumentation_end();
 
 	return entered_state;
-- 
2.34.1

