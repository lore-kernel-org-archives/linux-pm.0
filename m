Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166429;
	b=a9iTmpWWjZsjjkjsTmpzILUFaCHmMoydPlAyV8ae8xkcnsb1XHcb3fFbRsouvht+WMMd
	 Fm+U0WAqnAQSav/Bs/MaCAZVVvytQrfHIz6VlEsgZPA13RPNujPNoin1OE6Z2lQgMKeL7
	 4vMhmc2nMNVOrLRahp5rCZkCOFlZnaMTcfpegwJ/hEV4CTgmvtpnC08T6Cxh9Y3nPQ+4G
	 YuNEahjZSoeJnr7uhC8+sQKCRcNhdij1UPgtBQB6Z6EcbE/dkwGrrg4F11a97oGpBYqYF
	 kT0Om50MUc0j6ZXss7pPNWaAl1L0tHTfPna6q+0N20LHcdrmPxePieLsnbOOb8OLYxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166429;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=76K8RMWO4SU2ZXFWs5BbTqqNkuQlMpM5CVY6Rw3sotg=;
	b=Byb2yHuXmpuWU0rtMGk5QOYybFe7btShjcvOYBRPK5d77mYiQK0niNdwDgwqJDEZPqAt
	 XBw9ZFu5DrdKxllmVNDRNTYZ7QrT1dQ39nBTxinnC2Wj8VHf1NjuK73QMWRjzyT8zBWt/
	 KuQ947GsX/Bq/HtyJbLb9NngrJ4aIpRlZdg1errt7qiHO/C49ZY85gnl/JoC9giC2+Q6v
	 QL72HQF8tdftgm8exTPaHhpNB5Ai/rCs1bxihaNQZsrKA5370RYukNkgUGmQBUM+QScdw
	 nK6POSG5+zyGkEurY3sLQUYOG10+Mo5yJpFtdrthHUKuBV0rSsRC5ElppsXqa0TAx3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sxx30HjK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SAqBq1eC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666AE606A331
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 666AE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sxx30HjK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SAqBq1eC
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fDbq3320729
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	76K8RMWO4SU2ZXFWs5BbTqqNkuQlMpM5CVY6Rw3sotg=; b=Sxx30HjK968a0r9i
	nN2cUmnoXw0Av8mzVOSMfRp4ONN06PUjpqFbEgR04gIGoD/LnNnXxPRLsxQ9Zq8i
	4P+unKEz3BRJ1/Pluhk5E2uw7MDuVCAxAQC9+F/esmcAwnBHl0zCYxZ9WYyHRvQh
	zq7lweKg1PCP5nHi5rWCLG5VCikm5xbXYM0hyroXWavY1DeejKB2294VGac4IpHj
	tQULnoB4SG503IpKnARyvT0erRPZDVOSpkDBlF1uIwOy0C9BwBwAIIFfVqlSDmxB
	t+aUkNkdDqWNohc+X30+8qDIw/0Z65I2ssby12ElIMQEkJcVxVV+1lL4GGy+ETJM
	cxvavA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2frhs1fa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:20:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a06750c74fso658809b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 01:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795166427; x=1795771227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=76K8RMWO4SU2ZXFWs5BbTqqNkuQlMpM5CVY6Rw3sotg=;
        b=SAqBq1eCWBQT/FankBbIFETu7bCbhxbSFxTuTlKkJ2TZV5hjC5sNdpLmbScKXZw42p
         wO4OTi/1ubBwEI1Wds/s7Av33pqAE3nYGQ9sycDkZikYUQUW5ewyGzIMejXZ9Xkbk1wG
         sHbtJLqo16TzPWFY64SkHiS9nLtbDizRbavJeB5osX9pZyPFMzrViJbB5LPm7C0eDgZa
         i4EGvyq0yGvBZRWor7fud3Z0lChbPSMIPSmMTw9aGtxpdHnjpfH6n8jrCmuzXw6cuMfH
         f6m+L3TOs4yFpMs3CqnVYJ21JoGRmgjLFnq6VHLC7uwyL3K6qECb+YU7PC+/J+nPdaYT
         0oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166427; x=1795771227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76K8RMWO4SU2ZXFWs5BbTqqNkuQlMpM5CVY6Rw3sotg=;
        b=SOFcoW9m5dVhJ+MXkFsJ2QiCiffGDYGdF/S8AMY8KJBmJkwearn2mEuBMcN0c5K2DL
         yH7vhk4NKxJk8sfJEuhvbEv7GYHUiBvTE9q3mdwWdlbq+DNhM6FyJK/ojjrIa04JHYbp
         4oNXJeUlVSMkGtlaFddgfQ8nYIytSRsxwlcb0pVQzgDH35GHYhc1ZleZ5Dumm5x7rTOH
         eF8DGKGO4qIg7t2OqHtuG9mlRQx835Ol2ZwhtmxM0NkD9pYK29FZQXn2S0EUe50sePqB
         dh/GWJ9Hu/R6R9rZAPZlrkrKARFhDbXluz2YO5L+sQG5wVhxFFkpiSrdfZ7NyNuCHmQ4
         2wTQ==
X-Forwarded-Encrypted: i=1; AL+hErEjRzmohRjQhK4/WNUPqy2HQhjftJhHOsWg350+tbn2il+BktudwoWeYx+UYvHKE+RYNBY4uP9aQw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8qkCXtbZPbZeHm1xoILQyoCxMPzGxXsvLlsvhOkN8sPevPd6NW
	3WPu0tywkYssmmps+yVhevHZIZq3b1hz3P35KLaEBMsV6n0s92u0MJuSl/pYFjdEwLfumkwhw99
	0OB+B/zhNts/xEhtW4WavmtV1/bLjj7HcxFWYmRn4KkDBdeuVe1DK9Aon0Rqzgg==
