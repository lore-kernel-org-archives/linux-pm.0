Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018617;
	b=hiKb7OahVji568CnnpInhJAuTzr1AapDAToxJbvL0j7seC1v5l1ky75o8W4p4jE7M8rY
	 f7/SRHJqH6NZz4ev+bwzCcI8ghCQMgHKfyL2308GmtrYPwYw7KoRNzwuzqYbndBTMkJVA
	 xhl3ZM6y9mMJ02lI87wk1bM6NpC2c/7gtX5Ztn54b2YViR5itoEgbp8ne4RhK9SXM2+ip
	 Ot1bz37TwGybkG4PDkneJJ7Izj0a+NOrrhymgrDk/B0fdyk6QyOTgZ4LOK+ZpnovIsTeC
	 4ky4LxTX2DeUL7M4MKgM/bu7d2ykbZplIDq3ou0AWEapLKWp3wHV0aYHx3wcg/OZ2jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018617;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pOB78OBjoKUKg9xXXTUE6AnEpJ3d3Z6dp04LaBMreM8=;
	b=KZW6bdZqDLb17CpfGtdlXtbaxv8+mYnZv/UUtOyYimwswdfOngMCxQuNaBifmc1pmSrf
	 J08mmOdU27toOv3dscIkDam9hXBW2GjFAVMGV8iPmbEq8+0shz2dBHiOmtcOpabEf1ynm
	 ntkAHT8iQfpC4o/faTbqaS8mn6DLInRv8kk/Y4pITnzCPJUlmJkcud9gLdGi3+8bbnG2j
	 iH5Os9a0kCvSPwtAfnjCqFIL87N5ZpQZQeZ/IzNXxvMugjA0i5KLVbxyxrHo81oto/OuQ
	 jkKl0oQ+g2xVBAT4fh4vfUJZ6+Iw2L6cMPgQixfQASLvvPMI3cM6fT/HK7LAP6+J/nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XzdA8nap;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hpCaCzsN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E6606A33F
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 447E6606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XzdA8nap;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hpCaCzsN
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQOHN1928671
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pOB78OBjoKU
	Kg9xXXTUE6AnEpJ3d3Z6dp04LaBMreM8=; b=XzdA8nap5wPmr2gBgUn7zmPVnYj
	fYLMbHvYy+AzZr7swPl3HfFMHooKsDpx//mbEd1waQBEMOSKQ2dbBlWAfODE0RMu
	T4SnnOnRKeBEiZsD7rS3Mi59wt2Cn5wOm9b0yHXJQgTCow88zwEAzRyltQnBsh8R
	NYVmf29JmyObSXmloI/ckvRMDA1epG65jEx4xPLIQuLeXFlWHSbcb532VpT5Cylz
	whexmf62GQP4zG2DMcqx8Aik+rqC5i1hixtiFbkFrpgHkbfs7KTTQxt7CrA1JxAI
	Od7YQrHKjIFSKDsi7oFRIBet1cak4x6P/HqbHF3yO4foyFmbPw3Env7ZkgA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8byp6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:16:56 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-99e0a55e4b4so240304241.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 08:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795018615; x=1795623415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pOB78OBjoKUKg9xXXTUE6AnEpJ3d3Z6dp04LaBMreM8=;
        b=hpCaCzsN/N6CjZkPz+QdVlRNDqDr/6JLCoU8doHtmEe2Dk9cpcibIwLiu/s9oYa/YQ
         RzAKj4o8CyMT2ucr8x3JPjkrjTLC+MveN8/uiywLnPj+zA3hrf/oGL1IAAdB1snMyHmx
         cg5qNnRT6Cgb+qqbDj/VpuRdgl+PdR+wExcZs9f5dw6pyPh4aMML1p55kqPb6oNqdlIU
         9/4V/4ogkocEm5njRX9wvgvN9gut+RZuxQR7N3B0AXKDZ45mAFfLtIVmA3HHdW5yIu0H
         qEKzY48TZes5UaB1SNCnTL8ZXy5EoZjaYL55GrknBrkQToZ7tUGKa0182FzLoT6IgyR2
         gpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018615; x=1795623415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pOB78OBjoKUKg9xXXTUE6AnEpJ3d3Z6dp04LaBMreM8=;
        b=Fkv2Q/6nOqxiAjYjM7baF2QZt32UC4+9BCM6YY9U4hsAaJP7NBdU7RBCiMY5odqbka
         3GK1LZA/qhdzr5VZfCaUa0HR6c+Qxq47wzZtVKqSoE5JpTFMcIgUXDmUAoGFrYvySWfI
         oIQY1EcfB+dRmRP+Me6OmdIlNzvjWLxg9hIFMa3SRkGWBWvS+16PTFFfgK5+kbH6Fhe0
         99TjJXaRrzJxBt63chJiZmGnebSOzP93x0fpgwg+tdN3RLkbOaXN+qXgTuyBUjnRpEMu
         K/Au8VVCSfvxFfT/nj8FDAgGgCDMxHsfd3AnTHTMjvtiVMrl7PmnhebUgddj9xDrlbyF
         37Cw==
