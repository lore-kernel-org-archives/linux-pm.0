Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65AA41DEDE
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521272; cv=none; b=UqQ167LEEpF1mBmIDYtPcsRQQ3lb+hpgcvQ3AtUwPsRZNOFKjs7dUIS6E8/16k44nYNmsZpMivMF9tEfp0sfUXmXDDZNwuqTFT2FrXhGB+wWpzby4ncTUaj/pckPz1OBujwTcyO3ege4GLPGBJf0NU9V+W+V7C/v3VjOcWTnaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521272; c=relaxed/simple;
	bh=UFSKypV+EtK0Ea55Kg/sZknatS3o/XIcr3mC/cv7DuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIRLTnofAIXhr8Zw4m/cl49u17BhOJk2K1chPYz4oRWj8ow7/KSt/6fn9g3drlRpG2WtXjtQ3GS89wfroXiZApztCaA8kS7h5bAor1NDZ/tCUezIR+ELKPd7MxK1TuXm8BjSHHB2cjVdYqtYKSMzX/5MTPRRtwbXv4trxJPRgWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=idHl4gYc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jxxB76k7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="idHl4gYc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jxxB76k7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOjac404135
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 18:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VFIJP606ztFdpHXf6vk++n59DLq9jYBouMDkD7WGQC8=; b=idHl4gYcXDX4SbuY
	1vmGhPxR7xvEPyw0YieDkMX7DMr60DN5jo7kwUn9u08ql5nxoQft3ednsFN4fOmq
	2rCYrORMEmgBBCltZ07SQ9+oP12GFHgoPn3nXofiZaoYv9qFXFVMC34T8DHj/+tP
	NuEE4Eo3ksJRPFAw+8hPDqA2mzhLck8+M/VQEsAL0/XQeQu5gXrKAR++iWGFHI1Q
	nfkErx/ESRSq2Z6gGnPD37Kj0Olrp4nowCm7ApgrMpkM9Wx0d+uFcunBL6sG6JkV
	nmfpTC2VZWLg0okmhtD3WAOJl6ePteCD/gFj00KIrVFqvBqsHu20YDNS2oXUHrch
	PzcWHg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frufkhne3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 18:07:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso805603a12.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785521268; x=1786126068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VFIJP606ztFdpHXf6vk++n59DLq9jYBouMDkD7WGQC8=;
        b=jxxB76k7No+4tSt64Ysn1/Y8FSHMXhwEm06WAWUMzM9Ykw7s6FmdgQiVntTwolzgdG
         Z6gKAIDZqPMdz76YR+JfvvDfsvULXlmNl5zze37+oiDORQIpyRHtz2FK8ZhxWRhBB7j+
         yADP/8FyvCAPHZI0Pk1jjkEbMOmM1FPu1csPrsdof2ZT1JCIWZKKi3RWuiOxs9uSVWZE
         6DbqeOG3+d1/JdHjm8w1EAKQyPY4latBcWIzUwjzGczASouGUcmBiNXr10du2zk4bbOS
         0fRY7V7u4w48MrvC9Y38eDHPAePqaTIPLUX0bHk8a+nvet58dLdWHjpPsPNnbuY1TgAk
         WWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521268; x=1786126068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VFIJP606ztFdpHXf6vk++n59DLq9jYBouMDkD7WGQC8=;
        b=bOa1l2VYR5RuQdYHjL8SpTXr6ebKW+5WhraSwX+xHH8R+p0oV7ZP4c7g+SpwgrNJuK
         CDvR4THXmsGRnx4q57PAWGhuauqcvxjHlN9vlsAAAPUE5j/Mndmu/a0rDKkRCBVKjoZS
         5NWefWDE0yQLxoXERveyMlQ4edAbv7fVjsHS1NqMdwMFzU03EKg8mncmonijOeGgwRgA
         6DcRqJxaVlB7r7H4cp2sa5CLIlietcjj0ApNbF2ooWUP9UJTaEj3tLU16Bz2VZdmjoe2
         oNS1ArRDGaQmtijI6jjK1Huliux8i/imj5ERB9DIMpHYgvAkluSpghjlGE5fXSNS1Wah
         TMwA==
