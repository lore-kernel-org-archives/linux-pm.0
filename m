Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738133A9DB
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135006; cv=none; b=qwyDRUJi4DfVkDwzXeZgbs9fa7MJugJAONGvtNVk/OC/Fy7oHYc1mZvmQIrtZ8otybDzyukoeTqsGaKjvgLCfWAR2+XwdhBPBY7wIQm/4KCmrwb++4gdkFWkuRh8IEeaIWa3YJPQ2lFtibPyNjM7h/MhtdJrDuLMv9ao8fQz69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135006; c=relaxed/simple;
	bh=L47y2KuTQaE82CAJC9S6eRIVru6wf2RqgaMOg1n3oLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOeAP0Jfmo5yK3o7PRY1p/P9nk45BYaxknZIojjS/MoS8nJRXFy+Vo1pnDVPNLgU60BCNfXBzy/Ofl8icAOGQ5HXpMXX+03OYNrj8xO6jXe+jxvlPPHoI6b4+Z0fs7BB31bUC5xrzHvq/rF34uWxysbQ3CLzyZmjLWWC5rnE/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M/ttAb1t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wh/7g74C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M/ttAb1t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wh/7g74C"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6473eAPe1669575
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 06:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nbCDYI3s3UP
	CGmKd4YHz++jLfH6zEuiFSirImm5jJO8=; b=M/ttAb1tG0koLpwH7pqEOVJC/bA
	sfYfYwDFxxgGDm2L8tHu9on0fvbQ17ZRNRO4/SIrhmHIfaYViLFNhi+6/RPGicKk
	d8NQK+/8+HMeLPFXaKSaCYh0IZGxa5I97Ja0mIAZ2a7ZUQ9OmCW2ERn6NGp6spa9
	QxIzbL3tZqDA7J1HJJ+SNlQqH3Vcez/nxic9aMFGA7A0C7G62sZY7dJwUDpZcEiZ
	ijVeAHYYUW+JUHuq2Wjz6FrDPu3ozhKThGHOifrHDzdzcbyGUo06o3Jc/uOnx8Bc
	VXUsBLoDWLtruC5U0cw0B5EYZeVyJEjSoOcx9/pJ2kvQ56CEH7XoCQzhD0A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1p0g0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 06:23:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f85179263so471774b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 23:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778135004; x=1778739804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbCDYI3s3UPCGmKd4YHz++jLfH6zEuiFSirImm5jJO8=;
        b=Wh/7g74CkpPPOL8XYtAHudk80Z2I+vfJtAXJGLO4C+JDehTLPkPcTH8v0/kMts8l3Q
         G63mEx6Lg796firHi/OLtheIIfVPDREZ1ctpmftyobiZ1SctfgL/62+I8Jl2EEKjHqSC
         AxmXZUZkLjUbRcDZIvFUK+QpFEnBNcT9Gwz5+gj1YK453KrokmyUBmskh6+d9vK0LXCg
         OcZTkYq2ogIi8mRBeGstjRQ1riSCUZu9dE0qILxXTRAulLJ0GZdLH0dKcBvR1qY2hBnN
         nXoEEA4UrD9LvVJRsBmmkEZju4qLFEwKrV1RN4dP0ouf40alm+XWc5a0km5xuhGQqZC9
         LfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778135004; x=1778739804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbCDYI3s3UPCGmKd4YHz++jLfH6zEuiFSirImm5jJO8=;
        b=Cr+/fP8ou4kopABUnHP/+a/Bex0Tf57RKsZ8n6AbdSZ5F/1nDZ4oMg3DvcuzX1ctBI
         ZOU1LizaCJcrtIX3CUt6IeaDbnWkwURwsflqwc3fWbNvvsPBdmXZEn8K5plU4mXZuAeb
         foV0w6KNqFi5fDKYO6urAO9TaWA5MaqA00kAQUaql1kgA9pNdOK6D7ClEX7nvSFq04PS
         A/HWxK5d9A5lW9FLUz9AsU2eOogBtUd3rNINEHEY9mF9j0eThLvrydHdVGAOlL5pT70G
         SMzAsqP5ucdtTkSTQHC8pnpiTVCmqhJ1bk3TW6nfHreL5tEq8rl4vd/Pp5NxhJ1SsMO0
         Reuw==
