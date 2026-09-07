Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0346C84A
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779840; cv=none; b=OODjsvQekZfB8pA/+5l0k5ul8KFrjPffGXP6EBJfBrW9d5BBhHlNknt53fixUL8nSgSVle9ErIBJAKU0K1uKBigAdyU8pO04wJvRm19AKIAFc0CtKBe9ijpXOZoHLQs7BKql54ix8xb08XakPAw2vE7xO7JYtYOOTseRp67zTCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779840; c=relaxed/simple;
	bh=HksTSH5nZIdSJicXwafbbfriQ2xJFLxE5NRRSdeL95I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CchzgF6QliZMh+4VUYoucoSbDQgWS12vCHr594IikaxoA61kZPOfAzf/viE7tmDtWqWoHE5l2WtVopu28ZqkanUO0GCGH0lUw2Lf/IWLBEaAp2E56Ad9CLeTWAblk5b67easWZNMjxfwktk2FVmiWie6/L6E8etoE2f4jcVkQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KM9RgnRB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NoRH3mH1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KM9RgnRB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NoRH3mH1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687An1cu3230465
	for <linux-pm@vger.kernel.org>; Mon, 7 Sep 2026 11:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qc3aItDznK9
	eNLgbGrQcjkgrtgUZI6baFp+cJdIi190=; b=KM9RgnRBoCz1wPP+BQZ1Q5Oq01+
	RazZJXqBUbpn5yUGvYC9zTiaV4Ln2eMHYutAomBj2tloDuWuxISBPUV3Ls+Nq3br
	GbRtdq36E7Pb9RDcD55E4DHZyDyn34bSkKRA0zaJk0o7lcdU003o+ao3yuQSPKlY
	RBdDij03LCuY5qN2arSlWCu94glqp7clD8AX3H5fvientMxrpUlNAu7XQUiHVJbX
	LSy7GZ0uJEoT17p+hDR7s1ZxpVlSk10N2ELjx+d5YnPJl/Da/XEydLDF4usR0nUw
	PktKGkG2CAQpREwx8hqshIxxG5c+lNT7wEybQOOGsNppayk6r4XLGHyU9zA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfxkteck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 11:17:16 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-73850dfc198so310669137.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 04:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788779835; x=1789384635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qc3aItDznK9eNLgbGrQcjkgrtgUZI6baFp+cJdIi190=;
        b=NoRH3mH1IyzyiS13+PhH4bml004n+lExFwGWrTTEb6336ZLwt9AlJHbQGh0CICMlVZ
         ws/4VnPDM3oQ/iuffIPTXUQE1Mt9+2QKcFkDCfqsdtWqKlDHOSRVBGJ9fLButRFtLVs7
         ZVUp2M67iDz7NTRdW3l4ddcsguKm2tRcBuv3oHgSwaO4BYgKWjfuGn/9QPMrLRntETNR
         p1MkL1htkrc/evNyY9ECJm0bpO0suZQTphOy1Jj/DjVJF9a/vHZgUU4PoRInkdAWx32I
         V/TlqA52olSotB5sbcytZvunjYL3linTWQtdAuQqjL+OVOtiE+X0dJ08gbYhkNOFILVz
         e4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779835; x=1789384635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qc3aItDznK9eNLgbGrQcjkgrtgUZI6baFp+cJdIi190=;
        b=sgepYA7DJX7m+k+3qo3EorjWCmijmNjYd5aYyNW41xpq90OYPZO0ctvqe/CEN1HlQV
         LQSRZXxsLO1IL/90uNaTI3Ykz7SeWeMZsjbI+Wh0VgZ9XxI0e1W6c2s2pHURs9+fjTvV
         WEpAPPWLExLBPvz+vapdoyqKqiEvQ5gkwHhtmpnAh9oSz3d3eCwe5LZC5ZT4oRtuGakP
         ICExz1w0GTIHmbfxBvakVxgKmPOFs7X7bzxtdLqh4if1fdEnnClxNV4S+ZwBC8FHS3Mp
         e4ge5YrqsW8LJMDCPR68zE4M5UetPdh3jMVABEafS7Tpa1a2jSkPbPuBPUiLU9UYhKoU
         nmAQ==
X-Forwarded-Encrypted: i=1; AKwUvBztthhk/Ow+3dLDcF2nPW3VrXFwTMEVAXGi5un+YEDatnB9KlV5OVbbjM1WxcvaFCUBuQ/beLr4SQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lmwBij0zs6UQvkSSTB2JXIJ4Yu/jPMrPEN0rr5VNagPRcp+BNg
	mMCg9eVde1kb6XdJEgmrWRIO/xm2qrsJpm6wqkZvqs/4zUN1tAZ6+9/mR+YKTPxzHVjO8o6+QIx
	6n2ITE7IvuvEypfqLYWhczzYlpq+Jlw2Up5M1gaBOkje0OfohB3pfjYGHOn+jHA==