X-Gm-Gg: AYBFou011VXV5mYzq1YQDG0a9exJLN9FfNcgv+7UsmTxO0/1nPuoGmKOg0o2CDMeI9O
	7uHapqQhNYsKsQ/vv8q30kqK6xqIM5RNFlJw5+kG549LQjpQsaetDmFJemwzWwjIZ610C2/70wn
	oO7X7uaIHn/KWFibWY6PqXXW2Fhjs3rSSKDDjZv1MJP1DKE96jfD331LHnAfM0R+Grc0W2QMhmq
	DIUrkh3rsMVGKcYi7LFrAcBgCFcD8990qiPoGaupHXkte+nW67FljrYu4lKuIMn1VD19hNV0Ax9
	6Cld3j65yHlcO9g4tVKKoOCQRRoMLHGAXkppKrDl0y/Phr1G7BJQXQnbbZR8NNCrtWZDw5u9h3E
	+jult5MaACtNCubleU08ZD4rPHz/ZBcGYgdmIBigS1NSQAnU/NvTSXZynAGCyXZI5Xjhq
X-Received: by 2002:a05:6300:6bc8:10b0:402:13e6:58b with SMTP id adf61e73a8af0-40213e6061fmr373903637.37.1795166427431;
        Fri, 20 Nov 2026 01:20:27 -0800 (PST)
X-Received: by 2002:a05:6300:6bc8:10b0:402:13e6:58b with SMTP id adf61e73a8af0-40213e6061fmr373886637.37.1795166426985;
        Fri, 20 Nov 2026 01:20:26 -0800 (PST)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1cfa0sm1186994b3a.48.2026.11.20.01.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:20:26 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 14:49:41 +0530
Subject: [PATCH v2 1/7] dt-bindings: iio: adc: Add "qcom,adc5-gen4"
 property for ADC channels
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
Message-Id: <20261120-pmic5_gen4_adc-v2-1-94d0e1fd6847@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795166413; l=1979;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=F3jVIKW9NilXKZEG5EHwwNF+JBuq151qbC6+MY489TM=;
 b=8ENEqOoPLDHnJzh4eRJTEVq+hTwbYAEvLcp4kzvlcSiRgRjVSn+k7VUXrN6c2rQeOwm94xhUF
 j/xnvYGUOlUC/7vayoAhBUPFpJYPfxeB1KG4OvcYZ/AhxcJRN8Va7KG
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzNiBTYWx0ZWRfX+XSzNz4PZyZD
 qyKpydAe1WwlfGbhrG7Zpg5HH3jiIA62h90rbWRhHAbZC9Q9SPg/rpiim0mSeGsQ7Hlho1jmu29
 WIZdXwYU7iFXreEGUlzCamjWsBolYIM=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6b0010dc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=AKg146UrkyRmMzRSXpsA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: ZRgR0uotuv5qmV58h1IxWSWoSCGuJj4u
X-Proofpoint-ORIG-GUID: ZRgR0uotuv5qmV58h1IxWSWoSCGuJj4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzNiBTYWx0ZWRfX+ebQUoBmbr+3
 M5tE42+9fq9UWQ1J8+fleI5S5pfIFW9bL+fr21V8O7Gd719duVit8CbkkHF0mhVkpp4d04ISpe8
 8SF03+gFBlElcBQjyHOW+VTjG12NQcmVCgU7ngKO1sHVTp0WHA5+mq3MPOz0tdVnRfsQv3nSRnf
 emfZB0G1XGmhyHD3/sSnld4ADBSttNZFQLBLFWov8VlbpgZDTZk/GEA1KfMqmmx3Zm97IOXA8zR
 YSLcJZaazpgHVWejmEKlTECpeGGnFTwtlVIgrxsqCHeeMrCnxtS+PX5Oon0dA+ji3fuFvdfWWhG
 eBfTJi09bZY1ITsD1o7YJfmFjX/s3yrPZKboCEVRNqmcdm/Z7JNNd3CC/gd9KUWIV74+tyiPRyY
 W6nD3fOffAsegmFTSGeCx87v/ddKMTkphy2RpPjJXJtfyK9rEjPpwXVtnoDdddhVj+NodPj3Q79
 tO7fXs4Fm0kxnr2H9VA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200036

PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made for
improved performance, mostly at the hardware level. The main differences
are increased ratiometric conversion resolution (from 14 bits to 16 bits)
and increased bit field width for PMIC SID (to allow communication with an
increased number of PMICs, supported on latest SoCs).

In the Gen3 ADC topology, the ADC peripheral on the master PMIC
communicates with ADCs on other PMICs. It is possible that some of these
other PMICs have ADCs of a different generation and may need to be handled
differently (for example, on SM8750, PMK8550 is the master PMIC with Gen3
ADC peripheral and it communicates with PMIH0108, which has Gen4 ADC).
Add the "qcom,adc5-gen4" ADC channel property to indicate that a channel
is of type Gen4 ADC.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
index 149f4af8f4b8..065b82c41e86 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
@@ -83,6 +83,14 @@ patternProperties:
           This property indicates ADC_TM monitoring is done on this channel.
         type: boolean
 
+      qcom,adc5-gen4:
+        description:
+          Indicates channel is of type ADC5 Gen4. This may be needed in cases where the
+          master PMIC has an ADC peripheral of type Gen3, but some of the other PMICs it
+          communicates with have ADC peripherals of type Gen4, so channels of those PMICs
+          need to be marked as Gen4 to ensure their conversions are handled correctly.
+        type: boolean
+
 required:
   - compatible
   - reg

-- 
2.43.0

