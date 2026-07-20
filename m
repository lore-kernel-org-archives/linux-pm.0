Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B43CBE70
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534661; cv=none; b=n0A0hC+2wvawReWIoBNJZ0gDX6ykD3M6cQgsBo3zZ927pckMlj945KNzhRGaG/gjILsVB8LSIrGhJBM3H700G7B0MnDEO+qabYSDbXZhzUVfkaS+7iBkayZ6Y+gdq6/ibLCFmX0y3OdBZQuI590pqVHWAKJ7kwyjL38BcNX0cSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534661; c=relaxed/simple;
	bh=OvZGQdRrKQ1cKCtBZ2vJJlctMXShVHIPX/EnnD1FRmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EyqdSFqWmVwpy7st1IztWLf9f2+4WLa0eanZSNzMz9jLXSsZO6/pjLtRMcAXzH+kJ2IUGqF8oghCVOEZfbcBJ4q9YyYAJmwPWj9zrCJTGWzjfbgvmKBzv8630xAipkCJNRxvn2ijyBrbUgmNBxV8badxhwg2VdzoF8sw0mhSOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fD1FRDv5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NTAufNRO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fD1FRDv5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NTAufNRO"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RWpp1665624
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rBvoXcE6fyfh67dFVJmu8Fy0oBNY0thH0kUQWM4o/d4=; b=fD1FRDv5ltTwAYzp
	9AyJ8FEUcIOia4aZfjdkyZps3qII9mesgGOHSH+XfJgTjXjT/LarOKF5fvVSvtB6
	yJ3udarldBb4pT7KhZaobbweLzIAI0TEMe0Y65+4G4Ff6VXRRDabZ7kDh8468Mc6
	oI5zVEVtxa4K18sR8T7VMUj9ffYGrLzexk0yfqNl6hwFMYm0KgiL86ASBNl7vW/e
	qaIe05UEsXd6cjkPww9ONxeuRRZ3K5LgqLBWm1Ggzq3Axiqsyadq6/2tK7QlFij+
	IM3l9mq1MltLxgH4ncZ85zP+MMNXKpXdyfyBLcBBWs8qpciZkDrkPc6I3WcKx7f7
	KvBu+A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04v2t5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c12e43b98so193995391cf.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534654; x=1785139454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rBvoXcE6fyfh67dFVJmu8Fy0oBNY0thH0kUQWM4o/d4=;
        b=NTAufNROBswr54aO1eaA1syZf1BVbEt4i21uk7gPUcSW2+C9jF9PAYDbprM1z9T6Ui
         FMK4ZbNDuvZc75REb/cHCuA/FSNuJP6WdtHdGdg/UfSc+Fr/nGRsMf8ZUXY8cCzfiC6s
         iRhQqXVgHTe+FCHf+cEFnPyERo7gAbs5iTDqUF4yYzNUXXG7yWbXjt6YwKIaJg1o2MsZ
         M/t1l4WMek3x62otjkO087x0mpkxzV1nayP94LijBa7OhGOV/7Ls0a/9KSaQF0oDC8xk
         JliqFd3kVCNl4r9NsTQBjWRKF/xDihUQ52pn775+lDczaYzcZ4HQ7jvKSpMn1ZgFAN5v
         QbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534654; x=1785139454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBvoXcE6fyfh67dFVJmu8Fy0oBNY0thH0kUQWM4o/d4=;
        b=mwFbfqKdscZfUeOyVUz40lLQDN1R7vYqIkYb1aUtK6N/mU6iwtqrLDy/L1WhEF1Uv/
         70Dp+rWBiRokk7hDbM+b1Hb5Hfy2VOCMARz9AgJgrUTU2KSDY5G3UFCgOkgrYGGCFHN1
         ZnsxpDm1xXMyUpOe+dpCv+8j6HYxROUTI/KTKwXHWAvyCerCrHmIOtNX1Pk/InfihifN
         PvpROQlMv8br10qFv7tP7a559nvl7pwO7hoApynAwlp7zUWhlLPRHIc4+7JhuP3Rke+m
         yPyTjmQenH+UJ9Wd9fYquiveTvkPJV6TMbAI3VyVV4OCWVFc+Z8PZ77e1xIl9ZbUWHjL
         3YQQ==
X-Forwarded-Encrypted: i=1; AHgh+RrA03VysmWvIkwtItbYjjgOAqUFdq+w9gfWPuDGicM+5dyyTLRh315aWMRVq/2KxDjNAT1t30jQZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAYOzYaQRrMYUsW1YBnMTCp3o23IqPJW2oBoLJlRYbISFeutHP
	yzjo5XkmQNBcFZoLovjYD1IHKTrdT0uIrbtF2GvxegvlFkf7gpWlaMre6Cel0J3xr3KvtcJpASC
	osy1DLwQ1ADz65YfRFikbhMMRqO2Luz1CYgZuHoxaAZqLHhqnbf1Xu9/1zDMrxw==