X-Forwarded-Encrypted: i=1; AHgh+RqlbGZz25p6pe8B2AAlUE29GbQmz/OFwpV5fwedK/opk0YSITyIxCrE1q+BEXOgdtJN6WF/tt5AMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCE4FDK4xbIpfy8BJxoFt4lGwOWfYR1AXtERl53XGTwQx2Tsc
	/dHVqueVo6Am1SFJWnf1iJH4WpMVPgFTGlcT7TmudmMPdGomFD8EvKN8tSHW/1ouRZEICJSayLN
	YD+SseeopIEobvKnpPA6abMsP9ni78qtkU2RYRqopSgM90G/PQM6AWgoLN3IFnQ==
X-Gm-Gg: AR+sD12RwlVUn2YIVgU/QUjDCHM4pVuljFMhx6E92G/M7qOv2WsTP4CDDGewgOaPzEo
	ZSJzl73cUYwxrDq32F/dS9jhH6eTPSY/zoGylOEQMEFF8I9F93Gn3ZPkI36BSj9HGoK7qVER7Jc
	RVY7OlHojGE4z7BnE2xoi39gN4L5UMr3rQB9AbC/1xt7MfeYiEjRTaF9GjLAmKYpbzfiRU2yrmj
	l/EGhJusEXq7uxTbhscp2lPQHdHPPz5FEmlDu5mM+MmMZIseeIaSyaajACE20QruC54ObsVun+m
	QmTXDNBm7kCk2MpFmSVLB2EH2tdsDoyF14Xov+34Z5GmwohGdFS4yEZ4mKVLe9s/qGQeRVQrxNH
	rffG2RDYEqd6XC6KT2Uw=
X-Received: by 2002:a05:6a21:1bc2:b0:3c3:abd4:ac74 with SMTP id adf61e73a8af0-3c92a8400eamr726863637.39.1785521268385;
        Fri, 31 Jul 2026 11:07:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:1bc2:b0:3c3:abd4:ac74 with SMTP id adf61e73a8af0-3c92a8400eamr726802637.39.1785521267728;
        Fri, 31 Jul 2026 11:07:47 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06fe9fsm7069923eec.25.2026.07.31.11.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:07:47 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:36:15 +0530
Subject: [PATCH 2/7] iio: adc: qcom-spmi-adc5-gen3: Add support for QCOM
 PMIC5 Gen4 ADC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785521244; l=18544;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=UFSKypV+EtK0Ea55Kg/sZknatS3o/XIcr3mC/cv7DuI=;
 b=puidsO+/c7J+yEyqr1nMvupJ0PizizTg5F1oxK22bAIwy5BC4MFWMMvpVmm7OwOgPvQ9H8rxK
 CuDarxx3dY3DdBxLQQEN+M+xOZZ6MG7Bnq8a9t101gCa8ShM4iW2jAw
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfX9h9M2g294Ueu
 hPs5vmtnFasfpQ6a2g6U2GQJnZWZgBhraVQvau3mRJz9xr/Z5kWw1t4PFdExHiWxjdIeGWAObT3
 zBF7+SkudG5QkVSBuRlzvwUFedOC4qk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfX4fqjRIFXg17t
 PLNbubHXJg9gX1K9K9R9OPVRv9E4Z4LWLAVLfNq7y2SdcMe7GiFZ9fN7xCj0Y5HZ99SI2QXKyvV
 JULXYjTW6+fvVuDO0tYCLIiZstjkcULutKfU2FT5EDGCyF+b1Uo4DQP2ifRi6VxYNZ3vMpglkz8
 6Xw8i/ksKx1u0FFyq8qHYWzTftod24SZp3egykhV71CkPsApdh/RWGS9S+xlKWHyPFS8GfSPjMI
 SEH5da71RKQIlyBDUGmLGoUio5YKtjtReGtvLRJmQFQ8diPgXlDgtEgrCaBOka592tAAnta7Hmy
 03y4DeitccbYgqGm2J9RPWuIvSrTVcrg52chrVP+Juudbc9nWSZmW+yq/CXgCWUht2XeOZadYk5
 gkpjDh6MjBiKk1vY3NOLUTfzx3GSJlAOYTJq1s/Iio7fYrA/9dim9FTuGlEOBJAbn5HW8IGEx2u
 olX3en3iWjFE8GPLDag==