X-Forwarded-Encrypted: i=1; AFNElJ/JdaC824fDI6eZT9VDW+z1rTN1jIemCy/mYUwlCF6wakZLLI2SRBsvG93Tq0746G/Zojp/Wv8PuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKf4B5qzya+U5gS36hG+Jx0r14hf8k//Z9XnrUvTLvc/ewj85
	tvMGkTRU7YybitZlnKQAnaYtv7kLiP8DMN7NH2mB6b4OBzOMdaUSXeKEyfuHKBpRCar6aQoHdGu
	1EbaouE7NJkQvd8j43gZjdls+ZJyD+eNk3DrIIZLb5ayQwV02ckSvktVGwaatLg==
X-Gm-Gg: AeBDieso1oXf1r8g5AUaD7zkLyvlBkLVahKVTvZoQXlAkTT/1nF98HUF+Pd+5+xzT8v
	dlKePHp+EqeB0gDCEeIwstyqW8CKOVlWg0M90EHA2c1cXu9zUkaQIoEyGYzxu6Lqz8Ke1+iH7u9
	0RF/FKSlRvVRhB4JspfXwdgysVuYeyn+HkTZNOCpnpHWQT4ItwHn0l3OOOPjrjuoaNA7xJhQP9X
	ZgvbG9JORqCnKzjuJJaGy2RZa44A0qtKjeF0L3C7R/q5RYNHFhUkag6zJ4qG3OEBmSFz9Wdkp+k
	i0ONgTkVzgAU1m/d88oK0JcT8hs6WsPfzpl3eqSJFJBo9AeQd/TYBQm0F2AYpizBV49geQbyeO+
	yDj/nAmx+368LMwLe4sfVZ3cNSczAvSxgZFw3Mhns1CZ8B6EgC3jdB8X/VcVxgncNQ1bkaZDzog
	xNacOj3zZT05YnGPca63ihGUZSuiNkGhKd1mgSQpITfyquwDk=
X-Received: by 2002:a05:6a00:3918:b0:82f:7bec:2050 with SMTP id d2e1a72fcca58-83a5e550f4fmr6139014b3a.39.1778135003824;
        Wed, 06 May 2026 23:23:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:3918:b0:82f:7bec:2050 with SMTP id d2e1a72fcca58-83a5e550f4fmr6138963b3a.39.1778135003284;
        Wed, 06 May 2026 23:23:23 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 23:23:22 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        konradybcio@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        jonathanh@nvidia.com, thierry.reding@kernel.org, digetx@gmail.com,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: [RFC V6 5/8] PM / devfreq: Add a governor for tracking remote device frequencies
Date: Thu,  7 May 2026 11:52:34 +0530
Message-Id: <20260507062237.78051-6-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfXzJte/+9z3r/C
 5IDp6TT1uWQrLXryCIGoOseOo3Zj972nQg0Sgs8lUFNvjHy0lABHv2F0ou5X58paR4B2kY3Kh07
 zg1V7ckLGGZ96M3UGuJd7QPWsjAK7yfpF8bFzNMIAUiI2TIc9ODBHgRoapC+4oFRIwUEssKApau
 cWiAUhDEq51hYOBfobspSjSvdcKmS1wn5DWJLfmUE7WYyMeE3heNuv9ojY8O5w31g0wqkNpqR4R
 xnSmTkFGyee9T5LlmMXUBXduSc4IWOj8deOazfIGFW4B981k12azBASSGTHnTA20RnJEkuBseO9
 6hIJJDwVPM51chHFi/D0FSM08waghz2z1NwBfYagxXq6Dk2J0PZrmmVDwole+cwaUjdHyL5Wcua
 0z97yljVqv7trh2mYlDaHj8srvsG5SYo3gyUzJI6uAdcfgcdOw7Vq3HZP0D4G3DAA7ppMkeVjjy
 i9yNL7XbF2Yfy5d91Dg==
X-Proofpoint-GUID: ev5zj1ZWiEbj-WzZGR5X4LtJGirtXXtO
X-Proofpoint-ORIG-GUID: ev5zj1ZWiEbj-WzZGR5X4LtJGirtXXtO
X-Authority-Analysis: v=2.4 cv=K4IS2SWI c=1 sm=1 tr=0 ts=69fc2fdc cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=4aD_1Snzd4jiIFQuHjIA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070060

On SoCs, where the governor and the mechanism to control the frequency for
devices like caches is hosted on the System Control Processor (SCP), there
exists a need track the frequency changes in a reliable way and provide
ways to tweaking parameters on the remote governor.

