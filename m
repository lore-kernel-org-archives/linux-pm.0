Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166471;
	b=3qXTwj9aHzo7fNPSe2QvkcsPX+VVeHbkDdP/Mzv11zf+xhTumutm/OcnbzS3DH290isT
	 s49NVnsvBGfphVHGb3KtGoui9FB6AEt9fMsC9SVewXQGoEdDh3E/A3+Z5yie4sU1MXEjA
	 Ec43zltrG7uvYh9LGGBp5mCO73ItqIpeMIM3K77gdTZ5b74M9yyCXRln2BSrw34i1xWRt
	 8CfuF+0y2BE2ZRqybyXf5dvG5hTyiY/e4dMVJhd9ZMZyDhpMxdIuaDAAsngLUnUSK3fPi
	 qXHN/+zqKfsp7IGjcNlxrXMasWMLYDKlzDJoF5f3rmB41L1T3W7FtZ6IOK+/JfCmHnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166471;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mahhSk0PmR2ezEj2NwFomLCrdaTaXFYTI0YszKpQWiY=;
	b=2EyIWNiYWv3yYEYYvfjo+9lIXfS1AKAxOkGiXS6sleYgmRKyDad4+0A3EwKZJcp4BKDS
	 a+bKonm9+J3XaDfJSZD40nJ2Jfb6IhGLgGpzKAz+cs8oagiUz8LDjGDCNh1DgJMqzQ4PF
	 jx+sCg7GM9vO6y3ds/1C0SZv8t2zt6ZapkV6h08OebgWL+J/gjXn0dOOSCGf3CKY1/F4s
	 Oqiitg+3Rj9voMBQ3fR1W6CK8cC6dJUdOt/bGgQeXzx8iDhe8MeBHtL1yQNrQ3i+OxnKy
	 uZfjrNxgbUE5gctjDwuAKP3//7ooqHo9wZqk2l81M+7nSFYlmqhmBHlFZV5RfYoVqdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pFhEPrN6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NqgzgaSM;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9560A2602
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9B9560A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pFhEPrN6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NqgzgaSM
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7f6fO1742184
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mahhSk0PmR2ezEj2NwFomLCrdaTaXFYTI0YszKpQWiY=; b=pFhEPrN6iFGZr7FS
	VvJbym3P0aDFC5Mm6QmYQ8JuMe/VB09m9wlAzsRa6YXsLv9lQxEcdrboAUZD/FP+
	lSI6JC7Rb+kVErWHaE+h0B0AMvwzWFIpigt3Lcz8tYuAa3QraZgVqROZE0LynpG3
	0MiUlzT3RGFGqGNpbcstpbV6su1AOdrH8Gkottn+AuSS+f3Zb0Hn0kG3361s6+fX
	zojyQky2l4mhLXaSxt/XbfupAvTyws6dpx3ec5nJ8+asBghjUTN0R4t0ZRsaVP41
	x9F0nR9w6T2uQixjZTFmtRAoHs2N9rT2xQIPjIflbnsSKBqH3NcqGb1cekVKFwq2
	VVlTrA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2f4yh5ec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:21:09 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8b60129a46eso1158647b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 01:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795166469; x=1795771269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mahhSk0PmR2ezEj2NwFomLCrdaTaXFYTI0YszKpQWiY=;
        b=NqgzgaSMvMKItkCV353z87f29wbYiq/T7WdMxZVKhxWSarZZPDjFBGo3bmketF6U2/
         b7LtGGKC3CzdTz0qLh06aurC0I8P0poVho9MtfeUUR0rpcsPeDMqPTAqaN5q3dEgYgi9
         4vCc4G/zUVb4yPni45baGh/SiurwtCDSA9zNLROOCpGBpY+tp+qDlpSF8OxskRn16g0d
         yC4wQntfXZyYsGIuGlH0EOYkjZu7Onpej/DzG38WSwsDHRALfrszLKX5flqUuMBK5dyr
         s/hD0mkcqoRx3z/5QLmCVObkD0cRjAARUjeRLwKZrQEKPzQXGEw93abQpq51fJn4Zda6
         AqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166469; x=1795771269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mahhSk0PmR2ezEj2NwFomLCrdaTaXFYTI0YszKpQWiY=;
        b=P/901rouAmeXJXiHtKCyYvyghSQ04gXn6eaxqrU+QAb3Yq1ErqoVhZB0qfkKSSQ7Iu
         Pt7Xy1UnI4Xnuhn6DxEWx3wrUpblk/IqG82lSY1/KpBgZ900t7pDxCjFNkDk7+4cciLM
         yIzATCSG2njnG8ZKydx6PjrAn6qJlWrVdv8uARUXulqFeWNQ++GD1jcsrbMaJdc+WmYq
         Kk1zWFjl1K9yLTjy+Qg2jlZmq7iIMHxspNWYillEPhv85MtB4YXwPL8GXtEu3DQ5upZh
         5X+hMBZPQfIXaEV+QDVKPpbi59k/xdXFffVWmOZcjc/ZamixNezVvv+XXgt93kpbCOV7
         fHUw==
