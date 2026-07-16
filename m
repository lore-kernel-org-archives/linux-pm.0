Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25ED37CD5A
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218719; cv=none; b=mOgwFZum8KDPsJ8Iz9bxVo3pRtgmlxgetctzfDVZVOZqyFlizMC+9Rxyic3m6Z07bd0HfNoCsIi+mSBfFCZLvYMYFHZ1yhJT2bcLCxpetDVqZDKj+L8EY2hTnYWlTAW/ILxTJ5f9euFCOO1sSqeXhx4w+FbeW8o4YiVd2s1/iuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218719; c=relaxed/simple;
	bh=axJo0QsdmJg35RBqGTfo/6nxaHHL0FSyQ0xk2oeWY4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RmMWC7j2LWARRVlfr2mT9VB3GSmxZYBqo739RthiXnk7fPjp4kKvpLuj+/bAx/0K8QEGj9G9Hb4dT8KbubiJnvwVsPmURMJeDbX8cDavDtJ6tkglxa3JbWsR/VOqFhJ7Rt/h5/dQFnhjxyHvEe5Fw1IM3qvN1hWVJeiCUzXJFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZhImFcT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YBf1Tk4x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZhImFcT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YBf1Tk4x"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJtPT3988626
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fwGrtQXZOZLHM8CW5djIH+FZH0mzGoPJDhLtNrPv7hk=; b=YZhImFcT5m2pF49g
	syOvP3NGIYqkDogY3x5jnadc1wR06vX/bkETO3PenWTUjQ+T6WwEd2ZM+IcXWgyO
	zV1UAP2Yrn+gT4ODEp+2KZmDDaQJzmtbERrwA8trGQ2hojdEqaXMbjwsph830Qu3
	plAVXxqn7AOsHEhpPkLlrrWd0g4yx5jgw2tBaWoQmDnQypSCxP0SzK1zwiH14tR6
	nutMMBFRLxuX2ZPwLopXt6oozxhblP+pc4Dubi0IwOCXAWKs67q94CnKWHjtu5rp
	gefAZiXvinNRiqrR2yGh4pDiAc5JqOShuyEJNwWNTqZpEbamiCjWs5NJj5p0W5eb
	/6qZPg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3pk71r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1e6f602cso64988761cf.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218711; x=1784823511; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwGrtQXZOZLHM8CW5djIH+FZH0mzGoPJDhLtNrPv7hk=;
        b=YBf1Tk4xG3ILd3nGus6Wf2eXG3oC2UO75IFEuPuc7NptmKJSqI3m0YjFdLNmMCRdlq
         b13mDDFM7NVzR8T1xnnW7um61Rhuu4ReXL7azUQVpgeniHIuj/bx0pNaFHA+GGCKs9x/
         8zZXuIBkf/RmEUTl/fzOhYO4h6iWpyzUC+TaRuVNluUIzod6APSSBf33kMD5MQDAWIGv
         mkm9hVYIIEAHARAW6iEx1xBM9Ewuj2plBY+Nj+a1m1TTj07Y7qTsDbXGLeZnKDj5BTvX
         F9/Uq08CfKJOARcENDEK427uij+aEkZ+LdNhf1GdUtLQ/FxQ5okiW1TawHEfxzFFwlpu
         Yndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218711; x=1784823511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwGrtQXZOZLHM8CW5djIH+FZH0mzGoPJDhLtNrPv7hk=;
        b=U+UqkjU06iSdVLmOD+BYN+bWh2pAFGBgjIDND/jPAPAmAUjo9JWoP+Z1mMCJZNGOfc
         Y6yZ55+bWW6mAffb0BDDZ2Y73aE8pEhUxujMtC2+IV/YSap8eLxWfAZM5orjNLYRmLnG
         3GLqJMWCjKgjnpvqYQECwQU34RZyGEUifNcPY8BOhNk11rpGrAPLvwRo2YdYA0P9EHNY
         CPJO8AgmP+lGDWQbHc3B/Go/09K5PuRJQaoQiQ8rrq5yg7KWrFXm6o+B/J2/uxu5xYhZ
         eEhY04EOrTsh9Bx/QbNjezFLaN7I83ZSp6kVIo72NRgal/6wukjDb5/yeeJ41wR7fa3L
         6i0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrXxqIzVlmu4NfpvksfhGRZ1e2mmNjiTGhlvxad+NF4Mv2riI1lD+OfZNbeCxJcRRGeQTWvbOOBkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjFbp9gfTtKTjt/hMU8POYyX7dL5YlGT/MXQLyeU6CKq5SLXIZ
	Ug/Bfl2D4q6zQ4IUMYG5RpLM1rTy6p2a3f4iadv6jk06nQ9/VKig1xImMyq5qjiOzdqjvEG3YI8
	0tzQX7cX3ER5Vijl/yfcDch2qC7mgS0meIXxfWC+K9eqa9QfelaIbvVE6KhWxBQ==
