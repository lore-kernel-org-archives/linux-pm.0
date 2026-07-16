Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DACC376A04
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218719; cv=none; b=KUaOGTyQdGcu2l5ieB/75s2SPlP/AZeUx+9pgif5gR57n5eoGzv/l+InjyLdbJ4pMeq+5TBIBJe7L8p9fUdlv8ycRWNWHlPA8N0PdPAJMdsaDUlCwJGlRHAel5tVYkuXMJGibPf60AJZD+2SMPTbWzlbAZFG5hJ7qUFzJC9VJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218719; c=relaxed/simple;
	bh=OvZGQdRrKQ1cKCtBZ2vJJlctMXShVHIPX/EnnD1FRmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ka9Tx9ttQpgTtqbZ/BVBHRjndGFHYrc5jt69FQCqK2aGF9nGJ2161OKDsEwsqBusjneexuPAFS7wiq+rdmwQ0JeB67Ych6ox9N/XclMZ+VeLBPwIz8pnvDJjGzEaG2qCneJybag9X6cfZmjtWHTl58OofyPNtmGaH68yC1vHftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CnSn1BRp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SB7Fjzz1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CnSn1BRp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SB7Fjzz1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJolm2734544
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rBvoXcE6fyfh67dFVJmu8Fy0oBNY0thH0kUQWM4o/d4=; b=CnSn1BRpTHnJbFGf
	+T/6tewwxH6wTIdT0lXcjtg3atp9yuC5+r1BGMEx/6ME8clCZqHN5QYZY29MyPRV
	vjlbCxinuqm/0qULVrWZt7GEfSOr5TGDUFPLIgPEq3x+wPwJ/vvFoC9s2MTLjTa2
	n7Xkzy4O8QTcG0fYsJGuuxylsYuPutVCSEdlPlRUhHIuAB2DPnTr1GlbTYSaDXI7
	3NfO/kFdk/q7jZTftR/lKDXGmMHcx5UQb0Neym0uUucX3JvFftGrEOaShPJxc5ub
	3vb06u/V/pAEh+j0BF1E7neqB1N6Bre5F7nSOnCYaDFShH5CtThMyq5xm+mu6/Ju
	nJZp8w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv1ufc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c21c01cf3so67929371cf.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218709; x=1784823509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rBvoXcE6fyfh67dFVJmu8Fy0oBNY0thH0kUQWM4o/d4=;
        b=SB7Fjzz1UP3Kj0yNGAWVrg+afazPamEP+b6hNp/KUuXGp6bh2gOTflYM48fqAKat5B
         KE+gEwE0VKaX9x3/TIy0Fuzbo7rRvrvm4kImaQxxAYYG/4nmakT1VztBMA/YPLg9Yi9A
         D+vw4xLdK6LnSxwPXtcwPZVOjFqaGNVXiNXHIc/iGxqnJVwslsAntAm8uZNC3/TreK0C
         Y30OuFTBIkEMeIUkgA0oB+QdXuWEzLuIA7lzblsjHPitbFYOUszYPBRL5dYvGhTEOVq5
         BGuyxm1gYsfxApPrCJs62etTdquQ3zwVDyg2m5dyauP/hpTKBjlliDCB833c1sB5hvBi
         2QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218709; x=1784823509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBvoXcE6fyfh67dFVJmu8Fy0oBNY0thH0kUQWM4o/d4=;
        b=X22Czuwr2nyHLgfWqTb77WPmVBfUSr3o4BoqKTK7LnAYMuBTa0079pF4N4ELmvm4p0
         uYbahHNdHq30Hu4yHAZLxbdtdidApR316aIACeiDF/l9iNljIC9cxpktJLUnJ2Cb6akW
         OwQESftGlqfzuKxcuUoOmtjZonOv1NiABu0Mp8ugW7sEeXWTGpHKS2/L2yZAcaqQVRVC
         jAQvL4T6EuudHEynR4cymiFuozBiM//YhzR3oc04jt2fIjZRBOquXaayv7scGOAlVAy4
         gNMwqKYN6O3YQmrs0/QwFJ3n10MU06g0wECn5vgFMNke0M2IZofK7R66t52Ii2xUPR28
         Sg2g==