To address this introduce the new remote devfreq governor that provides for
a way to track the frequency changes on remote devices. It uses the newly
introduced target_freq attribute flag and track_remote flag to achieve
this.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 drivers/devfreq/Kconfig           |  8 ++++
 drivers/devfreq/Makefile          |  1 +
 drivers/devfreq/governor_remote.c | 80 +++++++++++++++++++++++++++++++
 include/linux/devfreq.h           |  1 +
 4 files changed, 90 insertions(+)
 create mode 100644 drivers/devfreq/governor_remote.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index c999c4a1e567..2caa87554914 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -56,6 +56,14 @@ config DEVFREQ_GOV_POWERSAVE
 	  the DEVFREQ framework returns the lowest frequency available
 	  at any time.
 
+config DEVFREQ_GOV_REMOTE
+	tristate "Remote"
+	help
+	  A simple governor to track the frequency of devices whose
+	  dvfs control lies outside the kernel. This governor acts
+	  as an observer and provides for ways to track frequency and
+	  set/get information related to the remote dvfs device.
+
 config DEVFREQ_GOV_USERSPACE
 	tristate "Userspace"
 	help
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 404179d79a9d..cde57c8cda76 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PM_DEVFREQ_EVENT)	+= devfreq-event.o
 obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)	+= governor_simpleondemand.o
 obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+= governor_performance.o
 obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
+obj-$(CONFIG_DEVFREQ_GOV_REMOTE)	+= governor_remote.o
 obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
 obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 
diff --git a/drivers/devfreq/governor_remote.c b/drivers/devfreq/governor_remote.c
new file mode 100644
index 000000000000..6bff3cdaf1e5
--- /dev/null
+++ b/drivers/devfreq/governor_remote.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/devfreq.h>
+#include <linux/devfreq-governor.h>
+
+static int devfreq_remote_track_func(struct devfreq *devfreq, unsigned long *freq)
+{
+	unsigned long cur_freq = 0;
+
+	if (devfreq->profile->get_cur_freq)
+		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
+
+	*freq = cur_freq;
+
+	return 0;
+}
+
+static int devfreq_remote_track_handler(struct devfreq *devfreq, unsigned int event, void *data)
+{
+	switch (event) {
+	case DEVFREQ_GOV_START:
+		devfreq_monitor_start(devfreq);
+		break;
+
+	case DEVFREQ_GOV_STOP:
+		devfreq_monitor_stop(devfreq);
+		break;
+
+	case DEVFREQ_GOV_UPDATE_INTERVAL:
+		devfreq_update_interval(devfreq, (unsigned int *)data);
+		break;
+
+	case DEVFREQ_GOV_SUSPEND:
+		devfreq_monitor_suspend(devfreq);
+		break;
+
+	case DEVFREQ_GOV_RESUME:
+		devfreq_monitor_resume(devfreq);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct devfreq_governor devfreq_remote_track = {
+	.name = DEVFREQ_GOV_REMOTE,
+	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL
+		| DEVFREQ_GOV_ATTR_TIMER,
+	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE
+		| DEVFREQ_GOV_FLAG_TRACK_REMOTE,
+	.get_target_freq = devfreq_remote_track_func,
+	.event_handler = devfreq_remote_track_handler,
+};
+
+static int __init devfreq_remote_track_init(void)
+{
+	return devfreq_add_governor(&devfreq_remote_track);
+}
+subsys_initcall(devfreq_remote_track_init);
+
+static void __exit devfreq_remote_track_exit(void)
+{
+	int ret;
+
+	ret = devfreq_remove_governor(&devfreq_remote_track);
+	if (ret)
+		pr_err("%s: failed remove governor %d\n", __func__, ret);
+}
+module_exit(devfreq_remote_track_exit);
+
+MODULE_DESCRIPTION("DEVFREQ Remote Tracking governor");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index dc1075dc3446..4d50cf230950 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -21,6 +21,7 @@
 #define DEVFREQ_GOV_POWERSAVE		"powersave"
 #define DEVFREQ_GOV_USERSPACE		"userspace"
 #define DEVFREQ_GOV_PASSIVE		"passive"
+#define DEVFREQ_GOV_REMOTE		"remote"
 
 /* DEVFREQ notifier interface */
 #define DEVFREQ_TRANSITION_NOTIFIER	(0)
-- 
2.34.1

