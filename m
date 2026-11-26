Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691371;
	b=0cOqxqdsPlXV7E/E/OJ0Nm06qZ7yRiIyK+69nX2PVf9QUkL1OtaRnz8hFVm/28U04Hd5
	 RMyM+Zy87n3duNBa/gWMRwyhv6/Yw+e+c/naFhT/GFxbMQ0u8xOq5D7srcdZYv/0d8Fr8
	 mRilPbx+Oj7JgETa+XWfJs9lEAFGvIvXBvQhFiBvhbeM49TlWTzgd7AL0ZOSeTITCrDrZ
	 TDmGW7x1tYD5K7bK4gjFXXPNmA3iFvzloOT8i6TjYV4mrRwUrh9hj9rkuao4zF5qn4SkN
	 jflqS/TY2kUxiq5JrXO74G4z8RtNIhEPILq+fM1hYJ4dBoAdnB4YG1H/m2qHUI4X+mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691371;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hfFhpia+LZFuVx/OFbiIekuEuJw2eEfcPbvtcN3sbs8=;
	b=5QceOC/RfsQsweDhMmccES3gL9DkAE1jR2g2bQODekiuSV3j81M11/nwWWj3j0wSMQmJ
	 i2JO0aJPOD3QPqPniElR74+Ot/gOQznNJYD2wQcxm1IuzvXh5PRFKq/pb2jF3nPiFMvg1
	 BInp7AXvbOJETRarBveMRjoBFinyUDx9VlXnRwcQa6A3wUS7zmaOqnp4h6/sIPnafHjcK
	 KIYU+3YpNkpAL8woySnkoVDVWpVmn2bKY3d1NOyPOS/+1bez2Uuv5DYRr/Mdyx0x3HpUj
	 ne+ilHsAtRVTBQzBJnny87mnXMC+dYPAy1zXOTRKQB9DH+ew3BBM9wY+PIwSO5sqIVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DXCubim9;
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E58606A31E;
	Thu, 26 Nov 2026 11:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69E58606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DXCubim9
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795691355; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hfFhpia+LZFuVx/OFbiIekuEuJw2eEfcPbvtcN3sbs8=;
	b=DXCubim9e5pAZHD92EhTzGaDT6o5v+l+aqDP8kjDxNZpK+s0z7SiL135Y4FzvEE4A5G/7rUkCNJQBCHdL91jKN+FdZgT8Jpo4nAtFhWh46k/KTgwd6nwmp25/htCNo9H1M/ZdoifgOiNHcwq49KWv8Jf8jnMAby05tu+tpo5Bgc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=jiangtianfeng@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFUIyJA_1795691345;
Received: from h68d07384.sqa.eu95.tbsite.net(mailfrom:jiangtianfeng@linux.alibaba.com fp:SMTPD_---0XFUIyJA_1795691345 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 19:09:15 +0800
From: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>,
	Ananthu C V <ananthu.cv@oss.qualcomm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
Subject: [RFC PATCH] cpufreq: Keep global boost enabled after partial enable
Date: Thu, 26 Nov 2026 19:08:52 +0800
Message-ID: <20261126110903.3747240-1-jiangtianfeng@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
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

Validation:
- mainline ARM64 defconfig build of the complete Image
- checkpatch.pl
- eight-case old-global/request/success state matrix
- independent static control-flow and locking review

NOT_RUN:
- runtime fault injection or reproduction with multiple policies
- global/local concurrency, hotplug, lockdep or KCSAN testing
- CPPC, SW frequency-table, ACPI or AMD hardware frequency/QoS testing

 drivers/cpufreq/cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4332cb114070..f23b64c2e620 100644
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
@@ -2918,10 +2921,15 @@ static int cpufreq_boost_trigger_state(int state)
 	if (likely(!ret))
 		return 0;
 
+	/* Keep partial enable usable and repairable through local sysfs. */
+	if (state && !boost_enabled && policy_success)
+		goto out_err;
+
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver->boost_enabled = boost_enabled;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+out_err:
 	pr_err("%s: Cannot %s BOOST\n",
 	       __func__, str_enable_disable(state));
 
-- 
2.47.3

