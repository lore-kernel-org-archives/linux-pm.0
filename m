Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559504;
	b=GzFda6x3yb10lGJbJiWkz5mxTVgWeihohABE9sMjW9fbWwQvMQwUYA3IRXTEwnELSVI6
	 B3kqA+ilrxvyegfG0n0kYLC3jhwrRDY8cronb/+vrRSyO+0hckXAyHN/3b47DjqGSKY5o
	 ueNlv05DI/gAiNvXy8YngEB75nHifra0tj9RWynAq3Eu7c4XAIesuFu87DF8ThFET6WWd
	 0+qkVX8IpYBzBd1XK6h5S1YXbq7bDnEMZK/MVRITIKU4vFByin57hf8sC+Xu/CBbgXI/V
	 lLQc63aT/hMm2g5z50oc/zGcPpYcF//7sJN+UZc4ZJ4l81ZEQJ7AGJz052fLVcyDqCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559504;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=gxV8jWkJrL5x4Ukev9pRL/MqZOjbjDyS7hPKdWYrOlw=;
	b=f/kvtl1gcW1V3TAGSYg9bb/FK39RegkZ260dlu4WnMT9Llf2tCRI+B0YuLAEoj4C01dC
	 9ppBGJe1vpq3784GnJZEepHA2gUXrCwuqy31/voIa+bu6bwy9KD9JBY7hdCcu9ldFC5PD
	 gK7LpkH7ouzNfC90VS1+IvFgP6l4bE3o5kjK0DM/t6azwZ8abgYoTXfAWfrLyUTV+mhI1
	 K3N6sN7VDETPxHj+0CbSjt48OJ5M540wPnzRmi81S/T/fD540koNSE6X4gZccuAhGSSbd
	 vjFxBtIDlPgE6kATB07UzTgOLNevA0cmAL4asmnz4RKb+3tH5S6+STBj1tzx51BthAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hsal.es;
	spf=pass smtp.mailfrom=hsal.es;
	dkim=pass header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=kUtDzGLi;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C310606A324;
	Sun,  1 Nov 2026 18:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C310606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hsal.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=kUtDzGLi
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jHkcg3Scbz8sqQ;
	Sun, 01 Nov 2026 19:58:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
	t=1793559491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxV8jWkJrL5x4Ukev9pRL/MqZOjbjDyS7hPKdWYrOlw=;
	b=kUtDzGLiq53XNm9bS/34T0NPC61clhCez7wX0EXj0fT3fHhdabwUMZRQoLFJL7f9K3vf40
	T8KnWY5YnGJv9Xb4IR1B6YNPCHeKr52zQN7O4VfU7QWac5LEa1RAx2rYkNML6dM7M7BMtt
	plTLjYIu+mEffAbjeV36POVYvRxv5TjsIWfT3wgVcOq7m51LPw4Tskf1+KNaJP4j+1rKyd
	frDIBhew5rkNgdR8qhcx6em5Vzwxd61P9NwIgEb2pt1QkS7Sw6YRInnSweW1FYIIDiU8xB
	6kXUYDH6aYXts4JGniQ88R+9enzDQ23eEmzsv/9pIXB+JSdQOVjiN/F7ihIufw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Len Brown <lenb@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Ashton A." <me@ashtonantila.com>,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] cpufreq: Add a CPUFREQ_UPDATE_CPUINFO policy notifier event
Date: Sun,  1 Nov 2026 18:58:04 +0000
Message-ID: <20261101185807.112449-2-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101185807.112449-1-hugo@hsal.es>
References: <20261101185807.112449-1-hugo@hsal.es>
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
X-Rspamd-Queue-Id: 4jHkcg3Scbz8sqQ

Turning boost on or off changes policy->cpuinfo.max_freq in the
->set_boost() callbacks of amd-pstate, cppc_cpufreq and the drivers that
use cpufreq_boost_set_sw(). Users that derive a QoS request from
cpuinfo.max_freq have no way to learn about it. The ACPI processor
thermal code is one: its throttling steps are fixed fractions of
cpuinfo.max_freq, computed only when the cooling state is written

Its freq QoS notifiers don't help, since they only fire when the
aggregate limit changes. While a thermal cap is lower than both maximums,
turning boost on changes boost_freq_req but not the aggregate

Add a CPUFREQ_UPDATE_CPUINFO policy notifier event and send it from
policy_set_boost() once the driver has updated cpuinfo. The helper that
sends it is global, so a driver that changes cpuinfo.max_freq outside
->set_boost() can send it too

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 Documentation/cpu-freq/core.rst |  9 ++++++---
 drivers/cpufreq/cpufreq.c       | 16 ++++++++++++++++
 include/linux/cpufreq.h         |  2 ++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/cpu-freq/core.rst b/Documentation/cpu-freq/core.rst
index 4ceef8e7217c3..946913c024121 100644
--- a/Documentation/cpu-freq/core.rst
+++ b/Documentation/cpu-freq/core.rst
@@ -49,11 +49,14 @@ transition notifiers.
 2.1 CPUFreq policy notifiers
 ----------------------------
 
-These are notified when a new policy is created or removed.
+These are notified when a new policy is created or removed, and when boost
+is turned on or off or the driver reports a change of cpuinfo.max_freq.
 
 The phase is specified in the second argument to the notifier.  The phase is
-CPUFREQ_CREATE_POLICY when the policy is first created and it is
-CPUFREQ_REMOVE_POLICY when the policy is removed.
+CPUFREQ_CREATE_POLICY when the policy is first created, it is
+CPUFREQ_REMOVE_POLICY when the policy is removed and it is
+CPUFREQ_UPDATE_CPUINFO when boost has been turned on or off or the driver
+reports that cpuinfo.max_freq has changed.
 
 The third argument, a ``void *pointer``, points to a struct cpufreq_policy
 consisting of several values, including min, max (the lower and upper
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54dde8419bdc4..4d974dac4dff5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -594,6 +594,8 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
 		return ret;
 	}
 
+	cpufreq_notify_cpuinfo_update(policy);
+
 	return 0;
 }
 
@@ -1184,6 +1186,20 @@ void refresh_frequency_limits(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL(refresh_frequency_limits);
 
+/**
+ * cpufreq_notify_cpuinfo_update - Notify policy notifiers of a cpuinfo change
+ * @policy: Policy whose cpuinfo limits have changed
+ *
+ * Send CPUFREQ_UPDATE_CPUINFO to the policy notifiers, so that QoS requests
+ * derived from @policy->cpuinfo can be recomputed. An inactive policy is
+ * notified too, since its QoS requests stay until CPUFREQ_REMOVE_POLICY
+ */
+void cpufreq_notify_cpuinfo_update(struct cpufreq_policy *policy)
+{
+	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+				     CPUFREQ_UPDATE_CPUINFO, policy);
+}
+
 static void handle_update(struct work_struct *work)
 {
 	struct cpufreq_policy *policy =
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d3d0d9d02aa4a..f3acdcee7183f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -249,6 +249,7 @@ void disable_cpufreq(void);
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
 
 void refresh_frequency_limits(struct cpufreq_policy *policy);
+void cpufreq_notify_cpuinfo_update(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
 bool have_governor_per_policy(void);
@@ -536,6 +537,7 @@ static inline void cpufreq_resume(void) {}
 /* Policy Notifiers  */
 #define CPUFREQ_CREATE_POLICY		(0)
 #define CPUFREQ_REMOVE_POLICY		(1)
+#define CPUFREQ_UPDATE_CPUINFO		(2)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);

base-commit: 5854d2ce4b0b9ccb37b154319d8283bad889a694
-- 
2.56.0

