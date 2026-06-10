Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290333B47F4
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081560; cv=none; b=bTvkAhF70e4ncB9AszRoelxHo4Z41ly90G4Kq25bOKTvZassw9/jeERNsWVWOsEKstTPRRUF5D1992RtuO2lMYCSbqAPhECT5BnRIcXDPKi2xPd/j2lmc4gPVR9LV5ZMcw8Kd5DEYaLlDkihylIv2tZMavPOZSKg79NGmp/x0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081560; c=relaxed/simple;
	bh=2KPY/tb0j+B5uSdY7N7v5/p0YXBtB2vvdjKahaGisRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJ9Hh+JzK4JLW9yDQBsKew/XYt2UYRCRt+jMOhFRnLi5sZxd5i1c/EoXxu5OO9pW1dziSMnhj5+QtrbiyVFxUMC8uXo9YWYdrh2LPNz6ryZvlO11y/WMa09FZ9S6XFtYj5wFfj/dYvuvJZx+Aq4V50bWBTNP1NeCxmpYLgf084Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TxrWFFvF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KTMzi+tG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TxrWFFvF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KTMzi+tG"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7icBS867718
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y0iynm1FGGwaEZbCphFRzeTZeB6sDyUBvZZjPoxKx0w=; b=TxrWFFvFkcs/YfxV
	/0pe4JLFXoZxkei0Ua3E1sW25CT+OKE+bbqD3kT8X50EYCSXCx7/ChseUa+BB93T
	NTk2XWguoKVhQpPLrRFepx2/w64a+WXVHZDppjzpFADT+1J5kuYpeLQMSi/mJAlf
	LrUDrX+vmdoPRL6y2S0ukEDOYRplJWXoNF+w4SNdQTD0Z5k43tjdr8+JwxWMq6ss
	kufLPHRWN3IfsAjW+LadA2zveZs/2QGcCCZOOpRJipY4on6Lht+8a7KlFLLP0wFt
	bXZ0R+1IJxL99Up0ygwb3Zq7pNN1Wz71d9LwZtfp/fZUpPO4t13sVmTZ8h+2M4OR
	N+pZyQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0kd9080-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:52:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso67318365ad.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781081557; x=1781686357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0iynm1FGGwaEZbCphFRzeTZeB6sDyUBvZZjPoxKx0w=;
        b=KTMzi+tGnWoqNGDyXTpqwy6TTC/4WlTnNxXKibPjIGaM2C4c6GnigbMjTQVtjNNnT8
         WEkzE41cMjLAUCkudQ1QAO/4lVul5Y8Ih0G/vUjGIOljK7EkWtk/xwmANsA1+ObWv1TN
         ErqkmG/arTGSTvbF7PIFIx0VlF3+xZqPwxJdM1FyZ/FtVkd3PtCGe8b0UioFPBx0xHU4
         VCh8HRZ721cpzpLcyxGSbb0G0rsNqkgnNt0m4TGFpQ+/Oz0tdHjPRqB+z2xQKZbDZ54z
         L3Y1R8+toxN80dLAi8ttSNRUNIK+Nvip7dK/7m6qyFbir0NNsKKkdEuF6uUe6X5GNabC
         Kmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781081557; x=1781686357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y0iynm1FGGwaEZbCphFRzeTZeB6sDyUBvZZjPoxKx0w=;
        b=OdX/R/5wKaQibnWsbqE1eyN05cMyEdpImxBUtYaYPnG1CNBF8K5PrzJ96k4SRmX7mi
         z9DEZRC4wUxWZsfnw8i4Wbs7IHc84CbLdiEBwv0t4a8KqkxbhA/+KnxFJ3j33msOyYNX
         cOTj86hjdqWa2xjRqowDNZOolzOAynFJbwZiUaieSp1IEGfyK80KNPTNp5SnUkmEp1QB
         qzRr9IAv58KFu1O/EhRB8TTrcOfKzvTH4nhvzYQSkVIs1wtgMWP5HQxLtqTBa/7g1/8G
         ms+JzY8BLDmCmDf7ytenRzVmV0t6a2iKpb8G1wC8lmRBPYGPc4v2wAC0eTw4b9c6VJHx
         zHQw==
X-Forwarded-Encrypted: i=1; AFNElJ+VcntNMygDtXbEuwtIVMFz3ZgrCZXUNjGAa/5qIMD3Ezygbn0mICdtJaSKRZrdvE24hQIEGK8LwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSP5Adk3ubYxgpYlbAhEOCzHMqX3AEy03ZW2aboGD5A3+BStS3
	Oenq0b07UAlT6wjx5N9d9vsP9xDAmY/LlYgGSwpBJNxx7rEhN5KIUJ69PFVC1dEaFDglr7LxaoF
	sGSCm3iM4Rl3V1Qb5VH/C90+WdyIQ1wpkUePHRB3xW4QNl0I1P/cJ3ugZ5UME4g==