X-Gm-Gg: AfdE7clu4N+LE4UrVE/qn8hIoqVn9GLqmQSFTs/hqc9SbN1oYXJv2ujM4HK4hM5GRK3
	zwYBTz7r6j4GKKBpiL4cGyUz8Pa/h4wkntz9gsXVZ3ra+G6SD3TwBNlaymIrEEpxHsauGBkbwgG
	/PKOn18eP4tg2MjSPkWRU0OLiv3dh5T10DZRbBqX3bi5oP6/F39twz/TOw4MIvq3MpZdhVB6Adf
	sJY5W2zCMArpns5jjshFDh3HWf0ZoiYQ5pweK7ANfF5TsV2MfRUYRtBVaxGaunDmIHKPOzO6Ugo
	h9EpAM6q86QnHx673f9eMQrf85+HzS+odJu/vuHH7MXdeCabeGjag+aaU4FrthJ0TBiKG7Le5O/
	sJiqD4kX/d9vJskX7l06GJtRuONw2Pvl7AEYgbffQpIU2qUjC+H7subOyB4vQq+3qzKyqHYh/fb
	6I22N6L8KJlMBuM9pMG8rSl1Q7JMwRyDBiUG3uaa7DDW81vnjCaTo=
X-Received: by 2002:ac8:7fd5:0:b0:51c:7b13:62f3 with SMTP id d75a77b69052e-5213e67ff0bmr121551111cf.73.1784534653669;
        Mon, 20 Jul 2026 01:04:13 -0700 (PDT)
X-Received: by 2002:ac8:7fd5:0:b0:51c:7b13:62f3 with SMTP id d75a77b69052e-5213e67ff0bmr121550961cf.73.1784534653113;
        Mon, 20 Jul 2026 01:04:13 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:11 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:05 +0200
Subject: [PATCH v5 03/11] power: sequencing: Add pwrseq_is_controllable()
 API
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-3-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5dd67e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=4a-8Ivk512-2hps7UIkA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX+TzfuR46BxFk
 xDWaBzMUs7G7Ms3dZ/CmAsHXS9g/6PNbQ1gTtPOhJ48o1GmoXHazMRZN7onu21T+GtdNXrkg6lv
 BpbbIL0Xeqe7o+T/d+bF7g6+fGccY4Rm6Fi5/7whAzaEEF6MNrc7QOKSUCCS2EyduypbC4qzMMv
 MVQNrgLnw0BkZyOgDNulLMFTJrpBrdfKo44F2eiqpfG/8otfZ26n/nOphpoiAr4exzXFe5IGlTP
 /2gsovTxGcz/H+yAWKvhuC4v0+M4A2GWkdYpzX3IfBnvOCXhsOwgYXoUgZFYc9IZQvDOZs+h6np
 Dvf37d0GutjlAJ4s2Iq71pCrOLPodsDp3Fs9MFYbH9x90zua2FNe+iE7x13t3DrqztSFQTjg38B
 rln5z1fTTR885kR6HYDGdRlATNTUd4XUN7FLYZ2/EIW08n5qG41EHRHEE0B9c0yHLytEuxZ3HXN
 ON6DchjLlip5r/O1tbQ==
X-Proofpoint-ORIG-GUID: CgSo3GFvYzlHER7I41P81zW-i2TahIuJ
X-Proofpoint-GUID: CgSo3GFvYzlHER7I41P81zW-i2TahIuJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX75H8DDdnIsN3
 rC8IPx0Lm1YwzYRn/KkzWpasF4kfigmy9kUFF25rUEtwlgGUQsP2yCrMVSA4Y75iN99vmKQqrqd
 6Hhd1lYSKvy8SF/JwAHYbSkfFWFeEM8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088

On some boards a power sequencing target has no host-controllable enable
for its function, for instance when the enable line is not wired up to a
GPIO and is hardwired to an always-on level. The pcie-m2 "uart" target is
one such example: when the M.2 connector does not route the W_DISABLE2#
signal to a host GPIO, its enable/disable are no-ops and the consumer
cannot gate the Bluetooth function at all or exclusively.

Add a generic pwrseq_is_controllable() helper. It reports whether the
target's final unit provides a host-controllable dedicated power actuator.
The target can implement a new optional is_controllable() callback,
reporting whether that actuator is effective on this target (for example
depending on GPIO presence). If the target does not provide the callback,
it is assumed to be controllable.

Note this only describes the target's own enable actuator. It does not
imply that a power-off reaches an electrical OFF state, since a target may
have multiple consumers. It also does not mean that power is uncontrolled
for the target's dependencies: those may still be gated on their own. And
it does not restrict consumers from calling pwrseq_power_off() either,
which remains valid to drop this consumer's vote on the (possibly shared)
resources and dependencies of the target.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 49 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pwrseq/consumer.h |  7 ++++++
 include/linux/pwrseq/provider.h |  8 +++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 02f42da915985339d3de507fc36dd158b0035a99..cabb3d0885f94d9d70e0631861ed6905d91ad3bc 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -182,12 +182,15 @@ static void pwrseq_unit_release(struct kref *ref)
  *               the state lock has been released. It's useful for implementing
  *               boot-up delays without blocking other users from powering up
  *               using the same power sequencer.
