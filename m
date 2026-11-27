Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795759463;
	b=i0i054/YgpLDLcwV2/unAylztBNJlCUjEDxdeJIzV179mGKVSdDMWQi0Yh+zPYIFnHe4
	 vIs7008nMzeG02ejFgouH2klQ8uEMwdSlWMcGaAHZjEq01C40jX3/fNP4etjhjgEfUcYX
	 wem9qfuNl4YHrDeEJ89Ogv+Kd7yWSlxL1ZTVMTY+FXqTR+CkR84XWW81sT7QoA6/Uxu+K
	 VipULXKs3nuA8/kaZyrPHt02IaLv1H5aYLwGl4VxZnOIIjS6dfxnmH53UmQEz5M/wyrhx
	 7RrnXMUJt1fyMOjUINWL+OxkAy5zoncCC6fPKky1Ug9Ev7uNOiMnum7gm9I3NDoXkNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795759463;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U4HHDYIdWf0fz8S6410uXcXdDyUbeJMfeULhc7w7ooc=;
	b=Z1gYGCRHhPM9SUFGl8m05CwHKMC01U5FTU9syJXJPNSnLkpF2YRUHVjy0z6XQivwlMBI
	 qVsRK3/WQHNW/9Ku+QLGSaBqbDH4IleCew7j5z9EI5lQ9j5xellZr1ZV9kEpzXi+0nCSF
	 r0lshcncVwa9L2xA3ED7rT7icTIl0pq/6UpjTHYGpnGM9tQ+HQBpskxsarEyspg7/iQCR
	 KdX57Wlaz41ITE9054TpkPgGAP8xUnJhSaCVB7aoG5Sl9kHdI8xsMNoJoSb0GFszfrWIm
	 YDLQQXe8LALG5z85mFCqyIyePg8FaiHgxsc0lYUqLPVI7znQIcXlM3WJq1FUQUywS+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="qT/Wz5Ue";
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BB606A321;
	Fri, 27 Nov 2026 06:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F06BB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qT/Wz5Ue
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795759458; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=U4HHDYIdWf0fz8S6410uXcXdDyUbeJMfeULhc7w7ooc=;
	b=qT/Wz5Ue/SioA3mHn7QtQaoaTJMi0LCg297+T52I8+Ih3qxBwj+0zqEyH8vkUXMpoyp2GkfpICH7mqeW5VDuWWSml8lch/PPzTP2XmLgzAgUsP9GFoiKtNPz9HQQFLMk+rQgMku1aLLWMCcp0H0kGvGhZwGxPMibwYZ+/zVeB1A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=jiangtianfeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XFWwdI-_1795759449;
Received: from h68d07384.sqa.eu95.tbsite.net(mailfrom:jiangtianfeng@linux.alibaba.com fp:SMTPD_---0XFWwdI-_1795759449 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 14:04:17 +0800
From: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christian.loehle@arm.com,
	ananthu.cv@oss.qualcomm.com,
	pierre.gondois@arm.com,
	zhongqiu.han@oss.qualcomm.com,
	jiangtianfeng@linux.alibaba.com
Subject: [RFC PATCH v3] cpufreq: Keep global boost enabled after partial enable
Date: Fri, 27 Nov 2026 14:03:59 +0800
Message-ID: <20261127060407.732709-1-jiangtianfeng@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127014937.413500-1-jiangtianfeng@linux.alibaba.com>
References: <20261127014937.413500-1-jiangtianfeng@linux.alibaba.com>
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

When global boost is enabled from the disabled state, a failure after
one or more policies have been updated successfully currently restores
the global flag to 0 without rolling back those policies. This leaves
them locally enabled, with their boost-related driver/QoS updates
retained, while the global flag rejects per-policy sysfs writes.

Keep the global flag enabled if at least one policy_set_boost() call
succeeded, while preserving the existing error return path. Global
boost = 1 grants permission to boost; it does not require every policy
to have boost enabled. The mixed per-policy state is therefore valid
and individual policies remain accessible through per-policy sysfs.

Restore the previous global state on disable and when no policy was
enabled successfully. After a partial enable, keep global boost enabled
so users can repair individual policies through sysfs. Do not roll back
earlier policy updates.

Qoder, an AI coding assistant, helped analyze the issue, develop the fix
and state matrix, and draft this description.

Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
Signed-off-by: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
---
This RFC discusses the user-visible partial-success semantics: a failed
write of 1 can leave the global flag readable as 1 when at least one
policy was enabled successfully.

Changes in v3:
- Correct the changelog and comment to describe restoration on disable
  or when no policy was enabled successfully, and local repair after a
  partial enable.
- No code-logic change from v2.
- Link: https://lore.kernel.org/linux-pm/20261127014937.413500-1-jiangtianfeng@linux.alibaba.com/

Changes in v2:
- Remove goto/out_err from the function using cleanup guards.
- Simplify the restoration condition to !state || !policy_success.
- Link: https://lore.kernel.org/linux-pm/20261126110903.3747240-1-jiangtianfeng@linux.alibaba.com/

No normal in-tree trigger for the partial-enable sequence has been
identified. Same-state global writes already provide a resynchronization
mechanism. The same-state disable/resync failure noted by Zhongqiu is
left for separate discussion instead of expanding this patch.

This AI-assisted draft requires human review and DCO sign-off before
submission.

Validation:
- mainline ARM64 defconfig build of the complete Image
- checkpatch.pl
- eight-case old-global/request/success state matrix
- independent static control-flow and locking review

NOT_RUN:
- runtime fault injection or reproduction with multiple policies
- global/local concurrency, hotplug, lockdep or KCSAN testing
- CPPC, SW frequency-table, ACPI or AMD hardware frequency/QoS testing

 drivers/cpufreq/cpufreq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4332cb114070..57f1874e087a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2887,6 +2887,7 @@ static int cpufreq_boost_trigger_state(int state)
 	struct cpufreq_policy *policy;
 	unsigned long flags;
 	bool boost_enabled;
+	bool policy_success = false;
 	int ret = -EOPNOTSUPP;
 
 	guard(mutex)(&cpufreq_boost_mutex);
@@ -2911,6 +2912,8 @@ static int cpufreq_boost_trigger_state(int state)
 		ret = policy_set_boost(policy, state);
 		if (unlikely(ret))
 			break;
+
+		policy_success = true;
 	}
 
 	cpus_read_unlock();
@@ -2918,9 +2921,12 @@ static int cpufreq_boost_trigger_state(int state)
 	if (likely(!ret))
 		return 0;
 
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	cpufreq_driver->boost_enabled = boost_enabled;
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	/* On failure, restore old state unless partial enable needs local repair. */
+	if (!state || !policy_success) {
+		write_lock_irqsave(&cpufreq_driver_lock, flags);
+		cpufreq_driver->boost_enabled = boost_enabled;
+		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	}
 
 	pr_err("%s: Cannot %s BOOST\n",
 	       __func__, str_enable_disable(state));
-- 
2.47.3

