Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989869;
	b=vg0eBhzvVwsPkuyGNhU0vjeRqiSR6oZY04KcpySM/H5k81Ipcsapv3/ajA7cpsZjAy6T
	 dlsfWYSX68UdGDjNvgvHN3EzMt17M20wYzTRWscxtj7HAU6Wz+qTLIDIbeyKKp1p06+NA
	 vU6VhzywJT9HlrYA/BbvVQiNL4lK6lmzOD9Lf/rOXRGeRaBAZEjS3cVHYn2HKrX+dMIb/
	 8p0TN9vS5cAj80Ms5asUj/fgrY4tvvYbIZrhmyBPGUvMhRRfzEmgXsJYJ2uUdtyim9C+q
	 6JgR+FcuPHf946bZzTTFElT2mtTBkYv7zznt0IC55q6g/e0l2mm5A7+nJ38rynUQmzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989869;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=lINQSLp1Gq3CX+BO3I8pHckQ/LjZgO4rP/j0aJx7QU4=;
	b=Yvnyy9kQsDsNtArhUMZKsY5KF6YihaOVeSWkYC6b3aoyxfcTB8ix3dLqiW+l+kzuLNa3
	 NO1y9eRSnLdoXq3p/Xd+Ree7cp5Jy8nRCJApsfUW6+Wj1AYE4AkfoJGPdU9OmPb4GptUs
	 PkFb92saBngZe0+MormYV69/gILlFaU0ygRpujf/r1fO5Dv+UXKYuNOaYs5wyXxLK0Sc+
	 S4LxDEad3WXl4OP+gpajjeQ/4atMKvkOGF9SlPuCuVvSMKfrpdITKbv4k67dC9sH9cT6M
	 jDGmpb4XD3P+8Hq6aSL0vnP8x2QpHTAJn2yTCM4I/PQ+tX55x17Avld7WvO1zDN2+gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d9slEs28;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE5606A336
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 18:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8CE5606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d9slEs28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793989867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lINQSLp1Gq3CX+BO3I8pHckQ/LjZgO4rP/j0aJx7QU4=;
	b=d9slEs287HYZujMDJ0z6AmW4G6urOPEeNH3PHTIh6DEpMhwwwjMQefsFTJmRqyILX71KbQ
	SihupCAENPOk+82p6M3g3AEggx83lxzstaoTdRahnPPasFxyWK6OQxSkhfECJwK3vYP4Nc
	kqbe6ALqAa3GRqrZqU6q0T0lT/9So3E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-mjTvFoKZPCy_EKI3ipHfLA-1; Fri,
 06 Nov 2026 13:31:04 -0500
X-MC-Unique: mjTvFoKZPCy_EKI3ipHfLA-1
X-Mimecast-MFC-AGG-ID: mjTvFoKZPCy_EKI3ipHfLA_1793989862
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C97D1944D29;
	Fri,  6 Nov 2026 18:31:02 +0000 (UTC)
Received: from dechen-thinkpadp1gen8.rht.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EBD3195608B;
	Fri,  6 Nov 2026 18:31:01 +0000 (UTC)