X-Proofpoint-GUID: nchGAU_RgA0TPydTUJrJUGzWaY0y9Hr6
X-Authority-Analysis: v=2.4 cv=BpOtB4X5 c=1 sm=1 tr=0 ts=6a6ce476 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VL9c4Isk2NYVz5x_yekA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: nchGAU_RgA0TPydTUJrJUGzWaY0y9Hr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310139

PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
for improved performance, mostly at the hardware level.

One significant software change is that ratiometric conversion resolution
has been increased from 14 bits to 16 bits, so the maximum value of
these measurements needs to be updated for Gen4. Add a new scaling
function for thermistor channels which use this type of conversion.

In the latest PMIC arbiter version (v8), there can be up to 4 buses
under the PMIC arbiter and 32 PMICs under each bus. In order to
support communication between ADC on the master PMIC and ADCs on any
of the other PMICs, a field of width 2 bits is added for bus index
and the bits for SID are extended from 4 to 5 bits, in the SID
register. Add support for this.

In addition, it is possible that the master PMIC has ADC of one generation
and it needs to communicate with another PMIC with ADC of a different
generation. Add new DT properties "qcom,adc5-gen3" and "qcom,adc5-gen4",
to distinguish Gen3 channels under a Gen4 master and Gen4 channels
under a Gen3 master respectively, to ensure that their conversions are handled
correctly.

Co-developed-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 165 +++++++++++++++++++-------
 drivers/iio/adc/qcom-vadc-common.c            |  32 +++++
 include/linux/iio/adc/qcom-adc5-gen3-common.h |  44 ++++++-
 include/linux/iio/adc/qcom-vadc-common.h      |   4 +
 4 files changed, 195 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index c68c6c5f6aca..810d25b665b1 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -86,7 +86,9 @@ int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
 }
 EXPORT_SYMBOL_NS_GPL(adc5_gen3_write, "QCOM_SPMI_ADC5_GEN3");
 
