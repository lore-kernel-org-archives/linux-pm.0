Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E7B42901C
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014143; cv=none; b=iFRmS+PcwA6w9VcsuvgJGTQNddGkMP/6xu+Fw3hEaQbOHKLLbbHuLwKRvViMgP+bRDWxtGo6MjK76WPuTBA+mcNJQ778vt8Ad9Wely881Ivyb/vzTyV8gkvNHLojwFPaHAGrCY9kzEcfrjHO215GD+Br1NAcA9/AFXNdmBrelrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014143; c=relaxed/simple;
	bh=8lt42/buAHFphD/X2Ubb5FOVWRvH0w8Fo9mbigYmOzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjLORxvky6wf+EDbBM2xB8awTRkz0K9wtwD+Nplrq0fN2bXvROItErj/nBaq0qds3wop7EKVEChJX3lDPjGb/Vx1XOvnA9FM0S1jVY32x5qGAdy40isK1vXQgXANItSCPuXCUksTHD/VI+FdXwYSeTHfZr7Ugz/cfXkJqL5msvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RvXhU4m3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WUHPnysC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RvXhU4m3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WUHPnysC"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nlpj1579059
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 11:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=OQ2LB/2wLJ9
	xLA2vO6RiQF0IzMe+r6MJZcfrmV+gTOg=; b=RvXhU4m3/0kALrH0zjqfvUiOl8a
	rD3fMYbsUQuOUqz0clSaoAcxIY1VucRyjvytMx/ak1KZV7kUOTWPOqLOZP6SfmV/
	oMugcgRozjN5KRHVuformVW2vInx8DbWe3ZJLw4LxeaLjZ9kfb9OI4Z+DtrSHMoV
	VT9eKjsHwTgrVA5Lf2D5kr/15gOA33xD9aFPf39EBInxIRf1c+r+y+W8U9mxw67l
	/WtKYvV3y32YYDERi7/Ku+AMYNZfAD4NXXAX77bwrQdEt8L42Mw6Ue8TRSRtgBJv
	0iH3sRo2dcG926ONPOlqjliHsCQ72rlgCJOhju7m96uzzi9kC9lajl1HxxQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvju8hpjy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 11:02:19 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-82014436716so56386517b3.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786014139; x=1786618939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OQ2LB/2wLJ9xLA2vO6RiQF0IzMe+r6MJZcfrmV+gTOg=;
        b=WUHPnysCaGADE3APCSnEBYdk/Ii6vciaM2Eixdxo3O0leEmb3FeaSjDq4vJi5FMdU2
         w8dz8eF7NEnd8Pg60xiImOKGw86EaDODhdzGDYkxquBa1wgl6HuLBacX/FO+GrpJG8p8
         RrnqVRlpzexP+BZUSdgH8v3/nqV7/tOlUuVIaj548eYibSN280h4qxiyaPjLSIBnTbwY
         fw3onX2TeigPma8NyuYrocMlWtQpq/Pe1aUeSrpnVGQGZBxTzX4OfctgmO2WM2ReoQHP
         ZoDs+HznD4h2v+N/cFxXjSo7sljY4jiYtr/M4OSgM7cl89HEzrkvY8svR3dTpW+inDIU
         SW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014139; x=1786618939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OQ2LB/2wLJ9xLA2vO6RiQF0IzMe+r6MJZcfrmV+gTOg=;
        b=c06AhyihwzBH+MZIlgUpHiqhr/IhmS7saA6BoiR8piSvJ4+MXarca836Y60qipRocS
         mlee5z26jX6gFbvY2gaxMPsLMuHSEpvf3knfVjmgWvhTeRsOOcf6p0LGJMXtQPBuOI24
         xt1n40jpjj8Wut+hWLzUtTmgGJt4WCzCiQPUJ2lXuZf2v+NyGagYUeMkhaz8mJ9U6Cpc
         x+LxtdT0KJI78KkjfSwx3xiVl8L5sL2LAC8OHPFmMlr2q4fhtFRyhzhsdGRHAfNwuoma
         iRkMznQmAFf4UrvZvNMFgltxNQVxTl5+G2zXe3do6O9sf+/j5H7rdqQbvRkl2iWeKSkG
         jsoQ==
X-Gm-Message-State: AOJu0YxvHQlWV25Aw61ACb/RkqoYBtLT0heueJRkUctvcnJDYSzgHoPc
	19fnVfREnKDJeEoPRidGrpzvJXkXQ9u3AmsRV71Jn5mMyx+89K/hhPFmNZeI/Ezh2zfO6jg4vSG
	4eeVkqYM6JPMBzInHTFyoMxvERpzuWzOh82YjTIPgYb4DPWfR6VncTSDW8fjqKp7W7+QWHn+VKm
	Q=