From: Dennis Chen <dechen@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Chen <dechen@redhat.com>
Subject: [PATCH] powercap: intel_rapl: Expose package CPUs in associated_cpus
Date: Fri,  6 Nov 2026 13:30:46 -0500
Message-ID: <20261106183046.208283-1-dechen@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit 525e0064f3d8 ("powercap: intel_rapl: Expose all package CPUs in
PMU cpumask") expanded cpumask to include all CPUs in the package.
Since perf opens an event for every CPU in cpumask, the value returned
for power/energy-pkg/ is roughly scaled by the number of CPUs.

On a single-socket 72-core DMR machine the reported value is roughly
72x higher than when perf is restricted to reading from a single CPU:

$ perf stat -e power/energy-pkg/ -- sleep 1
 Performance counter stats for 'system wide':

          8,052.48 Joules power/energy-pkg/

       1.010483558 seconds time elapsed

$ perf stat -C 5 -e power/energy-pkg/ -- sleep 1

 Performance counter stats for 'CPU(s) 5':

            112.15 Joules power/energy-pkg/

       1.009685587 seconds time elapsed

Revert cpumask to only include the CPU with the lowest ID in the
package and instead expose CPUs which can read from the PMU in
associated_cpus, akin to uncore PMU drivers with per-package counters.

This retains flexibility for userspace tools while maintaining semantic
consistency for perf's use of cpumask.

Assisted-by: LLM
Fixes: 525e0064f3d8 ("powercap: intel_rapl: Expose all package CPUs in PMU cpumask")
Signed-off-by: Dennis Chen <dechen@redhat.com>
---
 drivers/powercap/intel_rapl_common.c | 43 ++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 70cab5f08bc6..4197f7146afc 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1139,7 +1139,8 @@ static struct rapl_pmu rapl_pmu;
 
 /* PMU helpers */
 
-static void set_pmu_cpumask(struct rapl_package *rp, cpumask_var_t mask)
+static void rapl_pmu_collect_cpus(struct rapl_package *rp, cpumask_var_t mask,
+				  bool all_online)
 {
 	int cpu;
 
@@ -1151,9 +1152,15 @@ static void set_pmu_cpumask(struct rapl_package *rp, cpumask_var_t mask)
 		return;
 
 	/* TPMI/MSR RAPL uses any CPU in the package for PMU */
-	for_each_online_cpu(cpu)
-		if (topology_physical_package_id(cpu) == rp->id)
-			cpumask_set_cpu(cpu, mask);
+	for_each_online_cpu(cpu) {
+		if (topology_physical_package_id(cpu) != rp->id)
+			continue;
+
+		cpumask_set_cpu(cpu, mask);
+		/* Stop at first CPU in package if not all CPUs are requested */
+		if (!all_online)
+			return;
+	}
 }
 
 static bool is_rp_pmu_cpu(struct rapl_package *rp, int cpu)
@@ -1430,8 +1437,7 @@ static struct attribute_group pmu_events_group = {
 	.attrs = attrs_empty,
 };
 
-static ssize_t cpumask_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+static ssize_t rapl_pmu_cpus_show(char *buf, bool all_online)
 {
 	struct rapl_package *rp;
 	cpumask_var_t cpu_mask;
@@ -1444,23 +1450,36 @@ static ssize_t cpumask_show(struct device *dev,
 
 	cpumask_clear(cpu_mask);
 
-	/* Choose a cpu for each RAPL Package */
-	list_for_each_entry(rp, &rapl_packages, plist) {
-		set_pmu_cpumask(rp, cpu_mask);
-	}
+	/* Choose a set of CPUs for each RAPL Package */
+	list_for_each_entry(rp, &rapl_packages, plist)
+		rapl_pmu_collect_cpus(rp, cpu_mask, all_online);
 	cpus_read_unlock();
 
 	ret = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_mask));
-
 	free_cpumask_var(cpu_mask);
-
 	return ret;
 }
 
+static ssize_t cpumask_show(struct device *dev __always_unused,
+			    struct device_attribute *attr __always_unused,
+			    char *buf)
+{
+	return rapl_pmu_cpus_show(buf, false);
+}
+
+static ssize_t associated_cpus_show(struct device *dev __always_unused,
+				    struct device_attribute *attr __always_unused,
+				    char *buf)
+{
+	return rapl_pmu_cpus_show(buf, true);
+}
+
 static DEVICE_ATTR_RO(cpumask);
+static DEVICE_ATTR_RO(associated_cpus);
 
 static struct attribute *pmu_cpumask_attrs[] = {
 	&dev_attr_cpumask.attr,
+	&dev_attr_associated_cpus.attr,
 	NULL
 };
 
-- 
2.56.0

