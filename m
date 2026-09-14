Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531B47FB14
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398126; cv=none; b=Ic2jzA86x55ASpJBQg6BuWKtWsBxyRUcv/5RF7eWLL3LQCYvceb1xx0QgmIk6FD1K+PoxMUFUp5qcdgU9kmBRA/2bWkYbnXOquRd4uOzmYvjFCuQwFZ6t0zRuJVhTtGSVCzBCJq9ERx9F5rqMkLOD2PNjQG0V3O6D8xP/KXKFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398126; c=relaxed/simple;
	bh=+9ewyErakjiMv+XulshtUrNOZeuqyR5bAcwr2UTRCIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAk7rcwUTZtHnAwcJYvLwt2ddWWM+KSLXk95T6qztPQm0gZtigKV26ui2yblXW6F49V+i7s7Ha7KVB6+6tDjFv0IL+3G+u70cseYNuJXCBX/52k1qJT1VMep0aS7Wj3+3TAfwXrOQgqniQSLG0gCWJgQaGjXdAeUUtsTcmdAajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R3D4A7tR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kEPUhY+6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R3D4A7tR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kEPUhY+6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0QxD1761276
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RLdSqd1j1OI
	9R1VCLztteaDRbyZgd0G1W+hidlStvuM=; b=R3D4A7tR5d6I3rYhPblK/7F13xj
	AtTzyHRvih+2EcXm6uSQ0JMN8fWKau31PjhjVP1fKuVn4NZabhznAjLY/fZIjEwq
	xb13o10X7gO5PBKmqw5k32+A6sMnNShAKY2i3/aZokrEzkIrePrwASc3rpvVTSgz
	6NUa5hwLodYARnjnafLyNTAGxx8cGN6mmnng1XaB+FmV8lauRVKzYpBk3/CYtIfE
	9dAm3ZxGus/ox0z7V9dPmxHfs3hGhD/wrXxw7LfrdWxmBJ+Y+oFHdlBzrGV9jbTA
	ald+qtSAfzIPTBIbh7gnCPD5DwNqBTJtONRzYM8fEMYcUR21v0lyu5huWNw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeex98m9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:02:01 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6c34cd4bffbso1090571eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789398121; x=1790002921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLdSqd1j1OI9R1VCLztteaDRbyZgd0G1W+hidlStvuM=;
        b=kEPUhY+6iipsRWYmewi/lJlewgGGx8A3kTcDuXk6By7p6Y1A0IukXFOu6bON8x2gra
         dHc7h29OCvSxRR57HOlL0Ea2arEI+S8cBuZf0cxuKEq5+bNtXfK6umdKat+w89zSRxMb
         jycO5rgta3KUR6C8dhlIfxHXxlMjaBJSYzY58Z2yght5w0QnB33JdtZe9xu0sAmRk+zx
         5TXmQ0W0plU8h+3Qv7GPvihEYs2j32f88eZto6TCi6yZ2zLxuVGKJYvjPTl3tVmh8vfT
         nzU0ZfNzQhZHxG8j640joVh/hNnN6yp39vDO519gqnSMfhv7jq7sI69WG7JiBKTYbkmc
         c3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789398121; x=1790002921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RLdSqd1j1OI9R1VCLztteaDRbyZgd0G1W+hidlStvuM=;
        b=AWflmngzOFSjqTxBcYDPXVHuJ87vZ9BbIAx5YsBrAOFG3e6GreR8yoEpNSDM2fi+6D
         CumsNEATSN+LCspoxDi+VFDHVWj8PbFlucJ0igo/qndlbzCPJdwHov8/Pi7slfNRXkw3
         H92TwAZYGVDRarsJpcqBGzRakXuRG1xG/42/u4J62UFip++dsakjw69TNar+CS66rOPu
         J467FcM2mV44LB9sLp2IsuMEWhFiL6ov+Zc1rH6075kf4o8QEw7cJTNWOU+KEfNIaqAM
         2XJfdPqW0uDip9QPi3q6q18HObRcXiunsfZdnqvgW5uOgTnsnXQ1dHIa9/Lq7YCtwD/k
         HAbA==
X-Forwarded-Encrypted: i=1; AKwUvBwJ7zuYCnu8q9egYPqfaHULr0HVK3EOnUsv7DQ66zYrS4EjcMYDouz7eqy8f8X54FMXZwAbtzH3BQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nocGlDnFDPuxnrJWuJRpT7nEi9dRTP7VHWwIFDPq4J9aEU01qt
	hQVm9lL/kPunWUF4lYq40ol1McTaaFFFBYr/0t2UUyfs/6A2mfW2WMk6jSsMhF2msymj9W4Z4RZ
	XopRpNPiFITLfQTB5oiLwWYQQrWyImBquIR8nTX9jIrfw5GlaMcdbdF7j1NjNwA==