X-Forwarded-Encrypted: i=1; AL+hErFouOvRqiLJ9nZPY0jEcZaCvO/kedy2k3gyEANEhnkPl8aXVn2TFMtf9rRJxRhqt+KuNnKLAjh2BQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9lzMoHvWCcQXnuC2NW6J46gHRtSHzaHBxyVOAtOYzwmKectN+F
	sku6aPvN+A+/E1+O/dazjZ9DecFeHURP1pBs8eJdpk2swB6TMNNt8GA8CB2GTCdARj2NedPAHa8
	Wvyw22jP6SfnttWAqXuXlD8dNY6P7Iqcc3Z51INDwEnceayvpPNZIEMsEV5NXHxkOcxpuXw==
X-Gm-Gg: AZFdTZf6Dv25WOKZdyZG6MpplIvBmvI2LHCbmic2RKC94+ZNcXBNTucKuhnDJeXIzfz
	BVIvOc+O4BZcbUuIsHZn3XImQ7Ny0TKw9k5/vMpcx4MdBQWrBV3hqJk+m7vsh+q37yIn6fIubFw
	8vuQMENtrYt0Ky6D1CoJwaDvER6O24qePz6+X68ivZeUPwZbaCiJQNxF20NNZn5Ygaas6ePGT3m
	LgP6gvAdvBlwW8bJaIAEPRC4+81oHpDC/kPTkuz6X400Tw5PDdGgX/EVuoXXfYazoXT5TlglumI
	Qv6w6d0dA4I6wPpfYNrMLTLmmTbMcmtC69NperbamoOwSzZs1qJpNXZBJ5NV6sK/f8VaWBcXLsx
	P7akuCQHr+9KzArU55yGATPm1hKzipP4Vwzlt/wcYEpOF/JHKPv5si4Y2+1Uze0CABKV1
X-Received: by 2002:a05:6a00:13a4:b0:886:3827:c4a2 with SMTP id d2e1a72fcca58-8c8792b5df2mr2197426b3a.3.1795166468759;
        Fri, 20 Nov 2026 01:21:08 -0800 (PST)
X-Received: by 2002:a05:6a00:13a4:b0:886:3827:c4a2 with SMTP id d2e1a72fcca58-8c8792b5df2mr2197402b3a.3.1795166468320;
        Fri, 20 Nov 2026 01:21:08 -0800 (PST)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1cfa0sm1186994b3a.48.2026.11.20.01.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:21:08 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 14:49:47 +0530