X-Gm-Gg: AR+sD11LhK9WUn0zzT5QIH+llBJqtVJ34RnaRZLlFFvY2BLSbXxmQRXpPz3ts8gl6o+
	56aHnGUHOfN5NxycOwC0xQJWgFCxtVYXPf3mlRqtUnb1Fl7BnFAPQgyyavNLQMsth/HltETVj7r
	Cv6dcA2kuM4Yz8HW3Uotny+cdam8x8/RlZqwlnxpxJ/SzQo2EWCiLldRw3ZyHp/GDEj+a1u63UQ
	+FN7zWDoPcqEugBTDpGQVsg524WQITXu89Bpp1NnwY6K/Q18R4nr3hRgpbzYd/l0jovQeTr2ty2
	F+oD28h3RHKeULC/RPlEaLz6TBy3nWECtt01WC9ppUJIHJuP71TSLWyakwJxUjQyfCuPqYINuMl
	TG8GIRg9T91t7+SiYaOw=
X-Received: by 2002:a05:690c:448c:b0:809:ae5:1d2f with SMTP id 00721157ae682-8201c4895f7mr84040787b3.9.1786014138836;
        Thu, 06 Aug 2026 04:02:18 -0700 (PDT)
X-Received: by 2002:a05:690c:448c:b0:809:ae5:1d2f with SMTP id 00721157ae682-8201c4895f7mr84040527b3.9.1786014138430;
        Thu, 06 Aug 2026 04:02:18 -0700 (PDT)
Received: from juillet.lan ([2a01:cde0:108:24ed:1501:7670:a13c:4834])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820131db335sm36808917b3.3.2026.08.06.04.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:02:17 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH 2/2] selftests/powercap: Add powercap hierarchy creation API tests
Date: Thu,  6 Aug 2026 13:01:59 +0200
Message-ID: <20260806110159.69690-3-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com>
References: <20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: blNqzjHjgRDEcMbyd4x_wJW8NJDH2gWB
X-Proofpoint-ORIG-GUID: blNqzjHjgRDEcMbyd4x_wJW8NJDH2gWB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4NyBTYWx0ZWRfX04KZUv9QnpzN
 jco4Tki1MX7aq7kv6YAHvqP/lnSAjc9kSaX8P1F5K7FpBI2CvkDNKhkf9UBhw7yd2EazJC/VWkN
 h/0tXxltUUIqEZjQPBc4d96ZTtiA44D8eICjRHrp4aqySheXaRcPcis/gxbfJFaqpmKMcIgYIu0
 2dUqAOyB8F/y/SaLgPbM2hwhneQlB57S2DVp02QxIQQKiFsqlrbOx0rzEYnxQ4BPFkGxUJE2uXf
 rC8lck6OwbNuuPI5TyyUwN4sMH2xTTA7CUi6JQtPkLJCSjAM9+MC5wkoSlmF9k/ddjB2Y5AGtZr
 nm1IlnU/BfxzHhRD160s35WKCdpNKPaE9h+FxD4vvuP+Mx9uV4bdNv/WG5Pk8EWCJ73wIphVDN7
 A8yzVPWX9rYZGYPt6tj9lyPOQGoi5KRF8mB3S9gisUKSBBa85zTllh2+ytMTOqzpJzPnuPveVzC
 9jQF7Y/Zwmxzq0UGgtg==
X-Authority-Analysis: v=2.4 cv=K5cS2SWI c=1 sm=1 tr=0 ts=6a7469bb cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=xFgmAgSJGoImdcxQjNwA:9
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4NyBTYWx0ZWRfXyDKRfS3zOmMi
 YFMq9NWeurQmcxK4ZBq0qKO3Az7IRU561D4wY5bgXl0e4BVWgfAWnlXQ0cI9I2+nYQ09lfb6S0K
 E4wjsUDSkJLn/myTrDDSmyvvu4zxa2M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060087

The powercap hierarchy API introduces generic helpers to duplicate,
instantiate and destroy a complete powercap hierarchy from a static
description.

Add a kselftest exercising this API. The test builds a synthetic
powercap hierarchy composed of a package, three CPU clusters and twelve
CPUs, registers it as a powercap control type and verifies that the
expected sysfs hierarchy and attributes are created. It also validates
that the hierarchy is correctly removed when the module is unloaded.