X-Gm-Message-State: APuU4Z+htKwJp9x4iHLR4G+hA1skxbE6orXxk9JggWPDO8qzZj5vXLXn
	cgD1ZzX1lz+XpTZgZe9Pys/bhB06UbuWhbJn5C7HZ05mz8ALkh2wqj+QeomKev+ir/8QdHOAZAr
	JFp+SUTWPhGOs9KQAOTCbVOlV8iLaG0bqJy5WBuJuxCP7vCcXw3EhQKb4cOJaJyb0vZ2wlm8F
X-Gm-Gg: AYBFou1un8Xg3dtv7pmND0zkpxU8V1fYGWxkxyh9eu2u2laDrBa7oDrX4789tOU+9le
	uxpiCx94RMVD2t22ucS2yuU9yxoilFSj6xqfyS2yDuuPoIxr3y1e7dr91bt5zMUZQxuJg2v+E9g
	FnXHvaWlWPkbhnB+je1mFpI6qSFK7R+xPV3XYfRTQ1JFm7R8BIb8UhIzh3PUDVf8+okiDKpWO41
	KjddgqlJWMdDlvmQHmhnTGrAaHRsGoZYfO8FjY6Z8lzTSJ6lYyDY39sedaoah7JDpd7xCtYIEaH
	0Wz5/vMUuTBVTq4ex/pe6zoPBBNAqfozZgl/fFWBAoglJJMWad9nvmQhfy13LWU/bNchQ1uX/jD
	SccomcDhrtji9OROQAa5si2uk6OqkhSolGg4yq9zk0W8Utj7xb+NDacvD65+xfc+W2sm2miMcMo
	Ss
X-Received: by 2002:a05:6122:62a6:b0:5ec:c162:d58c with SMTP id 71dfb90a1353d-5ee646c8d94mr1575527e0c.9.1795018615274;
        Wed, 18 Nov 2026 08:16:55 -0800 (PST)
X-Received: by 2002:a05:6122:62a6:b0:5ec:c162:d58c with SMTP id 71dfb90a1353d-5ee646c8d94mr1575483e0c.9.1795018614742;
        Wed, 18 Nov 2026 08:16:54 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d355:fe70:14a0:ac8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm217090495e9.8.2026.11.18.08.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:16:54 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, tglx@linutronix.de
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Bradley Morgan <brads@mainlining.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        Bradley Morgan <bradley.morgan@linux.dev>,
        Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH RESEND v2 1/2] smpboot: Allow restricting per-CPU threads to a CPU mask
