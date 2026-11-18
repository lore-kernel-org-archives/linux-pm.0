Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998057;
	b=MBJgPg1oVa2mlR9hpcRL11+ThsFLgQWNt1lWjErr7lrtIVczh3rjJwyLmgb1L5pU1+kj
	 rcE+qNe8GPaypYKWqustcN7eqT4wtxmVPXVHXIHWiI8wuR5oGXw4kMNLJBeXoRWsPxDIB
	 jRrJ7h6Ax5guvObp1TbFqkUQgsXtfaNaATNJXCQiDX6upewReuyoESxxMDf8g6z+IMQCI
	 bP9rJjrBaGgAu+yf//hPnW6NBMg5qeervLqMH4eg25/q0gk4b02gab3caKXMVUMlwuGxs
	 zEZd457SmoQBLUSjSrHoeszyzB6dk2DUCJPZlWE1ew8Q9y0cCKdJldy23x6Jz68opdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998057;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aGe5/35woBldXiPfqQ49uVeqf5gd1K2N9K/JlpgH0bM=;
	b=BqV4z85mVoiWZidozM6NXfyDNfv/kDkNEkoeJ6PWvsAwTnpqLHXMnAmPBN7O+L8N1FeA
	 dPNmdpM7mnRNxPZ/t7KrBOhnvILjOQI19/Hkrj5KrToBHQhsS/tSrX4zcx7JevUFRUA4e
	 Qwr8vBb9VUbh6i6fwuIoPGeNuH2q1vdUPddp03KHMbUWsEXOsq3VBD6x++86BpVtC5xtg
	 MUH2s5IQhjJPUL9IdIJtajRepr52svMI73XxMwxa0YkjYL/hUC1CAMHFyKx+8Bz6aKlHe
	 nESEsC+jPiD19k0IxooXXB2K9m+Y5F2A02hLL9NMvGZ5ypTiwyjwTMB9TvYrxVIvc5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d2PcsH4x;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KPrV+OL6;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A7606A331
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 10:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E60A7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d2PcsH4x;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KPrV+OL6
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9k34i3353936
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 10:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aGe5/35woBl
	dXiPfqQ49uVeqf5gd1K2N9K/JlpgH0bM=; b=d2PcsH4x0fz27gATpvfFFjXUxTP
	Iqx+SHqvWPtcqOe4Nxybmu0h89MAVxrgdfDrOs1maertntw//gd1ZBJMh4Ji0HR0
	xUDL6FfeQ+rBgBcpwwSD5em/fHxN5aTuuPH6I+v9FtJULznJpih9vTAmvhWa6q/X
	S1M3E22AYYZs+GAVKWGxSo6TOCIz8+YX3i72Q61Jlrlyk1GChiS+J2cS2HealNJ3
	Theko5Uolj2m7PSzSXLhJEbG2yLe5Ll3CZTt7MG7zMNggyXz3Y9s/yiNtd3sBvbB
	NaGx5AfukLxxkGH+RoCrvQNA5Bxuta00iVhUSBHXWaPo0OrmQB3Z5gzPJJg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvatkq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 10:34:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-94960131b4eso161332285a.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 02:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794998055; x=1795602855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGe5/35woBldXiPfqQ49uVeqf5gd1K2N9K/JlpgH0bM=;
        b=KPrV+OL6mY9KdMLC0dNBwbCZNL9cCSbHbMqsgkZYteU4aBGoXFFLo6JMwgUODDwTPf
         XfnZ5M/8RVaCKlIWErNCsZHDcP81klEH26Hrkh+qbhyxSVeYlx1HYe7Xlzown1jmgdUx
         pkYGsV3E1Wq43GjqoVH5mwg1QMON041Vwcjh42Gt/H2XezPNVCQLIk685z57E/OxoemQ
         Mn8zotF4yzPP2PhyvT47H2gAa0srI7u3Tjs33SQBbDUQYwYYN2DZGJb7cIihk8OwuQ+i
         SdJwfUVDO7YnKMNJPbdQwqqTRT4qoxL2IczZgYmvHjAlJqWX0aumimLu/Br5zs5tDpKR
         7lTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794998055; x=1795602855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aGe5/35woBldXiPfqQ49uVeqf5gd1K2N9K/JlpgH0bM=;
        b=L+uIO/ZtvBUxSsFTYPQUL6KGpZV18L9wNA099r0p4kkce9sifuDiQKaFlXk5kN0JB+
         2+wAIiaqtK8e8thTQyDcFPQIkgkLqZJwTt3fQ9EFYr9ISKuO8GwfwbDk3yyYqZfXg3On
         O12bCg1uh6BnIlU5qyWjvU+qHObuZ0x1AfitgbTr9mTpn85hc54vTRL9kW+5yyzxJtzr
         U8BoDWDXFN4F+HdLe7UHbBKunhH4yQIAEPrr4anuO95EMygIch3enTchgSNmoMnAutDZ
         DawRIuzSOWHSqEKvdiZip8/vZ5swaFPcIX5+8t7t8aFY0ncednOm425xrSx9mZ2B52MP
         TfpA==
