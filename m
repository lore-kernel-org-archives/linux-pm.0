Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A244B5CC7
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445810; cv=none; b=IViCasnDqOIWQKwBCWsKLaT9dmbHEW31gzmpP13BfqmYYWTfxrcSz0XYVe+v9md7CltKU2Y8TQQp9uKZy9wl9L9YfGRvxtvfLoWMbVloZcGxnbL64rN0M2FfvNjouiXx7MWZrva4d+sdgA7KaqL91j4A4GgIR5tqnJ0mxr4sjXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445810; c=relaxed/simple;
	bh=87I7IBOfoO1/OUKB8jLS15WMIS9h1aPeWI6Zuv25XGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brxu3c5hXlEERGYnZpj+M4+TnLarGMk8lrCjHvjk31URgelyDA8DLdusHjiAAlt8Nh59uNRy+3ccn0zwudOnfMuY6Kn12a8zuGb2ivTIZuFKOP0GSPLJI5j+IFLKfk5n+32DY71J0rTqJHSkW3e812LSVlP2Jhf+ZsjVK0H0Tbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NmAw6K1A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TUu2l0+Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NmAw6K1A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TUu2l0+Z"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DAJVT588253
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 14:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5IXu4DZ5j3g12muqhUXwDxqYZMQhzBEXoYPVjup8Kq0=; b=NmAw6K1AONiALum7
	ZOh43+3ve5GlS71ktbLwK0uhPkPFpmLuwNtPKw58txum8MV+yt/4JKTuySMpb+jS
	Q6bEQ8F3pGjSz6sz7VLPrLixyAFa8SjmvkPzP3iIPoqH2sdUAZfwIWaomDTaIEhO
	8Vd5tEMq8z5nZhcOODoGnu4Mxam70q99G4aG2nCJOKmhPqMZiGWhVtAEHOqgRsGL
	8TMOlbW0f6gwfQQGmDeO6Ld/So2SsEIG3lhLJu2veOy4y04aN+sVHnHgRlT9mebu
	dsMqEK197LS0NFiBeHYDSvFk30oCiLvKxXAXVjzikkdAue8AfA0Qb6oe7+TtAk/a
	mwkzcQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyjbsy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 14:29:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-933023a5980so536087385a.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788445766; x=1789050566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5IXu4DZ5j3g12muqhUXwDxqYZMQhzBEXoYPVjup8Kq0=;
        b=TUu2l0+ZBPkbuEE1J6KQbCYiplZHJEs6wFbJ4WICWRsBwExybmZdqvx7bbicub2/Ai
         5z+gyqL/t90g5yGLLK0mhb993EeHeF97xxpT8xUVYrfPC5v8SDtpU8/SGqWwQvONWDCT
         in5DC6YTo6OCrZuPApJM4jr7Sjr3R0lJNznOSG+etQOJ5IO25gfnvA/O6yqURXY3cLW6
         5D042Ta6bxQSXIRNgzDQlzQFoHEIZ1fEXN/nTWFEfr4n+DNKGuLxst1HAkxuglQulQpJ
         kuXHfNdgcV2h1ZCfhf0e/ycQmNeQU0QW/sMUqOudAOzK7UrNC+gNV9Lc3SRKl8MGzOuo
         Cc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445766; x=1789050566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5IXu4DZ5j3g12muqhUXwDxqYZMQhzBEXoYPVjup8Kq0=;
        b=HKBi5IacF+V13RM59vwELj17Z8yTSGPlrkVQU+TIpeOchQt5EjPq/6853s4yyifyQS
         cL47DFT+TGkTxYO+AndY0VrExupXWeoEA9TicB4FHkaAu4AuNlYF4vufGVls/OgykWM0
         AVIbxYgNGlroCLZg+aWAJOuLtvtu6jiat2sEJpfnyUTq9vBaJ7GaGP1DKcj3EHQPHPMW
         mmhb3PMZ5K1jUNaOMSKDtzFsEwF02UIpZqLGTani6XbE8BI0yXRcCby19x20MpgPcm5W
         FXB4tEddRNI6L9WN46PPh+x5IuUjFxUKOvgkPeaqJsYwv8Tetoki2p/zbjYl9TVcfVkv
         CGzg==
X-Gm-Message-State: AFuF++lrgzJZJr6x3P7rc3jTrKB0sTC7aEJ9TW+uy5iNlzDJseIN2LuQ
	5rWln88nOFVTGNWdyLi/WIlptYzGp0J2ut6N51lVkJlyz2HiyZtPNiksYho5nVI5CoIppwH1TP2
	/0HV/EkhcMUHSC0lze8aZuPVynMx18T3/zAp0Gd3g3M4Wd9XV2EFXU3Xf8/eZ8A==
X-Gm-Gg: AYBFou3XRLp2FqmER2saZ3bKuQCZJ2xRM07SdV06kOgb4s4+LNiFabnd+Bko1QaWevJ
	bs9XM74a9RoHortD8IdEQkmjscPRMP+AB+Wd1N6OBQgxNDG479T+asAUioBr8zeMaW4HoAstUWV
	a1ITxz7y11W614bxwC/BSO57lMkYe0osP3R2BjX2m+NB+XAhorg3wJzFY+tdDYhwh6JOoiRn7b4
	gJhZ146zXp5hI2bgFSfi8HrlWo3bvDBFUtaFlKYSe6ye54QsljukO8g3WlQFGQU8DSc8dGNOoC0
	aXEamKrXlx+ep5skFFDsMij47TziGbl2V0+iIj/+bkI+uIUzY3o15aMdIjrXVLqiIY1hxXoIGI9
	QDADzm9fu8CmFC0kTSwnsQFHppCK0
X-Received: by 2002:a05:620a:2b8a:b0:930:f129:1a45 with SMTP id af79cd13be357-93960f5b352mr1559206485a.30.1788445765657;
        Thu, 03 Sep 2026 07:29:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8a:b0:930:f129:1a45 with SMTP id af79cd13be357-93960f5b352mr1559193685a.30.1788445764697;
        Thu, 03 Sep 2026 07:29:24 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:1c7d:412b:f9d3:3bfc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f9114sm72799415e9.5.2026.09.03.07.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:29:23 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 16:29:09 +0200
