Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72F03FC5AB
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677469; cv=none; b=afJ5Zxshh4yF2Ma8uTEH4or6BsAzE3lxcTCY5TYSsClUWM2ep6cnT5geGFX0BTlAhwW2gGzRiZ+PyB5A96JlELdLn3DxgQXB96NqZOUThVn6Gz9PSs2eN5EmAlE6okMs4l5PM/XdVVJJwd3F9VvMdSwHgpVrFRnQwTqnNlReUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677469; c=relaxed/simple;
	bh=7I0RHdk3qWyJVFH388ZwLbLetJ7qn/3xCwzAVbmebN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbwdvQchCumqFVaI1z60hEq9dnMwuKPopcdU0W/MzgL0W6j3p1zyEHWysLVpew7MZURDE1q4+QznFw+Pj/150XQQgvtpxjVRdq6I0bQtWuUJ7CG1PqNwCZ8//eWU5EzuLu0E8xCWpL5r3dRdgniqo/es8goQUaE2KQ6IYeUObjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GMR9edp4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N5lsTuVF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GMR9edp4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N5lsTuVF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A9TZaQ292053
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GW8pkbZvfYORJjmA07dNF76DD9uMqzlV8iaeANQ36+M=; b=GMR9edp4MEDRJZ3d
	eefnwfkR+g07cZAGReOZ0R2RW5AXUSz3E0WrR7XQ/vsYDCkQWqrYaX5k25zDHyvA
	UP8QuxYnWrp15YFPdGb1JaK1fJK30PX2gHZIsFAPByTMSLbFLi7Qk6vWfshIuSgg
	VCsLeDYBYFjRvXe6aSyyzN3O28sJTpshEOOXrHOvPQ/6avygar1zLHeScandaO4N
	9sl+zVyEzmWe6lgGp16+A/mT5iysCDAm/YWqdaPIfWjaSEzcubYt55MzAhRmW1Mk
	nhyDg9ZtzMI6sM2lluobJROKOeoDbsZq6i8g8o5l9b65dgluh2EPCx52jsGQKb0m
	duQ9BA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dg3k0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0e702df8so7221821cf.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677461; x=1784282261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GW8pkbZvfYORJjmA07dNF76DD9uMqzlV8iaeANQ36+M=;
        b=N5lsTuVF5QT24cUfIAsvdKWTqTWkmoWTsWqbu5LPXSzzfTNBRSzcKCI6FA0d2J3kr0
         6sB2yg9d14TzGufEwAKyR5cKggRMm6lY4Rbk7dGXjdyDuNnz0/djGs1o1YKLPNwnAZd7
         9mDLrhpfA4z0RxVVqVj6bih2EXcKDHkUgtbjJuvCtgd9FwQie4hipyqywuOGUl2kG75S
         HrFJaz6SEgFlAmYnnqZTbRX5osR5HCuvdIlAb43JzoiFbNsHheOLjCXMzfL47NXxQH3D
         krm0eHVw0douH2qWm1R5hkmuwKv6g801OXeAapCNB+ps96L7vEzBWkCYIcBqz1YderH5
         x6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677461; x=1784282261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GW8pkbZvfYORJjmA07dNF76DD9uMqzlV8iaeANQ36+M=;
        b=Hba+c5vJ5UTabZjVi5C7p+0IZxRs/kxXpJq5L2arfXB5C8dbamHVdR3BnakYzx9DlJ
         AE9jYuu2NP5gXsvTt3XJseYCkYmGb6B4e4ovboZBLJs+NRfyDRqSGtN0MAQWFYAePURc
         KrJK1+3PD1vVR4R81zFZ4xG3QjYLyE9b4b4lLocDggG6q4ahzuHNEV2DC+V1wQt98pnI
         /2fWj4nKLbzAzADi2ioMgEsWV3XO5gqFhq8s2Yco6aA3lZVyvZ4VkDqhLHEMII3PNq86
         Cx/Az0GKVMWAUnTxiKpgx1/c2UdUjAfPieQ2KiXGerCSUhDfS3bEdoysyvB296TTmecg
         gu0w==
