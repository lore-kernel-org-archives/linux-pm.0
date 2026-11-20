Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166451;
	b=y0yqY9NZU4i2Aze3VxwcC7yWza8OLYdQVH1zpQIvXWkNzvv6IoZ6os1hWjeSb0kNIkea
	 39klWpglZIGSLlVIiFPVQpObdGMqzByC57tZIPTixynN3FhCQN8QQof3XjKG7vM35Ltu5
	 cDdG8nqqcsa8OspTe4kyTf+vCd1eo2vbS9BBjWwjJHYzt0iaSZ8v1Nz857rg8NNBVo3XE
	 363d1q+ZTHhgkbXLkgHwJrnJeUor2k9UVwCbRNEtla6IYSdbEMzPCoToa1O5YwIxJYoSJ
	 +h8T8R1A2BRtQGOogIMOrhuwENdyqtsrB2CWxvmVOdTatJyVWbqqffAnU1O41IVMUZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166451;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4UoXxEYlDU+vrg6IGzrxVv+Q+U9W0KxfXSxO65QHNUA=;
	b=eyuUAct4/28zXaFU7fzs8QG7Kqh6wzinTBZ3CLMv46CuXJIhFBPSHrLu7hpXH0kJnKfS
	 4SscEMXUMhZGFu4N0CloOP4RrkaUFdhXJIfu2gkJ0D8N07w8Ym2P/TMq8VtEqEPBsAlaF
	 1vz8PsyY4sMbGtiChwsnObmbCqHyvPVjjZwGEi3vihEW3SAL4WQP+szqJCbKnFHZ0fmVY
	 qAM8c2JslFRC/3hNGkEo6VHT6Z5YyyfCQUiipNp5tSK2Ov4z9xkBL/SMbCJGc2j3rdLD6
	 lNCRKqB9oLTbNw72UEKwhYlLjqbbK5a3GJ+1elH/a+aHNHxkktbzI8OX9AN/0WX7Ccg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B3ORsv4T;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="EHYpf/XE";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230B606A335
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4230B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B3ORsv4T;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EHYpf/XE
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK9Aiat849345
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4UoXxEYlDU+vrg6IGzrxVv+Q+U9W0KxfXSxO65QHNUA=; b=B3ORsv4TKFKRGDSr
	hTxGphiiGH6rtLGy0eIfKNoeIY6CFchoi4MCueXsnvCRYmHxyzrr6mVm2LeBe9P9
	uwxLss5jcvs5VbW/aEQOgbe9GdjdnRDN0HCKCaDRXf2IVCywdj+0MnHz3Im2sgtf
	0Js8k0qUfS8dtwI/Xpl3eJwBJUFSS3sklK9WtOpIx9hn3IqOkbRtpeOtz8AA7W95
	/7jwjsCohMbA8ucF8txQqk1ySEhI4cRK8xhMCrL70o4IkI6HSF6dV0yni+ruaXzy
	5pcPAsBG9vZzluNZkw+6QR5zL1zge3oWx1CuLO3nkSazUtFeh2VneyPA4r956GW5
	elsPdg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fyjwyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:20:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so821917a12.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 01:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795166448; x=1795771248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4UoXxEYlDU+vrg6IGzrxVv+Q+U9W0KxfXSxO65QHNUA=;
        b=EHYpf/XEOks0kAzkQBrYxeD4uzNS62MjBtHPSIjc5Y10XQkHJM4Jez8zO+BuY34+q9
         CXt58ih4CCaE3ewK1eM9zG+ixUldESdlVi6Nbv07Io4PtSvbXa1YD5eEs6KxpRuqzNTp
         QARx8lcezDQFYVluB6+pWrJi7J9cPpUl6ErYYg/7nybRlH3iLB81gABmEMJoF1Zf3CIC
         zVyIrnI6tv7C/IXnNaRddBTdtDNijbIidad4mmbQXidKUFNQ5tlc5dYlVeSwehEtzWum
         TQ859jubhNHQucRCjYfjCCsvpc3NTJdZanMJfJwFlin7xrj0gv7E3s4pEwDqgDsW9k9N
         p3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166448; x=1795771248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UoXxEYlDU+vrg6IGzrxVv+Q+U9W0KxfXSxO65QHNUA=;
        b=SQtCkWsM4ndPUogwD3IyQU1BtBC1lzcZVD/M14QlaoEo0GzuafHKSmQBIudQ2u8+8z
         HG0xLRUq4CdQfdIr/9MH240xrAw+2BC0bnXQmAKyr6cVJ6X3kLOpbvH1quYrLFiqJgtR
         YLCjlQxYmHJ2rInVJJkr461KFun87PwRgjINOaRWgKuGN9VveWzaTAL77cputyEIa/Ev
         yaYcjZ0XhS+s3u4pDlaMQZzaFAX/3Gbv9r7/ZiPBpdWyvGhw97XJ27HSmDAEmfr2x58M
         m7LjJ9QKlg73h+9wcKp/Q1srhF4/YFiabGJUSsSmg/T+vcCDFWaMHTgmHkr9NUwQZy/3
         pbsQ==