Subject: [PATCH 2/2] power: sequencing: add kunit test cases
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-pwrseq-kunit-v1-2-1f893d2cabc2@oss.qualcomm.com>
References: <20260903-pwrseq-kunit-v1-0-1f893d2cabc2@oss.qualcomm.com>
In-Reply-To: <20260903-pwrseq-kunit-v1-0-1f893d2cabc2@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=45947;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=87I7IBOfoO1/OUKB8jLS15WMIS9h1aPeWI6Zuv25XGQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqmYQ+eXYa0+IwgnAlH39FBADL0T+gzsTDJnqQd
 ulA9ZPjbnqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCapmEPgAKCRAFnS7L/zaE
 wyGlEACrYgD3aM4eD3Ql8ivzPvND7mdFhbwnIIJvKnKUYbPXVZ3tYSY6s5ZYaPRfvV3RktDp+7r
 U/KJfzhL85Ews2v2ey9PYYfiEmfRnOCfidxA39cocT4cGe0KD7rOTiyvSJTY3oct/Chjn72zH0f
 RlALsPhkpgzmDifwe+q2qYeVZB7TKeWbHY2ADDtt1F1j8hjGo1N3lsTt3ts/s4YjsL5BmyuBZZl
 6omVh9Uyc8HTiHf+PusrOi4F/Yw825hQedyU2gv4XoG5wUKY+hYbCaZq/Zjm2czuFPgXLtiwky7
 jScVHqbRo1ldsKm3u8wrtfxbFJb81pweHlT0sscuNzQ1TIeqyklAfQjZY8EgCbRCTNBTaCYwpaw
 JM5a4GYjJKU3KcSY+20eTgDq7T03nuEEkDMXh2jwgpQTtgnVBxwOWHRmVCq2e3WDJSEq5emAbRn
 tMTyEjCjMVcYMwJH1YGsTORxo2Rq+BMxE0R6JdgVzKgmxk3eEISRBHnsv3PJ78VM2kO7FK8dyEs
 QbbFKmiUYd8CWafq0WVBzWBkex2g3k0A7XulrboGK+K/lFt3y9mDRofnbj/rwhuxJSEDy9wanjl
 48MNevWLnaUJ8jZiccYjDT4FseAh58h6iIYg+GeoDrW6ffa4qxJekAi3RSvoERVehzZSYu7rZ/w
 /YnwRbWmo8HpUvQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyNiBTYWx0ZWRfXzoVPYlOHN0Ot
 B6dHI6LeS6scfSBlxZfZAYvl1zLgYSvI48+OPAK+96cJivkMECWZRiSVqiVlNB8okNXdXpBEteo
 y/BOs9lGonC9g9ZRB3JDg8uFHfiZZDiL19/wx4nfxhWc1WOsOckDjuHfqHqlyVBKMpKVwHBj1qW
 xAG7humLBxirbyKfBSUAZ3G41LzeeomUfc5TGpJ6r818rmO4ZuLByuD7y5tuvap1dEeZ4CBUvFl
 RH1RePp09yQltMKZVMwWpFXdhqxqgMtGSobWIXwCQKGJBcNHB3QwFvKIB0DNwzo9baX9vudk0Lu
 LmBBNu5Gm4NPPwsUz1vapn0VlCu5sj/RVqX4mJifisQFnh3fA8t6hUi/h7tpHX0mawIKyNsbQYH
 FZn0xeWjayxlqmclP87VS187oj+FEQy03/unKRJShouevzitHOX60Or1xLsAN1wHMjtYlVFvk85
 /QTT+LsoQF1CJpe7Zcw==
X-Proofpoint-ORIG-GUID: a-j_ztMjlIhSyvCpruMrRYVLfrq58rMu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyNiBTYWx0ZWRfX2QRzoVnxbig0
 vdKFLCwMZM/BO9GEU6mabMW7uUrZWO0aTqwWf9HyZHVlaUxDmCHKl/vypOvCKcCScCtNZGrwpNQ
 ItbqGxtHBdIpEGRJmu931G7GvuGa/Bg=
X-Proofpoint-GUID: a-j_ztMjlIhSyvCpruMrRYVLfrq58rMu
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a998447 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Ap85WKxUwIOrhNPdkRgA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030126

Add a set of kunit test-cases for the power sequencing subsystem. Verify
several use-cases such as detecting circural dependencies, tracking of
the enable-count, shared dependencies, swnode lookup, missing target on
matching provider, etc.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/Kconfig        |   10 +
 drivers/power/sequencing/Makefile       |    1 +
 drivers/power/sequencing/pwrseq-kunit.c | 1497 +++++++++++++++++++++++++++++++
 3 files changed, 1508 insertions(+)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 1c5f5820f5b76479b380df79971ca5e245e62c6b..a09f18b41feafd97833dffe82e103288ffb6ce1b 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -46,4 +46,14 @@ config POWER_SEQUENCING_PCIE_M2
 	  connectors. This driver handles the power sequencing for the M.2
 	  connectors exposing multiple interfaces like PCIe, SATA, UART, etc...
 
+config POWER_SEQUENCING_KUNIT
+	tristate "Build power sequencing KUnit test cases"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Say Y here to build the module containing KUnit test cases for the
+	  power sequencing subsystem.
+
+	  If unsure, say N.
+
 endif
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
index 0911d461829897c5018e26dbe475b28f6fb6914c..cde06a5115d0c57b02b1a7d66cc641b691c5f5e3 100644
--- a/drivers/power/sequencing/Makefile
+++ b/drivers/power/sequencing/Makefile
@@ -6,3 +6,4 @@ pwrseq-core-y				:= core.o
 obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
 obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) += pwrseq-thead-gpu.o
 obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2)	+= pwrseq-pcie-m2.o
