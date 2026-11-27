Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795744191;
	b=Z2WHH6Qgg57cDXssIu/gbinjqOrf3vXSJarDw6qy/TDjhjKkyc+73PA9PkF80Rt4jvIF
	 JIeyg8sMVZYX8+9/TCr3oNqmv0Qs9tDzuijFQrzi/TwerUuHw/sRq8d5Vm5KH3Aev6HSk
	 6RDg9F4y097WFfMIPffIvKcKLMtoaGbI51gyM93eHGToP34GEw3g7acrgO03vX9ffOQ6x
	 92j6TTub1WqIX3NTAAVATZ3dcLoDSP7p0toWJtfWdpajtzovezcBvySRIDNGls1268MZl
	 9OEYpTgH7huqHakz0tOlY/m7Px0wl142+YBoVgiqYXSE1zrjgZJEwCVSk/npdjvIcvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795744191;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x14zHhnV4N4TwPMA5axxL2E1JT7/FZeG+7OjV1ttJ1c=;
	b=5sVCOAzvsScbcj8rOYRrDq8P7KhH6M8/sFY8o0BI+QifwkBNEjCe2B4Tl08+tB5t5k8V
	 +W3Zvw1Rv9KHN/NiLAeS/f9YTdHlkOTWsSMDZ40HqhkEzcW2zce0dM61W3a6bLhSirAYb
	 NbBFUGJXVf5PbnPw4vlCGbYOUhoxfckBE9Op+Sum9upN77l92MCfSwracZKU+N1bWAbst
	 K0I6VvZPuWHLa1NL1j/S2jJ/22bmB+iHEK0g/3GaR2Hjpxc/f+fpihwbXHmGIt+mPPeCe
	 onUI/2AsSthE6WN1aT4pzIujAaJxWbGvb5TYPb6WcUcZa/ZwaTBP4RWF38RUB628tww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="nlWWOV/D";
	arc=none smtp.remote-ip=115.124.30.118
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CED606A31C;
	Fri, 27 Nov 2026 01:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37CED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nlWWOV/D
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795744187; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=x14zHhnV4N4TwPMA5axxL2E1JT7/FZeG+7OjV1ttJ1c=;
	b=nlWWOV/DNbGNEhDUiG99DGsmoAUxEDvezkf9bWNmDL5ADwPPQHDt8GwEwbBXJOK3uvgqohZDyw8q1bJeiBoxp00b8uCb6baqH7OrXZiGL9+jLSpg8h5ubZsBEGJ2wdmDjtDkARkNxggL9OKV6Y/VmsmBc97W/QLSyFP45e1uVAk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=jiangtianfeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XFW0kue_1795744178;
Received: from h68d07384.sqa.eu95.tbsite.net(mailfrom:jiangtianfeng@linux.alibaba.com fp:SMTPD_---0XFW0kue_1795744178 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 09:49:47 +0800
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
Subject: [RFC PATCH v2] cpufreq: Keep global boost enabled after partial enable
Date: Fri, 27 Nov 2026 09:49:33 +0800
Message-ID: <20261127014937.413500-1-jiangtianfeng@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126110903.3747240-1-jiangtianfeng@linux.alibaba.com>
References: <20261126110903.3747240-1-jiangtianfeng@linux.alibaba.com>
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

Retain global-state restoration for enable failures without a
successful policy update, same-state resynchronization failures, and
disable failures. Do not roll back earlier policy updates.

Qoder, an AI coding assistant, helped analyze the issue, develop the fix
and state matrix, and draft this description.

Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
Signed-off-by: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
---
 drivers/cpufreq/cpufreq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4332cb114070..707de10ad36b 100644
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
+	/* Keep partial enable usable and repairable through local sysfs. */
+	if (!state || !policy_success) {
+		write_lock_irqsave(&cpufreq_driver_lock, flags);
+		cpufreq_driver->boost_enabled = boost_enabled;
+		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	}
 
 	pr_err("%s: Cannot %s BOOST\n",
 	       __func__, str_enable_disable(state));
-- 
2.47.3