The test consists of:

* a kernel module implementing a synthetic powercap hierarchy and
  dummy callbacks;
* a userspace kselftest script that loads the module, validates the
  exported sysfs hierarchy and attribute values, unloads the module
  and verifies that all objects have been removed.

This provides a regression test for the powercap hierarchy helpers and
their integration with the powercap core.

Cc: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/powercap/Kbuild       |   3 +
 tools/testing/selftests/powercap/Makefile     |  17 ++
 .../selftests/powercap/powercap_hierarchy.c   | 247 ++++++++++++++++++
 .../selftests/powercap/powercap_hierarchy.sh  | 118 +++++++++
 5 files changed, 386 insertions(+)
 create mode 100644 tools/testing/selftests/powercap/Kbuild
 create mode 100644 tools/testing/selftests/powercap/Makefile
 create mode 100644 tools/testing/selftests/powercap/powercap_hierarchy.c
 create mode 100755 tools/testing/selftests/powercap/powercap_hierarchy.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8d4db2241cc2..2fac671e9145 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -93,6 +93,7 @@ TARGETS += pidfd
 TARGETS += pid_namespace
 TARGETS += pipe
 TARGETS += power_supply
+TARGETS += powercap
 TARGETS += powerpc
 TARGETS += prctl
 TARGETS += proc
