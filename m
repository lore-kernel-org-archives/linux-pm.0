Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD59443E3B
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424687; cv=none; b=eJnZqwAqU0qORQZXqDm8ClFEj72WOVKuJmpxggxEtVBgWKCz4K2HIS4v7C8jta6YaWEuBrDdgNpTc1FQMJR+BQFYx6rwmqfhgYuPuEN6a2Fr05FrkthnYfVKe35D5qFMQRmNaK3wSzfAADwunXreR6zyr7m1oF1LViuZwllK2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424687; c=relaxed/simple;
	bh=kd86lPABYUrJ2jIXZLk3eCNkAgPOzCHoZEsmhQR1t/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ziq+z7ERofkT5BsuXufha5O0R93u6Y3Wvh63DTxQrZE6joai9ZKjUUXo7aK8o47V8Yrl8xP9bY1bPhiH074lWfYf/xixqAL5jFgVAG9Ks+w9jGEr83NTNa9Xm1Hjfeo0g3hFhOqPrR+zRsMgb1ZHV4mWyCEuxxKlhboThXdipU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OQftr52o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N35LXwgf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OQftr52o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N35LXwgf"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6838R3oa2955226
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 08:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g6u7H5xBFCRTUQgMYXpbZseEbBuryIsCQSRuaipZfXc=; b=OQftr52o2pwDje5h
	WUSgzCIRpnF7ZczcOeXvdhGrbNJ506hVOibxNxRj2sn2FhgsbVevHPArRSH6vLeW
	QF7G2ntOASJuc78K4Dc88+nBzVpzXsQjO7XKBHCmBTyNDoBo5YXywwkIoDyVoECU
	ahJ7ammqJDYfxh3ZdUcYOp0QZ9uL6oJkU+zH+4IxFcmU6wqyfgsWkE/cjsb69Ax8
	kjaD/zk9S5BAFsB1lC/5W+I+NGHFHGRZEFDgV0ttIC+KYnxhtRWIWNMUluCoastm
	5dln6Zy2CT8z3FigaOHsuVnqPr/EKDFKzvSFFRj7sDkT1pJqDyamH0iSZD/vHPDf
	C+ReOw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d101fv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 08:38:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93102454272so47861585a.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788424685; x=1789029485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g6u7H5xBFCRTUQgMYXpbZseEbBuryIsCQSRuaipZfXc=;
        b=N35LXwgf7o2h4EdGSDhdxxC1Tw187r+jmL00Z+CDFjHdI8teAtJR6yGA942eT9cBGI
         1MCKeHjKg/XNx+Bg8yQi4A7iIXFy/fORZ2ac1rBDw5KiFNKVw6fHUQ/k0Tzkqt3pj6Uv
         WREhtp6SmW8dRzVjwzvpvkHk3gC0MOngf6QgLscr+Im+OBqMLTyOtmKDQ35xBQv2O6lW
         44b6TKM2ZfsEt7ecH/PhPrYVjdfWAdB2xTG6+qU14mKnXbLxLOJv1CHyUMUVGCWKhhyl
         6hnkBEN7aLtjnF36MoBlkiMS8EO6K9wnXkWeUeHXwlrofzAw+HHPUovGJ39vKvjnpTgW
         bc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424685; x=1789029485;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6u7H5xBFCRTUQgMYXpbZseEbBuryIsCQSRuaipZfXc=;
        b=je6XMYMpVaDjOYPDhiIB6HcjP15j6lgkJY6NJVN8ISKK+saevVzxLAooiSRXC4QBAH
         X19EoMczVKXqO/ZhsMOgY7JkKKI9tn5ozKPJk/+TZ4CqveSC4Jtl592SLP35gwbTV0OI
         +8kv6OptH5ZgVG8iaMO1J0h0Mnh0K54nIxyt6G4yVtW6LDcfNZRl+xKZNVuUubJVaJ7o
         7uVARsQwV2LkVavy7D6kwI+m5R3OIVookMYFdslK1GGBhZf/poepcqFbsciTkk0x6hbM
         IC4yLYGEBt9maouChSgIMyOu5EkrEor+EMyrEpbM2nB97B6kJX/t3qWn5Ixs3wQiUuLk
         LWlw==
X-Forwarded-Encrypted: i=1; AKwUvBz5ZKNP7ZaJGjUjKd+RY6/1hiknKHXFEIp02twLdcRxsfakNEK5fD5frCbXi2LiBOgV7IBuDIv4zA==@vger.kernel.org
X-Gm-Message-State: AFuF++km1541Yf84vdnWiC85TRCjcf8a3aOxTUZ6BluIY5/Pgl6LTIFj
	aKTjAMJdIcVjMLDYy0qC1DsVwf4u6hOAJEz4WwfePJpD+0FoBBiLXD0M1B2FDhf02rEO14vN0cd
	2qAZLs3iSPxE3/crRC5eVfnhVFR/s2wp07zCK8jzooj/yECXhTvgB+yjh3k3RQw==