Date: Wed, 18 Nov 2026 17:15:26 +0100
Message-ID: <7a1e55d24c39d70caa157e6e2c823d9be5db07e7.1794992905.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794992905.git.daniel.lezcano@oss.qualcomm.com>
References: <cover.1794992905.git.daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: b0wBtoy119Ygqyr434Bh5UW7iX8ZV93a
X-Authority-Analysis: v=2.4 cv=N9u8hG9B c=1 sm=1 tr=0 ts=6afdcf78 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=5Kbu-F-uTTPTLeMpapkA:9
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NCBTYWx0ZWRfX/rgtVqmISL79
 bmK1lS1CaNte2/SH56ZVjNbVmgxsbUYa/8pacdhm68KvdA6tLMVodAByyLFjnltoo7cDxGMsX6q
 puy51WSykAHcjggJW4NQdNBEZu3dOzV6WzgZe2oliHv4n+mEvfUxdUaOWQzN0H9y+vafUoMtpDD
 cDRb+o5Pjz0pHZWgSUUsEcu5nzLE6VGoRceXZX+ceiQn53hEmYrydyiT2JEDkSP/w2DvHwueOXX
 g4NNB7Q0aFgRve3hHOcLajjsZu5TA0ph+jbD422FywOPr7GtM+s3Iew5hG/LUjHWRV5OdrjBodT
 lyEEjr1Bio4+h3S7+S4yNI/tHuIvbch+a4J/JhrFjmHNrgT25omdTEXy8HBMZfbd+MYrbiSqh0v
 Jc685ZWwf3XwcZQdQWde9VEwxGKN+L9l84FBqhZKhzLnvoEIKw2YDwrRnulusH6LK105mAJ4rrx
 87V2UURHyWXU6WKQMJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NCBTYWx0ZWRfX9PshRtJd03GY
 zPuL18H9NvA3q1R/WRgxHn+vvgaGfhZH6aGNpMrl50FQlxDdw3bWs/2wqh4nPds59dLBEARzo/H
 TguTcDHmVLpWQE3qcZ/yqZ/VyyEN05A=
X-Proofpoint-GUID: b0wBtoy119Ygqyr434Bh5UW7iX8ZV93a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180064

smpboot_register_percpu_thread() creates a thread for every online CPU
and registers the descriptor for subsequent CPU hotplug operations.
There is currently no way to restrict these threads to a subset of
CPUs, even when the user only needs work performed on that subset.

For example, an idle injection device targets a specific CPU mask.
Creating threads outside that mask consumes resources unnecessarily.
Supporting multiple such devices also requires each descriptor to
manage only the threads associated with its own CPUs.

Add an optional CPU mask to struct smp_hotplug_thread and apply it
throughout the thread lifecycle. Registration creates threads only for
online CPUs in the mask. CPU bring-up creates threads for selected
CPUs that were offline at registration, while parking and unparking
are restricted to the same mask.

Apply the restriction to thread destruction as well, both during
unregistration and registration failure cleanup. This is necessary
when descriptors with disjoint masks share the same per-CPU task
storage: tearing down one descriptor must not stop or clear threads
owned by another descriptor.

Reject registrations that share task storage with an existing
descriptor and have overlapping CPU masks. Check for overlaps under
smpboot_threads_lock before creating any threads, warn once and return
-EBUSY on a conflict. Checking the masks also covers offline CPUs,
whose task pointers may not yet be populated. This prevents descriptors
from sharing a thread and interfering with each other's teardown.

Default a NULL mask to cpu_possible_mask at registration, preserving
the existing all-CPU behavior and allowing the lifecycle helpers to
use the mask unconditionally. Use scoped guards for the registration
locks so all error returns release them in the correct order.

The caller must keep the mask valid and unchanged until the descriptor
is unregistered. smpboot serializes the overlap check and descriptor
registration against other registration and unregistration operations.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>

---
 include/linux/smpboot.h |  6 ++++++
 kernel/smpboot.c        | 45 ++++++++++++++++++++++++++++++++---------
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
index 9d1bc65d226c..57b945d51b19 100644
--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct cpumask;
 /* Cookie handed to the thread_fn*/
 struct smpboot_thread_data;
 
@@ -27,6 +28,10 @@ struct smpboot_thread_data;
  *			unparked (cpu online)
  * @selfparking:	Thread is not parked by the park function.
  * @thread_comm:	The base name of the thread
