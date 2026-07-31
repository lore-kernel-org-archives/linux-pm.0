Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2E446078
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521278; cv=none; b=e5kzexmkZjUKnhuxCN/b7+SolWezKeAXJu4zFvWdM/nzV0kd6XwW1fcXybtuphgJFye87KzHQNJOqvjYhZ5WlLewv1i6/ICGVMLPBAcPtQfWzANpF0XW7KbObAOj0ev0x8DBzGGBVNgw3smLFhP3hcjaX+8MR5tbCIzcR60DrRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521278; c=relaxed/simple;
	bh=CBnS7t1mizIEi2Yz8x8q0f7r1o0b48xywSRR695Tg4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+aavzMWtDwpwjaAwiPm9FlGzWGDSktmQivBAWdtfmPQFaNdNOo/G1HbsVG7Et0Q1j/uOlTfzHDa8OpdWRyrlNSbdkytmVUfTylUxvg2MJzInOR69DUTWNJCfmWBQawdUuKOd+QHoGodenMEURKskvboZPUo/JShWBnxbVBTBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N9tK1dNe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GmE2xhn5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N9tK1dNe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GmE2xhn5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOdp51400716
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 18:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YVGf3/uCJX9art/BsRFLlGRAM16RNT99A8fSY/yy6bQ=; b=N9tK1dNe80/RbOr+
	OvEd2wpQNyM9YLMk4vfqjNhqSXmY41YUa12fqDS0Vwg/YtnNSQJwpss+2S52lvcP
	iCN2U1rdB1D5pP69Ii50n6H49JK8zfB0ejkK0Ic4JLlZubSdrr3GOCOQmokQcav1
	H2ghyDKavbWybLwYfwSo60M6EfW3tjHHvEwT4AduvFUyORcZppNEpAIeSbuARt7Z
	VE3HnPdWMqzIuAeoQT7Nr07FcsFsFKv273Fb7s3A1UjkI4Q5iNbJGgtclODZEven
	AC2xeX3yAEaNItl3tf4VdSTY+r8ZUXS6qZzglLfJT7VkYUM277mWgZ/r5DHP5zLh
	uqzV6A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1x9rmq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 18:07:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfbf3e4a63so33600745ad.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785521276; x=1786126076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVGf3/uCJX9art/BsRFLlGRAM16RNT99A8fSY/yy6bQ=;
        b=GmE2xhn5wWr2K4U1RdY7FZjjcggneiJ9euuAWdCJ1a7IUhu3QaSD30T8NHvC23F/T+
         H2tG62P394BAcUD3kxyKqYB2M4l71bZx8tEbbwrtrW7ryv4qsKJovA2NishKYG2ueElO
         ZseuRLrz8vfP9nqsIuHNr7QtMrot0+qmjlmpYo9hf1dbzsZ0pDTpJEqXlwDFisXt5U5O
         euS2JdufyiZNpAmzNLNSncnfFP+cpw+GnJ1yD5O+Q4wVKSMAV4ZBtT7lUsY/gdYzO4xH
         JC5fZHUGtg93bhZ+TtG4SSzRVdNc++cJKoc+cBEVq+UpJM/Nk0ww57i6CgXJhavht4Iz
         f8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521276; x=1786126076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVGf3/uCJX9art/BsRFLlGRAM16RNT99A8fSY/yy6bQ=;
        b=F4OieOv8vks+wki/GKWFT3uToctCDCqdqXVKX+c19B62ENJinvpNbd8y8iTVhSDeZs
         DAtlRW9RA1oMeFbF/j9dCyvSQvmYehdlI0LRbsL+rQHsFkO2SlmdO+h1D4AtScz3A46d
         PV4g8836wxdgsVjApY6LrvyPPNCxf7Q7rC6wWrtoWvDTi3lYO1kNXewLkmFi9vG1Pqou
         P5GCMhYceg3+gANENPASyEPCVrZNtFJQjmeQAsTkU6Yz0wvAy39sIaGfA+zI6zFJ2hBX
         586vuhsfqPAGx1aDuk2GxVMsZkAUm0tKSdjboz7QULVXmCxJZ5PyGdOQjLbk0MqyjvRA
         40gQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBAaQzEnPfdX0nQ77W0ri/2dECFjzS0n6BnHJIYSDHYqP/0cFDh7LUyJXGZtLW6lb3CXdFzxnO1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXumJmLyuWA06hAmjFzHi8JPNUPjiAhmv7BaDZRd99LDGi7dPZ
	iOOrCCzgkvQtcZUZ44nlhVK0LmUwXZ2QPNGjWm+3xLzxpyXvlAWQhZ6TUD/R2LE+pAUHoNbfyqT
	oGGfd2QQ6J7EzbYk6vb3xLHd6rZSC6Q2AmpwBo66PNJ+GLtOA6n8DlEzeXQNnRA==
