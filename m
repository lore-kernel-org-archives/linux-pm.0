Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091493AE198
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174071; cv=none; b=ubLbSLil4gPQpHYfYBy9IzL9KexOuVtVDSq0vhF0+Y7sXyemuXjedCPz0LbuF40GqJrpLRpjqkBEPFarrye0OT1CRLNf0uogsP0cQdV+raqzaqzet4eSy4UQLAOddM7GWVWfheXZW1yGZlRynqPZcsOPZTU7Rr3+YSnJNjpMv7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174071; c=relaxed/simple;
	bh=wiyNFvdANljTSlZdzzOIqNOa3OOYFngki4pccOBgqpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ps3a0Ax0mA7BzzIsRN47awBVXfMnk7HCIVF39LQ2WwQBxG0wlaKgdTTy1lIVdzWP1VDZbG9lC819qE9RRhB6bdvzQMF9vOF5zINfxFQvnUW4LdGJo9n1byRFJWNVO0t0ysoi1NE6uwY0mUG6Q4ZUAzmuFvMJDMcFWar6ZGwAqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K6g0Vicv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WTYAcYoW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K6g0Vicv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WTYAcYoW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NDPGCd2698201
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gLDj0JW+dU0
	8V9SkdAKU/99MbkCwX+oCC26eUHXN6qI=; b=K6g0Vicv7KD7oc1WYMi+9/gmOBF
	5njCETzqpZYtsfeBQTzGxxNrzXL6WzV38KG8AzKztjEK/ZF1ilDxwSMecJXejBTb
	jDoiOx46Wyjg+K0Cv1ZDH30d+Kug10IrtqENEt/4Q37tkYLLZN5TUiDMFS56eX5p
	GdUTTgfsEOYsc5wN5/WdcWbUOkg8Tnij6pxXpLe8+hO7LXh2NXNhaK7NN/boqPQY
	1ejfC/aWJ2YBh4LwA3kKWXaShK+N5W2YnqYl719byugT8gQOIVj+dg0qgOpq4sI0
	vdNrqpuqu9j94VXp0eRpTRj1a1ekHStcrqytOkkz30kLa6sfuKIQ455ZNiA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwg9gu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:28 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-97e768af628so796322241.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790174068; x=1790778868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gLDj0JW+dU08V9SkdAKU/99MbkCwX+oCC26eUHXN6qI=;
        b=WTYAcYoWmKCjgeTnu7wBH73+u2MV8uOB9RPhVmO+zAYBiQM7sBQmCsXUSGgCP56kfu
         q4plnKkbAz4G4UbDnPy+ymP0Fqjo7ShJZB+Adx2Hpx1mNsfOEabMmtuyIliwwF3OLZcV
         Gz5yyQ4xIfQtTyUtj+qSbE6FqGMneXXbdJyj+uPjtFVoM4TcTaqD8M3a46PzwV+M31gY
         5mcE92KTVBrn4raM1EY+6GgPQVhk10I9PU2eYHgc2/4RZPbQ4x9TxQCmoQJ4fBO4JZ2w
         wWmVRVzUi6VOT2hw/GtJWVvbYjxaC3vwEjhW2zC7/3wvxmNZ1sUvQEnqySQFTTHGcw6T
         i96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174068; x=1790778868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gLDj0JW+dU08V9SkdAKU/99MbkCwX+oCC26eUHXN6qI=;
        b=wkdW2Z9XDtUYLcu755pDe/8F14H7N41VYlw/g6hPoCARjI/enCCmqOCSrI3Vn03wZx
         g4EWtvfU4eGSPP9GwDN4ID6OBO95pK2NEFPGRabj5jyVI/vcKdmLVlxsIVj7LKYd7t8b
         ny7SfZ42BVyYKEpjOI/GFeMiWb2qeZ6EzWzb+LNN3PAuC4EEZIUhlY5f31p/1srortCo
         dbp5UOz6t8XjGpycCQDYvr+Va8//KarFQvFApoisH7K9fDqPvA8F5BB1Kd2dOb4IcKHE
         bX1d7RtKq6pefiwYV/qQCDjxg38uTn7I361rD3UqnEvnWFd2r0QiFP/a2G27l6y4axJQ
         Rqww==
X-Gm-Message-State: AFuF++mRPvSxi2vMUAM9Ci8w3TCFdma76iE9AyqQsbLU2nCZTOv9daO4
	oXLNdUna59LmTpzaHnVI7UQESoRY3RZdmVs1MmH/k+pabQIDLzIS8nyEVXUxOEfmB8xGD8UjPYC
	NbH3DuP6HHZQZ9JJD8eONpjpN5tkv7smw1TP0J7tYP+0uRAR/emLvGA43NtozHQ==