+obj-$(CONFIG_POWER_SEQUENCING_KUNIT)	+= pwrseq-kunit.o
diff --git a/drivers/power/sequencing/pwrseq-kunit.c b/drivers/power/sequencing/pwrseq-kunit.c
new file mode 100644
index 0000000000000000000000000000000000000000..c2899f3b16e6450eab7178e58d75e9ddc005d5e5
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-kunit.c
@@ -0,0 +1,1497 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Qualcomm Technologies, Inc. and/or its subsidiaries
+ */
+
+#include <linux/err.h>
+#include <linux/fwnode.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
+#include <linux/pwrseq/provider.h>
+
+#include <kunit/fwnode.h>
+#include <kunit/platform_device.h>
+#include <kunit/resource.h>
+#include <kunit/test.h>
+
+#define PWRSEQ_TEST_PARENT			"pwrseq-test-parent"
+#define PWRSEQ_TEST_CONSUMER			"pwrseq-test-consumer"
+
+#define PWRSEQ_SWNODE_TEST_PROVIDER		"pwrseq-swnode-test-provider"
+#define PWRSEQ_SWNODE_TEST_PROVIDER_2		"pwrseq-swnode-test-provider-2"
+#define PWRSEQ_PROBE_ORDER_TEST_CONSUMER	"pwrseq-probe-order-test-consumer"
+#define PWRSEQ_PROBE_DEFER_TEST_CONSUMER	"pwrseq-probe-defer-test-consumer"
+
+static const struct software_node pwrseq_test_provider_swnode = {
+	.name = "pwrseq-test-provider",
+};
+
+KUNIT_DEFINE_ACTION_WRAPPER(pwrseq_device_unregister_wrapper,
+			    pwrseq_device_unregister,
+			    struct pwrseq_device *);
+
+static struct pwrseq_device *
+kunit_pwrseq_device_register(struct kunit *test,
+			     const struct pwrseq_config *config)
+{
+	struct pwrseq_device *pwrseq;
+	int ret;
+
+	pwrseq = pwrseq_device_register(config);
+	if (IS_ERR(pwrseq))
+		return pwrseq;
+
+	ret = kunit_add_action_or_reset(test, pwrseq_device_unregister_wrapper,
+					pwrseq);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return pwrseq;
+}
+
+KUNIT_DEFINE_ACTION_WRAPPER(pwrseq_put_wrapper, pwrseq_put,
+			    struct pwrseq_desc *);
+
+static struct pwrseq_desc *
+kunit_pwrseq_get(struct kunit *test, struct device *dev, const char *target)
+{
+	struct pwrseq_desc *desc;
+	int ret;
+
+	desc = pwrseq_get(dev, target);
+	if (IS_ERR(desc))
+		return desc;
+
+	ret = kunit_add_action_or_reset(test, pwrseq_put_wrapper, desc);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return desc;
+}
+
+struct pwrseq_test_ctx {
+	const char *consumer_name;
+	int enable_count_a;
+	int enable_count_b;
+	int disable_count_a;
+	int disable_count_b;
+	int enable_calls_a;
+	int post_enable_calls;
+	bool enable_error_a;
+	bool enable_error_b;
+	bool post_enable_error;
+};
+
+static int pwrseq_test_no_match(struct pwrseq_device *pwrseq,
+				struct device *dev)
+{
+	return PWRSEQ_NO_MATCH;
+}
+
+static int pwrseq_test_match_by_name(struct pwrseq_device *pwrseq,
+				     struct device *dev)
+{
+	struct pwrseq_test_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return strcmp(dev_name(dev), ctx->consumer_name) == 0 ?
+					PWRSEQ_MATCH_OK : PWRSEQ_NO_MATCH;
+}
+
+static int pwrseq_test_match_always(struct pwrseq_device *pwrseq,
+				    struct device *dev)
+{
+	return PWRSEQ_MATCH_OK;
+}
+
+static int pwrseq_test_enable_a(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_test_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	ctx->enable_calls_a++;
+
+	if (ctx->enable_error_a)
+		return -EIO;
+
+	ctx->enable_count_a++;
+
+	return 0;
+}
+
+static int pwrseq_test_disable_a(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_test_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	ctx->disable_count_a++;
+
+	return 0;
+}
+
+static int pwrseq_test_enable_b(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_test_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	if (ctx->enable_error_b)
+		return -EIO;
+
+	ctx->enable_count_b++;
+
+	return 0;
+}
+
+static int pwrseq_test_disable_b(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_test_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	ctx->disable_count_b++;
+
+	return 0;
+}
+
+static int pwrseq_test_post_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_test_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	ctx->post_enable_calls++;
+
+	return ctx->post_enable_error ? -EIO : 0;
+}
+
+static int pwrseq_test_parent_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver pwrseq_test_parent_driver = {
+	.probe = pwrseq_test_parent_probe,
+	.driver = {
+		.name = PWRSEQ_TEST_PARENT,
+	},
+};
+
+static int pwrseq_test_parent_init(struct kunit *test)
+{
+	static const struct platform_device_info pdevinfo = {
+		.name = PWRSEQ_TEST_PARENT,
+		.id = PLATFORM_DEVID_NONE,
+	};
+
+	struct platform_device *pdev;
+	bool bound;
+	int ret;
+
+	ret = kunit_platform_driver_register(test, &pwrseq_test_parent_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	pdev = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	wait_for_device_probe();
+	scoped_guard(device, &pdev->dev)
+		bound = device_is_bound(&pdev->dev);
+
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	test->priv = pdev;
+
+	return 0;
+}
+
+/*
+ * Test that registering a power sequencer whose unit dependency graph
+ * contains a two-node cycle (A -> B -> A) is rejected with -EINVAL.
+ */
+static void pwrseq_circular_deps(struct kunit *test)
+{
+	const struct pwrseq_unit_data *unit_a_deps[2] = { };
+	const struct pwrseq_unit_data *unit_b_deps[2] = { };
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device *pdev = test->priv;
+	struct pwrseq_unit_data unit_a, unit_b;
+	struct pwrseq_target_data target;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+
+	unit_a = (struct pwrseq_unit_data){
+		.name = "unit-a",
+		.deps = unit_a_deps,
+	};
+
+	unit_b = (struct pwrseq_unit_data){
+		.name = "unit-b",
+		.deps = unit_b_deps,
+	};
+
+	unit_a_deps[0] = &unit_b;
+	unit_b_deps[0] = &unit_a;
+
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &unit_a,
+	};
+
+	targets[0] = &target;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.match = pwrseq_test_no_match,
+		.targets = targets,
+	};
+
+	kunit_warning_suppress(test) {
+		pwrseq = kunit_pwrseq_device_register(test, &config);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+
+	KUNIT_EXPECT_TRUE(test, IS_ERR(pwrseq));
+	KUNIT_EXPECT_EQ(test, PTR_ERR(pwrseq), -EINVAL);
+}
+
+/*
+ * Test that a longer chain cycle (A -> B -> C -> D -> A) is also rejected
+ * with -EINVAL.
+ */
+static void pwrseq_circular_deps_chain(struct kunit *test)
+{
+	struct pwrseq_unit_data unit_a, unit_b, unit_c, unit_d;
+	const struct pwrseq_unit_data *unit_a_deps[2] = { };
+	const struct pwrseq_unit_data *unit_b_deps[2] = { };
+	const struct pwrseq_unit_data *unit_c_deps[2] = { };
+	const struct pwrseq_unit_data *unit_d_deps[2] = { };
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device *pdev = test->priv;
+	struct pwrseq_target_data target;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+
+	unit_a = (struct pwrseq_unit_data){
+		.name = "unit-a",
+		.deps = unit_a_deps,
+	};
+	unit_b = (struct pwrseq_unit_data){
+		.name = "unit-b",
+		.deps = unit_b_deps,
+	};
+	unit_c = (struct pwrseq_unit_data){
+		.name = "unit-c",
+		.deps = unit_c_deps,
+	};
+	unit_d = (struct pwrseq_unit_data){
+		.name = "unit-d",
+		.deps = unit_d_deps,
+	};
+
+	unit_a_deps[0] = &unit_b;
+	unit_b_deps[0] = &unit_c;
+	unit_c_deps[0] = &unit_d;
+	unit_d_deps[0] = &unit_a;
+
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &unit_a,
+	};
+
+	targets[0] = &target;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.match = pwrseq_test_no_match,
+		.targets = targets,
+	};
+
+	kunit_warning_suppress(test) {
+		pwrseq = kunit_pwrseq_device_register(test, &config);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+
+	KUNIT_EXPECT_TRUE(test, IS_ERR(pwrseq));
+	KUNIT_EXPECT_EQ(test, PTR_ERR(pwrseq), -EINVAL);
+}
+
+/*
+ * Test that a valid acyclic dependency graph (A -> B) registers successfully.
+ */
+static void pwrseq_register_valid(struct kunit *test)
+{
+	const struct pwrseq_unit_data *unit_a_deps[2] = { };
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device *pdev = test->priv;
+	struct pwrseq_unit_data unit_a, unit_b;
+	struct pwrseq_target_data target;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+
+	unit_b = (struct pwrseq_unit_data){
+		.name = "unit-b",
+	};
+
+	unit_a_deps[0] = &unit_b;
+	unit_a = (struct pwrseq_unit_data){
+		.name = "unit-a",
+		.deps = unit_a_deps,
+	};
+
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &unit_a,
+	};
+
+	targets[0] = &target;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.match = pwrseq_test_no_match,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pwrseq);
+}
+
+/*
+ * Test that registration is rejected with -EINVAL when .parent, .match or
+ * .targets is missing, or when .targets is a non-NULL but empty array.
+ */
+static void pwrseq_register_invalid_args(struct kunit *test)
+{
+	const struct pwrseq_target_data *empty_targets[1] = { };
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device *pdev = test->priv;
+	struct pwrseq_target_data target;
+	struct pwrseq_unit_data unit;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+
+	unit = (struct pwrseq_unit_data){ .name = "unit-a" };
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &unit,
+	};
+	targets[0] = &target;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.match = pwrseq_test_no_match,
+		.targets = targets,
+	};
+
+	config.parent = NULL;
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_EXPECT_TRUE(test, IS_ERR(pwrseq));
+	KUNIT_EXPECT_EQ(test, PTR_ERR(pwrseq), -EINVAL);
+	config.parent = &pdev->dev;
+
+	config.match = NULL;
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_EXPECT_TRUE(test, IS_ERR(pwrseq));
+	KUNIT_EXPECT_EQ(test, PTR_ERR(pwrseq), -EINVAL);
+	config.match = pwrseq_test_no_match;
+
+	config.targets = NULL;
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_EXPECT_TRUE(test, IS_ERR(pwrseq));
+	KUNIT_EXPECT_EQ(test, PTR_ERR(pwrseq), -EINVAL);
+
+	config.targets = empty_targets;
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_EXPECT_TRUE(test, IS_ERR(pwrseq));
+	KUNIT_EXPECT_EQ(test, PTR_ERR(pwrseq), -EINVAL);
+}
+
+/*
+ * Test that a target without a unit is rejected with -EINVAL.
+ */
+static void pwrseq_register_target_without_unit(struct kunit *test)
+{
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device *pdev = test->priv;
+	struct pwrseq_target_data target;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = NULL,
+	};
+	targets[0] = &target;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.match = pwrseq_test_no_match,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_EXPECT_TRUE(test, IS_ERR(pwrseq));
+	KUNIT_EXPECT_EQ(test, PTR_ERR(pwrseq), -EINVAL);
+}
+
+/*
+ * Test that enabling and disabling a single-unit target increments and
+ * decrements enable_count correctly and fires the enable/disable callbacks
+ * exactly once.
+ */
+static void pwrseq_enable_disable(struct kunit *test)
+{
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device *pdev = test->priv;
+	struct platform_device_info pdevinfo;
+	struct pwrseq_target_data target;
+	struct pwrseq_test_ctx *ctx;
+	struct pwrseq_unit_data unit;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+	struct pwrseq_desc *desc;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	unit = (struct pwrseq_unit_data){
+		.name = "unit-a",
+		.enable = pwrseq_test_enable_a,
+		.disable = pwrseq_test_disable_a,
+	};
+
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &unit,
+	};
+
+	targets[0] = &target;
+
+	ctx->consumer_name = PWRSEQ_TEST_CONSUMER;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.drvdata = ctx,
+		.match = pwrseq_test_match_by_name,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pwrseq);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+	};
+
+	pdev = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	desc = kunit_pwrseq_get(test, &pdev->dev, "test-target");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, desc);
+
+	ret = pwrseq_enable(desc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_a, 1);
+	KUNIT_EXPECT_EQ(test, ctx->disable_count_a, 0);
+
+	ret = pwrseq_disable(desc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_a, 1);
+	KUNIT_EXPECT_EQ(test, ctx->disable_count_a, 1);
+}
+
+/*
+ * Test that two consumers sharing a common dependency unit cause it to be
+ * enabled only once and disabled only once, while enable_count tracks each
+ * consumer correctly.
+ */
+static void pwrseq_shared_deps(struct kunit *test)
+{
+	const struct pwrseq_unit_data *unit_a_deps[2] = { };
+	const struct pwrseq_unit_data *unit_b_deps[2] = { };
+	const struct pwrseq_target_data *targets[3] = { };
+	struct pwrseq_unit_data dep_unit, unit_a, unit_b;
+	struct pwrseq_target_data target_a, target_b;
+	struct platform_device *parent = test->priv;
+	struct platform_device *pdev_a, *pdev_b;
+	struct platform_device_info pdevinfo;
+	struct pwrseq_desc *desc_a, *desc_b;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+	struct pwrseq_test_ctx *ctx;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	dep_unit = (struct pwrseq_unit_data){
+		.name = "dep",
+		.enable = pwrseq_test_enable_a,
+		.disable = pwrseq_test_disable_a,
+	};
+
+	unit_a_deps[0] = &dep_unit;
+	unit_a = (struct pwrseq_unit_data){
+		.name = "unit-a",
+		.deps = unit_a_deps,
+		.enable = pwrseq_test_enable_b,
+		.disable = pwrseq_test_disable_b,
+	};
+
+	unit_b_deps[0] = &dep_unit;
+	unit_b = (struct pwrseq_unit_data){
+		.name = "unit-b",
+		.deps = unit_b_deps,
+	};
+
+	target_a = (struct pwrseq_target_data){
+		.name = "target-a",
+		.unit = &unit_a,
+	};
+	target_b = (struct pwrseq_target_data){
+		.name = "target-b",
+		.unit = &unit_b,
+	};
+
+	targets[0] = &target_a;
+	targets[1] = &target_b;
+
+	ctx->consumer_name = PWRSEQ_TEST_CONSUMER "-a";
+
+	config = (struct pwrseq_config){
+		.parent = &parent->dev,
+		.drvdata = ctx,
+		.match = pwrseq_test_match_by_name,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pwrseq);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_TEST_CONSUMER "-a",
+		.id = PLATFORM_DEVID_NONE,
+	};
+	pdev_a = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev_a);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_TEST_CONSUMER "-b",
+		.id = PLATFORM_DEVID_NONE,
+	};
+	pdev_b = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev_b);
+
+	/*
+	 * match_by_name() only matches one consumer name at a time, so
+	 * reconfigure ctx->consumer_name between the two pwrseq_get() calls
+	 * below to acquire descriptors for both consumer-a and consumer-b.
+	 */
+	desc_a = kunit_pwrseq_get(test, &pdev_a->dev, "target-a");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, desc_a);
+
+	ctx->consumer_name = PWRSEQ_TEST_CONSUMER "-b";
+	desc_b = kunit_pwrseq_get(test, &pdev_b->dev, "target-b");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, desc_b);
+
+	ret = pwrseq_enable(desc_a);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_a, 1);
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_b, 1);
+
+	ret = pwrseq_enable(desc_b);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_a, 1);
+
+	ret = pwrseq_disable(desc_a);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->disable_count_a, 0);
+	KUNIT_EXPECT_EQ(test, ctx->disable_count_b, 1);
+
+	ret = pwrseq_disable(desc_b);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->disable_count_a, 1);
+}
+
+/*
+ * Test that calling pwrseq_enable() twice on the same descriptor has no
+ * effect.
+ */
+static void pwrseq_enable_idempotent(struct kunit *test)
+{
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device *pdev = test->priv;
+	struct platform_device_info pdevinfo;
+	struct pwrseq_target_data target;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_unit_data unit;
+	struct pwrseq_config config;
+	struct pwrseq_test_ctx *ctx;
+	struct pwrseq_desc *desc;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	unit = (struct pwrseq_unit_data){
+		.name = "unit-a",
+		.enable = pwrseq_test_enable_a,
+		.disable = pwrseq_test_disable_a,
+	};
+
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &unit,
+	};
+
+	targets[0] = &target;
+
+	ctx->consumer_name = PWRSEQ_TEST_CONSUMER;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.drvdata = ctx,
+		.match = pwrseq_test_match_by_name,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pwrseq);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+	};
+
+	pdev = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	desc = kunit_pwrseq_get(test, &pdev->dev, "test-target");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, desc);
+
+	ret = pwrseq_enable(desc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_a, 1);
+
+	/* Second power_on on same descriptor must be a no-op. */
+	ret = pwrseq_enable(desc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_a, 1);
+
+	ret = pwrseq_disable(desc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->disable_count_a, 1);
+}
+
+/*
+ * Test that when a dependency unit's enable() callback fails, the error
+ * propagates to the caller, the top unit's enable callback is never reached,
+ * and target->post_enable() is never invoked.
+ */
+static void pwrseq_enable_enable_error(struct kunit *test)
+{
+	const struct pwrseq_target_data *targets[2] = { };
+	const struct pwrseq_unit_data *top_deps[2] = { };
+	struct pwrseq_unit_data dep_unit, top_unit;
+	struct platform_device *pdev = test->priv;
+	struct platform_device_info pdevinfo;
+	struct pwrseq_target_data target;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+	struct pwrseq_test_ctx *ctx;
+	struct pwrseq_desc *desc;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	dep_unit = (struct pwrseq_unit_data){
+		.name = "dep",
+		.enable = pwrseq_test_enable_a,
+	};
+
+	top_deps[0] = &dep_unit;
+	top_unit = (struct pwrseq_unit_data){
+		.name = "top",
+		.deps = top_deps,
+		.enable = pwrseq_test_enable_b,
+	};
+
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &top_unit,
+		.post_enable = pwrseq_test_post_enable,
+	};
+
+	targets[0] = &target;
+
+	ctx->consumer_name = PWRSEQ_TEST_CONSUMER;
+	ctx->enable_error_a = true;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.drvdata = ctx,
+		.match = pwrseq_test_match_by_name,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pwrseq);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+	};
+
+	pdev = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	desc = kunit_pwrseq_get(test, &pdev->dev, "test-target");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, desc);
+
+	ret = pwrseq_enable(desc);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+	/*
+	 * Dependency's enable() was attempted but failed, so it never
+	 * incremented.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->enable_calls_a, 1);
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_a, 0);
+	/* Target unit's enable() was never reached. */
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_b, 0);
+	/* Target's .post_enable() must not run on an unpowered sequencer. */
+	KUNIT_EXPECT_EQ(test, ctx->post_enable_calls, 0);
+}
+
+/*
+ * Test that when the top unit's own enable() callback fails after its
+ * dependency's enable() already succeeded, the dependency is rolled back.
+ */
+static void pwrseq_enable_rollback_on_top_failure(struct kunit *test)
+{
+	const struct pwrseq_target_data *targets[2] = { };
+	const struct pwrseq_unit_data *top_deps[2] = { };
+	struct pwrseq_unit_data dep_unit, top_unit;
+	struct platform_device *pdev = test->priv;
+	struct platform_device_info pdevinfo;
+	struct pwrseq_target_data target;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+	struct pwrseq_test_ctx *ctx;
+	struct pwrseq_desc *desc;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	dep_unit = (struct pwrseq_unit_data){
+		.name = "dep",
+		.enable = pwrseq_test_enable_a,
+		.disable = pwrseq_test_disable_a,
+	};
+
+	top_deps[0] = &dep_unit;
+	top_unit = (struct pwrseq_unit_data){
+		.name = "top",
+		.deps = top_deps,
+		.enable = pwrseq_test_enable_b,
+	};
+
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &top_unit,
+	};
+
+	targets[0] = &target;
+
+	ctx->consumer_name = PWRSEQ_TEST_CONSUMER;
+	ctx->enable_error_b = true;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.drvdata = ctx,
+		.match = pwrseq_test_match_by_name,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pwrseq);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+	};
+
+	pdev = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	desc = kunit_pwrseq_get(test, &pdev->dev, "test-target");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, desc);
+
+	ret = pwrseq_enable(desc);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+	/*
+	 * Dependency was enabled, then rolled back once top's own enable
+	 * failed.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_a, 1);
+	KUNIT_EXPECT_EQ(test, ctx->disable_count_a, 1);
+	/*
+	 * Target unit's own enable never incremented since it returned an
+	 * error.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_b, 0);
+}
+
+/*
+ * Test target->post_enable() on both the success and failure paths: it must
+ * run exactly once per pwrseq_enable() call that actually powers the target
+ * unit on, and a failing post_enable() must roll the unit back and clear
+ * powered_on so a subsequent pwrseq_enable() is called again.
+ */
+static void pwrseq_enable_post_enable(struct kunit *test)
+{
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device *pdev = test->priv;
+	struct platform_device_info pdevinfo;
+	struct pwrseq_target_data target;
+	struct pwrseq_unit_data unit;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+	struct pwrseq_test_ctx *ctx;
+	struct pwrseq_desc *desc;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	unit = (struct pwrseq_unit_data){
+		.name = "unit-a",
+		.enable = pwrseq_test_enable_a,
+		.disable = pwrseq_test_disable_a,
+	};
+
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &unit,
+		.post_enable = pwrseq_test_post_enable,
+	};
+
+	targets[0] = &target;
+
+	ctx->consumer_name = PWRSEQ_TEST_CONSUMER;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.drvdata = ctx,
+		.match = pwrseq_test_match_by_name,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pwrseq);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+	};
+
+	pdev = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	desc = kunit_pwrseq_get(test, &pdev->dev, "test-target");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, desc);
+
+	/* Success path: post_enable() runs once and reports success. */
+	ret = pwrseq_enable(desc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->post_enable_calls, 1);
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_a, 1);
+
+	ret = pwrseq_disable(desc);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* Failure path: post_enable() fails, unit is rolled back. */
+	ctx->post_enable_error = true;
+	ret = pwrseq_enable(desc);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+	KUNIT_EXPECT_EQ(test, ctx->post_enable_calls, 2);
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_a, 2);
+	KUNIT_EXPECT_EQ(test, ctx->disable_count_a, 2);
+
+	/* powered_on must have been cleared. */
+	ret = pwrseq_enable(desc);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+	KUNIT_EXPECT_EQ(test, ctx->enable_count_a, 3);
+}
+
+/*
+ * Test that pwrseq_get() returns -ENOENT when the matched provider does not
+ * have the requested target name.
+ */
+static void pwrseq_get_target_not_found(struct kunit *test)
+{
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device *pdev = test->priv;
+	struct platform_device_info pdevinfo;
+	struct pwrseq_target_data target;
+	struct pwrseq_unit_data unit;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+	struct pwrseq_desc *desc;
+
+	unit = (struct pwrseq_unit_data){
+		.name = "unit-a",
+	};
+
+	target = (struct pwrseq_target_data){
+		.name = "real-target",
+		.unit = &unit,
+	};
+
+	targets[0] = &target;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.match = pwrseq_test_match_always,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pwrseq);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+	};
+
+	pdev = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	desc = kunit_pwrseq_get(test, &pdev->dev, "nonexistent-target");
+	KUNIT_EXPECT_TRUE(test, IS_ERR(desc));
+	KUNIT_EXPECT_EQ(test, PTR_ERR(desc), -ENOENT);
+}
+
+/*
+ * Test that pwrseq_put() on a descriptor that is still powered on disables
+ * it as part of tear-down, instead of leaking the power-on state.
+ */
+static void pwrseq_put_disables_powered_desc(struct kunit *test)
+{
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device *pdev = test->priv;
+	struct platform_device_info pdevinfo;
+	struct pwrseq_target_data target;
+	struct pwrseq_unit_data unit;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_test_ctx *ctx;
+	struct pwrseq_config config;
+	struct pwrseq_desc *desc;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	unit = (struct pwrseq_unit_data){
+		.name = "unit-a",
+		.enable = pwrseq_test_enable_a,
+		.disable = pwrseq_test_disable_a,
+	};
+
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &unit,
+	};
+
+	targets[0] = &target;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.drvdata = ctx,
+		.match = pwrseq_test_match_always,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pwrseq);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+	};
+
+	pdev = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	desc = kunit_pwrseq_get(test, &pdev->dev, "test-target");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, desc);
+
+	ret = pwrseq_enable(desc);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->disable_count_a, 0);
+
+	/*
+	 * Run the deferred pwrseq_put() action now instead of at test
+	 * teardown, so its effect can be asserted below.
+	 */
+	kunit_release_action(test, pwrseq_put_wrapper, desc);
+	KUNIT_EXPECT_EQ(test, ctx->disable_count_a, 1);
+}
+
+/*
+ * Test that pwrseq_device_unregister() on a target with an active user
+ * triggers "REMOVING POWER SEQUENCER WITH ACTIVE USERS", and that both
+ * pwrseq_enable() and pwrseq_disable() start returning -ENODEV for
+ * previously acquired descriptors afterwards.
+ */
+static void pwrseq_unregister_with_active_user(struct kunit *test)
+{
+	struct platform_device *pdev = test->priv, *cons_a, *cons_b;
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device_info pdevinfo;
+	struct pwrseq_desc *desc_a, *desc_b;
+	struct pwrseq_target_data target;
+	struct pwrseq_unit_data unit;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_test_ctx *ctx;
+	struct pwrseq_config config;
+	bool bound;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	unit = (struct pwrseq_unit_data){
+		.name = "unit-a",
+		.enable = pwrseq_test_enable_a,
+		.disable = pwrseq_test_disable_a,
+	};
+
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &unit,
+	};
+
+	targets[0] = &target;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.drvdata = ctx,
+		.match = pwrseq_test_match_always,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pwrseq);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_TEST_CONSUMER,
+		.id = 0,
+	};
+	cons_a = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cons_a);
+
+	wait_for_device_probe();
+	scoped_guard(device, &cons_a->dev)
+		bound = device_is_bound(&cons_a->dev);
+
+	KUNIT_ASSERT_FALSE(test, bound);
+
+	pdevinfo.id = 1;
+	cons_b = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cons_b);
+
+	wait_for_device_probe();
+	scoped_guard(device, &cons_b->dev)
+		bound = device_is_bound(&cons_b->dev);
+
+	KUNIT_ASSERT_FALSE(test, bound);
+
+	desc_a = kunit_pwrseq_get(test, &cons_a->dev, "test-target");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, desc_a);
+	desc_b = kunit_pwrseq_get(test, &cons_b->dev, "test-target");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, desc_b);
+
+	ret = pwrseq_enable(desc_a);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	kunit_warning_suppress(test) {
+		kunit_release_action(test, pwrseq_device_unregister_wrapper, pwrseq);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+
+	ret = pwrseq_enable(desc_b);
+	KUNIT_EXPECT_EQ(test, ret, -ENODEV);
+
+	ret = pwrseq_disable(desc_a);
+	KUNIT_EXPECT_EQ(test, ret, -ENODEV);
+}
+
+/*
+ * Test that pwrseq_to_device() returns the pwrseq provider's own device,
+ * and NULL for a NULL descriptor.
+ */
+static void pwrseq_to_device_test(struct kunit *test)
+{
+	struct platform_device *parent = test->priv, *cons;
+	const struct pwrseq_target_data *targets[2] = { };
+	struct platform_device_info pdevinfo;
+	struct pwrseq_target_data target;
+	struct pwrseq_unit_data unit;
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_config config;
+	struct pwrseq_desc *desc;
+	struct device *dev;
+
+	unit = (struct pwrseq_unit_data){ .name = "unit-a" };
+	target = (struct pwrseq_target_data){
+		.name = "test-target",
+		.unit = &unit,
+	};
+	targets[0] = &target;
+
+	config = (struct pwrseq_config){
+		.parent = &parent->dev,
+		.match = pwrseq_test_match_always,
+		.targets = targets,
+	};
+
+	pwrseq = kunit_pwrseq_device_register(test, &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pwrseq);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+	};
+
+	cons = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cons);
+
+	desc = kunit_pwrseq_get(test, &cons->dev, "test-target");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, desc);
+
+	dev = pwrseq_to_device(desc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	KUNIT_EXPECT_PTR_EQ(test, dev->parent, &parent->dev);
+	KUNIT_EXPECT_TRUE(test, device_is_registered(dev));
+
+	KUNIT_EXPECT_PTR_EQ(test, pwrseq_to_device(NULL), NULL);
+}
+
+static struct kunit_case pwrseq_tests[] = {
+	KUNIT_CASE(pwrseq_circular_deps),
+	KUNIT_CASE(pwrseq_circular_deps_chain),
+	KUNIT_CASE(pwrseq_register_valid),
+	KUNIT_CASE(pwrseq_register_invalid_args),
+	KUNIT_CASE(pwrseq_register_target_without_unit),
+	KUNIT_CASE(pwrseq_enable_disable),
+	KUNIT_CASE(pwrseq_shared_deps),
+	KUNIT_CASE(pwrseq_enable_idempotent),
+	KUNIT_CASE(pwrseq_enable_enable_error),
+	KUNIT_CASE(pwrseq_enable_rollback_on_top_failure),
+	KUNIT_CASE(pwrseq_enable_post_enable),
+	KUNIT_CASE(pwrseq_get_target_not_found),
+	KUNIT_CASE(pwrseq_put_disables_powered_desc),
+	KUNIT_CASE(pwrseq_unregister_with_active_user),
+	KUNIT_CASE(pwrseq_to_device_test),
+	{ }
+};
+
+static struct kunit_suite pwrseq_test_suite = {
+	.name = "pwrseq",
+	.init = pwrseq_test_parent_init,
+	.test_cases = pwrseq_tests,
+};
+
+/*
+ * Match a consumer to this test provider by resolving its "pwrseq-provider"
+ * software-node reference and comparing it to the provider's own fwnode.
+ */
+static int pwrseq_test_match_by_swnode_ref(struct pwrseq_device *pwrseq,
+					   struct device *dev)
+{
+	const struct software_node *provider_swnode;
+	struct fwnode_handle *provider_fwnode, *ref;
+	bool match;
+
+	if (!dev_fwnode(dev))
+		return PWRSEQ_NO_MATCH;
+
+	ref = fwnode_find_reference(dev_fwnode(dev), "pwrseq-provider", 0);
+	if (IS_ERR_OR_NULL(ref))
+		return PWRSEQ_NO_MATCH;
+
+	provider_swnode = pwrseq_device_get_drvdata(pwrseq);
+	provider_fwnode = software_node_fwnode(provider_swnode);
+	match = (ref == provider_fwnode);
+	fwnode_handle_put(ref);
+
+	return match ? PWRSEQ_MATCH_OK : PWRSEQ_NO_MATCH;
+}
+
+static const struct pwrseq_unit_data pwrseq_swnode_test_unit = {
+	.name = "test-target",
+};
+
+static const struct pwrseq_target_data pwrseq_swnode_test_target = {
+	.name = "test-target",
+	.unit = &pwrseq_swnode_test_unit,
+};
+
+static const struct pwrseq_target_data *pwrseq_swnode_test_targets[] = {
+	&pwrseq_swnode_test_target,
+	NULL,
+};
+
+struct pwrseq_swnode_provider_pdata {
+	const struct software_node *provider_swnode;
+};
+
+static int pwrseq_swnode_provider_probe(struct platform_device *pdev)
+{
+	const struct pwrseq_swnode_provider_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct pwrseq_config config;
+
+	config = (struct pwrseq_config){
+		.parent = &pdev->dev,
+		.drvdata = (void *)pdata->provider_swnode,
+		.match = pwrseq_test_match_by_swnode_ref,
+		.targets = pwrseq_swnode_test_targets,
+	};
+
+	return PTR_ERR_OR_ZERO(devm_pwrseq_device_register(&pdev->dev, &config));
+}
+
+static struct platform_driver pwrseq_swnode_provider_driver = {
+	.probe = pwrseq_swnode_provider_probe,
+	.driver = {
+		.name = PWRSEQ_SWNODE_TEST_PROVIDER,
+	},
+};
+
+static struct platform_driver pwrseq_swnode_provider_driver_2 = {
+	.probe = pwrseq_swnode_provider_probe,
+	.driver = {
+		.name = PWRSEQ_SWNODE_TEST_PROVIDER_2,
+	},
+};
+
+struct pwrseq_probe_order_pdata {
+	unsigned int probe_count;
+	int pwrseq_err;
+};
+
+static const struct pwrseq_probe_order_pdata pwrseq_probe_order_pdata_template;
+
+static int pwrseq_probe_order_consumer_probe(struct platform_device *pdev)
+{
+	struct pwrseq_probe_order_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct pwrseq_desc *desc;
+
+	pdata->probe_count++;
+
+	desc = devm_pwrseq_get(&pdev->dev, "test-target");
+	pdata->pwrseq_err = PTR_ERR_OR_ZERO(desc);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	return 0;
+}
+
+static struct platform_driver pwrseq_probe_order_consumer_driver = {
+	.probe = pwrseq_probe_order_consumer_probe,
+	.driver = {
+		.name = PWRSEQ_PROBE_ORDER_TEST_CONSUMER,
+	},
+};
+
+static struct platform_driver pwrseq_probe_defer_consumer_driver = {
+	.probe = pwrseq_probe_order_consumer_probe,
+	.driver = {
+		.name = PWRSEQ_PROBE_DEFER_TEST_CONSUMER,
+	},
+};
+
+/*
+ * Verify that driver core orders the probe of a pwrseq consumer after its
+ * provider. The consumer references the provider through a software node and
+ * is registered first and we rely on devlink for ordering.
+ */
+static void pwrseq_swnode_probe_order(struct kunit *test)
+{
+	struct property_entry properties[2] = { };
+	struct pwrseq_probe_order_pdata *pdata;
+	struct platform_device_info pdevinfo;
+	struct platform_device *prvd, *cons;
+	struct fwnode_handle *fwnode;
+	bool bound = false;
+	int ret;
+
+	ret = kunit_platform_driver_register(test, &pwrseq_swnode_provider_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_platform_driver_register(test, &pwrseq_probe_order_consumer_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fwnode = kunit_software_node_register(test, &pwrseq_test_provider_swnode);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
+
+	properties[0] = PROPERTY_ENTRY_REF("pwrseq-provider",
+					   &pwrseq_test_provider_swnode);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_PROBE_ORDER_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+		.data = &pwrseq_probe_order_pdata_template,
+		.size_data = sizeof(pwrseq_probe_order_pdata_template),
+		.properties = properties,
+	};
+
+	cons = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cons);
+
+	wait_for_device_probe();
+	scoped_guard(device, &cons->dev)
+		bound = device_is_bound(&cons->dev);
+
+	KUNIT_ASSERT_FALSE(test, bound);
+
+	pdata = dev_get_platdata(&cons->dev);
+	KUNIT_ASSERT_EQ(test, pdata->probe_count, 0);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_SWNODE_TEST_PROVIDER,
+		.id = PLATFORM_DEVID_NONE,
+		.swnode = &pwrseq_test_provider_swnode,
+		.data = &(const struct pwrseq_swnode_provider_pdata){
+			.provider_swnode = &pwrseq_test_provider_swnode,
+		},
+		.size_data = sizeof(struct pwrseq_swnode_provider_pdata),
+	};
+
+	prvd = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, prvd);
+
+	wait_for_device_probe();
+
+	scoped_guard(device, &prvd->dev)
+		bound = device_is_bound(&prvd->dev);
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	scoped_guard(device, &cons->dev)
+		bound = device_is_bound(&cons->dev);
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	pdata = dev_get_platdata(&cons->dev);
+	KUNIT_EXPECT_EQ(test, pdata->probe_count, 1);
+	KUNIT_EXPECT_EQ(test, pdata->pwrseq_err, 0);
+}
+
+/*
+ * Verify that a pwrseq consumer referencing a provider whose software node is
+ * not registered yet, defers its probe instead of failing.
+ *
+ * The provider software node is deliberately left unregistered when the
+ * consumer is added. fw_devlink cannot resolve the reference, so it creates no
+ * supplier link and does not order the consumer - the consumer's probe() runs
+ * and calls pwrseq_get(), which finds no matching provider and returns
+ * -EPROBE_DEFER. Once the provider software node and device appear, the
+ * deferred consumer probes again and binds.
+ */
+static void pwrseq_swnode_probe_defer_on_unregistered(struct kunit *test)
+{
+	struct property_entry properties[2] = { };
+	struct pwrseq_probe_order_pdata *pdata;
+	struct platform_device_info pdevinfo;
+	struct platform_device *prvd, *cons;
+	struct fwnode_handle *fwnode;
+	bool bound = false;
+	int ret;
+
+	ret = kunit_platform_driver_register(test, &pwrseq_swnode_provider_driver_2);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_platform_driver_register(test, &pwrseq_probe_defer_consumer_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	properties[0] = PROPERTY_ENTRY_REF("pwrseq-provider",
+					   &pwrseq_test_provider_swnode);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_PROBE_DEFER_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+		.data = &pwrseq_probe_order_pdata_template,
+		.size_data = sizeof(pwrseq_probe_order_pdata_template),
+		.properties = properties,
+	};
+
+	cons = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cons);
+
+	wait_for_device_probe();
+	scoped_guard(device, &cons->dev)
+		bound = device_is_bound(&cons->dev);
+
+	KUNIT_ASSERT_FALSE(test, bound);
+
+	pdata = dev_get_platdata(&cons->dev);
+	KUNIT_ASSERT_GT(test, pdata->probe_count, 0);
+	KUNIT_ASSERT_EQ(test, pdata->pwrseq_err, -EPROBE_DEFER);
+
+	fwnode = kunit_software_node_register(test, &pwrseq_test_provider_swnode);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
+
+	pdevinfo = (struct platform_device_info){
+		.name = PWRSEQ_SWNODE_TEST_PROVIDER_2,
+		.id = PLATFORM_DEVID_NONE,
+		.swnode = &pwrseq_test_provider_swnode,
+		.data = &(const struct pwrseq_swnode_provider_pdata){
+			.provider_swnode = &pwrseq_test_provider_swnode,
+		},
+		.size_data = sizeof(struct pwrseq_swnode_provider_pdata),
+	};
+
+	prvd = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, prvd);
+
+	wait_for_device_probe();
+
+	scoped_guard(device, &prvd->dev)
+		bound = device_is_bound(&prvd->dev);
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	scoped_guard(device, &cons->dev)
+		bound = device_is_bound(&cons->dev);
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	pdata = dev_get_platdata(&cons->dev);
+	KUNIT_EXPECT_EQ(test, pdata->pwrseq_err, 0);
+}
+
+static int pwrseq_swnode_test_init(struct kunit *test)
+{
+	/*
+	 * A device link teardown from an earlier test case, or from this
+	 * suite's previous module load, may still be queued on device_link_mq.
+	 * Flush it so software_node_register() below doesn't spuriously see
+	 * the about-to-be-reused node name as still taken.
+	 */
+	device_link_wait_removal();
+
+	return 0;
+}
+
+static struct kunit_case pwrseq_swnode_probe_order_tests[] = {
+	KUNIT_CASE(pwrseq_swnode_probe_order),
+	KUNIT_CASE(pwrseq_swnode_probe_defer_on_unregistered),
+	{ }
+};
+
+static struct kunit_suite pwrseq_swnode_probe_order_test_suite = {
+	.name = "pwrseq-swnode-probe-order",
+	.init = pwrseq_swnode_test_init,
+	.test_cases = pwrseq_swnode_probe_order_tests,
+};
+
+kunit_test_suites(&pwrseq_test_suite,
+		  &pwrseq_swnode_probe_order_test_suite);
+
+MODULE_DESCRIPTION("KUnit test cases for the power sequencing subsystem");
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>");
+MODULE_LICENSE("GPL");

-- 
2.47.3

