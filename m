Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293058;
	b=swLRNrB7wDg4THTFLwHtGH5g8lN5o5Ia5x3FI45+6VAgsLAzfzokQ72sjDE9RWIpRQST
	 G3HkiPjb8kZnm/E2wA2wEhjgzz6NFD0lUjGlEI9cBaYHee63m91CJqHDjKzOJ64cJGvBX
	 dkB56Q6aELczBgnhs532L92jPWs8+MpAt/BhhisR/LC3DUozGDnRLDdc0vcHZBZBNxx6y
	 3UzxedJ67KOYjp30230sLSOyv1/04SlVJlHSRyW0UCyeWauebYHElN4ttW527+R5fXU5R
	 lGb4EIJPirxKzNg4OFCedOjwszbVps2yvRdTD5dB5uul0S1rneRoJriWui5hHoENb3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293058;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=i5dERoVXLxk+rf1xHVErC8lZqJ0WOTCOKsXb2waD2uo=;
	b=A4BZBiYhCQYywenl30Puqzax58pdc5aXCWMb6aZJfiq8T5z+e4D36v5BJYI/DBwbDwIx
	 jLxgGNXFfqK7uAWHzqNYPfxFTWi9wXsRLQI1Fq8dD2MjTjNYi/xClP+mzXVXHCpmhb2vi
	 uNwZlfggKiQU2lopa/0JlJaALluwLjBoAiQqGqosYQUqedhzdC/rpQ41xipRvZNrkSfpo
	 2X8JucvLIBCSG6yxuEXR3erGps+sKWp+l8eOlvGd008DLDCILdBTfhjzmRfDP0oG0k5st
	 CthTPZqDHB+hx+SgJXjPFWJPKAwmOq3XjPWQQL2E8Pq0T3onbtccuEe2vd2EVB6do9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AMnLMJM1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gIAxNshc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB68606A31C
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BB68606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AMnLMJM1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gIAxNshc
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGCxdX3872930
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i5dERoVXLxk
	+rf1xHVErC8lZqJ0WOTCOKsXb2waD2uo=; b=AMnLMJM1EgrzepVxTY+eNHxjFAV
	1EoOQ8IsjBUWht01pr/p+0QWX8eR4Cko9wiUkLdJX0zXHKbsOnWIEKuZ+WtbtDvQ
	IJXeOmiPapsvqm6bTdiuxQ6fxvH4YelOPofag7yiNC0Ub6VXxWfysKUUQ/cpGdAC
	a0SjzpGYM2nFCTXNLTIxkeJupzZ1Cvq5af72G8HFPgXzl7iL8ijJa+8kbvRSz/Le
	qCwhHQax7cInrYLKsLXBZukzxZEk0U/qmdpCrIHTjDMogLHRRCDdJN24zOvok12h
	cMzTyR6cA0mZYUMjtGgzSdYZzbwOKVSZMuNGYaP8dDRRdJRwcQPCkcBHPAw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm7620yw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:37 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc0e78a4ccso376973137.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793293056; x=1793897856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i5dERoVXLxk+rf1xHVErC8lZqJ0WOTCOKsXb2waD2uo=;
        b=gIAxNshc67zm5+VuaDWyjN1jUiQMtgJCICyu792wGG8nU9wbIMfd6nDoAuMcQPfMY8
         pB+zNyR7k4C8vCTHwhYItXILOGIZHKgf1E78Zw2r3twe6+8VKS/yZ66U33P0TFfJ7fHg
         llpSf1abSIP9Ky6x1JY91YRE3SFBTJHTmPMRsgLFH9uRpAR2J2ObIl131Dy+YRigRAd1
         PXiMo2KxLQ8BXdlaqMVO3WbUlorA1oee4IN2/9ICQ9Q4BYihYOu25ASq15ARPlFF5yV4
         VjpSg/4L/Kh8Kg6bH87xyiNxOsJYY7ddkJcpDf14mHZeqWOhQMYjIq2Ol8OoGlKLOmYB
         XKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293056; x=1793897856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i5dERoVXLxk+rf1xHVErC8lZqJ0WOTCOKsXb2waD2uo=;
        b=KBYJ/e65astGgRsMYTrLPM8erPIwT6dMmljYgKNru3wJ0oCsdDJQXbO0cYTCs8eH7c
         vcA9I5HfU6+c50CR0XhWqbYRadlYmZMB1G1o27c4UY+UDmp7tykHVaoKlUte2PcFJqNL
         D27351thdVBbvU6xaasSZAVKCuv3OX6RGOeTlJE5IKVGCLJQTzGafxEnCQXrGeGZofIM
         giZjlrEdOCbHhoNz0j2I3MA1GY1J31hSp1h5qzKq5be+PjwYej11T1GZsovh8dnWwhzd
         r2/Lpiw4t2zT2tnH2dPbO96ZIZyZ8dXHhiZuZYssfqX6JsYeoCwoJyiYdNme7pPdBFLP
         RWFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwT7k+GI2qcyLdVuMxySmPGsz2cmd5onw6oJsbO4lwFHTWWIh18QCYfAEH2PcV7k+616V3rq6CduQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+jRAKzF9NLOb5hY3BLTQFElGD3dTjr+pYyrHE+tKkkqFH2RmG
	QLBOIatJKz4CLoUcXG8ntwC8uD3zVnFW9vwOVWrlKka4GhAjrTfMsgJNCMlAUFaARysvDgbYrBc
	7CjLZe4RMtwl/xA4qnrdIMQPE3nijDHrAA2Ap0ptGeY6QQBFpcmVzLtMhHKvnlw==