+ * @is_controllable: Optional callback reporting whether enabling/disabling
+ *                   this target actually controls power.
  */
 struct pwrseq_target {
 	struct list_head list;
 	const char *name;
 	struct pwrseq_unit *unit;
 	pwrseq_power_state_func post_enable;
+	pwrseq_is_controllable_func is_controllable;
 };
 
 static struct pwrseq_target *
@@ -206,6 +209,7 @@ pwrseq_target_new(const struct pwrseq_target_data *data)
 	}
 
 	target->post_enable = data->post_enable;
+	target->is_controllable = data->is_controllable;
 
 	return target;
 }
@@ -991,6 +995,51 @@ struct device *pwrseq_to_device(struct pwrseq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(pwrseq_to_device);
 
+/**
+ * pwrseq_is_controllable() - Check whether the target provides a
+ *                            host-controllable power actuator.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * Some power sequencing targets provide no host-controllable enable for their
+ * function on a given board, for instance when the enable line is not wired up
+ * and is instead hardwired to an always-on level. For such targets a call to
+ * pwrseq_power_off() is still allowed, so that the consumer can drop its vote
+ * on the (possibly shared) resources, but the host cannot gate the function
+ * on its own.
+ *
+ * Returns:
+ * True if the target provides a host-controllable power actuator, false
+ * otherwise. Also returns false if @desc is NULL.
+ */
+bool pwrseq_is_controllable(struct pwrseq_desc *desc)
+{
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_target *target;
+	struct pwrseq_unit *unit;
+
+	might_sleep();
+
+	if (!desc)
+		return false;
+
+	pwrseq = desc->pwrseq;
+	target = desc->target;
+	unit = target->unit;
+
+	guard(rwsem_read)(&pwrseq->rw_lock);
+	if (!device_is_registered(&pwrseq->dev))
+		return false;
+
+	if (!unit->enable && !unit->disable)
+		return false;
+
+	if (!target->is_controllable)
+		return true;
+
+	return target->is_controllable(pwrseq);
+}
+EXPORT_SYMBOL_GPL(pwrseq_is_controllable);
+
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
 struct pwrseq_debugfs_count_ctx {
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 3c907c9e1885dc2958043a9a733fbe20bdf95f6e..f70f694c19ab73f70ccf775aa24902bfcc982a42 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -25,6 +25,8 @@ int pwrseq_power_off(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
+bool pwrseq_is_controllable(struct pwrseq_desc *desc);
+
 #else /* CONFIG_POWER_SEQUENCING */
 
 static inline struct pwrseq_desc * __must_check
@@ -58,6 +60,11 @@ static inline struct device *pwrseq_to_device(struct pwrseq_desc *desc)
 	return NULL;
 }
 
+static inline bool pwrseq_is_controllable(struct pwrseq_desc *desc)
+{
+	return false;
+}
+
 #endif /* CONFIG_POWER_SEQUENCING */
 
 #endif /* __POWER_SEQUENCING_CONSUMER_H__ */
diff --git a/include/linux/pwrseq/provider.h b/include/linux/pwrseq/provider.h
index 33b3d2c2e39decafac6c6fca9254ad4329d90e94..7285ad94a2214070a1c27f25c783f51105705b36 100644
--- a/include/linux/pwrseq/provider.h
+++ b/include/linux/pwrseq/provider.h
@@ -6,12 +6,15 @@
 #ifndef __POWER_SEQUENCING_PROVIDER_H__
 #define __POWER_SEQUENCING_PROVIDER_H__
 
+#include <linux/types.h>
+
 struct device;
 struct module;
 struct pwrseq_device;
 
 typedef int (*pwrseq_power_state_func)(struct pwrseq_device *);
 typedef int (*pwrseq_match_func)(struct pwrseq_device *, struct device *);
+typedef bool (*pwrseq_is_controllable_func)(struct pwrseq_device *);
 
 #define PWRSEQ_NO_MATCH 0
 #define PWRSEQ_MATCH_OK 1
@@ -43,11 +46,16 @@ struct pwrseq_unit_data {
  *               the state lock has been released. It's useful for implementing
  *               boot-up delays without blocking other users from powering up
  *               using the same power sequencer.
+ * @is_controllable: Optional callback checking whether enabling/disabling this
+ *                   target actually controls power (for example when the
+ *                   controlling GPIO is wired up). If not provided, the
+ *                   target's power is assumed to be always controllable.
  */
 struct pwrseq_target_data {
 	const char *name;
 	const struct pwrseq_unit_data *unit;
 	pwrseq_power_state_func post_enable;
+	pwrseq_is_controllable_func is_controllable;
 };
 
 /**

-- 
2.34.1

