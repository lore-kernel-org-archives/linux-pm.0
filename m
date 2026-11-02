Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661044;
	b=E5pJ2wCG2DdZqsIQItFExAxeEXn65fRBVqo+8zgEiO6TR+iROkX3kjmghalWxrwJ0flq
	 UDlNJR2+hd8Fj7vL+P1okKBmih58xmgh47l5KGD2LS7Wf6Z3h1/JxSfpZWdK8nkgJaT9A
	 L4IEVSxmiKUNUSh8GcTDf5qwnXmzSDx5BhxoPea0Emxz6NufoPcCtS7g3lq6KaztPJtqQ
	 kh8kxlhPovzuExUgo5U1fhU+ehYo/h/3X8zZtdU4+nDMclCMtjBVizffKD7Pu9JYBv3oX
	 XdRMf5PiaYWzKt/G8xI2d5Ha6DvjvfwtAEMaWrKokwKNp1wnHSk85EjlBMCFh8y9NQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661044;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RNPEXbcvLHlz70jUnJvyWiGs4WgJ8gGzePseO2P4c0Y=;
	b=CCsk03dIGRiSgd5bAS5wNu7M7TsCXzwuyLrPzUTOPH2vaS4OLRBCKrzfE9KbVo0W1gej
	 g4UE6jZpaoR49rDwX8CM3ETXseA4vgtNhh8f+sb1rxohKxElskN3/sjbpaaxoVFrSOVPY
	 6JmWkN43xLt757heZygYZV5RZf858ifbdjtZYTwGA/6VfRcU+edLhwOkSF2Tpm826odHY
	 7quw0KFZ2TYfc8k0RdLJtT9n+PTEnenODMJMwj9dWKM/GLxv+W1/U46i7Of1Fy7l3U+wt
	 UwPrWSoajEpQPs1I3eA4BZU4N8N5Eye+Kt8u4EGVV3HfvkkkQ4H3c9Hb5Q5SB+R+5xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZUNjv8iO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ED1vANuR;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235A3606A324
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 23:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 235A3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZUNjv8iO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ED1vANuR
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2K6CoI1746253
	for <linux-pm@vger.kernel.org>; Mon, 2 Nov 2026 23:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RNPEXbcvLHl
	z70jUnJvyWiGs4WgJ8gGzePseO2P4c0Y=; b=ZUNjv8iOu0cW5VdrUGImHyJiA16
	Y+L8jMtCrcru0H+eiv4v+0T6AGLDpg7SuT/sSijN3ioOElR55w7lOd2zSi3aNJka
	Q40NDdlPZuInNL1WYquTpit3QKEn5NCAiirvIo8h9v6Qh6MfHYxzNlSh7VMTB23B
	S+5YTrjCRs6pNv69AOmVdj/r1O/XSWGTivyq3LFfirFuYMw/XXxn520EXWFv4rbZ
	OOLsPv/8PluEs5ceDLV2srFwq3cWw8S1yULOkj4b8TeEzvxZHYYORtIczAwaUsa8
	qaihozL7CbKg+/Lz+B/gXXbjXAVqZVu+4NVHpYYejX26wz6pvpXjOiHlXZw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqmvuaa1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 23:10:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f2373e9b4so356345985a.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 15:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793661038; x=1794265838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNPEXbcvLHlz70jUnJvyWiGs4WgJ8gGzePseO2P4c0Y=;
        b=ED1vANuRMDOghU3by7FnR2lmz23pq00C/nbAWsAj2mNGIEiBkTxjcrSX8lGBJ5Vwv4
         4lFp12a2tvWBlojEHawd2pZJKYuVYiRwA7JdLN3hDnrjyrQWfUK/VAWbVY9z7BzB2jSC
         OKiSGqh1rGPgo4rCICR1N22AWQtUoVY3dPvnPHXJFe3xgIjvyDPdrI1JaYtTH5EH5rsH
         FBBnq0xVIl+MVT60RnApXIVZ1BKlLCXLuWAL2A1WLD/rqR/yyrYx7zhUvUZwQtpznn6j
         NYuOQW/oanhYb/sQBCHdxz8xdqxr9aOgPqPgVPCxf37Qqb2lOQyFYbKgb2pLEuTSzmSg
         Jdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661038; x=1794265838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RNPEXbcvLHlz70jUnJvyWiGs4WgJ8gGzePseO2P4c0Y=;
        b=C7CRu9mLUdDJS/hoEAfIXrUCtpurUhhwyijgyzjTrRcriMLFF9y0PQGmB/HTg9rhpr
         wyvUG3QtnvDIKJyrCapT9KAnvVqJpzb7gVK4ypOz5qlW0nrJ1vNSXmJnJqHWs8+2JGnD
         QHRyiLKiRBfk8a1N7y810czU4LT1/fEbd168ZduSj2GC9ME9KFjHTdAmP0Bl4kb9gz1u
         M9oc9vLqSl+shBuuBLfLtef4zqnj6xekxJs/oFSKGuUZM1TzRFqKNhTqQjp1vMSBbBRD
         Vtgu9EMwWqznwOhkIseXSd/Vn4JclrbJ8bXZPeBYHFqttLWK3leMzmIBJptqda3C8nSu
         osrQ==