X-Gm-Gg: AR+sD13gVMQ4piiIP0TwVESNl3uIa6tQQRIWAz+L8RB6sw0czZLVzC9S3dZfc07iM2Z
	6AY5IFTlwm4j19iAqgkf9ivKXDineS1D9SKqVGqo76XJMTB7tdxWzlplr5fOS7erwqHEfmZ5thq
	smkHUZxixiDkbheezQtpurMSfOSnI9UetcdaljmY/CjeKGMGKJP9KasUjd8NDfNH+DY4T796AjM
	Kjhc+zAZQoV6GCjKJf/jr840i4wwO0Yi9c6rJ7pMuG5dT7hHDIwXowrJA20iByYAP0ZMfOjbfC0
	vV8N0DhGXFEWrxbZWJvVIpFQhncA0ahcnoRb3latEtXq7kfWM6qApvjLo9h1XkF0xNlyW5zARGC
	7sptRdnn+hccSXZEA42M=
X-Received: by 2002:a17:90b:5807:b0:387:e0db:3fae with SMTP id 98e67ed59e1d1-38fbc588cc1mr781583a91.39.1785521275986;
        Fri, 31 Jul 2026 11:07:55 -0700 (PDT)
X-Received: by 2002:a17:90b:5807:b0:387:e0db:3fae with SMTP id 98e67ed59e1d1-38fbc588cc1mr781534a91.39.1785521275532;
        Fri, 31 Jul 2026 11:07:55 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06fe9fsm7069923eec.25.2026.07.31.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:07:55 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:36:16 +0530
Subject: [PATCH 3/7] thermal: qcom: qcom-spmi-adc-tm5-gen3: Add support for
 QCOM PMIC5 Gen4 ADC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-pmic5_gen4_adc-v1-3-9c49b2eea6f9@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
In-Reply-To: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785521244; l=5321;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=CBnS7t1mizIEi2Yz8x8q0f7r1o0b48xywSRR695Tg4E=;
 b=59vZircmYcZ0ERDsSkZssy77HNxYRTa8SE77jx7AWQl+/YFdOShCc/i0cfXWqxNdVK4zgKZAV
 aEGb6J1jRrPDXsYhBe7oXjJ0lDRd1vO+StwGLyBuLwpjlFnZoa8x0Ep
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfX8V7pN4ETVD/M
 cMypx7gQIEq2uz4Rtk44bMU5AmVVnhd24ZHhMgBYZJH5D9t4paAUdIJXtuY3EVBOl4Fzh15MuvO
 juLmYDtG9Q6lhcjLPYA6Y/gYspMoJkg=
X-Authority-Analysis: v=2.4 cv=GpByPE1C c=1 sm=1 tr=0 ts=6a6ce47c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=mq5v3e01y4o_RV37-9wA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfXz+pVhtjComG8
 IWyulzkvIsuYVR1nDU2m0aZPokZkBZSWd5U5n37TMzWc5cYRYQMiadzsdVqnYcMr7uK4RmCUVat
 emdrg5CnHjp7Rz783LfSiKrYHu2c/HxjWQ8DD3VoydK/8MEkS/FkRG9wHOvmAGa4DNYzNpx0lIZ
 ohJnuOopOJB7PeB+RxBGsIkrykwSS9xFNPbZ4ivdq2eRpgl3qhvE69i3h6vE+5NtW5gJJCHcEUQ
 kXPkgI1zEz6FLJEa1wwbtYBUv31t6n1GsrpIdstOWYvkk5owIAM4hLHEnBattrTwEMOqJdt1ATL
 PqzVIv2lxFCliJle+5ljD8OLrldiVFuX+MFdOtt3L1PVy5eBdDsHL06GLEpSRhSLhPImZ2Rx9Z/
 kic9ZYisOigEgs6592MTpFXIzS+jH5jrw2AC7A4a0kJChpSXyHGpUgbkcomtwIo8CfegUaM3gqG
 4z1LH4HOBfcSwnuXhyg==
X-Proofpoint-ORIG-GUID: axvbqBg9RpLE20YP0rvPGViU-OXPIZsy
X-Proofpoint-GUID: axvbqBg9RpLE20YP0rvPGViU-OXPIZsy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310139

PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
for improved performance, mostly at the hardware level.

One significant software change is that ratiometric conversion resolution
has been increased from 14 bits to 16 bits. Add a reverse scaling function
for Gen4 ADC thermistor channels.