X-Forwarded-Encrypted: i=1; AHgh+RrPCeMG8gUyTa5t4gJKVE+phfGQ5Oies26KRIDqaMHPcKUcOV2lzTzvIJZWjMrxj1KFzFizRHcjUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvo3qkWqkyvWmd0IcGcNy/DKnkyr2RxWDZIn+4H7hhpSQeT12d
	zhKJscbKuhVq8B36FmoHDMbt0guVs53SrBh5F5Nnr0b4iGOH2Br+jl4C2mCNK/JCZXMhLSUTZqS
	hexJQQi79QS6qv31RAuHGSqYAWvxtnU5Nz8x5XZ+/4A2x1mMHQVfjLnZ4aCwmVw==
X-Gm-Gg: AfdE7cm585/YBRiXP6N7YuugwCjScc/TzzMvH9RoClBWObflD9a72eUQRBl3ntps7ZO
	BA8PiyM7AHGWrfySUJUxHd7/Z6I3X8YOJ9ZrdWHq14J0yedtWCGZVgpK5/PrKvMfPz5swZ3iF7Y
	JOQPPPwKd4okcJMiMdC/gmx4M0Zb5KhJKgoMLVhxm+M0dQg1YQaucGJI6OmHk6OODx3dtC7zfZ6
	Ifo9Q74XTvISpyg4vRIKad2Q/jujL/iVm79SU71DhP29mYuAMhcf6XS2ysazLm2Gc0DB1sjTmZi
	o1mnD5sQerIy6xMCx20uNewFCeee27/nWSBTcaaEICQmczP/SQy1zvvHCsk/9svOssZiuzFCXJL
	g5fuEOjqgPFKSn4EJ1toNbenLX6LTVo9JgZiJhfUJq8pqH4Td6PQyUJfDoO9VKfeX3J88obKzyb
	LStlsDMw+f8PR3/1cY/1Kf6zPvX9WBjWYnD0A4Ye+2GrdDg/wtBeNPXMNX0UEcXA2qe3+WThqgZ
	2pergGuyaUKRluIKo0g
X-Received: by 2002:ac8:5956:0:b0:51c:7b12:5fe9 with SMTP id d75a77b69052e-51c8b42893amr134253361cf.85.1783677460977;
        Fri, 10 Jul 2026 02:57:40 -0700 (PDT)
X-Received: by 2002:ac8:5956:0:b0:51c:7b12:5fe9 with SMTP id d75a77b69052e-51c8b42893amr134253051cf.85.1783677460461;
        Fri, 10 Jul 2026 02:57:40 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:31 +0200
Subject: [PATCH v3 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-5-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX+KbUzS5umZA7
 +wx0hXki/PnEv5PlyKxhdLC4K7nGynd7oz5Fuxz8E5Y8GUzT4xuQc6yhAwpYq7CWGvHoA/Zi/s0
 YE9H+m2+rom0kjOr8/tC9ZPLr6ZjBT4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfXwXcGo4DBHJlJ
 0SLBT4MzNmsApBrIPa/hlT5kgFM/4dZHadtkx5mbbjNlBNTJsmnpQm1GxEeciC4QoVFEjB35JJy
 /8thcwlYO3AoADAv8aXNj9Dp6J2NFQZPel57IVjccQ3x+GTW2s3exdmI/cGLdZi+QB3DaO5CDx5
 wc51bDsILLqpyfyRsOLzcTk5D7d0h/tV5Hg/eYjiEPiZoPhgXhAx9rSa998Z4Z5/B0+MMCbjwfo
 c2Wm+VO5F+vCMLIPgjGuuEOYr0C2SWElDy4JF+8f7tZzgfBArRWkHrXzauivWOiXF9tvAVLAotW
 97MYmx1bDv9wqB7uYRfPTiplBS0Ve2vqcCtFoJtQUBSMnXFROl9u1+93xjlMze5B7iZqubqKchG
 EdAkW9DIteW+mWBRBv9cb30YGxP0H01s0MjLn9lX13okYxzW+Qn1Es7VzXW+u0j+P1pL6Kkd5ZN
 YQ+jz621NdjdrfA87Ow==
X-Proofpoint-GUID: 72_vv8B1dIdj0AIBKoX7yW2PeYOH9EJ5
X-Proofpoint-ORIG-GUID: 72_vv8B1dIdj0AIBKoX7yW2PeYOH9EJ5
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a50c216 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=QWuo0IUDA92h_ITipQ8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
gate the respective functions. These GPIOs are optional, on some boards
they are hardwired to an always-on pull-up and not routed to a host GPIO.
In that case the corresponding enable/disable callbacks are no-ops, so the
host cannot gate that function's power on its own.

Implement the per-unit .is_controllable() callback on the bluetooth-enable
and wlan-enable units so that consumers can query this via the pwrseq API.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index b55b4317e21b626e050e022648147770ca7f386e..d5c9b734b0538e209734e15980ff2877ef5a614d 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -184,11 +184,25 @@ static int pwrseq_qcom_wcn_bt_disable(struct pwrseq_device *pwrseq)
 	return 0;
 }
 