-static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
+static int adc5_gen3_read_voltage_data(struct adc5_chip *adc,
+				       struct adc5_channel_common_prop *prop,
+				       u16 *data)
 {
 	u8 rslt[2];
 	int ret;
@@ -99,8 +101,10 @@ static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
 	*data = get_unaligned_le16(rslt);
 
 	if (*data == ADC5_USR_DATA_CHECK) {
-		dev_err(adc->dev, "Invalid data:%#x\n", *data);
-		return -EINVAL;
+		if (!(prop->generation == ADC5_GEN4 && prop->cal_method == ADC5_RATIOMETRIC_CAL)) {
+			dev_err(adc->dev, "Invalid data:%#x\n", *data);
+			return -EINVAL;
+		}
 	}
 
 	dev_dbg(adc->dev, "voltage raw code:%#x\n", *data);
@@ -131,8 +135,9 @@ static int adc5_gen3_configure(struct adc5_chip *adc,
 	if (ret)
 		return ret;
 
-	/* Write SID */
-	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->sid);
+	/* Write SID and bus_id*/
+	buf[0] = FIELD_PREP(ADC5_GEN4_BUS_INDEX_MASK, prop->bus_index) |
+		 FIELD_PREP(ADC5_GEN4_SID_MASK, prop->sid);
 
 	/*
 	 * Use channel 0 by default for immediate conversion and to indicate
@@ -268,7 +273,7 @@ static int adc5_gen3_do_conversion(struct adc5_chip *adc,
 		return -ETIMEDOUT;
 	}
 
-	ret = adc5_gen3_read_voltage_data(adc, data_volt);
+	ret = adc5_gen3_read_voltage_data(adc, prop, data_volt);
 	if (ret)
 		return ret;
 
@@ -325,7 +330,7 @@ static int adc5_gen3_fwnode_xlate(struct iio_dev *indio_dev,
 	int i, v_channel;
 
 	for (i = 0; i < adc->nchannels; i++) {
-		v_channel = ADC5_GEN3_V_CHAN(adc->chan_props[i].common_props);
+		v_channel = ADC5_GEN4_V_CHAN(adc->chan_props[i].common_props);
 		if (v_channel == iiospec->args[0])
 			return i;
 	}
@@ -351,7 +356,7 @@ static int adc5_gen3_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = qcom_adc5_hw_scale(prop->scale_fn_type, prop->prescale,
-					 adc->data, adc_code_volt, val);
+					 prop->data, adc_code_volt, val);
 		if (ret)
 			return ret;
 
@@ -433,15 +438,89 @@ static const struct adc5_channels adc5_gen3_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_THERM_100K_PU_PM7)
 };
 
+static const struct adc5_channels adc5_gen4_chans_pmic[ADC5_MAX_CHANNEL] = {
+	[ADC5_GEN4_OFFSET_REF]		= ADC5_CHAN_VOLT(0,
+						SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN4_1P25VREF]		= ADC5_CHAN_VOLT(0,
+						SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN4_VPH_PWR]		= ADC5_CHAN_VOLT(1,
+						SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN4_VBAT_SNS_QBG]	= ADC5_CHAN_VOLT(1,
+						SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN4_DIE_TEMP]		= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_PMIC_THERM_PM7)
+	[ADC5_GEN4_AMUX1_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX2_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX3_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX4_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX5_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX6_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX1_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX2_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX3_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX4_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX5_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+};
+
+static const struct adc5_data adc5_gen3_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.adc_chans = adc5_gen3_chans_pmic,
+	.info = &adc5_gen3_info,
+	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
+			   { 85, 340, 1360 },
+	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
+			   { 15, 100, 200, 300,
+			     400, 500, 600, 700,
+			     1000, 2000, 4000, 8000,
+			     16000, 32000, 64000, 128000 },
+};
+
+static const struct adc5_data adc5_gen4_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.adc_chans = adc5_gen4_chans_pmic,
+	.info = &adc5_gen3_info,
+	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
+			   { 85, 340, 1360 },
+	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
+			   { 15, 100, 200, 300,
+			     400, 500, 600, 700,
+			     1000, 2000, 4000, 8000,
+			     16000, 32000, 64000, 128000 },
+};
+
+static const struct of_device_id adc5_match_table[] = {
+	{
+		.compatible = "qcom,spmi-adc5-gen3",
+		.data = &adc5_gen3_data_pmic,
+	},
+	{
+		.compatible = "qcom,spmi-adc5-gen4",
+		.data = &adc5_gen4_data_pmic,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adc5_match_table);
+
 static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
 					 struct adc5_channel_prop *prop,
 					 struct fwnode_handle *fwnode)
 {
 	const char *name = fwnode_get_name(fwnode);
-	const struct adc5_data *data = adc->data;
+	const struct adc5_data *data;
+	u32 chan, value, sid, bus_index;
 	struct device *dev = adc->dev;
 	const char *channel_name;
-	u32 chan, value, sid;
 	u32 varr[2];
 	int ret;
 
@@ -452,27 +531,46 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
 
 	/*
 	 * Value read from "reg" is virtual channel number
-	 * virtual channel number = sid << 8 | channel number
+	 * virtual channel number = bus index << 13 | sid << 8 | channel number
+	 * For ADC5 GEN3 channels, bus index = 0
 	 */
-	sid = FIELD_GET(ADC5_GEN3_VIRTUAL_SID_MASK, chan);
-	chan = FIELD_GET(ADC5_GEN3_CHANNEL_MASK, chan);
+	bus_index = FIELD_GET(ADC5_GEN4_V_CHAN_BUS_INDEX_MASK, chan);
+	sid = FIELD_GET(ADC5_GEN4_V_CHAN_SID_MASK, chan);
+	chan = FIELD_GET(ADC5_GEN4_V_CHAN_CHANNEL_MASK, chan);
 
 	if (chan >= ADC5_MAX_CHANNEL)
 		return dev_err_probe(dev, -EINVAL,
 				     "%s invalid channel number %d\n",
 				     name, chan);
 
+	prop->common_props.bus_index = bus_index;
 	prop->common_props.channel = chan;
 	prop->common_props.sid = sid;
 
-	if (!adc->data->adc_chans[chan].info_mask)
+	if (fwnode_property_read_bool(fwnode, "qcom,adc5-gen4")) {
+		prop->common_props.generation = ADC5_GEN4;
+		data = &adc5_gen4_data_pmic;
+	} else if (fwnode_property_read_bool(fwnode, "qcom,adc5-gen3")) {
+		prop->common_props.generation = ADC5_GEN3;
+		data = &adc5_gen3_data_pmic;
+	} else {
+		prop->common_props.generation = (adc->data == &adc5_gen3_data_pmic) ?
+						 ADC5_GEN3 : ADC5_GEN4;
+		data = adc->data;
+	}
+	prop->common_props.data = data;
+
+	if (!data->adc_chans[chan].info_mask)
 		return dev_err_probe(dev, -EINVAL, "Channel %#x not supported\n", chan);
 
 	channel_name = name;
 	fwnode_property_read_string(fwnode, "label", &channel_name);
 	prop->common_props.label = channel_name;
 
-	value = data->decimation[ADC5_DECIMATION_DEFAULT];
+	if (prop->common_props.generation == ADC5_GEN3)
+		value = data->decimation[ADC5_DECIMATION_DEFAULT];
+	else
+		value = data->decimation[ADC5_GEN4_DECIMATION_DEFAULT];
 	fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
 	ret = qcom_adc5_decimation_from_dt(value, data->decimation);
 	if (ret < 0)
@@ -480,7 +578,7 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
 				     chan, value);
 	prop->common_props.decimation = ret;
 