X-Forwarded-Encrypted: i=1; AKwUvBx10YvfiCpD4gykp/TkwHtRDRwSHYRuQbnB34dZiwTtrAyEFAvTvn7HBD/yb3Y991lt0fZZQ0ZftA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL0IJeS0vhs/wz7OrEvZ8NVdOH+NfTlkastY28b7n1RSHgNd9fA
	X8OWlgjcvKu3h+iYvjUw7IbUdcv8xf7R0qFcYYHsOa4ky7lvhAWHCwL9YVQXSP7Z7A41ufnbeGA
	VPl3N+zhaN848h1EGrbl/AjQAFbEI6O49e8rf5n43iBmKyINEs1uVXzV+Tffj6w==
X-Gm-Gg: AYBFou3AL11uRAVt+OHbAg7WT4VNCXtVnKn/fKKBzDBg3A+xzdT7N4JrPW3sSfCkCmJ
	/1bHoQ2GJ2L0QYkYJYtRC0MvzxoHKWxjRSzz7fHunF/FoMI1tcYnqpW0VXWXANKU8L9eslzhDBU
	Jr/rIY1F6reAoTeSD3xD3BSHXk+2M3/MXxRxBmIqAH1d80JHBDUZvKXTRFdYEnvMi+rzSY3NvvO
	amPdZ2E03Zdo2Xl1ltLYidcP8YwTnEg1JjgJOJDwNNnqbR06tQgR+uB6yMHHO6c0y0H6TnkhfWa
	XinBHUvG9mMUEpa3iiJvOk6nGZ/UyRhCJaWCYZoPb6aJzqDI2Lisq5LtXiFMTklZWpvUCNmOCWA
	pML/oPG5WU+zWSpEZkSNj7J+U6XRH3/HxvpeCNSX8C9P+L/SV4ygs1DXKn9BO2EMnzLExG047gZ
	Hb
X-Received: by 2002:a05:620a:28c6:b0:93c:6fd4:467a with SMTP id af79cd13be357-94421541a87mr1857269285a.2.1793661037870;
        Mon, 02 Nov 2026 15:10:37 -0800 (PST)
X-Received: by 2002:a05:620a:28c6:b0:93c:6fd4:467a with SMTP id af79cd13be357-94421541a87mr1857266285a.2.1793661037320;
        Mon, 02 Nov 2026 15:10:37 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8b9e:7797:dd05:11cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a82cf248sm25198725e9.2.2026.11.02.15.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:10:35 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: akpm@linux-foundation.org, rafael@kernel.org, tglx@kernel.org,
        peterz@infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] powercap: idle_inject: Create per-CPU threads on registration
Date: Tue,  3 Nov 2026 00:09:41 +0100
Message-ID: <71091b05daff46020ccd1bba3ed66b0055c85046.1793660202.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793660202.git.daniel.lezcano@oss.qualcomm.com>
References: <cover.1793660202.git.daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=TMDQ2Fla c=1 sm=1 tr=0 ts=6ae9186f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=z2xlO20o2AOZ5rEB0BcA:9 a=NFOGd7dJGGMPyQGDc5-O:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: d9Fm0HWh1Xh_WrRc1L4ZD8yjXaQssSxf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA5MSBTYWx0ZWRfX/Rp+sZOIEavF
 32mO7f0t+Inc2ZcDYQRmVEwCP3aPj4yAqYpxQGWaBCppCvPVt/aWNP7Irud7v5+ZFM9Is6RSucu
 puhL0FmHhiC/cnHyrl5YMXPOeO1Kalc=
X-Proofpoint-ORIG-GUID: d9Fm0HWh1Xh_WrRc1L4ZD8yjXaQssSxf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA5MSBTYWx0ZWRfXx89h7AmY+C4Q
 ozUMLg6hlNEFI1FtLiKecxQqr1KZ1z9copjqb975av4hpw7aOdTbVAM4CkflVSE8TXGYwlFqstg
 y9S4R4RNUKYKlnLgCXfmEGcqNvaB+2cpJokiTtToTgEf0Zu9S1vPGKlmOBndomCPTwQMsNY3DrQ
 n+q7aqpaZyGTSQfUdRjtCT1If7t7MGiuOFxCbWjlyP55Nd6qz62WCtZk2YJQCsDxddfuWDTR9UU
 qzClNiH43ZZmecnBh4F4IkJOU8AmA0VL7mZi1T2iosiHbBZPPWwPmniGapy7Dy2jQS0pmRqfder
 TBoSWYc050/91ZIxKOzXM/BK+vgcmaJnEqTa+Nka0dEIcEoAXp+YHQXB0AKCd15I21SKriiCH0s
 w6hYgI44+jrhDAFW0oB5tg722riSqjzlrSs0ST6MXVIGo8l15smdSFwFE5XX9Lk6qW5OkBxYqbO
 aWX4mR6U71aGQGPC1Yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020091

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

