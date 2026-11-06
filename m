Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997088;
	b=bPyNsKuGFyRxecQLem3e/t5Ze5HPN4Wx0V7Vqa9XyE4rAxCUQ53d+GjIFOkX6eeJRSkd
	 URCD1m/l6liACNmJb/D6eehKzRFSIjHzvugflQUrp1wQGljpaWZkvq3PTw5ysi3UgL1el
	 9Oq2X9YvZJzpXSJtDzdp8m/RzjKbY5qJIAyn5gRu/ALwKjGGW6XOL4/C3vFYvPZPzl8hc
	 e5PJEoJSB9y2yvEws4GPIwYlS2esvx1Q38eP0aFj0UXmGBPGfFHfM+RGPRJVI+iSEajSb
	 uy1tnzVOpiofvc7EOz7u59Q7iipfTOwCCiXjus8J5J6LQEkpBcsQYeVFnu1J7xG6odA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997088;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=jmq8ZDo0DD/pacTstuAlrQ+VHSWanXJGgK0/pDlWtis=;
	b=1TN6qNHW+t2oecfd4o5g8vm+JeOwMCX1A5XQ4EKHUOUtxUZhFibU/nPnjWfIOivt34eH
	 G203sm5DBnuDeZM7IaZ4O3ttSMzgQc+CCWblgDjFlBJDeYfFO9S6NgjmRPLy81I3NjLgo
	 Z2Y0s14EG2FMPzJ4OX9zBeeufnAbNCx7xyHLG+j+WOPckWNNBSJrdjHtbfxqwL+JFS9tj
	 WOwwsoIOxmR5rZjS2R2H/aEfyTqFxE3pGGpmilzxSDoRYF8GQtjWWOTnWV/OHMfG+FvHs
	 Jz6TsG0SHtHuvwCgugqlrgiycAJrpUNSMD4CATOQ2+xNF3/r1t2qONruSEivK8jaPPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZUO0SiAC;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39335606A334
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 20:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39335606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZUO0SiAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793997087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jmq8ZDo0DD/pacTstuAlrQ+VHSWanXJGgK0/pDlWtis=;
	b=ZUO0SiAC2MAeSgRQ7y2EnmXErOTQ9OiXxUZPbcLMqvtWBLYac0WDyk+cRbrli58851OdRI
	TMYp9SFKQ8JnOcU1BsC20FGHNTtkDJSJXZ6/G+O0IQD4Tv+Ppd2aE/PmPNja8fBReGb/sv
	WKCNJz1zQFRcrrdhZHE+f0XQ/u2XpJE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-SjsK3oa5MUeNrr_mnnSGoA-1; Fri,
 06 Nov 2026 15:31:23 -0500
X-MC-Unique: SjsK3oa5MUeNrr_mnnSGoA-1
X-Mimecast-MFC-AGG-ID: SjsK3oa5MUeNrr_mnnSGoA_1793997082
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9748A1955EB1;
	Fri,  6 Nov 2026 20:31:22 +0000 (UTC)
Received: from dechen-thinkpadp1gen8.rht.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 907D51848D42;
	Fri,  6 Nov 2026 20:31:21 +0000 (UTC)
From: Dennis Chen <dechen@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Chen <dechen@redhat.com>
Subject: [PATCH] Revert "powercap: intel_rapl: Expose all package CPUs in PMU cpumask"
Date: Fri,  6 Nov 2026 15:31:15 -0500
Message-ID: <20261106203115.237269-1-dechen@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

Reverting this commit restores the expected behavior for perf.

Fixes: 525e0064f3d8 ("powercap: intel_rapl: Expose all package CPUs in PMU cpumask")
Cc: stable@vger.kernel.org
Signed-off-by: Dennis Chen <dechen@redhat.com>
---
Changes in v2:
- Simply revert 525e0064f3d8 and don't add associated_cpus sysfs attr

 drivers/powercap/intel_rapl_common.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 70cab5f08bc6..f58649ff4f53 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1139,21 +1139,23 @@ static struct rapl_pmu rapl_pmu;
 
 /* PMU helpers */
 
-static void set_pmu_cpumask(struct rapl_package *rp, cpumask_var_t mask)
+static int get_pmu_cpu(struct rapl_package *rp)
 {
 	int cpu;
 
 	if (!rp->has_pmu)
-		return;
+		return nr_cpu_ids;
 
 	/* Only TPMI & MSR RAPL are supported for now */
 	if (rp->priv->type != RAPL_IF_TPMI && rp->priv->type != RAPL_IF_MSR)
-		return;
+		return nr_cpu_ids;
 
 	/* TPMI/MSR RAPL uses any CPU in the package for PMU */
 	for_each_online_cpu(cpu)
 		if (topology_physical_package_id(cpu) == rp->id)
-			cpumask_set_cpu(cpu, mask);
+			return cpu;
+
+	return nr_cpu_ids;
 }
 
 static bool is_rp_pmu_cpu(struct rapl_package *rp, int cpu)
@@ -1435,6 +1437,7 @@ static ssize_t cpumask_show(struct device *dev,
 {
 	struct rapl_package *rp;
 	cpumask_var_t cpu_mask;
+	int cpu;
 	int ret;
 
 	if (!alloc_cpumask_var(&cpu_mask, GFP_KERNEL))
@@ -1446,7 +1449,9 @@ static ssize_t cpumask_show(struct device *dev,
 
 	/* Choose a cpu for each RAPL Package */
 	list_for_each_entry(rp, &rapl_packages, plist) {
-		set_pmu_cpumask(rp, cpu_mask);
+		cpu = get_pmu_cpu(rp);
+		if (cpu < nr_cpu_ids)
+			cpumask_set_cpu(cpu, cpu_mask);
 	}
 	cpus_read_unlock();
 
-- 
2.56.0