-	prop->common_props.prescale = adc->data->adc_chans[chan].prescale_index;
+	prop->common_props.prescale = data->adc_chans[chan].prescale_index;
 	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
 	if (!ret) {
 		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
@@ -526,34 +624,13 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
 	return 0;
 }
 
-static const struct adc5_data adc5_gen3_data_pmic = {
-	.full_scale_code_volt = 0x70e4,
-	.adc_chans = adc5_gen3_chans_pmic,
-	.info = &adc5_gen3_info,
-	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
-			   { 85, 340, 1360 },
-	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
-			   { 15, 100, 200, 300,
-			     400, 500, 600, 700,
-			     1000, 2000, 4000, 8000,
-			     16000, 32000, 64000, 128000 },
-};
-
-static const struct of_device_id adc5_match_table[] = {
-	{
-		.compatible = "qcom,spmi-adc5-gen3",
-		.data = &adc5_gen3_data_pmic,
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, adc5_match_table);
-
 static int adc5_get_fw_data(struct adc5_chip *adc)
 {
 	const struct adc5_channels *adc_chan;
 	struct adc5_channel_prop *chan_props;
 	struct iio_chan_spec *iio_chan;
 	struct device *dev = adc->dev;
+	const struct adc5_data *data;
 	unsigned int index = 0;
 	int ret;
 
@@ -582,10 +659,11 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
 			return ret;
 
 		chan_props->chip = adc;
-		adc_chan = &adc->data->adc_chans[chan_props->common_props.channel];
+		data = chan_props->common_props.data;
+		adc_chan = &data->adc_chans[chan_props->common_props.channel];
 		chan_props->common_props.scale_fn_type = adc_chan->scale_fn_type;
 
-		iio_chan->channel = ADC5_GEN3_V_CHAN(chan_props->common_props);
+		iio_chan->channel = ADC5_GEN4_V_CHAN(chan_props->common_props);
 		iio_chan->info_mask_separate = adc_chan->info_mask;
 		iio_chan->type = adc_chan->type;
 		iio_chan->address = index;
@@ -697,7 +775,7 @@ int adc5_gen3_get_scaled_reading(struct device *dev,
 
 	return qcom_adc5_hw_scale(common_props->scale_fn_type,
 				  common_props->prescale,
-				  adc->data, adc_code_volt, val);
+				  common_props->data, adc_code_volt, val);
 }
 EXPORT_SYMBOL_NS_GPL(adc5_gen3_get_scaled_reading, "QCOM_SPMI_ADC5_GEN3");
 
@@ -705,12 +783,9 @@ int adc5_gen3_therm_code_to_temp(struct device *dev,
 				 struct adc5_channel_common_prop *common_props,
 				 u16 code, int *val)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
-	struct adc5_chip *adc = iio_priv(indio_dev);
-
 	return qcom_adc5_hw_scale(common_props->scale_fn_type,
 				  common_props->prescale,
-				  adc->data, code, val);
+				  common_props->data, code, val);
 }
 EXPORT_SYMBOL_NS_GPL(adc5_gen3_therm_code_to_temp, "QCOM_SPMI_ADC5_GEN3");
 
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index b03cf584b165..cb23d0d178c7 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -301,6 +301,10 @@ static const struct u32_fract adc5_prescale_ratios[] = {
 	{ .numerator =  1, .denominator = 16 },
 };
 
