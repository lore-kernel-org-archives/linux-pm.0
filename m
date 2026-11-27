Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770330;
	b=zrhGF0gJTvcYz2IE/LIpUibaLz3vQJDSg5OvQdKiV1rgHs/7VC2TWLmFp5/bOUjj0A4G
	 wJOPvyLH5HCf3NQ4/ItRWcuM46PPLKRBAS/zTL8/wBQOm8iyrnILwXUGZ+oQ9pHvCHudu
	 SGB52L941Xlezn1uCFR/s4iYxi0Ioac7hNRcWzbU0tCHM0QxGVFui8stv+5iwLyii0SFC
	 gXXXEk51vEaI3Xv/ePYXbjME0qEGCOlTW/2CyFfM2NS5K9FlzW9Ezw6RPUiTSkkW1HUv1
	 xSQeO7c/khJJG5BbL73TPvETJu43oRLqqQTTPQPVVf0yUmdYNLdvvlVkp6MvwucK9OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770330;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F5twJYjlisCkSUmE0ZthgE9nV7AeZ+LTI2ZMvBz5Ygg=;
	b=Hpguf4JY65fYvLmAcq1+C2jDTEhM78lnXYPD3KQE3mYuis1jX3N6mnLdEhxTY4iLNser
	 TrRwPJzb+nvjf0lELLsD2iSafEd0sNclCtzI7MYsZLH/FXyqUutbQmTz6YxoTtUyKKE8M
	 Vm4B8rQT5WhIutW12ZK5MN6EDCaTLvs4AG1qPns6y8hnOoD/gd8GsFwgqpOcf5wDvmNks
	 bfDJrxn0k/1/EH8BGyaxl8iTduEeJ3ss79xovjBoJtkWOiq4iqk7VCV0JCaOLL5JK2083
	 zaULceUaJ0FOOrw0htUA4W2t7p1MB4RkJMt93hvm6uXmpLQ/YKxYfWqp9yCEBDohdyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cu13HkOr;
	arc=none smtp.remote-ip=115.124.30.131
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825F606A336;
	Fri, 27 Nov 2026 09:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3825F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cu13HkOr
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795770324; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=F5twJYjlisCkSUmE0ZthgE9nV7AeZ+LTI2ZMvBz5Ygg=;
	b=cu13HkOrDr+BNCAPeQeZ18bOlltbKY65gNPqSEzP6E5YyQfCrMEOeKVCBHzzRiZVH6bHcfm15mcJvEYr0zNB4jsJ3sGJVWkmMeyDBW4osmmaFQQdZuE07joYB7ahJm8JJePfu+aGewDigsgdczPVyiZ/YprBdH3AUHRtdoDMqsg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=jiangtianfeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XFXaSeI_1795770314;
Received: from h68d07384.sqa.eu95.tbsite.net(mailfrom:jiangtianfeng@linux.alibaba.com fp:SMTPD_---0XFXaSeI_1795770314 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 17:05:24 +0800
From: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Ananthu C V <ananthu.cv@oss.qualcomm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
Subject: [PATCH v4] cpufreq: Keep global boost enabled after partial enable
Date: Fri, 27 Nov 2026 17:05:08 +0800
Message-ID: <20261127090513.910723-1-jiangtianfeng@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127060407.732709-1-jiangtianfeng@linux.alibaba.com>
References: <20261127060407.732709-1-jiangtianfeng@linux.alibaba.com>
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
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
---
A failed write of 1 can leave the global flag readable as 1 when at
least one policy was enabled successfully. The write still returns an
error, and the resulting mixed per-policy state remains valid and locally
repairable.

Changes in v4:
- Drop the RFC prefix after review and add Zhongqiu's Reviewed-by.
- Remove the human-review/DCO-process note from the posting.
- No code changes from v3.
- Link: https://lore.kernel.org/linux-pm/20261127060407.732709-1-jiangtianfeng@linux.alibaba.com/

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

Validation (unchanged code from v3):
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