Subject: [PATCH v2 7/7] iio: adc: qcom-spmi-adc5-gen3: Add support for Gen4
 ADC master PMICs
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
Message-Id: <20261120-pmic5_gen4_adc-v2-7-94d0e1fd6847@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795166413; l=1816;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=8tKiHC9A/M3XzU0T08Uaoa2wdw40KkBqDDzliwqYNnU=;
 b=BKiM0wm2FEu3QaMv6oPG6DNGe1n0UDqLZHy1I0BEjBtQuV7N70QOdKz+q2TF2AotRmVplAnqC
 nByof0nMIoGA1wh3QC9cGllTN1Cfc0pQV4XI23sX18Mn9k1isyv2Rhn
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Authority-Analysis: v=2.4 cv=Zs54uN7G c=1 sm=1 tr=0 ts=6b001105 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=c7yoL7TMHuxufLz7hX4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfX/1Mas8FAxnFz
 haAsQUhrJ+q6g7hNsivXwgxLu3z2yIjjDcPmgh6uHPXu7QWGjYdedECTxwDRE3JL7VKB1jFR6Pd
 knY80JG90g+eMBc0kfI5M53UxbvjxrtpBdEplzycAA/0lRjY9tg/ha6w21QnmTI/FAQ7l2MpUi8
 XzGmoNiNcGPlIZZAJFu9BhxGQgthFwaR1iQqdgNUzAvRf3EWrddXRaZMiTnVF6JDftvLc5oB2Yh
 QjnGf7aPiB8J8zIYpLAQ/VdWn1J3V03aIW058AutsPFwoW6tdKX5CniSiY1KTMGzLjQvduMk/r3
 w3NB17ILRa8yaEgAbZhC5nuZE/dJQHcovmj+GONTCniFSe3M5A5s9U0wp3Ne6Nyh1F/nPsIQyrK
 ImGBPtvhwcrDCycFowXeFEVjlLyR6WhDV9dQR/ctt6ax6qn8P3k8eT5vopOxKyCNrrIN0Pv6Hd2
 dsTsfNdl1ic8+pQK0Pw==
X-Proofpoint-GUID: Z5G6wxjDt7MkalT1YRd77gei6uXJBGvb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfX5Kv7STbU2+ha
 OfEiaYAfKBjJsEw2R+r0mmXRPbc4HwrMWmTAOPvtN0nwqnkP4f+Gb3RZKEDLEP6s0yM1RDscR76
 AKZvvpHAGVxkC+TWIidghecWcC0Ei1g=
X-Proofpoint-ORIG-GUID: Z5G6wxjDt7MkalT1YRd77gei6uXJBGvb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200037

At present, support is present for Gen4 ADC channels under a master PMIC
with Gen3 ADC, through the ADC channel property "qcom,adc5-gen4". Add a
compatible string "qcom,spmi-adc5-gen4" to support a master PMIC with Gen4
ADC.

For Gen4 master PMIC, add a new DT property "qcom,adc5-gen3" to distinguish
Gen3 channels under a Gen4 master, similar to the channel property
"qcom,adc5-gen4". A channel without either of these properties is
considered to be of the same type indicated by the top-level compatible
string.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index aa06d4d1083a..6782e0ab3993 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -521,9 +521,13 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
 	if (fwnode_property_read_bool(fwnode, "qcom,adc5-gen4")) {
 		prop->common_props.generation = ADC5_GEN4;
 		data = &adc5_gen4_data_pmic;
-	} else {
+	} else if (fwnode_property_read_bool(fwnode, "qcom,adc5-gen3")) {
 		prop->common_props.generation = ADC5_GEN3;
 		data = &adc5_gen3_data_pmic;
+	} else {
+		prop->common_props.generation = (adc->data == &adc5_gen3_data_pmic) ?
+						 ADC5_GEN3 : ADC5_GEN4;
+		data = adc->data;
 	}
 	prop->common_props.data = data;
 
@@ -596,6 +600,10 @@ static const struct of_device_id adc5_match_table[] = {
 		.compatible = "qcom,spmi-adc5-gen3",
 		.data = &adc5_gen3_data_pmic,
 	},
+	{
+		.compatible = "qcom,spmi-adc5-gen4",
+		.data = &adc5_gen4_data_pmic,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc5_match_table);

-- 
2.43.0