X-Gm-Gg: AYBFou3bSJ+AtJOdSxhdHCzU+SWLRxM3z7QZrtSfnlv7dlDjViRqX9/pxzLfOXaUOTs
	tvSjOERukXAMtnWsYa6wdZ6M/rD7nb5a66LSf6a4Sa80Hb86G0ydEjLp1N7eQksAYvj+0WuwscS
	I1EiWrMEFfh9/7/kp8bn2QidXbcef5y19+zAGskD9dzbqy1VjssJo1HRfsQQAxzAwYMZTQLUtG7
	XI3ddEa6gWzE4KEZ5blt8YqR6sHvep44Gp9WvKc5mXV0BtT5B+tUQwz0GfUvBz7z8zic37CRn0t
	bTSkwUVBnhcvsoijUP+NbK9RCUM7gY8hHd1n+t5AFRTcFT2Ysuw3/YvcgsddbeBZXssTSDxA5zr
	RWYA3wMEg5m8Rjv+CoStPKTu2HfJzAQXAKZ2eYenA3zbHQesdWTFAbrwe6Q==
X-Received: by 2002:a05:6102:5814:b0:786:b28e:f980 with SMTP id ada2fe7eead31-78a4a99f7c6mr7574456137.10.1788779835469;
        Mon, 07 Sep 2026 04:17:15 -0700 (PDT)
X-Received: by 2002:a05:6102:5814:b0:786:b28e:f980 with SMTP id ada2fe7eead31-78a4a99f7c6mr7574414137.10.1788779834862;
        Mon, 07 Sep 2026 04:17:14 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5cfaa2sm456120066b.59.2026.09.07.04.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:17:13 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <goledhruva@gmail.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] pmdomain: core: Allow a non-CPU device in a CPU PM domain to do power on
Date: Mon,  7 Sep 2026 13:16:52 +0200
Message-ID: <20260907111659.263324-3-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907111659.263324-1-ulf.hansson@oss.qualcomm.com>
References: <20260907111659.263324-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyNCBTYWx0ZWRfX8XvVqyPtkObq
 4FbWy8l6gwmto90urgfqDheOpX6bf44OYucXuPgdKCnMT9pfTd/HBkUbwpSamAFg4lS6+B0LOje
 YPOX4m0aTLwebR4QhYgofmhYghETBTCTvCGKZU+olMNMytVkXitOPhf2kQbYe71+JU0Ehm+3H7P
 c790kMEvRvhoBrwPIesTVpK3FLNRAUBpV+feQHhS9q2TssA+ENOehz4gy0fjp4fhnwHGXInUwZ+
 +S9ZW9e8r4duxHNMQi41jZ8Esr/ysTU9BrYoe81+4KqwTDQSxRNYReWEAs1aDKQpel34gXS45F0
 xICananAr5OF0Z/XWvBNmbNz1k8gQjuZOMIH4OArUnx13YEiZ7wVM3pZuwKkzf14yMcE869+wSn
 RFK5/bK3V6drV8A2Y2IczSkghPvMeBd7HwoECITz/ZmWxKcVxhYW5r+MkyT+xO4M0aO2Y6E46+u
 VHlHgjx5IgRHQjKjkRA==
X-Proofpoint-GUID: NPrTjDTSBH-XAyQBu7APCFgEjvEFhxPl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyNCBTYWx0ZWRfXwMN1DA4fY0Us
 UVsE7zqLd3EXyNd9ezr2U7ezEsk4JOtasPrxEriQhtoULi7jrlHnIgPuwTETy9s7l41IawiO0o+
 ctR63pWDbpD1EVIQvkgPD71sxVLUT7Y=
X-Authority-Analysis: v=2.4 cv=daOwG3Xe c=1 sm=1 tr=0 ts=6a9e9d3c cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=u8BtVuMVLpZXKRMe:21 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VqZmVlX21PZHT1he1CgA:9
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: NPrTjDTSBH-XAyQBu7APCFgEjvEFhxPl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070124

A driver for a non-CPU device that is attached to a CPU PM domain (the
genpd has the GENPD_FLAG_CPU_DOMAIN configuration set), is currently not
able to power on the PM domain. More precisely, to power on a CPU PM domain
one of its corresponding CPUs needs to be woken up if they are idle.

The current support for a non-CPU device is that its driver can only
prevent an already powered on CPU PM domain from being powered off. This
leads to problems for a driver while probing its device or when it needs to
call pm_runtime_get_sync() to turn on the power for it. From the driver
point of view it looks like it all works fine, but when accessing the
device it may end up with various errors as the device may not be fully
powered on.

To fix the behavior for these types of devices, let's adjust the behaviour
in genpd_power_on() to wake up an idle CPU that belongs to it, in cases
when it's needed.

Link: https://lore.kernel.org/all/CAPx+jO-sCierYj8jnoKQHckJG16dOBxnNrsZVYO=38R2cLV8nw@mail.gmail.com/
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Tested-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---

