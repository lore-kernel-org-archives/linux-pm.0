Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1047F779
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152523; cv=none; b=JloGJVWD/pBjgv3OSMJ/AdQgYPe1AE68L16rxROMBxvaireZRTUdO6JhP/dSjcQi1TuIzXCooGT0aGLuPhrI3fGWKEYXKfFbBe08r7vCedjV/R+57tHQekA5BrdLW+H7gQ+AKG1jll1fZjHD7JENEPkZMWZ8/yABUhjZHtTRd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152523; c=relaxed/simple;
	bh=UcA162awZ/FDLL+nLPTQwzMiSqcHxbiYyOYH5gX1pI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9qvHQl/JX7oqwEk+svZi0hq+PWIPDVt/EHKhkSb4GDFA1zak9DHBIkmfhseFJ8EKUxmWFVCrWa2/6RylKJRRWyJPF+jVJ8iyzMB6lVcDeP8YAfXoOKKxT5W+soZ9j5nblcIbHXpMBclgEClcWaO4ebumYIu6LQEl0P45iuGI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JoqoNvOv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ux0GzagR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JoqoNvOv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ux0GzagR"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF22vK445146
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=feUNzhq5Dex
	7vlE9YWr3DimXFOMzSyfolhfBuwRnZkk=; b=JoqoNvOvpksv9Fcn60bfrQfGwL7
	oxctt78YzNZbdVLBTDB3UbHaYAeOvtuHbaY679K2Q9V325HeKhxsnIBxOJ9IH/Nc
	1VoDD0vYDS5/vg3YKU8f4mKMHg//Nzv614HV8FXuw3WDmJLrKb/s7WoZ+rWnAh/K
	ykS1qBgtwK282xtJ8cbOcsKajWSzO3XXCMGmMmh/i6U7kYFJE0SO1ET19LmhoiWC
	2sMs6N06PBQaPDtdy2V5trYESPKVO7PRvcRC2CWzaxYjRs0fmNDGx40z026TWTek
	5Stkvgba5J5DsT8RxY3+lUgd9XgpKb0AZSm8+AgREUs4DbGmTXma6V8IX/Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es6023y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9349c5af52bso196300085a.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787152520; x=1787757320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=feUNzhq5Dex7vlE9YWr3DimXFOMzSyfolhfBuwRnZkk=;
        b=Ux0GzagR3Ufxq1DN6j1UFe4ApP7acJUJ+7EgZRcyDgbwqN6RIxVBMXAeEnh1397pyB
         KBpRaAVtgV8/9oNx3Cm9y+QlqhqhX5lfazzZrVI7W9RuKypKsbJC9FoLp/9WDgH7BWFv
         nk7NBWKdMMlGjK61bA9od49mf6yLrLbhVVbDHHWqFI0/tPmO4JF/H3vltxmGp1oRu8hm
         8m4ziaztiqvsdT430Ya9Wf0yVJdlbvcj9kU3us8ovhZkgJL40doMrj/XkcnGqvw6G/lr
         oduQdFT2bGcqJnluGtDtfbYcKjHfXxup7NRywH+9ueWy0ij+/HenUNZsCni/M+nvl7mg
         F5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152520; x=1787757320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=feUNzhq5Dex7vlE9YWr3DimXFOMzSyfolhfBuwRnZkk=;
        b=LYZdkAO6IQJ1m/Mi43/YFxs54p9PXnemRFaTZZOivyVJPt+SbBaqohf0yJ8y/wQS7w
         +SN3fda5+wp2KuaRekob8tpH/nfvSI4PRwut9gaC1UsHqc/rDgQFpYZrfNvBnLlvY9CO
         BOatEe7ufNPRfGBC6Ge2EqolIgMKfa6y/f285TuZxhmYIYxWxGj4arZjClSCyJSMjyZy
         5f1+uPs8pMaNLN68hnZY0fsfb+qiNPJiNncMnnZdn910Ys50qmb/YiH3RSjDl0cOc1NG
         bvK/6XGnpSv4+xKFKlNMln7pU33r6fxlBKNevPQi7fbkSlurAzHx1w2VwjYAruDnyGB3
         Y+eQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZyCQ/u4EelqiipIN6uPKD/5t+JWnqV7/S6sOoCH33ByiXHaVVN3S6m3kOrS25II8Jh00DtHankg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMoDap1ucXp6DWj4QQHDaJgGI1UPwCi9CTgqWjUl31sff/my5+
	JMf/Q1i8S6FieysIAcMnsU5Zn5SyYrp4Xq4EhGW3rooyFbEfwCArG1A/Mrpdj2y53Q8Q7OzlxIj
	Dw5jVkE+Va2/bfa1495QsV9kiaDXGAPin5RAoKPRqvT8u2u2Pv62c8EqcTBau/Q==