X-Gm-Gg: AYBFou0YqyoYgEfptOXs1PH95kpuZTZLIkJehZeeQvYkRPbEQcgNrPjHJbjmaAgfLs/
	TijI6ZKy4erz2hN31SfspHCOKc4HKUZWJNyUVD7mC34KO6ROg2VNbX3+DJKlY8RldM571l/2cPw
	tmnboF5qhjUJCxpKdPvnGelxgn8fKzF/aG7NEDsNXdjk6tH7pBRStUOhCVI0GNvCiinnUaTJ0Un
	84s+AQohgWkgJRoPdak7pdM4mULhL9d1llWVGap/vJSzhQeh4DtR4cSmmQEg9TcjfZ5aA4oWqhP
	yiGaEIshXS5327UodxCSnRqr03vSFeURhOz4x9qcGM+xrTUdt0tJL14IsRe4dTCPQv0yK6EBjE+
	JM+bf1BpCwjMXl/BNc5IU2kXzNYsMz/vMJpt+miPpQ/gqZ+TKzSBQSlGpXA==
X-Received: by 2002:a05:6820:4b91:b0:6b7:8396:f3cf with SMTP id 006d021491bc7-6c541b451edmr1405292eaf.49.1789398120171;
        Mon, 14 Sep 2026 08:02:00 -0700 (PDT)
X-Received: by 2002:a05:6820:4b91:b0:6b7:8396:f3cf with SMTP id 006d021491bc7-6c541b451edmr1405146eaf.49.1789398118846;
        Mon, 14 Sep 2026 08:01:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296608480esm468632666b.36.2026.09.14.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:01:57 -0700 (PDT)
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
Subject: [PATCH v4 2/5] pmdomain: core: Allow a non-CPU device in a CPU PM domain to do power on
Date: Mon, 14 Sep 2026 17:01:38 +0200
Message-ID: <20260914150146.187622-3-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914150146.187622-1-ulf.hansson@oss.qualcomm.com>
References: <20260914150146.187622-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfXyDDBIcXubzML
 eBwaBRfgWHfUiKejqwPbQdXSUhhBwFgxajoD+jOFKtzcg61hxctTwZfpqyqcuUA3i2QrjqfPyGA
 NemzfbJ0Q1I+iqeKHmwCDH/LgqLy/iQYi9dJBWE4FJwolL487FqAEYjEnuyXsZYXNHbEix7286V
 bMThJx8RDMCfAY9Z8Y0UtoEV4I5fUB/x779K8ZCeUJfg9ALV0NOTGTeN6i+SGwo0l3QUoZquvZg
 sn5qXpUJLy8qewTWWjCUWTcEy/lPrLw1wTos2//Re249iEd8WARW1Fe562REvzBpNsSUB0i3T0d
 CyAQ/SSJacQd9dyRSI1Cwpt7mIk/QMvE3WH9U4xu6FVLehHU5fHXDcnlVmGL7GPiQv3YgrvCIBC
 mCQayUNDrgLPLWQV46sd76BkIXBt1+7pkyU0NChV6lwE5SPa11y6qAdAVKDKMZCnUdGditqpOIQ
 NtO0x4l4E3haa9Kr89Q==
X-Proofpoint-GUID: 3yLJ8rBReKE2dn4dgLH_GslxPAuXjKs_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIxNSBTYWx0ZWRfX5qgK2E7qlWwz
 IcKdYnsv750C+mV+PTTlbzpTS5fgpHVWi6p6SabhfPUKwAbJ/PlpmjgxlpW0YfpD5vQClS/q5KC
 sWyEe8Wtd/TMvY0/VO8mbUj6hOxgeRI=
X-Proofpoint-ORIG-GUID: 3yLJ8rBReKE2dn4dgLH_GslxPAuXjKs_
X-Authority-Analysis: v=2.4 cv=MsrHeGae c=1 sm=1 tr=0 ts=6aa80c69 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=u8BtVuMVLpZXKRMe:21 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=CAA96EveQzfqUpAuUaoA:9
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140215

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
Reviewed-by: Dhruva Gole <goledhruva@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---

Changes in v4:
	- Decreased the timeout.

Changes in v3:
	- Moved to atomic polling, pointed out by Dhruva.

Changes in v2:
	- Rename a function according to Abel's suggestion.

---
 drivers/pmdomain/core.c | 80 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 6abe8b198949..c593a3479ad0 100644
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
+#define GENPD_CPU_ON_TIMEOUT_US		300000		/* 300ms */
 
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

