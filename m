Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018619;
	b=cyuqa+Swhl4z+DDQihF7LmiZ6aRHJf0RCIB5/MS0cZz3VbBzLqY3Mum3LcC0uUevNx/a
	 VeRvlsJg+8NmEphXp+q6U2NvbhZtYowL4Ft1RCtLWdC+xj4HBNiR0UbL5B2wdFyVGsHsr
	 kZdk7cBmeBav4tZ77YMVuhyQ2GgLQxL3xc8Aw1jx7sMMfYgwraO6SOR9ZKnc0QYFkX1Lo
	 GW2cBRIguyKwabSP+mrEykhqHwCg195ZMO1pGWkx5pDBH/aBn5xdk0OTVngibImmD8NAE
	 bLlP7u/AtiqUztPI6elpxx8IsyfeJoltmEngLjRMEZ8JIob4HM1kNg+/DVQ+/Cc28eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018619;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aGe5/35woBldXiPfqQ49uVeqf5gd1K2N9K/JlpgH0bM=;
	b=nw5IZMNMNHnHIniVYSt5TXbzz30VlzcmSTb9MluZXer9TwtaNMbqM93mj8UBiAaR3rVa
	 AadyfOjVm7f3mZp/6X1+l/6h+ZkMNv4dcek4g5UOUd/0xI9oEQaeMOXE5m/j4hs6ITAnn
	 LMPKBUjdfAEuygLacZSIZElg6DcT+zmIoVnbsrLCXr/3WFk51BvZ3XZuUhuRZkqXy3HHe
	 UsGtFa6b1MmSBTRuyaasAtCMXLgsuauePIHM7ASqlrtn+YPTedqFWF7s0AIyuMk8nhz6O
	 mOUtkDb2t83aQ+j7W3m0nnVXwHpcqYu2viIWkBFR277rZgHqmQ6YKk74rL04eQGu+9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SmXFyTTp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eVuGEma4;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5C606A33F
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76F5C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SmXFyTTp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eVuGEma4
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQBNN3912231
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aGe5/35woBl
	dXiPfqQ49uVeqf5gd1K2N9K/JlpgH0bM=; b=SmXFyTTpfxkyIIUFFruIb6Wl0m9
	IhD+1LOsHb5gF2fMOJ19it96xX5wdl/2kRwo563HugOxMaJUyCzSU6fExEWKU9A8
	AAk819vkz0Q7tLs9QDl/c9kArEAF0SNWGdV5Qbzx3ZEneFU81vEkw7+u8XxcnskY
	izIpzcT4TutiM2OUn/iopob9I+CD2CnZzuDvRxPz794BnBV4TrqZ9KcafE7Zya7y
	HhePdMueDFKtyMuFOZt9UmOwk+zFfz7esTE7mstfOumDGgZsXFZiN00K2dljkDS/
	mqrXyNv3mnkZOVe5yOU755x6JdOSrJuErlXCF5eGbnkMdQOfxrNtsUXDyEQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9c0cb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:16:57 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eabb3a1bd8so1002953e0c.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 08:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795018617; x=1795623417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGe5/35woBldXiPfqQ49uVeqf5gd1K2N9K/JlpgH0bM=;
        b=eVuGEma4HhW3atxptdh7E99AMh73J6rrBR0R+PXxkUwQHNdC5f81Do6iPdrz/jcCfU
         hM5pJE7rdpB/uZYJUj+FV16BGPNcAhw3ItLen93rdtlgXcKo5ZW1BGu8iXEK23qCEVSc
         g+td5JFow9L5CmuHnfh9L0PayDIHCgO0WgH4D9jrV0KAwYIXyuKNHcHRpaW4GH5Xvpv4
         coO4ek+dLGkYwUalFhfpUrWBrCO78IJb+WOTB0c1xT7HsQ+49EKmjevrTDXhkvX/DzUF
         Nkri0/omzaXbuwb24e04QsSkbTPV0AR1mUBw5he/G0yNo4I/a/O+CK4SO1PuLvOXpBbU
         KCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018617; x=1795623417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aGe5/35woBldXiPfqQ49uVeqf5gd1K2N9K/JlpgH0bM=;
        b=2hTlEf+02UL6O6DO/YYmjq2PCu0HpylaJrjD8dQOxyubAoj7L50Erks/bfwY8Ytmsp
         ciXnpvLDRg6dRmoDb7i+sHqhcOdoX9yL4powfISUNKpQE63gtWOYOkEMbIWXyAlkhG97
         JgFSLROvn6b7qyRQxZT9Cd+zjD+XB+/HH92PYxgnoi7rKVb1BlXeBTsi6UH1/otG0xAY
         DylSINOeg6GqPLXSu/DaVsC+h1YAkuPpw79zAVfqDGhBzXQgBNOLJBKOULjDOKYY9C7Z
         RCAfAa8SLF5LesOacJgTcHZz3aPo5CA9kjZVv04+bNn/ioBeIOVSbS5tBywDPkcAUnoL
         47UQ==