+static int qcom_adc5_gen4_scale_hw_calib_therm(
+				const struct u32_fract *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_mdec);
 static int qcom_vadc_scale_hw_calib_volt(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
@@ -341,6 +345,8 @@ static const struct qcom_adc5_scale_type scale_adc5_fn[] = {
 					qcom_vadc7_scale_hw_calib_die_temp},
 	[SCALE_HW_CALIB_PM5_CHG_TEMP] = {qcom_vadc_scale_hw_chg5_temp},
 	[SCALE_HW_CALIB_PM5_SMB_TEMP] = {qcom_vadc_scale_hw_smb_temp},
+	[SCALE_HW_CALIB_THERM_100K_PU_GEN4] = {
+					qcom_adc5_gen4_scale_hw_calib_therm},
 };
 
 static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
@@ -556,6 +562,32 @@ static int qcom_vadc7_scale_hw_calib_therm(
 	return 0;
 }
 
+static int qcom_adc5_gen4_scale_hw_calib_therm(
+				const struct u32_fract *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_mdec)
+{
+	s64 resistance = adc_code;
+	int ret, result;
+
+	if (adc_code >= RATIO_MAX_ADC5_GEN4)
+		return -EINVAL;
+
+	/* (ADC code * R_PULLUP (100Kohm)) / (full_scale_code - ADC code)*/
+	resistance *= R_PU_100K;
+	resistance = div64_s64(resistance, RATIO_MAX_ADC5_GEN4 - adc_code);
+
+	ret = qcom_vadc_map_voltage_temp(adcmap7_100k,
+					 ARRAY_SIZE(adcmap7_100k),
+					 resistance, &result);
+	if (ret)
+		return ret;
+
+	*result_mdec = result;
+
+	return 0;
+}
+
 static int qcom_vadc_scale_hw_calib_volt(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
index 39cbfcbdb101..5d8e38350827 100644
--- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
+++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
@@ -40,7 +40,8 @@
 #define ADC5_GEN3_CONV_ERR_CLR_REQ		BIT(0)
 
 #define ADC5_GEN3_SID				0x4f
-#define ADC5_GEN3_SID_MASK			GENMASK(3, 0)
+#define ADC5_GEN4_SID_MASK			GENMASK(4, 0)
+#define ADC5_GEN4_BUS_INDEX_MASK		GENMASK(6, 5)
 
 #define ADC5_GEN3_PERPH_CH			0x50
 #define ADC5_GEN3_CHAN_CONV_REQ			BIT(7)
@@ -51,6 +52,7 @@
 #define ADC5_GEN3_DIG_PARAM			0x52
 #define ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK	GENMASK(5, 4)
 #define ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK	GENMASK(3, 2)
+#define ADC5_GEN4_DECIMATION_DEFAULT	1
 
 #define ADC5_GEN3_FAST_AVG			0x53
 #define ADC5_GEN3_FAST_AVG_CTL_EN		BIT(7)
@@ -75,10 +77,13 @@
 #define ADC5_GEN3_CONV_REQ			0xe5
 #define ADC5_GEN3_CONV_REQ_REQ			BIT(0)
 
-#define ADC5_GEN3_VIRTUAL_SID_MASK		GENMASK(15, 8)
-#define ADC5_GEN3_CHANNEL_MASK			GENMASK(7, 0)
-#define ADC5_GEN3_V_CHAN(x)		\
-	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)
+#define ADC5_GEN4_V_CHAN_BUS_INDEX_MASK		GENMASK(14, 13)
+#define ADC5_GEN4_V_CHAN_SID_MASK		GENMASK(12, 8)
+#define ADC5_GEN4_V_CHAN_CHANNEL_MASK		GENMASK(7, 0)
+#define ADC5_GEN4_V_CHAN(x) \
+	(FIELD_PREP(ADC5_GEN4_V_CHAN_BUS_INDEX_MASK, (x).bus_index) | \
+	 FIELD_PREP(ADC5_GEN4_V_CHAN_SID_MASK, (x).sid) | \
+	 FIELD_PREP(ADC5_GEN4_V_CHAN_CHANNEL_MASK, (x).channel))
 
 /* ADC channels for PMIC5 Gen3 */
 #define ADC5_GEN3_REF_GND			0x00