X-Gm-Gg: Acq92OFdl985J/9BW3/IvtG9a7tZuRoVelkWU6RMOXv/5RQfAVkZenHXRnCJbm63NRP
	i6kuKJqFQtpIIVwvf74f0Oi3DTALpm9tNtDoQ/plfR7ZK7mh8H+aHnLYJMGLJ/7HTxIDRdsuIcI
	0xs7G+5yTsi9yj2KsOm35I257CdbsN9yn5w/EPd6wSnXLuoAvcvm3tRLQWngIWmCigSKSnJXQwi
	0HKiVzoyxa+c1d0dw9mPWDDpVN5SOqhavVAzvRsKrtnktZ2iWZdvc1fHs71weJSJocDINrjtrbO
	/oo66T+wJMXHV3MLdyd4aBaFBE2tMaNSObWh+CvpWL2zAW6ELdLji06SwpxrOIunoMAeHN+JKCQ
	9wD3hAbsox3XEWnyLzVAeRIYDWr+3EXCN3drUoHVV6/kEDp7YqIuWSf+paCPHuZumKkP7+14hOM
	k57n+s2A/WhV+1u1mPtGLQ7WaWXAKvUnFBfydXTeuPi5BWU62tPXakGDyn0pk=
X-Received: by 2002:a17:902:fc48:b0:2bf:23ad:8595 with SMTP id d9443c01a7336-2c1e78e4f0emr297477655ad.4.1781081556859;
        Wed, 10 Jun 2026 01:52:36 -0700 (PDT)
X-Received: by 2002:a17:902:fc48:b0:2bf:23ad:8595 with SMTP id d9443c01a7336-2c1e78e4f0emr297477305ad.4.1781081556405;
        Wed, 10 Jun 2026 01:52:36 -0700 (PDT)
Received: from hu-ppapaniy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edc8acasm114618175ad.45.2026.06.10.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:52:36 -0700 (PDT)
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 14:21:33 +0530
Subject: [PATCH RFC v7 6/9] PM / devfreq: Add a governor for tracking
 remote device frequencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-rfc_v7_scmi_memlat-v7-6-f3f68c608f25@oss.qualcomm.com>
References: <20260610-rfc_v7_scmi_memlat-v7-0-f3f68c608f25@oss.qualcomm.com>
In-Reply-To: <20260610-rfc_v7_scmi_memlat-v7-0-f3f68c608f25@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781081505; l=4893;
 i=pragnesh.papaniya@oss.qualcomm.com; s=20260120; h=from:subject:message-id;
 bh=xZowMXSIo/yjYoix7dfxNcBQFvLyEboivbRIq1BkEFU=;
 b=XGGVsmcuQqsb7xxvF7kkpvKNz7arqGm5Q77SCmhmuZWxjWFRBwfyljemBijVv02n419Asznfo
 ce5/XapDYe0BqR8iEbYjxr25/B4xeON8mbI0zhXc5GM+c20jwuEccS4
X-Developer-Key: i=pragnesh.papaniya@oss.qualcomm.com; a=ed25519;
 pk=09P9nFmZLXJ9+4Jx10ZK5rIW0Fmk79A/DLErm6aVA0c=
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a2925d6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=DkxomDJNIKAFLi0tgcIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: aZgedB6eFwmrIINFmEgiwwnxP19Q6N0r
X-Proofpoint-ORIG-GUID: aZgedB6eFwmrIINFmEgiwwnxP19Q6N0r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4MyBTYWx0ZWRfX0mM8TGaMQxl9
 b7LnMODDpY77kEzhXF37NceIL387RbonQDUG2kwX5J38cDwWq0DSUH54u857kRUj2XYnjO210x3
 Se0YiOg6yPYMkKeyO1+vXEDxg2noIKyNkYuAJfetNeLAkXTjS6t/DU5gMGFTSi9MGYFtmUrrQxB
 nwi0cJMS5jFEsBmggUDJmmsVSAiDc7QTJwVAcWrNeNyw0bbLxrHx0EyAC9fswG/jhPAgtMysPSV
 BNf8h3v2+zoro2L70v+D9WdIpZ2tuh2VDuyVd41OWJqYxSnFfOmJJDRLRw57CwjuBJ43WLlwPuK
 9wI0tTG+w3a9lT/DHn9A1pZnU9FWpqazMzgiPVS3EwV0E9skODzjf8bujvpRKbikzWAFlhm8895
 qauO0ahVBn/GXlRzwOaSqrpN4rndRY9NIt32f/VRdbNUeA/+HjZFeL1EHAW5/8f3jnhfqBLUPQK
 AujWrVjKaYg8HpIqzBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100083

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

On SoCs where the governor and the mechanism to control the frequency
for devices like caches is hosted on the System Control Processor
(SCP), there exists a need to track the frequency changes in a
reliable way and provide ways to tweak parameters on the remote
governor.

Add a new "remote" devfreq governor that uses the track_remote
flag to expose the remote device's frequency to userspace via
trans_stat. The governor deliberately does not advertise the
DEVFREQ_GOV_ATTR_TARGET_FREQ attribute since the kernel cannot
set the frequency on a remote-managed device; reads of the
target_freq sysfs node therefore return -EINVAL.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
---
 drivers/devfreq/Kconfig           |  8 +++++
 drivers/devfreq/Makefile          |  1 +
 drivers/devfreq/governor_remote.c | 73 +++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h           |  1 +
 4 files changed, 83 insertions(+)

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
index 000000000000..df3819757e56
--- /dev/null
+++ b/drivers/devfreq/governor_remote.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/devfreq.h>
+#include <linux/devfreq-governor.h>
+
+static int devfreq_remote_track_func(struct devfreq *devfreq, unsigned long *freq)
+{
+	if (!devfreq->profile->get_cur_freq)
+		return -ENXIO;
+
+	return devfreq->profile->get_cur_freq(devfreq->dev.parent, freq);
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
+		pr_err("%s: failed to remove governor %d\n", __func__, ret);
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