X-Gm-Gg: AR+sD11DnpTx+DQMkNlzTLD7XxVUunmRKYEzUoyvpWJbZ3rcppBKJXF4VPvf8i5BD8C
	rZMVtq0VTpOqPw3ksqk00LCpt4e/kAXAr2CGV36BPrt+QSua762MINwTJhWtykAxIG6i7lLoSk4
	E/qxRyKRpykMnPI6CheRHy3mqXNy6Dc/FqauFEtiOKfMGlkzdqKtMAHlZlxYgHlbhJ5Zf1OQMSm
	RrNsWo5tzayPDEBkFlfMCF1LKjzL3qxhV4qiLqe4GjHpwmvBbrQPz+JW8zkmusbTLHaZwBTAB4a
	Suz9hyGaYYptlr2rEJLvLXPuJTQxVSVaGIqyyCRV2oWYMjEdfxp4r0KKrb8Cp1/LrQg2ROs39yw
	LyKl1zwIJIymbqlXbUoRbfa1JLOdiRYeuCF/ticUuTkwnkz0d2TOQbvS0QA==
X-Received: by 2002:a05:620a:608d:b0:937:65d:d89e with SMTP id af79cd13be357-9371e1dd574mr581279185a.3.1787152519559;
        Wed, 19 Aug 2026 08:15:19 -0700 (PDT)
X-Received: by 2002:a05:620a:608d:b0:937:65d:d89e with SMTP id af79cd13be357-9371e1dd574mr581268685a.3.1787152519023;
        Wed, 19 Aug 2026 08:15:19 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c4ac06asm94124666b.33.2026.08.19.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:15:14 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>
Subject: [RFC PATCH 1/3] pmdomain: core: Allow a non-CPU device in a CPU PM domain to do power on
Date: Wed, 19 Aug 2026 17:14:51 +0200
Message-ID: <20260819151457.256959-2-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819151457.256959-1-ulf.hansson@oss.qualcomm.com>
References: <20260819151457.256959-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E5/9Y6dl c=1 sm=1 tr=0 ts=6a85c888 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=u8BtVuMVLpZXKRMe:21 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VqZmVlX21PZHT1he1CgA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: l5u8u5_iJotdztmE0Xths619fgrz11Lg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExOCBTYWx0ZWRfX1S1jwPgMoTnb
 Nb2RioHvUf6qyEG4SDc2xqlZE0ov4xkzFXHwAvQi9E6k9IpQleS5QfSdeWYmZP+I5lc7mct9Qho
 IKxmVUzcnvBDLBDdQGMHq83y0qM5+nsi04P7rLlJzySsYWGK+TpqD75I3VzhDOz3hPQR8qHY9je
 whfwY8Zh9HSF2iShGjUmd21Bv/Ukoaf3/exk1y4GS153I+3DxLM9Gwo4v9X5ftun/4rBPs1a4hx
 PY2C7e2R5RVcvlIpxzoD91WKLGPsH4rubBibUrihGafnjrJ1Z4wOjHSYz0C2o4GutADXTp1wdg4
 5S4wVO79mYRK2OxQSHK9Cui8DqD4strALSUq+NVG6e4s5ODTbFynYNd48yARdT4/mFyTM8+Ke5P
 G+uHAls5OAeC3titoDxg4n4xNcEmKnOSMQiiySdcxCfQbO5HfUof3jQ0v6xWy4ew9pXO+0Bp7fR
 5Y0NtCP2A2tbYc4ppeQ==
X-Proofpoint-ORIG-GUID: l5u8u5_iJotdztmE0Xths619fgrz11Lg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExOCBTYWx0ZWRfXw/QLR+qcSMPv
 /xkzBo3+44ov9a/5H6PELEilMeKc1cCY7w0KUDYHb4dki77wat4jH7LVWvN4IAQXWtGeKDBRWUx
 clM4qQkg6oTZ28y7VOSet3YeqAQxWq0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190118

From: Ulf Hansson <ulfh@kernel.org>

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
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
---
 drivers/pmdomain/core.c | 80 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 842c4169e290..7345c06f1d55 100644
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
@@ -1027,15 +1033,75 @@ static void genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	}
 }
 
+static bool genpd_check_status_on(struct generic_pm_domain *genpd)
+{
+	bool is_on;
+
+	genpd_lock(genpd);
+	is_on = genpd_status_on(genpd);
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
+	ret = readx_poll_timeout(genpd_check_status_on, genpd, is_on, is_on,
+				 GENPD_CPU_ON_POLL_PERIOD_US,
+				 GENPD_CPU_ON_TIMEOUT_US);
+
+	genpd_lock(genpd);
+
+	/* Re-check the status as we have released the lock in between. */
+	if (ret || !genpd_status_on(genpd))
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
@@ -1043,6 +1109,10 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	if (genpd_status_on(genpd))
 		return 0;
 
+	/* Special case for a device attached to a CPU domain. */
+	if (genpd_need_alive_cpu(genpd, dev))
+		return genpd_wakeup_cpu(genpd);
+
 	/* Reflect over the entered idle-states residency for debugfs. */
 	genpd_reflect_residency(genpd);
 
@@ -1057,7 +1127,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 		genpd_sd_counter_inc(parent);
 
 		genpd_lock_nested(parent, depth + 1);
-		ret = genpd_power_on(parent, depth + 1);
+		ret = genpd_power_on(parent, dev, depth + 1);
 		genpd_unlock(parent);
 
 		if (ret) {
@@ -1307,7 +1377,7 @@ static int genpd_runtime_resume(struct device *dev)
 
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