@@ -102,6 +107,27 @@
 
 #define ADC5_MAX_CHANNEL			0xc0
 
+/* ADC channels for PMIC5 Gen4 */
+#define ADC5_GEN4_OFFSET_REF		0x00
+#define ADC5_GEN4_1P25VREF			0x01
+#define ADC5_GEN4_DIE_TEMP			0x03
+#define ADC5_GEN4_USB_SNS_DIV20			0x11
+#define ADC5_GEN4_VIN_DIV20_MUX			0x12
+#define ADC5_GEN4_VPH_PWR			0x8e
+#define ADC5_GEN4_VBAT_SNS_QBG			0x8f
+/* 100k pull-up channels */
+#define ADC5_GEN4_AMUX1_THM_100K_PU		0x44
+#define ADC5_GEN4_AMUX2_THM_100K_PU		0x45
+#define ADC5_GEN4_AMUX3_THM_100K_PU		0x46
+#define ADC5_GEN4_AMUX4_THM_100K_PU		0x47
+#define ADC5_GEN4_AMUX5_THM_100K_PU		0x48
+#define ADC5_GEN4_AMUX6_THM_100K_PU		0x49
+#define ADC5_GEN4_AMUX1_GPIO_100K_PU		0x4a
+#define ADC5_GEN4_AMUX2_GPIO_100K_PU		0x4b
+#define ADC5_GEN4_AMUX3_GPIO_100K_PU		0x4c
+#define ADC5_GEN4_AMUX4_GPIO_100K_PU		0x4d
+#define ADC5_GEN4_AMUX5_GPIO_100K_PU		0x5e
+
 enum adc5_cal_method {
 	ADC5_NO_CAL = 0,
 	ADC5_RATIOMETRIC_CAL,
@@ -117,6 +143,11 @@ enum adc5_time_select {
 	MEAS_INT_NONE,
 };
 
+enum adc_generation {
+	ADC5_GEN3 = 0,
+	ADC5_GEN4,
+};
+
 /**
  * struct adc5_sdam_data - data per SDAM allocated for adc usage
  * @base_addr: base address for the ADC SDAM peripheral.
@@ -166,6 +197,9 @@ struct adc5_channel_common_prop {
 	unsigned int hw_settle_time_us;
 	unsigned int avg_samples;
 	enum vadc_scale_fn_type scale_fn_type;
+	enum adc_generation generation;
+	unsigned int bus_index;
+	const struct adc5_data *data;
 };
 
 /**
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 3bf4c49726a7..4be682083843 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -54,6 +54,7 @@
 
 #define R_PU_100K				100000
 #define RATIO_MAX_ADC7				BIT(14)
+#define RATIO_MAX_ADC5_GEN4			0xffff
 
 /*
  * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
@@ -105,6 +106,8 @@ struct vadc_linear_graph {
  *	charger temperature.
  * @SCALE_HW_CALIB_PM5_SMB_TEMP: Returns result in millidegrees for PMIC5
  *	SMB1390 temperature.
+ * @SCALE_HW_CALIB_THERM_100K_PU_GEN4: Returns temperature in millidegC using
+ *	lookup table for PMIC5 Gen4 ADC. The hardware applies offset/slope to adc code.
  */
 enum vadc_scale_fn_type {
 	SCALE_DEFAULT = 0,
@@ -120,6 +123,7 @@ enum vadc_scale_fn_type {
 	SCALE_HW_CALIB_PMIC_THERM_PM7,
 	SCALE_HW_CALIB_PM5_CHG_TEMP,
 	SCALE_HW_CALIB_PM5_SMB_TEMP,
+	SCALE_HW_CALIB_THERM_100K_PU_GEN4,
 	/* private: */
 	SCALE_HW_CALIB_INVALID,
 };

-- 
2.43.0