X-Gm-Gg: AYBFou2f+0Hir7Uuk5n1zjorPsb/zaiPpxhYbLvLCi3C4+b4q17oYr/wgmwTHZB/7wI
	NLcjGgbxlHq1ygHma0YYYccmErDgMEXkdFN9ofWSzPz4U78Zp1I8yiLjVOCl1tvtboT1/vwJnsH
	Atsx13vNrd5/lRLEekEootlLYuE2X0JmIlp7bmZnuXq//KuT0HXjHd7zezE69KgOGW51QeJQ0ZO
	7NYbGsmXzbVYhmKOnWQRqX85AaT2BDEwUUDnzqWRkng5Rjmpr9mU/z4fv72pzhhaGC5TbDW/9Wb
	7ekCQXsknsSILqqKfMHBun/GpQMTuRLkCTbYnyJUa4NoLZPzWEtYwDOPheWTNNnvP3XyYKjoeG4
	pocRPO3ck8g4JipHD3beo5g==
X-Received: by 2002:a05:620a:640f:b0:939:17ec:8a81 with SMTP id af79cd13be357-93960f8a9afmr776712785a.3.1788424684627;
        Thu, 03 Sep 2026 01:38:04 -0700 (PDT)
X-Received: by 2002:a05:620a:640f:b0:939:17ec:8a81 with SMTP id af79cd13be357-93960f8a9afmr776708685a.3.1788424684116;
        Thu, 03 Sep 2026 01:38:04 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f41735ecsm64908166b.19.2026.09.03.01.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 01:38:03 -0700 (PDT)
Message-ID: <4cd975ee-6d63-46dd-93ef-7c6ac1931837@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 10:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: qcom: pmk8850: Add ADC5 Gen4 peripheral
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
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
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-5-9c49b2eea6f9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260731-pmic5_gen4_adc-v1-5-9c49b2eea6f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3NCBTYWx0ZWRfX2twjge0Ait0v
 S/4EW9lFTlSZftLCOF95Eqp9fHKNZ7RDwfDjIJPFM3dt6t+rDTzxSNlQfjiSWVBe8i05f98fT6Z
 DGfzAsNYgTH84cF1IGpC3mv5ZXWkiGNJIO9Xgi7DjVF9tAMc+9HwcnQoZ5HJe6QCNklBxQy5cJ2
 EwkQqAbCMMQlXHiCwyKHn3LsONhE4HSlfvJFnSiozP6aYHLhVpAi296lvSCO7ZvNyx88pgzFIzN
 WO6hXdOqqpw+c1u+wQaHTfXuinb6I2nid1zhMx41PXlsv8yIH4Av8zyBTP+YnWAkdwydp/qq2Di
 6tyE8mFOFXBPZ+GQQtdfs/PfgiOQ7avsJNZy1G4HQqJSNlZJnhP0dUAQxq++TqaZ8O/89NUXx7G
 nmcPKlRDrmmuL2nc2TXP2m9z6jvuRUEEXKoGZ/my4jDHfwyShCn3qY29mn+aM2TAeduV+VP2jUr
 RoMCykcac0jsnTQ7JkQ==
X-Proofpoint-ORIG-GUID: S3DowDex5QLlMhSfVJ7UL7z1ewWF0zzB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3NCBTYWx0ZWRfX/mBml61qpPnE
 ewGb9VF6P91UFDPD4Zq8CpBI/UdSI3xahS97Ap054UBunP5een0fsgiKBHDB8z0BMbilclklwhf
 pyP+5BgHXadkoqrWxtK88qsekUHS4JI=
X-Proofpoint-GUID: S3DowDex5QLlMhSfVJ7UL7z1ewWF0zzB
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a9931ed cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=eQlnLCDwCofjbIFrPS4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030074

On 7/31/26 8:06 PM, Jishnu Prakash wrote:
> PMK8850 has an ADC5 Gen4 peripheral that acts as the master ADC for
> the platform, communicating with ADC peripherals on other PMICs on the
> system. Add the ADC peripheral node with PMK8850 die_temp and
> xo_therm channel nodes under it initially.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/pmk8850.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmk8850.dtsi b/arch/arm64/boot/dts/qcom/pmk8850.dtsi
> index c7ba72fd48bc..44d1d1957f8a 100644
> --- a/arch/arm64/boot/dts/qcom/pmk8850.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmk8850.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> +#include "qcom-adc5-gen4.h"
>  
>  &spmi_bus0 {
>  	pmic@0 {
> @@ -45,6 +46,30 @@ pmk8850_gpios: gpio@b800 {
>  			#interrupt-cells = <2>;
>  		};
>  
> +		pmk8850_vadc: adc@9000 {
> +			compatible = "qcom,spmi-adc5-gen4";
> +			reg = <0x9000>, <0x9100>;

nit: one a line would be perfect

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

P.S. can we also add some more channels that look like they would
be present on all 8850 installations, e.g. offset-ref, vref-1.25
etc.?

Konrad