X-Forwarded-Encrypted: i=1; AL+hErGntz6jucahjoU6teolLCtD44USK0HkZuOGXoOl6y0nUBjb62affKdPwcfBgMAmV3KqyFWw29XVFQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8EJ3/5HjRDupKj7UkBC8jExnCwxAL3Gl2rGJBHZqlJUPWuMQks
	8ysWhZjSIF4KKhIH8iyH2P4VfT5tbs+Dlt5M6ExFVp7t/8baXo8STFfgdCvvB2JBNwas3JXJkw0
	eWBdGH95brQlucINBKjUXLBvfWt1ZQBpESmQznb6GE+oIjYadOLbBWmKiXpdcBw==
X-Gm-Gg: AYBFou37g4rNR+TiOEj3SnZL2yQef3JZcMChxj7rWTlqmxCQJds6RhfipYrHG36PZyX
	ZYMUV8CWrkTZBc4/7fSGW5cbyLzyCuT6KCIlf8z+FfSXh7i8N/gZbDSDldQSWnldyVHdz0PymxW
	rew1KXBykALFnpcbykF/JtvstI6JtcVWQtZ6c1VF4l6dmevjOZWpFFpYaLS1S9AFlAbfgzNue7L
	E95VevXKTTQSYss1Ngmr87PFp0rh/RsfACPm8IQ5rv9SrLHI0sGYeRMbP/hezww6BBjUNVyCt+3
	0x+VnYuhrJi7bBIxnsLcKBBPqLSoVG5W+esHbMzltUfqccsVGRUZpY/4KvskuOMj8o9uziB92sT
	I1XXJs8Ahzi4oj8KtOQR5bzHt38tvrsznCjS1KuPHhTPbeEHzUo6vhfzNplMXf+gyfIcKH7HM2h
	/K
X-Received: by 2002:a05:620a:3710:b0:947:8344:17a7 with SMTP id af79cd13be357-949995f8716mr384303685a.11.1794998054895;
        Wed, 18 Nov 2026 02:34:14 -0800 (PST)
X-Received: by 2002:a05:620a:3710:b0:947:8344:17a7 with SMTP id af79cd13be357-949995f8716mr384298685a.11.1794998054258;
        Wed, 18 Nov 2026 02:34:14 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d355:fe70:14a0:ac8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a650d2ecd0sm4519631f8f.8.2026.11.18.02.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:34:13 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, tglx@linutronix.de
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Bradley Morgan <brads@mainlining.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] powercap: idle_inject: Create per-CPU threads on registration
Date: Wed, 18 Nov 2026 11:33:49 +0100
Message-ID: <0fd0b28b29f6d9ad38bc91f3582bfee511fbf4f8.1794992905.git.daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=SMzXx+vH c=1 sm=1 tr=0 ts=6afd7f28 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=OuZLqq7tAAAA:8 a=z2xlO20o2AOZ5rEB0BcA:9 a=PEH46H7Ffwr30OY-TuGO:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: toKc96Px7zUZJ7Edfk7OUSH_gyRojN1E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0MSBTYWx0ZWRfX1UzR1g+/TuCO
 qGCeAEIPx5jX99JbinMnt4d77wOvmimDv9zMrVF9RWHCrDxUc/qAKy5YacqL5JqW3z42JYfhxen
 UJsGdFDNjpgXU0Ds3I4uCfV+GAdLwsvEovPcAUQq3/mRgh9cjnKTbC/AEEG6s7+gMqOdNGxZqkL
 9esW0GRzbPoJqaOWyTRoxa4IVdCLvjOfq8JUOrp4Mv19vDIHhS/HrzH5kMyAnpeo2XyLn1oWLn3
 RsZdkX0hOuYO+0dLtuTwbW5oVWeZBVBz2CxY0mx9JM33X7jWd6e0DXZaZD6BdeNThHIbFu5VTej
 teolEjB741Ic8tCkLtsCKjLg6hlGMm8S2y+/qItd4641A4TNG+wdsCihH3cSKjvfvqkwzwk4qjn
 aQzLiGbYIjDWlBTM4FHeIwJpWj7QbzOs7nP7RS4dphJBQJHtAmmfpbWcoQWELAj6ubU0GzPtJ+V
 mo571Om9pXS1JQLalVg==
