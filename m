Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559503;
	b=YchAbP3iWyELlTt4/7Q1LWzVIg6MFrr4S6RtVd5tbVYVxh8Qsm2hJPDj8e+sYSNR+68Y
	 nm8wiEZ1fdNQq4bcE/2Ime8S/664yKnS9N/chfBor0TXwNSX9fXRQkb5NyaKw3E8o3hPj
	 Mad+VdmIT2UF+mH9s+6mXFx8vEXgsV4/Fou43N+Dgb7pLxyGfwOgmdE/7kqrGoEzqqSZ7
	 FEGtSxEp4ZCiap+rXkntpvSgeai+q+7YPwr9rjdJkW00owUeJDfZso62xsT/3DDLbRFt2
	 VzI9AY85qfOY/QdzrnQkXVMiqM6Bddr5gteg2ZNmw7yzqGWEpkdohbo2DBTFWMfJq0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559503;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=cRlY9PvrLu6yok7ISbu9LgYDjesp7+jnlD6ofkXCI4M=;
	b=UYk9Kiq4+XTaWmP8tniw6R6hi6Co0p150JmOhA60EcmHRVPE83qC1Qy/+BCj7HEU9z34
	 wF0RynHkHqrN2JYvErJgVtJPxDjyOcFb5ql6kavKHe6gYN7swYetjZ2QSSlfkpzSDBzBe
	 hRdSOHKRnIAvE5R7kEPD6892wyyHy6WelneBcUjcBnFoJ6FCp4sal/0eNHdlExTBtK/d1
	 ggeegtwRP2rSRH2EnncOESAue+MFl/aAjEcujHGWFb2dnC1sV0XpmkAxC78jSIThk3NCx
	 W1pncKdKhSlLKi7OtX7CdcmeuPuhHn6zPKiBVIH1v/irsR4blPrq1i/wTmzQ/KLQ1fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hsal.es;
	spf=pass smtp.mailfrom=hsal.es;
	dkim=pass header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=A7iKlyER;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017160A261F;
	Sun,  1 Nov 2026 18:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9017160A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hsal.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=A7iKlyER
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jHkcl2nR2zKn2J;
	Sun, 01 Nov 2026 19:58:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
	t=1793559495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRlY9PvrLu6yok7ISbu9LgYDjesp7+jnlD6ofkXCI4M=;
	b=A7iKlyERAei+nc2Ikga3bSALxpdcNSAWy+OLnI12AVkXwa+Ss5crJCkUvcHLMCbCvW9sZQ
	7Vw5UHMbzJ12gXBlm1X5KxSKWfsxggLi2z880caltmo6JxuTmO9IUuoB5EsMsbJYrEeI0g
	h+leV4P+G945JIYjjTuUVujWD4AanjzWoEnVhh4a9GAoJnp78EyUyxJmFdv2zpbvqF1riq
	SAWu18QW9zRuHfct8RxvqcfZea6hTtAy+iPf0A7Gish6L/R519YKNSQppcjpWrY179yqYh
	W/sjrOqnd0NswxY97mkChrgBHgbntDQrlrtzYl4/VXFVs+/x16gxeyPdomuQAg==
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
Subject: [RFC PATCH 4/4] ACPI: processor: thermal: Recompute the frequency cap when boost changes
Date: Sun,  1 Nov 2026 18:58:07 +0000
Message-ID: <20261101185807.112449-5-hugo@hsal.es>
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
X-Rspamd-Queue-Id: 4jHkcl2nR2zKn2J

thermal_req is a fixed fraction of policy->cpuinfo.max_freq, computed
only when the cooling state is written, so it keeps the boost state of
that moment. That includes step 0, which caps at cpuinfo.max_freq
itself. The ACPI thermal zone writes step 0 on every resume, so if boost
was off at suspend, turning it on after resume leaves the CPUs at their
base clock

Recompute the cap on CPUFREQ_UPDATE_CPUINFO, as the CPUFREQ_ADJUST
notifier did before d15ce412737a, with the step each CPU's request was
last set to

Fixes: d15ce412737a ("ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier")
Link: https://lore.kernel.org/all/20261028-acpi-thermal-stale-limit-v1-1-4b0ab3230f01@ashtonantila.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221795
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
This is an alternative to Ashton's one-line fix linked above, which
stops step 0 from setting a cap. Here step 0 still sets one, at
cpuinfo.max_freq, and it is recomputed with the other steps when boost
changes

The step is kept per CPU because reduction_step()'s per-package slot
moves when the first CPU of the package goes offline