diff --git a/tools/testing/selftests/powercap/Kbuild b/tools/testing/selftests/powercap/Kbuild
new file mode 100644
index 000000000000..baa0d0ba9593
--- /dev/null
+++ b/tools/testing/selftests/powercap/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-m += powercap_hierarchy.o
\ No newline at end of file
diff --git a/tools/testing/selftests/powercap/Makefile b/tools/testing/selftests/powercap/Makefile
new file mode 100644
index 000000000000..210d6e6c5577
--- /dev/null
+++ b/tools/testing/selftests/powercap/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# User-space test script
+TEST_PROGS := powercap_hierarchy.sh
+
+# Kernel module built as part of the test
+TEST_FILES := powercap_hierarchy.ko
+
+KDIR ?= $(if $(O),$(O),$(realpath ../../../..))
+
+all:
+	$(MAKE) -C $(KDIR) M=$(CURDIR) modules
+
+clean:
+	$(MAKE) -C $(KDIR) M=$(CURDIR) clean
+
+include ../lib.mk
diff --git a/tools/testing/selftests/powercap/powercap_hierarchy.c b/tools/testing/selftests/powercap/powercap_hierarchy.c
new file mode 100644
index 000000000000..9531fc86aa01
--- /dev/null
+++ b/tools/testing/selftests/powercap/powercap_hierarchy.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
+ *
+ * Powercap hierarchy description test module
+ */
+#include <linux/powercap.h>
+
+struct pch_test_data {
+	int value;
+};
+
+static struct powercap_node __initdata pch_test_nodes[] = {
+	[0] = { .name = "package",
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[1] = { .name = "cluster0", .parent = &pch_test_nodes[0],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[2] = { .name = "cluster1", .parent = &pch_test_nodes[0],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[3] = { .name = "cluster2", .parent = &pch_test_nodes[0],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[4] = { .name = "cpu0", .parent = &pch_test_nodes[1],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[5] = { .name = "cpu1", .parent = &pch_test_nodes[1],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[6] = { .name = "cpu2", .parent = &pch_test_nodes[1],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[7] = { .name = "cpu3", .parent = &pch_test_nodes[1],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[8] = { .name = "cpu4", .parent = &pch_test_nodes[2],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[9] = { .name = "cpu5", .parent = &pch_test_nodes[2],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[10] = { .name = "cpu6", .parent = &pch_test_nodes[2],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[11] = { .name = "cpu7", .parent = &pch_test_nodes[2],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[12] = { .name = "cpu8", .parent = &pch_test_nodes[3],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[13] = { .name = "cpu9", .parent = &pch_test_nodes[3],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[14] = { .name = "cpu10", .parent = &pch_test_nodes[3],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+	[15] = { .name = "cpu11", .parent = &pch_test_nodes[3],
+		.data = &(struct pch_test_data) { .value = 0xDEADBEEF } },
+};
+
+static struct powercap_hierarchy __initdata pch_test_hierarchy = {
+	.nodes = pch_test_nodes,
+	.nr_nodes = ARRAY_SIZE(pch_test_nodes),
+};
+
+static struct powercap_hierarchy *hierarchy;
+
+static struct powercap_control_type *pct;
+
+struct pch_test {
+	struct powercap_zone zone;
+};
+
+static struct pch_test *to_pch_test(struct powercap_zone *pcz)
+{
+	return container_of(pcz, struct pch_test, zone);
+}
+
+static int pch_test_get_max_power_range_uw(struct powercap_zone *pcz,
+					   u64 *power_uw)
+{
+	*power_uw = 0xBADC0FFEE;
+	return 0;
+}
+
+static int pch_test_get_power_uw(struct powercap_zone *pcz,
+				 u64 *power_uw)
+{
+	*power_uw = 0xC0FFEE;
+	return 0;
+}
+
+static int pch_test_release(struct powercap_zone *pcz)
+{
+	kfree(to_pch_test(pcz));
+	return 0;
+}
+
+static const struct powercap_zone_ops pch_test_ops = {
+	.get_max_power_range_uw = pch_test_get_max_power_range_uw,
+	.get_power_uw = pch_test_get_power_uw,
+	.release = pch_test_release,
+};
+
+static int pch_test_set_power_limit_uw(struct powercap_zone *pcz,
+				       int cid, u64 power_uw)
+{
+	return 0;
+}
+
+static int pch_test_get_power_limit_uw(struct powercap_zone *pcz,
+				       int cid, u64 *power_uw)
+{
+	*power_uw = 0xDEADC0DE;
+	return 0;
+}
+
+static int pch_test_set_time_window_us(struct powercap_zone *pcz,
+				       int cid, u64 power_uw)
+{
+	return 0;
+}
+
+static int pch_test_get_time_window_us(struct powercap_zone *pcz,
+				       int cid, u64 *power_uw)
+{
+	*power_uw = 0xDEADC0DE;
+	return 0;
+}
+
+static int pch_test_get_max_power_uw(struct powercap_zone *pcz,
+				     int cid, u64 *power_uw)
+{
+	*power_uw = 0xDEADC0DE;
+	return 0;
+}
+
+static const char *pch_test_get_name(struct powercap_zone *pcz, int cid)
+{
+	return "my constraint name";
+}
+
+static const struct powercap_zone_constraint_ops pch_test_constraint_ops = {
+	.set_power_limit_uw = pch_test_set_power_limit_uw,
+	.get_power_limit_uw = pch_test_get_power_limit_uw,
+	.set_time_window_us = pch_test_set_time_window_us,
+	.get_time_window_us = pch_test_get_time_window_us,
+	.get_max_power_uw = pch_test_get_max_power_uw,
+	.get_name = pch_test_get_name,
+};
+
+static struct powercap_zone *pch_test_create(struct powercap_control_type *pct,
+					     const char *name, void *data,
+					     struct powercap_zone *parent)
+{
+	struct pch_test_data *pcht_data = data;
+	struct pch_test *pcht;
+	struct powercap_zone *pcz;
+
+	if (!pct) {
+		pr_err("Invalid NULL controller type\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!name) {
+		pr_err("Invalid NULL name\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (pcht_data->value != 0xDEADBEEF) {
+		pr_err("Invalid pcht data != 0xDEADBEEF");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pcht = kzalloc_obj(*pcht);
+	if (!pcht)
+		return ERR_PTR(-ENOMEM);
+
+	pcz = powercap_register_zone(&pcht->zone, pct, name, parent,
+				     &pch_test_ops, 1, &pch_test_constraint_ops);
+	if (IS_ERR(pcz)) {
+		pr_err("Failed to register powercap zone '%s': %ld\n",
+		       name, PTR_ERR(pcz));
+	}
+
+	return pcz;
+}
+
+static void pch_test_destroy(struct powercap_control_type *pct,
+			     struct powercap_zone *zone,
+			     void *data)
+{
+	struct pch_test_data *pcht_data = data;
+
+	if (!pct) {
+		pr_err("Invalid NULL controller type\n");
+		return;
+        }
+
+	if (!zone) {
+		pr_err("Invalid NULL zone\n");
+		return;
+        }
+
+	if (pcht_data->value != 0xDEADBEEF) {
+		pr_err("Invalid pcht data != 0xDEADBEEF");
+		return;
+        }
+
+	powercap_unregister_zone(pct, zone);
+}
+
+static int __init pch_test_init(void)
+{
+	int ret;
+
+	hierarchy = powercap_hierarchy_dup(&pch_test_hierarchy);
+	if (IS_ERR(hierarchy)) {
+		ret = PTR_ERR(hierarchy);
+		pr_err("Failed to dup the hierarchy: %d\n", ret);
+		return ret;
+	}
+
+	pct = powercap_register_control_type(NULL, "powercap-test", NULL);
+	if (IS_ERR(pct)) {
+		ret = PTR_ERR(pct);
+		pr_err("Failed to register control type: %d\n", ret);
+		goto out_free_hierarchy;
+	}
+
+	ret = powercap_hierarchy_create(pct, hierarchy, pch_test_create, pch_test_destroy);
+	if (ret) {
+		pr_err("Failed to create the hierarchy: %d\n", ret);
+		goto out_unregister_pct;
+	}
+
+	return 0;
+
+out_unregister_pct:
+	powercap_unregister_control_type(pct);
+out_free_hierarchy:
+	powercap_hierarchy_free(hierarchy);
+	return ret;
+}
+module_init(pch_test_init);
+
+static void __exit pch_test_exit(void)
+{
+	powercap_hierarchy_destroy(pct, hierarchy, pch_test_destroy);
+	powercap_hierarchy_free(hierarchy);
+	powercap_unregister_control_type(pct);
+}
+module_exit(pch_test_exit);
+
+MODULE_DESCRIPTION("Powercap hierarchy test driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@oss.qualcomm.com");
+
diff --git a/tools/testing/selftests/powercap/powercap_hierarchy.sh b/tools/testing/selftests/powercap/powercap_hierarchy.sh
new file mode 100755
index 000000000000..eb070181ca89
--- /dev/null
+++ b/tools/testing/selftests/powercap/powercap_hierarchy.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+ksft_pass=0
+ksft_fail=1
+ksft_skip=4
+
+MODULE=powercap_hierarchy
+CONTROL=powercap-test
+SYSFS=/sys/devices/virtual/powercap/$CONTROL
+
+fail()
+{
+	echo "FAIL: $*"
+	exit $ksft_fail
+}
+
+skip()
+{
+	echo "SKIP: $*"
+	exit $ksft_skip
+}
+
+cleanup()
+{
+	if lsmod | grep -q "^${MODULE}\b"; then
+		if ! rmmod "$MODULE"; then
+			echo "WARNING: failed to unload $MODULE"
+		fi
+	fi
+}
+
+trap cleanup EXIT INT TERM
+
+[ "$(id -u)" -eq 0 ] || skip "must be run as root"
+
+insmod ./powercap_hierarchy.ko || fail "failed to load module"
+
+[ -d "$SYSFS" ] || fail "missing $SYSFS"
+
+check_zone()
+{
+	zone=$1
+
+	[ -f "$zone/name" ] || fail "$zone/name missing"
+
+	[ -f "$zone/power_uw" ] || \
+		fail "$zone/power_uw missing"
+
+	[ -f "$zone/max_power_range_uw" ] || \
+		fail "$zone/max_power_range_uw missing"
+
+	power=$(cat "$zone/power_uw")
+	[ "$power" = "12648430" ] || \
+		fail "$zone: unexpected power_uw ($power)"
+
+	max=$(cat "$zone/max_power_range_uw")
+	[ "$max" = "50159747054" ] || \
+		fail "$zone: unexpected max_power_range_uw ($max)"
+
+	constraint="$zone/constraint_0"
+
+	name=$(cat "$constraint""_name")
+	[ "$name" = "my constraint name" ] || \
+		fail "$constraint: bad constraint name"
+
+	pl=$(cat "$constraint""_power_limit_uw")
+	[ "$pl" = "3735929054" ] || \
+		fail "$constraint: bad power limit"
+
+	mp=$(cat "$constraint""_max_power_uw")
+	[ "$mp" = "3735929054" ] || \
+		fail "$constraint: bad max power"
+}
+
+zones=0
+
+find "$SYSFS" -type f -name name | while read namefile
+do
+	zone=$(dirname "$namefile")
+
+	case "$zone" in
+		*/constraint_*)
+			continue
+			;;
+	esac
+
+	check_zone "$zone"
+
+	zones=$((zones + 1))
+done
+
+#
+# Count the number of powercap zones.
+#
+count=$(find "$SYSFS" -type f -name name | \
+	grep -v constraint | wc -l)
+
+[ "$count" -eq 16 ] || \
+	fail "expected 16 zones, got $count"
+
+#
+# Explicitly unload the module.
+#
+cleanup
+
+#
+# Verify that the hierarchy disappeared.
+#
+if [ -d "$SYSFS" ]; then
+	fail "$SYSFS still exists after module removal"
+fi
+
+trap - EXIT INT TERM
+
+echo "PASS"
+
+exit $ksft_pass
-- 
2.53.0