X-Gm-Gg: AYBFou0LoeUsm4boxj6cpPJmp4Z1IArJmRix/cQ4LG6dFoYaXGpEfmxdyH9PK9Dfva5
	QQs1rFkyEAO68JmyTJG7KHMD/U3MC+3cVEqz70bKsP8j1WTNp/zXzwreNP5BlcpLpv6xwRRyeEF
	zOdpwiIhT+CY1dUg9W2yvJbsBELLq/9SAxn2w5+bilxZ9cc2MwSMceesUk8j9r9MS0jY4E3MLi4
	kyaA1lQheeH5gJ10Her7f6wCRdZmizXQnl0VqgoijAWp+9sQ3lT1q81+dVZlKEh3kaEwlUgenul
	9lxlG90y5AeToXK2NhRVpTLCQPSLKe+fyf09KjD0bQxaGO7JrJou3KOhbvczcpxQYNKVYRR+iLZ
	+RGs1YCFfWRw4hzISlAZbaVDUizMGUXN9FbEziIN5/4V8l7a0yNpFiTEgV/yt3hJfY7aVLMj9y3
	kd
X-Received: by 2002:a05:6102:5492:b0:7cc:5c9d:7e07 with SMTP id ada2fe7eead31-7d03a50d052mr2503838137.11.1793293055631;
        Thu, 29 Oct 2026 09:57:35 -0700 (PDT)
X-Received: by 2002:a05:6102:5492:b0:7cc:5c9d:7e07 with SMTP id ada2fe7eead31-7d03a50d052mr2503808137.11.1793293054638;
        Thu, 29 Oct 2026 09:57:34 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7fbe:151a:486d:a2cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6df961dasm325669f8f.23.2026.10.29.09.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:57:33 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v4 2/6] selftests/powercap: Add powercap hierarchy creation API tests