A new mutex serializes the recompute with cpufreq_set_cur_state() and
with adding and removing thermal_req. Boost can be toggled while a
policy is being removed, and a cooling state write that read the old
cpuinfo.max_freq must not overwrite the recomputed cap
---
 drivers/acpi/processor_driver.c  |  2 ++
 drivers/acpi/processor_thermal.c | 48 +++++++++++++++++++++++++++++---
 include/acpi/processor.h         |  4 +++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index bdd1529d79f03..c3929425a88b6 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -221,6 +221,8 @@ static int acpi_processor_notifier(struct notifier_block *nb,
 	} else if (event == CPUFREQ_REMOVE_POLICY) {
 		acpi_processor_ppc_exit(policy);
 		acpi_thermal_cpufreq_exit(policy);
+	} else if (event == CPUFREQ_UPDATE_CPUINFO) {
+		acpi_thermal_cpufreq_update(policy);
 	}
 
 	return 0;
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 25c4b0ad64e36..8b1a3cb004571 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/acpi.h>
+#include <linux/mutex.h>
 #include <acpi/processor.h>
 #include <linux/uaccess.h>
 
@@ -40,6 +41,16 @@ static int cpufreq_thermal_max_step __read_mostly = 3;
 static int cpufreq_thermal_reduction_pctg __read_mostly = 20;
 
 static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_step);
+/* The step each CPU's thermal_req was last set to */
+static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_req_step);
+
+/*
+ * Serializes adding, updating and removing thermal_req, and the step saved
+ * with it, so recomputing the cap after a boost change can't race a cooling
+ * state write. It nests inside policy->rwsem and the cooling device lock,
+ * so take neither while holding it
+ */
+static DEFINE_MUTEX(cpufreq_thermal_lock);
 
 #define reduction_step(cpu) \
 	per_cpu(cpufreq_thermal_reduction_step, phys_package_first_cpu(cpu))
@@ -95,6 +106,8 @@ static void cpufreq_update_thermal_req(struct cpufreq_policy *policy,
 	unsigned long max_freq;
 	int ret;
 
+	lockdep_assert_held(&cpufreq_thermal_lock);
+
 	max_freq = (policy->cpuinfo.max_freq *
 		(100 - step * cpufreq_thermal_reduction_pctg)) / 100;
 
@@ -102,7 +115,10 @@ static void cpufreq_update_thermal_req(struct cpufreq_policy *policy,
 	if (ret < 0) {
 		pr_warn("Failed to update thermal freq constraint: CPU%d (%d)\n",
 			pr->id, ret);
+		return;
 	}
+
+	per_cpu(cpufreq_thermal_req_step, pr->id) = step;
 }
 
 static bool cpufreq_update_thermal_limit(unsigned int cpu, struct acpi_processor *pr)
@@ -124,6 +140,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 	if (!cpu_has_cpufreq(cpu))
 		return 0;
 
+	guard(mutex)(&cpufreq_thermal_lock);
+
 	reduction_step(cpu) = state;
 
 	/*
@@ -177,9 +195,13 @@ void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 		if (!pr)
 			continue;
 
-		ret = freq_qos_add_request(&policy->constraints,
-					   &pr->thermal_req,
-					   FREQ_QOS_MAX, INT_MAX);
+		scoped_guard(mutex, &cpufreq_thermal_lock) {
+			ret = freq_qos_add_request(&policy->constraints,
+						   &pr->thermal_req,
+						   FREQ_QOS_MAX, INT_MAX);
+			if (ret >= 0)
+				per_cpu(cpufreq_thermal_req_step, cpu) = 0;
+		}
 		if (ret < 0) {
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
@@ -190,6 +212,23 @@ void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 	}
 }
 
+void acpi_thermal_cpufreq_update(struct cpufreq_policy *policy)
+{
+	unsigned int cpu;
+
+	guard(mutex)(&cpufreq_thermal_lock);
+
+	for_each_cpu(cpu, policy->related_cpus) {
+		struct acpi_processor *pr = per_cpu(processors, cpu);
+
+		if (!pr || !freq_qos_request_active(&pr->thermal_req))
+			continue;
+
+		cpufreq_update_thermal_req(policy, pr,
+					   per_cpu(cpufreq_thermal_req_step, cpu));
+	}
+}
+
 void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	unsigned int cpu;
@@ -200,7 +239,8 @@ void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 		if (!pr)
 			continue;
 
-		freq_qos_remove_request(&pr->thermal_req);
+		scoped_guard(mutex, &cpufreq_thermal_lock)
+			freq_qos_remove_request(&pr->thermal_req);
 
 		thermal_cooling_device_update(pr->cdev);
 	}
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index b5447af4d40b4..ccd5ac6acb57e 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -432,12 +432,16 @@ void acpi_processor_thermal_exit(struct acpi_processor *pr);
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
 #ifdef CONFIG_CPU_FREQ
 void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
+void acpi_thermal_cpufreq_update(struct cpufreq_policy *policy);
 void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy);
 #else
 static inline void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 {
 	return;
 }
+
+static inline void acpi_thermal_cpufreq_update(struct cpufreq_policy *policy) { }
+
 static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	return;
-- 
2.56.0