+static bool pwrseq_qcom_wcn_bt_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The Bluetooth enable is driven through the BT_EN GPIO. When it is not
+	 * wired up (e.g. hardwired to an always-on pull-up), the enable/disable
+	 * callbacks are no-ops, so the host cannot gate the Bluetooth function
+	 * on its own.
+	 */
+	return !!ctx->bt_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_qcom_wcn_bt_unit_data = {
 	.name = "bluetooth-enable",
 	.deps = pwrseq_qcom_wcn_unit_deps,
 	.enable = pwrseq_qcom_wcn_bt_enable,
 	.disable = pwrseq_qcom_wcn_bt_disable,
+	.is_controllable = pwrseq_qcom_wcn_bt_is_controllable,
 };
 
 static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_bt_unit_data = {
@@ -196,6 +210,7 @@ static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_bt_unit_data = {
 	.deps = pwrseq_qcom_wcn6855_unit_deps,
 	.enable = pwrseq_qcom_wcn_bt_enable,
 	.disable = pwrseq_qcom_wcn_bt_disable,
+	.is_controllable = pwrseq_qcom_wcn_bt_is_controllable,
 };
 
 static int pwrseq_qcom_wcn_wlan_enable(struct pwrseq_device *pwrseq)
@@ -218,11 +233,25 @@ static int pwrseq_qcom_wcn_wlan_disable(struct pwrseq_device *pwrseq)
 	return 0;
 }
 
+static bool pwrseq_qcom_wcn_wlan_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The WLAN enable is driven through the WLAN_EN GPIO. When it is not
+	 * wired up (e.g. hardwired to an always-on pull-up), the enable/disable
+	 * callbacks are no-ops, so the host cannot gate the WLAN function on
+	 * its own.
+	 */
+	return !!ctx->wlan_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_qcom_wcn_wlan_unit_data = {
 	.name = "wlan-enable",
 	.deps = pwrseq_qcom_wcn_unit_deps,
 	.enable = pwrseq_qcom_wcn_wlan_enable,
 	.disable = pwrseq_qcom_wcn_wlan_disable,
+	.is_controllable = pwrseq_qcom_wcn_wlan_is_controllable,
 };
 
 static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_wlan_unit_data = {
@@ -230,6 +259,7 @@ static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_wlan_unit_data = {
 	.deps = pwrseq_qcom_wcn6855_unit_deps,
 	.enable = pwrseq_qcom_wcn_wlan_enable,
 	.disable = pwrseq_qcom_wcn_wlan_disable,
+	.is_controllable = pwrseq_qcom_wcn_wlan_is_controllable,
 };
 
 static int pwrseq_qcom_wcn_pwup_delay(struct pwrseq_device *pwrseq)

-- 
2.34.1