X-Proofpoint-ORIG-GUID: toKc96Px7zUZJ7Edfk7OUSH_gyRojN1E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0MSBTYWx0ZWRfX3GTNqnY2HuQp
 F3QqquAVgqAe56g2YBODVQbTg0Q8CVfR1rcfsDhSgl4a4JJusnh3RMg1hfXtEfq18mGFLviE4ys
 SPGu8gX/UWk8OHkAyQr8Qcv+o9c8P5c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180041

Create idle injection threads when a device registers instead of
creating them unconditionally during early initialization. Destroy the
threads when the device unregisters.

Use a per-device smpboot descriptor with the device's CPU mask so thread
creation and CPU hotplug handling are limited to the CPUs registered by
that device. Allow stopping devices whose offline CPUs have not yet had
a thread created, and update the registration documentation to describe
the thread lifecycle and possible failures.

Serialize CPU ownership checks and claims with a framework-wide mutex.
Without serialization, registrations with overlapping masks can both
observe an unclaimed CPU and overwrite each other's device pointer.
Their smpboot descriptors can then share the same per-CPU task, allowing
one device's teardown to destroy a thread belonging to another device.
Registration rollback can also clear another caller's ownership.

Hold the mutex through smpboot registration and failure rollback, and
during thread unregistration through ownership release. This prevents a
CPU from being claimed again until its previous thread is destroyed.

Stop idle injection before acquiring the mutex, keeping timer callback
cancellation and stop-side hotplug exclusion outside the ownership
critical section. Neither the idle injection threads nor their smpboot
hotplug paths acquire this mutex. The existing caller-side lifecycle
synchronization requirement remains in effect.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
---
 drivers/powercap/idle_inject.c | 69 +++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index a25eb2018acd..24646b8be9ac 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -10,11 +10,9 @@
  * It relies on the smpboot kthreads feature providing common code for CPU
  * hotplug and thread [un]parking.
  *
- * All of the kthreads used for idle injection are created at init time.
- *
- * Next, the users of the idle injection framework provide a cpumask via
- * its register function. The kthreads will be synchronized with respect to
- * this cpumask.
+ * Users of the idle injection framework provide a cpumask via its register
+ * function. The kthreads are created on demand for CPUs in this mask and
+ * will be synchronized with respect to it.
  *
  * The idle + run duration is specified via separate helpers and that allows
  * idle injection to be started.
@@ -40,6 +38,7 @@
 #include <linux/cpu.h>
 #include <linux/hrtimer.h>
 #include <linux/kthread.h>