Changes in v3:
	- Moved to atomic polling, pointed out by Dhruva.

Changes in v2:
	- Rename a function according to Abel's suggestion.
---
 drivers/pmdomain/core.c | 80 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 6abe8b198949..b62d4e544bc5 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -10,6 +10,7 @@
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
@@ -19,11 +20,14 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/sched.h>
+#include <linux/smp.h>
 #include <linux/suspend.h>
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 
+#include <trace/events/ipi.h>
+
 /* Provides a unique ID for each genpd device */
 static DEFINE_IDA(genpd_ida);
 
@@ -32,7 +36,9 @@ static const struct bus_type genpd_provider_bus_type = {
 	.name		= "genpd_provider",
 };
 
-#define GENPD_RETRY_MAX_MS	250		/* Approximate */
+#define GENPD_RETRY_MAX_MS		250		/* Approximate */
+#define GENPD_CPU_ON_POLL_PERIOD_US	100		/* 100us */
+#define GENPD_CPU_ON_TIMEOUT_US		5000000		/* 5s */
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
 ({								\
@@ -1026,15 +1032,75 @@ static void genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	}
 }
 
+static bool genpd_status_on(struct generic_pm_domain *genpd)
+{
+	bool is_on;
+
+	genpd_lock(genpd);
+	is_on = genpd_status_on_unlocked(genpd);
+	genpd_unlock(genpd);
+
+	return is_on;
+}
+
+static int genpd_wakeup_cpu(struct generic_pm_domain *genpd)
+{
+	unsigned int cpu;
+	bool is_on;
+	int ret;
+
+	/* Find the first online CPU in the genpd's cpumask. */
+	cpu = cpumask_first_and(genpd->cpus, cpu_online_mask);
+	if (cpu >= nr_cpu_ids)
+		return -EAGAIN;
+
+	genpd_unlock(genpd);
+
+	/* Send a IPI to wakeup the selected CPU. */
+	smp_send_reschedule(cpu);
+
+	/* Poll to wait for it to complete the power on sequence. */
+	ret = readx_poll_timeout_atomic(genpd_status_on, genpd, is_on, is_on,
+					GENPD_CPU_ON_POLL_PERIOD_US,
+					GENPD_CPU_ON_TIMEOUT_US);
+
+	genpd_lock(genpd);
+
+	/* Re-check the status as we have released the lock in between. */
+	if (ret || !genpd_status_on_unlocked(genpd))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static bool genpd_need_alive_cpu(struct generic_pm_domain *genpd,
+				 struct device *dev)
+{
+	if (!genpd_is_cpu_domain(genpd))
+		return false;
+
+	/* This is not for CPU devices as those are managed differently. */
+	if (to_gpd_data(dev->power.subsys_data->domain_data)->cpu >= 0)
+		return false;
+
+	/*
+	 * If the current CPU doesn't belong to the genpd's cpumask, we need to
+	 * wake up one of those idle CPUs to power on the CPU domain correctly.
+	 */
+	return !cpumask_test_cpu(smp_processor_id(), genpd->cpus);
+}
+
 /**
  * genpd_power_on - Restore power to a given PM domain and its parents.
  * @genpd: PM domain to power up.
+ * @dev: The device that needs the PM domain to power on.
  * @depth: nesting count for lockdep.
  *
  * Restore power to @genpd and all of its parents so that it is possible to
  * resume a device belonging to it.
  */
-static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
+static int genpd_power_on(struct generic_pm_domain *genpd, struct device *dev,
+			  unsigned int depth)
 {
 	struct gpd_link *link;
 	int ret = 0;
@@ -1042,6 +1108,10 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	if (genpd_status_on_unlocked(genpd))
 		return 0;
 
+	/* Special case for a device attached to a CPU domain. */
+	if (genpd_need_alive_cpu(genpd, dev))
+		return genpd_wakeup_cpu(genpd);
+
 	/* Reflect over the entered idle-states residency for debugfs. */
 	genpd_reflect_residency(genpd);
 
@@ -1056,7 +1126,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 		genpd_sd_counter_inc(parent);
 
 		genpd_lock_nested(parent, depth + 1);
-		ret = genpd_power_on(parent, depth + 1);
+		ret = genpd_power_on(parent, dev, depth + 1);
 		genpd_unlock(parent);
 
 		if (ret) {
@@ -1306,7 +1376,7 @@ static int genpd_runtime_resume(struct device *dev)
 
 	genpd_lock(genpd);
 	genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
-	ret = genpd_power_on(genpd, 0);
+	ret = genpd_power_on(genpd, dev, 0);
 	genpd_unlock(genpd);
 
 	if (ret)
@@ -3410,7 +3480,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 
 	if (power_on) {
 		genpd_lock(pd);
-		ret = genpd_power_on(pd, 0);
+		ret = genpd_power_on(pd, dev, 0);
 		genpd_unlock(pd);
 	}
 
-- 
2.43.0