+ * @cpumask:		Optional mask of CPUs on which to create threads. Must remain
+ *			valid and unchanged until the descriptor is unregistered.
+ *			Registration defaults NULL to cpu_possible_mask. Descriptors
+ *			sharing @store must have disjoint masks.
  */
 struct smp_hotplug_thread {
 	struct task_struct		* __percpu *store;
@@ -40,6 +45,7 @@ struct smp_hotplug_thread {
 	void				(*unpark)(unsigned int cpu);
 	bool				selfparking;
 	const char			*thread_comm;
+	const struct cpumask		*cpumask;
 };
 
 int smpboot_register_percpu_thread(struct smp_hotplug_thread *plug_thread);
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 4503b60ce9bd..f997fe85f088 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -168,6 +168,9 @@ __smpboot_create_thread(struct smp_hotplug_thread *ht, unsigned int cpu)
 	struct task_struct *tsk = *per_cpu_ptr(ht->store, cpu);
 	struct smpboot_thread_data *td;
 
+	if (!cpumask_test_cpu(cpu, ht->cpumask))
+		return 0;
+
 	if (tsk)
 		return 0;
 
@@ -225,6 +228,9 @@ static void smpboot_unpark_thread(struct smp_hotplug_thread *ht, unsigned int cp
 {
 	struct task_struct *tsk = *per_cpu_ptr(ht->store, cpu);
 
+	if (!cpumask_test_cpu(cpu, ht->cpumask))
+		return;
+
 	if (!ht->selfparking)
 		kthread_unpark(tsk);
 }
@@ -244,6 +250,9 @@ static void smpboot_park_thread(struct smp_hotplug_thread *ht, unsigned int cpu)
 {
 	struct task_struct *tsk = *per_cpu_ptr(ht->store, cpu);
 
+	if (!cpumask_test_cpu(cpu, ht->cpumask))
+		return;
+
 	if (tsk && !ht->selfparking)
 		kthread_park(tsk);
 }
@@ -267,6 +276,9 @@ static void smpboot_destroy_threads(struct smp_hotplug_thread *ht)
 	for_each_possible_cpu(cpu) {
 		struct task_struct *tsk = *per_cpu_ptr(ht->store, cpu);
 
+		if (!cpumask_test_cpu(cpu, ht->cpumask))
+			continue;
+
 		if (tsk) {
 			kthread_stop_put(tsk);
 			*per_cpu_ptr(ht->store, cpu) = NULL;
@@ -279,28 +291,41 @@ static void smpboot_destroy_threads(struct smp_hotplug_thread *ht)
  * 					    to hotplug
  * @plug_thread:	Hotplug thread descriptor
  *
- * Creates and starts the threads on all online cpus.
+ * Creates and starts the threads on online CPUs selected by the descriptor's
+ * cpumask, or all online CPUs if no mask is specified.
+ *
+ * Return: 0 on success, -EBUSY if a registered descriptor shares the same task
+ * storage and has an overlapping CPU mask, or a thread creation error.
  */
 int smpboot_register_percpu_thread(struct smp_hotplug_thread *plug_thread)
 {
+	struct smp_hotplug_thread *ht;
 	unsigned int cpu;
-	int ret = 0;
+	int ret;
+
+	if (!plug_thread->cpumask)
+		plug_thread->cpumask = cpu_possible_mask;
+
+	guard(cpus_read_lock)();
+	guard(mutex)(&smpboot_threads_lock);
+
+	list_for_each_entry(ht, &hotplug_threads, list) {
+		if (ht->store != plug_thread->store)
+			continue;
+		if (WARN_ON_ONCE(cpumask_intersects(ht->cpumask, plug_thread->cpumask)))
+			return -EBUSY;
+	}
 
-	cpus_read_lock();
-	mutex_lock(&smpboot_threads_lock);
 	for_each_online_cpu(cpu) {
 		ret = __smpboot_create_thread(plug_thread, cpu);
 		if (ret) {
 			smpboot_destroy_threads(plug_thread);
-			goto out;
+			return ret;
 		}
 		smpboot_unpark_thread(plug_thread, cpu);
 	}
 	list_add(&plug_thread->list, &hotplug_threads);
-out:
-	mutex_unlock(&smpboot_threads_lock);
-	cpus_read_unlock();
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(smpboot_register_percpu_thread);
 
@@ -308,7 +333,7 @@ EXPORT_SYMBOL_GPL(smpboot_register_percpu_thread);
  * smpboot_unregister_percpu_thread - Unregister a per_cpu thread related to hotplug
  * @plug_thread:	Hotplug thread descriptor
  *
- * Stops all threads on all possible cpus.
+ * Stops all threads associated with the descriptor, including offline CPUs.
  */
 void smpboot_unregister_percpu_thread(struct smp_hotplug_thread *plug_thread)
 {
-- 
2.43.0