In the latest PMIC arbiter version (v8), there can be up to 4 buses
under the PMIC arbiter and 32 PMICs under each bus. In order to
support communication between ADC on the master PMIC and ADCs on any
of the other PMICs, a field of width 2 bits is added for bus index
and the bits for SID are extended from 4 to 5 bits, in the SID
register. Add support for this.

Co-developed-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-vadc-common.c            | 11 +++++++++++
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 19 ++++++++++++++-----
 include/linux/iio/adc/qcom-vadc-common.h      |  2 ++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index cb23d0d178c7..25bd4622c389 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -720,6 +720,17 @@ u16 qcom_adc_tm5_gen2_temp_res_scale(int temp)
 }
 EXPORT_SYMBOL(qcom_adc_tm5_gen2_temp_res_scale);
 
+u16 qcom_adc_tm5_gen4_temp_res_scale(int temp)
+{
+	s64 resistance;
+
+	resistance = qcom_vadc_map_temp_voltage(adcmap7_100k,
+						ARRAY_SIZE(adcmap7_100k), temp);
+
+	return div64_s64(resistance * RATIO_MAX_ADC5_GEN4, resistance + R_PU_100K);
+}
+EXPORT_SYMBOL(qcom_adc_tm5_gen4_temp_res_scale);
+
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 		    unsigned int prescale_ratio,
 		    const struct adc5_data *data,
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
index 9cf552d36868..80e820b6dc4b 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
@@ -207,15 +207,23 @@ static int adc_tm5_gen3_disable_channel(struct adc_tm5_gen3_channel_props *prop)
 			       ADC5_GEN3_CONV_REQ, &val, sizeof(val));
 }
 
+typedef u16 (*temp_res_scale)(int temp);
+
 static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
 				  int low_temp, int high_temp)
 {
 	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
 	u8 buf[ADC_TM5_GEN3_CONFIG_REGS];
+	temp_res_scale tm_scal_fn;
 	u8 conv_req;
 	u16 adc_code;
 	int ret;
 
+	if (prop->common_props.generation == ADC5_GEN4)
+		tm_scal_fn = qcom_adc_tm5_gen4_temp_res_scale;
+	else
+		tm_scal_fn = qcom_adc_tm5_gen2_temp_res_scale;
+
 	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
 	if (ret < 0)
 		return ret;
@@ -225,8 +233,9 @@ static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
 	if (ret < 0)
 		return ret;
 
-	/* Write SID */
-	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->common_props.sid);
+	/* Write SID and bus_id*/
+	buf[0] = FIELD_PREP(ADC5_GEN4_BUS_INDEX_MASK, prop->common_props.bus_index) |
+		 FIELD_PREP(ADC5_GEN4_SID_MASK, prop->common_props.sid);
 
 	/* Select TM channel and indicate there is an actual conversion request */
 	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
@@ -252,7 +261,7 @@ static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
 	/* High temperature corresponds to low voltage threshold */
 	prop->low_thr_en = (high_temp != INT_MAX);
 	if (prop->low_thr_en) {
-		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high_temp);
+		adc_code = tm_scal_fn(high_temp);
 		put_unaligned_le16(adc_code, &buf[8]);
 		buf[7] |= ADC5_GEN3_LOW_THR_INT_EN;
 	}
@@ -260,7 +269,7 @@ static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
 	/* Low temperature corresponds to high voltage threshold */
 	prop->high_thr_en = (low_temp != -INT_MAX);
 	if (prop->high_thr_en) {
-		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low_temp);
+		adc_code = tm_scal_fn(low_temp);
 		put_unaligned_le16(adc_code, &buf[10]);
 		buf[7] |= ADC5_GEN3_HIGH_THR_INT_EN;
 	}
@@ -306,7 +315,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_gen3_chip *adc_tm5)
 	int ret;
 
 	for (int i = 0; i < adc_tm5->nchannels; i++) {
-		channel = ADC5_GEN3_V_CHAN(adc_tm5->chan_props[i].common_props);
+		channel = ADC5_GEN4_V_CHAN(adc_tm5->chan_props[i].common_props);
 		tzd = devm_thermal_of_zone_register(adc_tm5->dev, channel,
 						    &adc_tm5->chan_props[i],
 						    &adc_tm_ops);
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 4be682083843..55efad27ed73 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -159,6 +159,8 @@ u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
 
 u16 qcom_adc_tm5_gen2_temp_res_scale(int temp);
 
+u16 qcom_adc_tm5_gen4_temp_res_scale(int temp);
+
 int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
 
 int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);

-- 
2.43.0