Date: Thu, 29 Oct 2026 17:56:46 +0100
Message-ID: <a213188c0bb43928d576e7b6cfdce4b8a360e1cd.1793288783.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
References: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 9Z25IoebIHASlWZhoN2SbkvBdO0deF-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfXyCTfDQR/oxpD
 6vb23j78F518smjZqUDdiL1H+lKqu7hrXegAwg99vRGgvs4dmXcdAdWxTZGH1N4i0p2Ch24RV1k
 FM90YL/iHR87Knnk2jVXuYbqVacfE3ktq0OknoR07RurorKZotiP9BwQ8oNgx8pAQ4e9HIHYlXf
 auvM0FXuQA6HOIsutWX1Wo29kQCiyYB3MoK7CXYQS0OroXkgGv42f0ZWZI5ZJI8UXpGV9jAggO3
 v6uJeoC0WZqpzGLyp4R3BbAPCX3cTXN2EfH0r5fh3FIRMtXFT19iwVj4dFQyaUB1zkD+vCBQyYH
 NUcihU+C47QSJ+RvLPvYpYEoT489ow0FP7PrEHWbj+n7yESZTxbUymCbFULySCBwB9DguRjEnS2
 am7vjJ2kFu2+PxnUXf3KQmNjxQuFYpyWQ0brmUW0KYWoPtsUWD8h890yW8ufIkTHoTrxRH+gB7v
 te3uDUsRRAQEpUj7T8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX9Zm5rvrjojY9
 3SMex65leaWHVgwS7FbMN5KWR0YUVmW4tNlcOyWKBQTzdHao1NxUYVoY4Lk+cflq2Czhh6KPNbX
 w9nBptbzLQXZGelW6VHYHMbnlcttR3M=
X-Authority-Analysis: v=2.4 cv=Kv3YSmWN c=1 sm=1 tr=0 ts=6ae37b01 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=HObOqzEOzm0AAkIsdZgA:9 a=gYDTvv6II1OnSo0itH1n:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 9Z25IoebIHASlWZhoN2SbkvBdO0deF-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290066

The powercap hierarchy API introduces generic helpers to duplicate,
instantiate and destroy a complete powercap hierarchy from a static
description.

Add a kselftest exercising this API. The test builds a synthetic
powercap hierarchy composed of a package, three CPU clusters and twelve
CPUs, registers it as a powercap control type and checks the zone count
and selected sysfs attribute values. It also checks that the controller
directory disappears when the module is unloaded.

Exercise direct static creation, duplication, skipped clusters and their
descendants, reuse after partial destruction, and repeated creation
returning -EBUSY without replacing existing zone pointers. Callback
checks verify the controller, name and backend-private data supplied by
the helpers.

The test consists of:

* a kernel module implementing a synthetic powercap hierarchy and
  dummy callbacks;
* a userspace kselftest script that loads the module, checks 16 zones
  and their power and constraint attributes, unloads the module with an
  attribute descriptor open, and checks controller removal.

Use powercap-owned zone allocations so registration failures are cleaned
up by the core. Build generated module files in the selftest output
directory and extend the common clean target with Kbuild module cleanup.

Provide a config fragment for powercap and module support. Skip module
builds when the configuration prerequisites or Module.symvers are
missing, and skip runtime checks when powercap or the test module is
unavailable. Resolve inherited kernel output paths before invoking
Kbuild so cleanup also works with a relative O= argument.

Keep the statically initialized mutex in permanent module data so its
lockdep key survives initialization. Use a separate init-only hierarchy
description to exercise duplication and release the original node array.

This provides a regression test for the powercap hierarchy helpers and
their integration with the powercap core.

Cc: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Link: https://patch.msgid.link/20260806110159.69690-3-daniel.lezcano@oss.qualcomm.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
Changes in v4 (since v3):
- Rebase on v7.3 and address the issues reported by Sashiko.
- Add a config fragment requesting powercap, modules and module unloading;
  guard the Kbuild module target with CONFIG_POWERCAP.
- Skip module builds when configuration prerequisites or Module.symvers
  are missing, avoiding unresolved-symbol failures during modpost.
- Resolve inherited output paths and pass absolute O=, KBUILD_OUTPUT and
  module-output paths to Kbuild, including during relative-O= cleanup.
- Keep the static mutex in permanent module data so its lockdep key
  survives init-memory reclamation; duplicate a separate init-only
  hierarchy description.
- Return KSFT_SKIP when powercap sysfs support or the module is absent.
- Update the commit description to explain these fixes.

Changes in v3 (since v2):
- Rebase on v7.3-rc7.
- Use TEST_GEN_FILES and MO=$(OUTPUT); preserve the common clean recipe.
- Use powercap-owned allocations for consistent registration cleanup.
- Keep validation and counting in the main shell so failures propagate.
- Add static creation, skipped branches, reuse and -EBUSY checks, and
  hold a sysfs descriptor open across module removal.
