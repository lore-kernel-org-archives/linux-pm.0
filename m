Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D83C3429
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478009; cv=none; b=IrSUHslWao2kHVJQdThNAQC4pN08QXAFdR+RQbsAX9Fc3JUhaSSN3wYxUhL0YPKvDQSTxtARyOkx1L6dAxaLOHA0FWRS0Kb2udWML3KwUfESvJFzsSZHO+gtNVFSTReGoPQGaNDEdVnq7qGGdZkGAtd80gsJgQYI/boUpVv+Ssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478009; c=relaxed/simple;
	bh=aJV9Xrr95EtSKmJNthDsm9/m9KIx/zbZcbP1GQTxqko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpJe0+jsbHBxq2ONgpX1o1UrG5dHW9zf+aQtTx3SB2AjctQwafQ1GiMANjGk1b7vEpppbfQrHzVDNUlRoSyrTY+lMnwiCmSJqnIWSweZJ80d/hBufgZoEN6u8/gsv+lLc1UsZFoNclXO0P+cReKNkj1Av3rHFr62EIsuP4Iy6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlcXEtYy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlcXEtYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789478006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5seYoKzdZGkO2AJnM6Hqn/UPowkFqA5z8qkgD+F5jE=;
	b=JlcXEtYybm1jmDO96DF2oCtnJRP+6lGHSBczEyoBpgAEXr+rsh6b1rPru7uFqspkV2ErGy
	dZ18qXWRO4jEbQmiJQl6yRWADDuGCQWg490d1gXFs4XORUFH/qR8XvnISHI2ikZOl7MYWC
	LMubKsQV3P+3PPkWG3HpArluM+Z1jqk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-cJte0mtOM9OZLIiE1BdU8g-1; Tue,
 15 Sep 2026 09:13:25 -0400
X-MC-Unique: cJte0mtOM9OZLIiE1BdU8g-1
X-Mimecast-MFC-AGG-ID: cJte0mtOM9OZLIiE1BdU8g_1789478004
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F49C195D003;
	Tue, 15 Sep 2026 13:13:24 +0000 (UTC)
Received: from aharivel-thinkpadp1gen3.rmtfr.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E9481956045;
	Tue, 15 Sep 2026 13:13:22 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org,
	Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH 1/1] cpuidle: add per-CPU latency_limit_ns sysfs attribute
Date: Tue, 15 Sep 2026 15:13:07 +0200
Message-ID: <20260915131310.1053834-2-aharivel@redhat.com>
In-Reply-To: <20260915131310.1053834-1-aharivel@redhat.com>
References: <20260915131310.1053834-1-aharivel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a per-CPU sysfs attribute at:
  /sys/devices/system/cpu/cpuN/cpuidle/latency_limit_ns

This allows privileged userspace to set a governor-respected upper
bound on the exit latency for idle state selection on a given CPU.
When set (non-zero), cpuidle_governor_latency_req() returns the
minimum of the existing PM QoS constraints and latency_limit_ns,
so all governors (menu, TEO, haltpoll) automatically respect it
without per-governor modifications.

Use case: cloud operators running mixed workloads can cap idle
depth on CPUs pinned to latency-sensitive VMs while allowing other
CPUs to enter deep C-states for energy savings. The interface is
latency-based (nanoseconds) rather than C-state-index-based, making
it portable across Intel/AMD/ARM without uarch-specific tuning.

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
---
 drivers/cpuidle/governor.c | 10 +++++++++-
 drivers/cpuidle/sysfs.c    | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h    |  1 +
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 5d0e7f78c6c5..4c6f77ce2028 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -112,6 +112,8 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
 	int device_req = dev_pm_qos_raw_resume_latency(device);
 	int global_req = cpu_latency_qos_limit();
 	int global_wake_req = cpu_wakeup_latency_qos_limit();
+	struct cpuidle_device *dev;
+	s64 result;
 
 	if (global_req > global_wake_req)
 		global_req = global_wake_req;
@@ -119,5 +121,11 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
 	if (device_req > global_req)
 		device_req = global_req;
 
-	return (s64)device_req * NSEC_PER_USEC;
+	result = (s64)device_req * NSEC_PER_USEC;
+
+	dev = per_cpu(cpuidle_devices, cpu);
+	if (dev && dev->latency_limit_ns && dev->latency_limit_ns < result)
+		result = dev->latency_limit_ns;
+
+	return result;
 }
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index b81d22479234..d060a4b7facc 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -207,8 +207,44 @@ static void cpuidle_sysfs_release(struct kobject *kobj)
 	complete(&kdev->kobj_unregister);
 }
 
+static ssize_t show_latency_limit_ns(struct cpuidle_device *dev, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", dev->latency_limit_ns);
+}
+
+static ssize_t store_latency_limit_ns(struct cpuidle_device *dev,
+				       const char *buf, size_t count)
+{
+	u64 value;
+	int err;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	err = kstrtou64(buf, 0, &value);
+	if (err)
+		return err;
+
+	dev->latency_limit_ns = value;
+
+	return count;
+}
+
+static struct cpuidle_attr attr_latency_limit_ns = {
+	.attr = { .name = "latency_limit_ns", .mode = 0644 },
+	.show = show_latency_limit_ns,
+	.store = store_latency_limit_ns,
+};
+
+static struct attribute *cpuidle_device_default_attrs[] = {
+	&attr_latency_limit_ns.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(cpuidle_device_default);
+
 static const struct kobj_type ktype_cpuidle = {
 	.sysfs_ops = &cpuidle_sysfs_ops,
+	.default_groups = cpuidle_device_default_groups,
 	.release = cpuidle_sysfs_release,
 };
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a2485348def3..f70d6288e13d 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -101,6 +101,7 @@ struct cpuidle_device {
 	u64			last_residency_ns;
 	u64			poll_limit_ns;
 	u64			forced_idle_latency_limit_ns;
+	u64			latency_limit_ns;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 	struct cpuidle_driver_kobj *kobj_driver;
-- 
2.55.0