X-Gm-Gg: AYBFou1ah6TMro8yUwBOQJBBHcuUTme2cNN/BEGxLva7CRqrbPztaQN8ptLTYxqGHXY
	F/+ojgUyvmplfsdKmcibN9YFvCs5xOGqDJKLW+VNTO2FzC8lO2fwYg406kkFF+PVe8XOD56QHVG
	ipEvXMeBMma+lcOx2O78lzOVfeGCLxdgbWJBqxUIav+i1sawJQ1lMGFkGK19BGP672kQYNFoGAu
	jFcjmFfCzNm8FWsdBD3ix8ANfay6ksvMHmQMPhWrqleToLWyW4jbRNF3FttfI9VdRRiVZrrrUkK
	p3pyzYE8aNepsEIJPiMB07dfW1q/LfKye7ki6yraYwDkLYF3TQvRSh7b3n8mYyaOoPw0hb6lizR
	1P7p5c2BbGBxWUmgJ0lmhVhuI9Yhip1KUr6xYDw==
X-Received: by 2002:a05:6102:5808:b0:7a0:f7cc:5045 with SMTP id ada2fe7eead31-7ac1ace44e2mr2721144137.9.1790174067938;
        Wed, 23 Sep 2026 07:34:27 -0700 (PDT)
X-Received: by 2002:a05:6102:5808:b0:7a0:f7cc:5045 with SMTP id ada2fe7eead31-7ac1ace44e2mr2721110137.9.1790174067444;
        Wed, 23 Sep 2026 07:34:27 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a913:ba43:96d7:743c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf158147sm58213905e9.0.2026.09.23.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:34:26 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 2/6] selftests/powercap: Add powercap hierarchy creation API tests
Date: Wed, 23 Sep 2026 16:34:12 +0200
Message-ID: <20260923143416.3713485-3-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com>
References: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX4qPiMzo41VDP
 kQ8RkVOcBENEEIYPN72sYPPczXOm0SnQvVcmHhKifhEU2pxTo8Dg0iAo7BPjY70JtQVQbssNefJ
 YfgKiL0dCX1xnKgf6R6O1BC97FfCkgDm7Rc/HACpIv90mnUDPAeO5lx9soA0kROYa+TzJQdzLYs
 vHn6vnch1Mn5JVDo2oaQ5gor0v7IjvVtqhLcKDcu9KmG/H7Cxa32M6KdEv6aud81nKen/TfI8wv
 OwqK/8PIj1byXibi1VODCdXqJN7ofyF9mrrfpRm+Yr467lddIz8JEPShDXMEJARgQkd11NghS0r
 tDV6a5SnXzfqBneyo2bh/+C+CvrprsvmxLmoo++Lr6gjx0gGK5+uMkfIWXYHwQ7bLEsFhZo5bdD
 kLjyjspex3RG+YsFoW33hdzbag4m5GGsCjaaVLC1kuU0lxzPtbIF422My+E0HX8+tU0f+Ls7eBJ
 +onJJCnQ/e2GP27fm2g==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab3e374 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=xFgmAgSJGoImdcxQjNwA:9 a=TD8TdBvy0hsOASGTdmB-:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX80Wf9qqNK3Mz
 qeMo/ysRighZ7184nd3NuhJx0+En8tWNLpKxXyCWvtkPqf3fA4nVp4cYh5mGMfjY1Aa66OoyIrL
 GhA1KwrNUl3OwnFKHJ793Z281OCSqHM=
X-Proofpoint-ORIG-GUID: om5iqrwegas_CIFa9oXSvLe1vmcp3dEg
X-Proofpoint-GUID: om5iqrwegas_CIFa9oXSvLe1vmcp3dEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230058

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
Link: https://patch.msgid.link/20260806110159.69690-3-daniel.lezcano@oss.qualcomm.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/powercap/Kbuild       |   3 +
 tools/testing/selftests/powercap/Makefile     |  17 ++
 .../selftests/powercap/powercap_hierarchy.c   | 246 ++++++++++++++++++
 .../selftests/powercap/powercap_hierarchy.sh  | 118 +++++++++
 5 files changed, 385 insertions(+)
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
index 000000000000..ab3f1220f909
--- /dev/null
+++ b/tools/testing/selftests/powercap/powercap_hierarchy.c
@@ -0,0 +1,246 @@
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
2.43.0