- Document the tests and describe their actual assertions.
- Fix closing-brace indentation and __initdata placement.

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/powercap/Kbuild       |   5 +
 tools/testing/selftests/powercap/Makefile     |  46 +++
 tools/testing/selftests/powercap/config       |   3 +
 .../selftests/powercap/powercap_hierarchy.c   | 314 ++++++++++++++++++
 .../selftests/powercap/powercap_hierarchy.sh  | 128 +++++++
 6 files changed, 497 insertions(+)
 create mode 100644 tools/testing/selftests/powercap/Kbuild
 create mode 100644 tools/testing/selftests/powercap/Makefile
 create mode 100644 tools/testing/selftests/powercap/config
 create mode 100644 tools/testing/selftests/powercap/powercap_hierarchy.c
 create mode 100755 tools/testing/selftests/powercap/powercap_hierarchy.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index bc4fdb6f5337..764cca6182ce 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -104,6 +104,7 @@ TARGETS += pidfd
 TARGETS += pid_namespace
 TARGETS += pipe
 TARGETS += power_supply
+TARGETS += powercap
 TARGETS += powerpc
 TARGETS += prctl
 TARGETS += proc
diff --git a/tools/testing/selftests/powercap/Kbuild b/tools/testing/selftests/powercap/Kbuild
new file mode 100644
index 000000000000..9300e779db0d
--- /dev/null
+++ b/tools/testing/selftests/powercap/Kbuild
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ifeq ($(CONFIG_POWERCAP),y)
+obj-m += powercap_hierarchy.o
+endif
diff --git a/tools/testing/selftests/powercap/Makefile b/tools/testing/selftests/powercap/Makefile
new file mode 100644
index 000000000000..39d9ec73ba74
--- /dev/null
+++ b/tools/testing/selftests/powercap/Makefile
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# User-space test script
+TEST_PROGS := powercap_hierarchy.sh
+
+KERNEL_SRC := $(realpath ../../../..)
+KERNEL_OUTPUT := $(or $(O),$(KBUILD_OUTPUT))
+# The selftests parent exports BUILD as <absolute kernel output>/kselftest.
+# Use it when clean inherits a relative O= through MAKEFLAGS.
+KDIR ?= $(if $(KERNEL_OUTPUT),$(if $(BUILD),$(BUILD)/..,$(if $(filter /%,$(KERNEL_OUTPUT)),$(KERNEL_OUTPUT),$(KERNEL_SRC)/$(KERNEL_OUTPUT))),$(KERNEL_SRC))
+KERNEL_BUILD := $(abspath $(KDIR))
+
+-include $(KERNEL_BUILD)/include/config/auto.conf
+
+ifeq ($(CONFIG_POWERCAP)$(CONFIG_MODULES)$(CONFIG_MODULE_UNLOAD),yyy)
+ifneq ($(wildcard $(KERNEL_BUILD)/Module.symvers),)
+TEST_GEN_FILES := powercap_hierarchy.ko
+endif
+endif
+
+.DEFAULT_GOAL := all
+
+include ../lib.mk
+
+ifeq ($(TEST_GEN_FILES),)
+all:
+	@echo "SKIP: powercap module needs CONFIG_POWERCAP, CONFIG_MODULES, CONFIG_MODULE_UNLOAD and a full kernel build"
+endif
+
+.PHONY: modules
+
+$(OUTPUT)/powercap_hierarchy.ko: modules
+
+modules:
+	$(MAKE) -C $(KERNEL_BUILD) O=$(KERNEL_BUILD) KBUILD_OUTPUT=$(KERNEL_BUILD) \
+		M=$(CURDIR) MO=$(abspath $(OUTPUT)) modules
+
+.PHONY: clean_modules
+
+clean: clean_modules
+
+clean_modules:
+	@if [ -f "$(KERNEL_BUILD)/Makefile" ] && [ -d "$(OUTPUT)" ]; then \
+		$(MAKE) -C $(KERNEL_BUILD) O=$(KERNEL_BUILD) KBUILD_OUTPUT=$(KERNEL_BUILD) \
+			M=$(CURDIR) MO=$(abspath $(OUTPUT)) clean; \
+	fi
diff --git a/tools/testing/selftests/powercap/config b/tools/testing/selftests/powercap/config
new file mode 100644
index 000000000000..76ae5bcb1dde
--- /dev/null
+++ b/tools/testing/selftests/powercap/config
@@ -0,0 +1,3 @@
+CONFIG_POWERCAP=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
diff --git a/tools/testing/selftests/powercap/powercap_hierarchy.c b/tools/testing/selftests/powercap/powercap_hierarchy.c
new file mode 100644
index 000000000000..e43d510d5426
--- /dev/null
+++ b/tools/testing/selftests/powercap/powercap_hierarchy.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
+ *
+ * Powercap hierarchy description test module
+ *
+ * Test coverage:
+ * - Duplicate an init-only description for use after module initialization.
+ * - Create and destroy a hierarchy directly from a static initializer.
+ * - Skip a cluster and its children while creating independent branches.
+ * - Destroy the partial hierarchy and create the complete hierarchy again.
+ * - Reject repeated creation with -EBUSY and preserve existing zone pointers.
+ * - Check callback arguments and preservation of backend-private data.
+ *
+ * The complete hierarchy remains registered for powercap_hierarchy.sh to
+ * check its 16 zones and exported attribute values. Module removal destroys
+ * it so the script can check cleanup with a sysfs descriptor still open.
+ */
+#include <linux/powercap.h>
+#include <linux/string.h>
+
+struct pch_test_data {
+	int value;
+};
+
+static struct powercap_node pch_test_nodes[] __initdata = {
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
+static struct powercap_hierarchy pch_test_description __initdata = {
+	.nodes = pch_test_nodes,
+	.nr_nodes = ARRAY_SIZE(pch_test_nodes),
+};
+
+/* A static mutex's lockdep key must outlive the module's init sections. */
+static struct powercap_hierarchy pch_test_hierarchy =
+	POWERCAP_HIERARCHY_INIT(pch_test_hierarchy, NULL, 0);
+
+static struct powercap_hierarchy *hierarchy;
+
+static struct powercap_control_type *pct;
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
+static const struct powercap_zone_ops pch_test_ops = {
+	.get_max_power_range_uw = pch_test_get_max_power_range_uw,
+	.get_power_uw = pch_test_get_power_uw,
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
+	struct powercap_zone *pcz;
+
+	/* Validate the arguments and private data supplied by the helper. */
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
+	pcz = powercap_register_zone(NULL, pct, name, parent,
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
+	/* Destruction must receive the original private data and a valid zone. */
+	if (!pct) {
+		pr_err("Invalid NULL controller type\n");
+		return;
+	}
+
+	if (!zone) {
+		pr_err("Invalid NULL zone\n");
+		return;
+	}
+
+	if (pcht_data->value != 0xDEADBEEF) {
+		pr_err("Invalid pcht data != 0xDEADBEEF");
+		return;
+	}
+
+	powercap_unregister_zone(pct, zone);
+}
+
+static struct powercap_zone *
+pch_test_skip_cluster(struct powercap_control_type *pct, const char *name,
+		      void *data, struct powercap_zone *parent)
+{
+	if (!strcmp(name, "cluster0"))
+		return NULL;
+
+	return pch_test_create(pct, name, data, parent);
+}
+
+static int __init pch_test_init(void)
+{
+	struct powercap_zone *zones[ARRAY_SIZE(pch_test_nodes)];
+	size_t i;
+	int ret;
+
+	/* Keep a runtime copy whose parent pointers survive init memory release. */
+	hierarchy = powercap_hierarchy_dup(&pch_test_description);
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
+	/* Exercise direct creation with a statically initialized hierarchy lock. */
+	pch_test_hierarchy.nodes = pch_test_nodes;
+	pch_test_hierarchy.nr_nodes = ARRAY_SIZE(pch_test_nodes);
+	ret = powercap_hierarchy_create(pct, &pch_test_hierarchy,
+					pch_test_create, pch_test_destroy);
+	if (ret) {
+		pr_err("Failed to create the static hierarchy: %d\n", ret);
+		goto out_unregister_pct;
+	}
+
+	powercap_hierarchy_destroy(pct, &pch_test_hierarchy, pch_test_destroy);
+	pch_test_hierarchy.nodes = NULL;
+	pch_test_hierarchy.nr_nodes = 0;
+
+	/* NULL skips cluster0 and its descendants, but not the other clusters. */
+	ret = powercap_hierarchy_create(pct, hierarchy,
+					pch_test_skip_cluster, pch_test_destroy);
+	if (ret)
+		goto out_unregister_pct;
+
+	for (i = 0; i < hierarchy->nr_nodes; i++) {
+		/* Node 1 is cluster0; nodes 4 through 7 are its four CPUs. */
+		bool skipped = i == 1 || (i >= 4 && i <= 7);
+
+		if (!!hierarchy->nodes[i].zone == skipped) {
+			pr_err("Unexpected zone state after skipping cluster0\n");
+			ret = -EINVAL;
+			goto out_destroy_hierarchy;
+		}
+	}
+
+	/* Partial destruction must leave the hierarchy reusable for a full tree. */
+	powercap_hierarchy_destroy(pct, hierarchy, pch_test_destroy);
+
+	ret = powercap_hierarchy_create(pct, hierarchy, pch_test_create, pch_test_destroy);
+	if (ret) {
+		pr_err("Failed to create the hierarchy: %d\n", ret);
+		goto out_unregister_pct;
+	}
+
+	/* A second creation must return -EBUSY without replacing any zone. */
+	for (i = 0; i < hierarchy->nr_nodes; i++)
+		zones[i] = hierarchy->nodes[i].zone;
+
+	ret = powercap_hierarchy_create(pct, hierarchy, pch_test_create, pch_test_destroy);
+	if (ret != -EBUSY) {
+		pr_err("Expected -EBUSY when recreating the hierarchy, got %d\n", ret);
+		ret = -EINVAL;
+		goto out_destroy_hierarchy;
+	}
+
+	for (i = 0; i < hierarchy->nr_nodes; i++) {
+		if (hierarchy->nodes[i].zone != zones[i]) {
+			pr_err("Recreation changed an existing zone\n");
+			ret = -EINVAL;
+			goto out_destroy_hierarchy;
+		}
+	}
+
+	/* Leave the full tree available for the userspace sysfs checks. */
+	return 0;
+
+out_destroy_hierarchy:
+	powercap_hierarchy_destroy(pct, hierarchy, pch_test_destroy);
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
+	/* Remove zones before their controller; the script checks disappearance. */
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
index 000000000000..9a81d9afc010
--- /dev/null
+++ b/tools/testing/selftests/powercap/powercap_hierarchy.sh
@@ -0,0 +1,128 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Loading the module runs its in-kernel hierarchy API checks. Then validate
+# all 16 exported zones, their power readings and constraint attributes, and
+# removal of the controller while a sysfs attribute descriptor remains open.
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
+[ "$(id -u)" -eq 0 ] || skip "must be run as root"
+[ -d /sys/class/powercap ] || skip "powercap is not available in the running kernel"
+[ -f ./powercap_hierarchy.ko ] || skip "powercap_hierarchy.ko is not available"
+
+trap cleanup EXIT INT TERM
+
+insmod ./powercap_hierarchy.ko || fail "failed to load module"
+
+[ -d "$SYSFS" ] || fail "missing $SYSFS"
+
+check_zone()
+{
+	zone=$1
+
+	# Check required attributes and the deterministic values from the module.
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
+namefiles=$(find "$SYSFS" -type f -name name) || fail "failed to list zones"
+
+while IFS= read -r namefile
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
+done <<EOF
+$namefiles
+EOF
+
+#
+# Count the number of powercap zones.
+#
+[ "$zones" -eq 16 ] || \
+	fail "expected 16 zones, got $zones"
+
+#
+# Keep an attribute open across module removal, then close it afterwards.
+#
+exec 3<"$zone/power_uw" || fail "failed to open power_uw before removal"
+cleanup
+exec 3<&-
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