+#include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/smpboot.h>
@@ -60,6 +59,7 @@ struct idle_inject_thread {
 /**
  * struct idle_inject_device - idle injection data
  * @timer: idle injection period timer
+ * @threads: per-device CPU hotplug thread descriptor
  * @idle_duration_us: duration of CPU idle time to inject
  * @run_duration_us: duration of CPU run time to allow
  * @latency_us: max allowed latency
@@ -82,6 +82,7 @@ struct idle_inject_thread {
  */
 struct idle_inject_device {
 	struct hrtimer timer;
+	struct smp_hotplug_thread threads;
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
 	unsigned int latency_us;
@@ -92,6 +93,9 @@ struct idle_inject_device {
 static DEFINE_PER_CPU(struct idle_inject_thread, idle_inject_thread);
 static DEFINE_PER_CPU(struct idle_inject_device *, idle_inject_device);
 
+/* Serialize CPU ownership changes and the associated thread lifecycle. */
+static DEFINE_MUTEX(idle_inject_lock);
+
 /**
  * idle_inject_wakeup - Wake up idle injection threads
  * @ii_dev: target idle injection device
@@ -279,7 +283,8 @@ void idle_inject_stop(struct idle_inject_device *ii_dev)
 		iit = per_cpu_ptr(&idle_inject_thread, cpu);
 		iit->should_run = 0;
 
-		wait_task_inactive(iit->tsk, TASK_ANY);
+		if (iit->tsk)
+			wait_task_inactive(iit->tsk, TASK_ANY);
 	}
 
 	cpu_hotplug_enable();
@@ -319,12 +324,12 @@ static int idle_inject_should_run(unsigned int cpu)
  * idle
  *
  * This function creates an idle injection control device structure for the
- * given set of CPUs and initializes the timer associated with it. This
+ * given set of CPUs, registers their kthreads and initializes the timer. This
  * function also allows to register update()callback.
  * It does not start any injection cycles.
  *
- * Return: NULL if memory allocation fails, idle injection control device
- * pointer on success.
+ * Return: NULL if allocation or thread registration fails, or a CPU is already
+ * registered; idle injection control device pointer on success.
  */
 
 struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
@@ -342,6 +347,8 @@ struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
 	ii_dev->latency_us = UINT_MAX;
 	ii_dev->update = update;
 
+	mutex_lock(&idle_inject_lock);
+
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
 		if (per_cpu(idle_inject_device, cpu)) {
@@ -352,6 +359,20 @@ struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
 		per_cpu(idle_inject_device, cpu) = ii_dev;
 	}
 
+	ii_dev->threads = (struct smp_hotplug_thread) {
+		.store = &idle_inject_thread.tsk,
+		.setup = idle_inject_setup,
+		.thread_fn = idle_inject_fn,
+		.thread_comm = "idle_inject/%u",
+		.thread_should_run = idle_inject_should_run,
+		.cpumask = to_cpumask(ii_dev->cpumask),
+	};
+
+	if (smpboot_register_percpu_thread(&ii_dev->threads))
+		goto out_rollback;
+
+	mutex_unlock(&idle_inject_lock);
+
 	return ii_dev;
 
 out_rollback:
@@ -361,6 +382,8 @@ struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
 		per_cpu(idle_inject_device, cpu_rb) = NULL;
 	}
 
+	mutex_unlock(&idle_inject_lock);
+
 	kfree(ii_dev);
 
 	return NULL;
@@ -372,11 +395,11 @@ EXPORT_SYMBOL_NS_GPL(idle_inject_register_full, "IDLE_INJECT");
  * @cpumask: CPUs to be affected by idle injection
  *
  * This function creates an idle injection control device structure for the
- * given set of CPUs and initializes the timer associated with it.  It does not
- * start any injection cycles.
+ * given set of CPUs, registers their kthreads and initializes the timer. It
+ * does not start any injection cycles.
  *
- * Return: NULL if memory allocation fails, idle injection control device
- * pointer on success.
+ * Return: NULL if allocation or thread registration fails, or a CPU is already
+ * registered; idle injection control device pointer on success.
  */
 struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 {
@@ -398,23 +421,15 @@ void idle_inject_unregister(struct idle_inject_device *ii_dev)
 
 	idle_inject_stop(ii_dev);
 
+	mutex_lock(&idle_inject_lock);
+
+	smpboot_unregister_percpu_thread(&ii_dev->threads);
+
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask))
 		per_cpu(idle_inject_device, cpu) = NULL;
 
+	mutex_unlock(&idle_inject_lock);
+
 	kfree(ii_dev);
 }
 EXPORT_SYMBOL_NS_GPL(idle_inject_unregister, "IDLE_INJECT");
-
-static struct smp_hotplug_thread idle_inject_threads = {
-	.store = &idle_inject_thread.tsk,
-	.setup = idle_inject_setup,
-	.thread_fn = idle_inject_fn,
-	.thread_comm = "idle_inject/%u",
-	.thread_should_run = idle_inject_should_run,
-};
-
-static int __init idle_inject_init(void)
-{
-	return smpboot_register_percpu_thread(&idle_inject_threads);
-}
-early_initcall(idle_inject_init);
-- 
2.43.0