X-Forwarded-Encrypted: i=1; AL+hErEYShxzHRQo/osOFWpXebYhgAuuDgSmcFinkUCtMLRCh1xNq+zMfmyq1s7+LZt0iBr2aIBFoiwozg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CMJycRW8bZYBY4HYt2AedsWBXLL/UCVLep+UZeUtwOaVKKh5G
	ktFghmqcxFbnZ+h7u1wkECyL8GFMbcpLP9jr0jKaCIFF6XpWUA+0j2HI7PONP3o1CuDIci8yKJg
	HqaEwywtNIdld0K02YWR5zg+ls/LI3GBx5fPg4NodRN1OCvm10Slm8eqftj6p/Q==
X-Gm-Gg: AYBFou084eZZeO8xFpsK480GzfRiEmUlqLTikhvXxoMbr5ANtPX0nePJHhQVR/Nlu7l
	/mJfjvNYPBncvk/WTfnxlDulcy2wvRh+GMkGVePAk9nai7auWEE7ylt2q48HX47YZ0qj6qrFP5n
	M7gxNYa4Ytdh18THipjYXbRlXKDHT0Vr54gMvQhltuOOAcDxCQhCXcMJ+qsCkPmDNxsPvu5qPB2
	PagEbL4d2YUCINS84edspYeVvcTnX6FVqeFSz+hmRMj9LWuRrZbHI48T2wvVeGKjSBPd0bvdCn7
	HCN5wtOHOEmuoYgB645h+FpbeE8dlcpL2vZDdw7uCstk9PaMy491uVWgFTi2ixja0MBcaCrDpkV
	NEwD1rT0bzsv1V8uCvjo7jJ+EDXvaA177or/8n7hAGs3SP58lWzrYBL+Br5lKOOrM+Y+l
X-Received: by 2002:a05:6372:a810:b0:3e0:c5c9:d55e with SMTP id adf61e73a8af0-4014e45acd4mr1946952637.63.1795166448195;
        Fri, 20 Nov 2026 01:20:48 -0800 (PST)
X-Received: by 2002:a05:6372:a810:b0:3e0:c5c9:d55e with SMTP id adf61e73a8af0-4014e45acd4mr1946918637.63.1795166447805;
        Fri, 20 Nov 2026 01:20:47 -0800 (PST)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1cfa0sm1186994b3a.48.2026.11.20.01.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:20:47 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 14:49:44 +0530
Subject: [PATCH v2 4/7] thermal: qcom: qcom-spmi-adc-tm5-gen3: Add support
 for QCOM PMIC5 Gen4 ADC
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-pmic5_gen4_adc-v2-4-94d0e1fd6847@oss.qualcomm.com>
References: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
In-Reply-To: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795166413; l=5321;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=a5Gm59hIanPZVcwpMcDGmTR3tX4XWoqM7uTqFsy8vjw=;
 b=6BFkjrj2aKjGJufUHv/kUhuQOYsyjdtJtOn/ZIQewqQvV3FNOC4NRMy3HeLVTi2+vZpa121Uc
 RLHhrlouwlyA5n1gpe0bmaaSXoJ6szpPI282XP+6sYPpCkRxaPSEkGR
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfX3xwqpKAo2FfQ
 fIgSmr9HPKHkh8m8Xpk+a0fxkNuyjYBhxcn6CXBLQiVE3R6qZpjYp5bKxJ99IYd3dOAh/xhTKOH
 nVU4WrwW1vUnFGGJ+ffk6ZIz0mb3iuI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfX1W/ut8p30Zih
 1plzikHHqmyDv2WGq/3nGbARlnIaY4r9h+euFdmsWY2HCSFocceDOz1ZgQDNJMH81qw0Xi8vh8A
 8c92SXHdTqbk7kOMUuAbSuQrJk1Aj28vUjC/azK8H2xwA9898djcyak4Nvt/zzuyBPRtiq5lh7u
 xaLYsnRapytGafSjNhvp02AQTRXnXX/h3Ii9nA6Uk94IMWFk6EYdAifQoJQN4YJEzDIsMGXLeV/
 lMYJYs+kbnpD78AUJQQEGnUjynhoQAes0eaSz0H+m7Zm+SwfWAgRD7hDmVHpG7DgPOgVEcUg5PA
 OopggMBLas/mDqDSh763p/vAokkjvSw+JYfSKwDWuvAdSOSeaisYZ5GGWBjQztc3fJS4nwya0j6
 I+88U+OKklUoxOfTsNKOKx6kqF7n0dYlhfnOMi4hw3Nx1U7blbMM0ypnL0IuRp1/hqdElpfu1XI
 yJjhHfVKec0aa8PtqlQ==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6b0010f1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=mq5v3e01y4o_RV37-9wA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: SJ5ZpyfWobDFjTZ4j1dLmKC2-PHSIbXr
X-Proofpoint-GUID: SJ5ZpyfWobDFjTZ4j1dLmKC2-PHSIbXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200037

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
index 5c4052f6f24f..779c2a66a858 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -718,6 +718,17 @@ u16 qcom_adc_tm5_gen2_temp_res_scale(int temp)
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
index 910b241fa94d..aeaf13f4fc66 100644
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