X-Forwarded-Encrypted: i=1; AHgh+RrI4rue68GZ5d3huHiWgNhI1Fa/lA3CfNg6ojtBNlIO26jHV8OVW20u94LwdbhOYvy1wvfbU1SO7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzydr3ucwLdlm+k2XEhGMPAeB5d4IILmj4twMaCnWCx7MBDiNy2
	eTCrKhPfAKteZrefNxXYDTwwV6wmVs7cDCq61DqYFj11sEmlVYocdMHD6pH3QSOJAXW69HcXMkw
	IqfL+kKAaY94LWhagaprMI/CP+UbDCcG/OZ0rAzcs3GCJLm1RT9nc8NVE1WM9gg==
X-Gm-Gg: AfdE7cl2CpHQsYNWlFtXiTwIlG5xBc10QA3iumQAvpCUKfSif2pQcnVzFIehHhJJtWX
	NqMdJJmkQoFc7zkyxrQmQKftXYz//kvsl5wS7T5KSDqxkKtJbHF6+YDGdOw1j/ytDT7TLl/u7i8
	sPM0Z7ZpqG97qQnQqKre+fUWUL0cQK6lpHtWeUftCPaazOjzQoesTSY2ZQnUkudJxWYAfu+baD0
	ZWYnyDb7BI8IXvkvb5StW7PxiH6XzV9vlcjCIgABL/DHotL18RlKoNlJ90uuIGBhX/b6cX7lMcf
	YKufjtv1yP07cDVUtT8OHrIjghx9Rgh3aFuFW68i8mtSe9TE1DBUVezzgQgpTPxrLlP8yQi1G4x
	iJIXF95c5I0GPigTetoieOBUDV+YYi/itjk51I2w1QzvBgXNb1rEhFL4xlWvlPvNACAsUFN4ZsT
	ehm4CXv95l+UHG2Mxl0uhFzw+DmOeQtSHHEymhdgDhWgYlyLVDb00=
X-Received: by 2002:a05:622a:112:b0:51b:f40b:2fac with SMTP id d75a77b69052e-520be692394mr2840901cf.50.1784218709432;
        Thu, 16 Jul 2026 09:18:29 -0700 (PDT)
X-Received: by 2002:a05:622a:112:b0:51b:f40b:2fac with SMTP id d75a77b69052e-520be692394mr2840331cf.50.1784218708837;
        Thu, 16 Jul 2026 09:18:28 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:27 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:20 +0200
Subject: [PATCH v4 03/11] power: sequencing: Add pwrseq_is_controllable()
 API
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-3-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX5nHCR9+Zqg+0
 BRBe7hmJdFbXYFOFZmrEgKKOfJznNhjOnss3RVPC1KOnSKn/ZHWq21+5i0QpLg2OPSvXvmorx6L
 miY4yJ3tX5VKaemLm8kAKr0nj7EcPm7BvAJ2YYb1d8jG0GmrL4CcvxlgDBs83RcjuKvz1QoMY1W
 buhXhRxSynREKepRYWIvfdaLLWwFt7hTBEG/fEJGVfH9VZaFIkpozPdWPcUQDPzL9sVTlfj0/f5
 JrKgesTCN/DERBmyjNhb8g17owyHF9vD+p/35lJDxXuHc8gLMEwScPHQQQs2TBDwUpAtDtC7/66
 BqTbIEj8dpaPJMhTlKsjpthMqr0qNmmE5rM9Z9hpinulPjlMpwLk653vmW/VM4RaHwW6/QtFp8m
 YLpjOyHu+GkSXgXu42Gn5JoVVw7D5JglA1xzSiiQRjWsdlvpOqLllgZcloh1+8hnaGLylaj8t0a
 +Ku9pGV5XweVPJxp0DA==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a590456 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=4a-8Ivk512-2hps7UIkA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 1Cytr9TV5Nc28gxqZnEOLr4bCCAIdYMp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX/YSSL7ERvXr8
 /jYCii3OS1NrqkCrW7DYR9BHdlUnQcuBsH1h6JWKCo8Tm285UV4mnrQmbwQUsrR+GqfUZQkGmSA
 86Tz9+JHX83UiRHF44f850O76ybopJw=
X-Proofpoint-ORIG-GUID: 1Cytr9TV5Nc28gxqZnEOLr4bCCAIdYMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160166

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