X-Gm-Gg: AfdE7ck1GiE8zwFHi/AYPR4t0ocMfxi7ZE7LwQYV626YGb1ty4APGCKLIDoOvhYzsx3
	mdw/8WLuAW01MJUCOyit7JxCy4ud3gTsdD7UOHRy973CROIPweHVDhioryoqPxTMnvlkrjWBtw8
	rCcUPQvidRo+ohsZdb/TGMhmEjccD+o2pLjaXnSjRfESusaMIVWHD1hR0m6+KZrwheut1OPaLxg
	DI5G9FJ74V/J8AGqxSev5w1Y6lV2/tiQeDRAqs8fMBNyL2wNBrGUzom6ibmFbB1lPeERIfiA9+K
	+FfuATHX3H+fWcoYEk5SYWQwgv6R1JsohEtO0wfIt6p1f3D2Z2+K3J/P99+5lMttXr9hI9txJb5
	r9ljNztWFhIDh6iE2rngrR90mv4s4jXEI25ywd2WD89H8h3ypcewlzvQzb7Pl0Ws+HHaF7hYyiV
	FcWsPK7CmPWQMzlxBLr96ZaKaiHkp/azpkv7uPtoMxmOBcK0rXduI=
X-Received: by 2002:a05:622a:248:b0:51c:257c:8166 with SMTP id d75a77b69052e-520bcdf04fdmr2656401cf.33.1784218711292;
        Thu, 16 Jul 2026 09:18:31 -0700 (PDT)
X-Received: by 2002:a05:622a:248:b0:51c:257c:8166 with SMTP id d75a77b69052e-520bcdf04fdmr2655801cf.33.1784218710638;
        Thu, 16 Jul 2026 09:18:30 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:21 +0200
Subject: [PATCH v4 04/11] power: sequencing: pcie-m2: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-4-9b02e6f549d7@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: oCiILL_6HJAfXJ3hjDMYa651RD1uTu7r
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX4ztXzx70q9lo
 czQF7upQ+DTk50O2EBGn8VunBL2CEUWXFKSA4EbEsH4xRDR7RAxNy40LGd9hprQX+UIVlmUa1Ph
 7EAjS6v1IJYYb+kt99uM8hZ0R6pRvq4=
X-Proofpoint-GUID: oCiILL_6HJAfXJ3hjDMYa651RD1uTu7r
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a590458 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Wval_j7vKiRkorSqWqkA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX1hoJyfJe6KKD
 FhzRz5VyOcjjTHY1ZmmoUEL50927EIxOl0OEJC0se15xUzxtk/vew7KajyPfiUHyLfDRDRDb2I5
 UebQa8PaKjvqDFBdULo9m33UXP8HvducmsXB1FhHAuSDrnFvtynHvZjZBKEMMoxb3slPG6b2mwT
 mq1xr9GKdvXTBeqjLGHW6aZ3JXgR89pbjooWkd/1mBXy2ptUHWzUBzcqxMh7XMnZZrsIsx+eoC0
 oxySRzJwvcKwa3tpuj9Xwib+Hm1FFCa5T748HIV40I98XOeCJJyk8E0d7m34ZKHdegmpNGO+Le2
 YPoqQoUGfmgc8KjLS109AL0Y3U24zGa5M0ICbMiOlneGt94Whk3ADbkJXxmuiUHNF7SwQaIkYxk
 Lu+otL+RadVwOUHpgAak9+6nJ94GFClpjwtnIHaJ3eY0CP9RKhLpShJClyoQEwc1gOsWT+rzaHG
 G4NtElj7p3ICrK1q1WQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160167

The M.2 Key E connector gates/resets its functions through the
W_DISABLE1# (PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals.
When a signal is not routed to a host GPIO, the corresponding
enable/disable callbacks are no-ops, so the consumer cannot gate
or reset that function on its own.

Implement the .is_controllable() callback on the "uart" and "pcie"
targets so that consumers can query this per instance (based on the
runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) via
pwrseq_is_controllable().

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index e3ba9169144dabbf0c553c0a4302c3b511fcaaa1..8e4cb778e31f66aa171ad9831d4213e17d2e6145 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -84,6 +84,18 @@ static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
 }
 
+static bool pwrseq_pci_m2_e_uart_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The UART enable is driven through the W_DISABLE2# line. When it is not
+	 * wired up on this connector the enable/disable callbacks are no-ops, so
+	 * the host cannot gate the Bluetooth function on its own.
+	 */
+	return !!ctx->w_disable2_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
 	.name = "uart-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
@@ -105,6 +117,18 @@ static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
 }
 
+static bool pwrseq_pci_m2_e_pcie_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The PCIe/WiFi enable is driven through the W_DISABLE1# line. When it
+	 * is not wired up on this connector the enable/disable callbacks are
+	 * no-ops, so the host cannot gate the PCIe/WiFi function on its own.
+	 */
+	return !!ctx->w_disable1_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
 	.name = "pcie-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
@@ -133,12 +157,14 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
 	.name = "uart",
 	.unit = &pwrseq_pcie_m2_e_uart_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+	.is_controllable = pwrseq_pci_m2_e_uart_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
 	.name = "pcie",
 	.unit = &pwrseq_pcie_m2_e_pcie_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+	.is_controllable = pwrseq_pci_m2_e_pcie_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {

-- 
2.34.1