X-Gm-Message-State: APuU4Z9kUUNW/Td31nqopMhmXGv6ESVdW1Vs+dVgz7c7CuDe2ddIsXry
	2hkbH+/VLx9OoSZwCMUlwQ/Jng1zTvUyJq0HcxLTrAEp9QB73V/P6YT2WxWpLvmWjYOYZutthwt
	4eKYWu2kyWHx6tAlH6D/npSEuQxsq81NUICjuzY+7K92VXvEhgvSM8DI1d8aHjg==
X-Gm-Gg: AYBFou11JyrlUWdlq6h5Cg3/s+7b70eYkXZ/VFLDm5V9UyZNIvpxDuKs6aZ4QAXxTS2
	1VVBqlJH/0Ccc3zqCrs/mKEd8xFkCOzqh/YeWhwxhqdunyAhkFQMaINWc0JAfr5T8jt/LFj71m2
	6WTEgwktxDQMxTm+1SgBptLMDM6vlE2l7iAaix9QvQuh3Xk/M+ngtatK0Bs/JRlAF+FV1MkQcCG
	lHvP8EVTWmwgjfeSKRAaFD/XzqjPz5Sua3g6uCAMHfw6V5T9DaOdImtsQMlsfZIBQufKUextUuo
	CFTSPWB3fYIBGz3KY/urjB9+0DL7zQDlz3ul5AG7by6rSuGyjJ1S3Hud42H3ONj434ncGthe8ZD
	/e8SQiqTjxy8sP2w1XAZw+obdhGb8bG5KcDRIicts2EWTvG7hb614DiHnXB3SfEIpTssbFwHIpE
	JS
X-Received: by 2002:a05:6122:1b8e:b0:5ec:7589:f9e0 with SMTP id 71dfb90a1353d-5ee64724bd7mr1781031e0c.11.1795018616594;
        Wed, 18 Nov 2026 08:16:56 -0800 (PST)
X-Received: by 2002:a05:6122:1b8e:b0:5ec:7589:f9e0 with SMTP id 71dfb90a1353d-5ee64724bd7mr1781018e0c.11.1795018616101;
        Wed, 18 Nov 2026 08:16:56 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d355:fe70:14a0:ac8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm217090495e9.8.2026.11.18.08.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:16:55 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, tglx@linutronix.de
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Bradley Morgan <brads@mainlining.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH RESEND v2 2/2] powercap: idle_inject: Create per-CPU threads on registration
Date: Wed, 18 Nov 2026 17:15:27 +0100
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NCBTYWx0ZWRfX5OkRuYiA7+F+
 JRdb6lCzwEXX7Kpb5r66VxLkMrwRgYcAl0kzQ+US+tfddU/tzzMeFj4sF0WxcZ9WfmMHMe30Moe
 hOEzC4tSnIoM3ucCQF0DoljG7WCuDR0=
X-Authority-Analysis: v=2.4 cv=acT0Dhot c=1 sm=1 tr=0 ts=6afdcf79 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=OuZLqq7tAAAA:8 a=z2xlO20o2AOZ5rEB0BcA:9 a=tNoRWFLymzeba-QzToBc:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NCBTYWx0ZWRfX5FI2VwCVkAce
 VQOw66GTzuWVcgxhjyImHNdDybn8mkukzpJ/xHEifcOmRHidl5+tRmD4j/z9I3hrAdGpmgPnlGR
 Z8PBJq17W5jbF6pFniZ5yBOFqdvrdT8fXF1xtmaXiBe+H8qV13UaUXguQqaIRcK41FzIeL2Hfzc
 SsO50O60fdYK04PcPFzrbGwwD/AQVQrTiI8rBOqGCAWY8CWyR4vq9G/SdwrfIU8qswKwyEpph5O
 /4eciK1uzdX3fxsqh1D6fhPOosx74WZTcteKOvqC4QXo+gtQtp53o/my7BFA1A6R0c8LS6WrSJF
 gL9cNwFxcBJxmS6lvmh9GL8EfK6xYSyNpY6EawskvPKM8miBsIHf7ZvABAGF9sbYHrPqZy2WftP
 usw27oLpSRZ9DH+4365mREIDPl1pwhb9ZDfcvvfl0B9eKvdodg+VzThxyYhffHoLqLtdKvnc0d/
 XA6smrSa2C6ok8o5D8w==
X-Proofpoint-ORIG-GUID: Ttm5L474bP1HHbeFtfTO8gmGXb8oDuao
X-Proofpoint-GUID: Ttm5L474bP1HHbeFtfTO8gmGXb8oDuao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180064
Message-ID: <20261118161527.fgIDKLe2y_LUprY_AXrKpHUjt_efsg1M9HEwn-8a3_M@z>

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

