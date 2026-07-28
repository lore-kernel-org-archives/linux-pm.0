Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152013D4126
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785224984; cv=none; b=ZJEzgJrNS+jtaM6y6CqU/VHpqd9vyiGCGXZGWJe95fXRYjapop4Dg5ceAX0TFXzxa/97yoLj21LLj9fLIDkg05fDxYlSrWgjj3fmH6YFVRk/T2qg56oPRnnnVqa8NwX4Xw3NWTUwO3M+b7hmfl0DmxoiBozSTJHs5EO6kOEapnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785224984; c=relaxed/simple;
	bh=BXsR1PsroGmjU22Kfo1R3WWVQ8SfW8ospEk7LYL1kzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WF3x3m8I0N3nbXs9enh85UT5znAaW0tkrDVeGKRTZmlIX3Ea2CJ9L/lGB0l+JBHw5s6KNlBlwLyhUmF3CYJi1sRDQFOvP4KP4AWQFRmEg3Jbrp4NttvpBiCKjaZVB2txOlQ2zUustepTiDE7vieEp9378nStwbkAvABfnxwaFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7yr0L7T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N5CMbSUv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7yr0L7T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N5CMbSUv"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S6Yl6M1824264
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xACYJf8+xxMrhsOL+JreK/GAqAzmxdkE6g+EW6DuSng=; b=f7yr0L7TtfyrzM/u
	FgsyFcijfBvJ0vRzgfCbzCtomAyQJBU+D2FbnTacOwUS5B0fuqsv9jhuOfAodMRV
	gzre8wU+eA2LPrZcTc484gkujuM/s/cqvQ58iZLbzCCezqReu6YPX9DKXhUKlYrq
	d5DK627VwSXMRIAxNPG54+WM86jERXCJCTAXSDiFn6cgKsiY3vo+Do2B/mzqeoOM
	UbjxY5nfrKNDN7WCOvhY4y5T/6PmP1e8nc5Nk/VUOPntBgm989lRbeJLtaOcKUa5
	bkKDPsnKcbs7hoUML8urjkVCcRQ2QrM9ORqBeq0hkMxe3YGEU17mLkHRLNpac4ko
	w40DUg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpq9hg9r2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:49:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cce14a21faso11548185ad.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785224980; x=1785829780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xACYJf8+xxMrhsOL+JreK/GAqAzmxdkE6g+EW6DuSng=;
        b=N5CMbSUv/qxf+VPJ4hUwnAbxvQ0wWt3/k2B6IT69peJUJCbe5ZXUK1JYswjpAeAxU4
         vV9ohSDyY10IB38NmB/f5yCVKxLYeBBaF2K5YJscjcjn9ox5wfoXlWcuPG2lWV2AEb4i
         uzbH27gKAp5cIao/ATCasuOY6Q3wNsL9DmjghOhIsfhb08NmwBEY1cXq+JVssxbUCvKk
         qePfr31JgMUsecRoiyKPNKUb3naHYPHXpCaNbpXLLML9le4bM0ihcOJsx6dkQDYikFm8
         xoNlG1bbScQNz1Ieb42zVboe7lwV7LyNI1ogSx0zLnvIa6KfM2acUIaOvKsqkExJR4AF
         A9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785224980; x=1785829780;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xACYJf8+xxMrhsOL+JreK/GAqAzmxdkE6g+EW6DuSng=;
        b=GiYE0xLgoTdWpbSy8lRnhB+aBS4CpeDI50hmO5AkRxXgEY4sUDRUce4J+EWCe3QO96
         +3A0HYE0u/7RnIwP+U50NOcVfeHm9NNgotpkuweTXEEpsh9nWzalYrXShgu9KCrxDq6v
         p4eTtnXjliEgVwPZYlLN+t69yMrwcrET8pKAj6YAemS2URH3gqb0R1DPFox3b6BN8YBl
         G7TA0ZS1aOly1OFcHBM488LWt8lJVDQLzq6oRNEg40oWlGaosKEOF0fMZErZ569HlKp4
         MmuXte22vl4r1mfy6Ih7YDJm3lvMz3REcCFbkfuqncq4WQwxLH8RSXEiYcQ0CtDgyMMC
         Nmrw==
X-Gm-Message-State: AOJu0YxQ6CfieyZzVS2kZjXxV/l6HF/A7GLUBusN8KmKn0+Od+LPLBmj
	Ar52xANzos1uXDgHNonJqjTKf9x8NksoC+L+zlXEvyVz555l65LTmFzvznFkvSu2mcNNRTbRa1H
	u7bLSDHr63ZNWs2O0IOJsfQQlJhodFSfRNW/6az74AUPRA047zzpz1qS5IbQSvdLfleV77gfm
X-Gm-Gg: AR+sD11stdWiXb2L8DdjBZlFz1iR5GktDMbVj9QPNqbPJWLpg8kjwSOBvfE+8L8U6DU
	dUng1TAdSyJK8RNtV81zX0FA9dbqb8Es4wiLjBbVazDz53QXFENuu8gx2/7Yg1q0y7AHh+RrjFR
	DKSChDs1LP+su6sx7QfQLCxUo7Hn7l0SeJrkcSA1aev2wgTE7OLJnyq2t8psF4ShNO7M206uMx1
	2EihJGSUZOGHmT8RNYayVr148RoyyzuP3wQ3qwcui7L0RC4wGX9BwUuOUU5n/oFNRqEtMFMOyO1
	g70I+Ej+6pQTuTptIgChwZyQoFnJ0jZLYQppVcrkGmJEHBSzr3PWKJ/JDkmcJ596Jp0a4zRXXKX
	27WD7gk1mpq5pw24UK7FpUFLgJ8BCugEI3qsNWNQ7YMbHu3Z/wdt5STi69ivRdj5b+ry8jw==
X-Received: by 2002:a17:903:38c8:b0:2ca:2390:ff13 with SMTP id d9443c01a7336-2d015af49e5mr15436475ad.5.1785224979978;
        Tue, 28 Jul 2026 00:49:39 -0700 (PDT)
X-Received: by 2002:a17:903:38c8:b0:2ca:2390:ff13 with SMTP id d9443c01a7336-2d015af49e5mr15436195ad.5.1785224979558;
        Tue, 28 Jul 2026 00:49:39 -0700 (PDT)
Received: from [10.133.33.39] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e8a44sm48598425ad.35.2026.07.28.00.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 00:49:39 -0700 (PDT)
Message-ID: <ee48d1db-2fa3-469a-a89c-8aada3375dd1@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 15:49:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: thermal: qcom-tsens: Document the Maili
 Temperature Sensor
To: Haritha S K <haritha.k@oss.qualcomm.com>, dipa.mantre@oss.qualcomm.com,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com, gaurav.kohli@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260619-b4-maili-upstream-3-v2-1-e54516c37022@oss.qualcomm.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <20260619-b4-maili-upstream-3-v2-1-e54516c37022@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2NiBTYWx0ZWRfX+dOj1f51fmnn
 Alao5dH5OdiWfuifjkOBSMOt0iVgAG+jAyHjujErMgydsWyN2VKUulAeIl8U/83UlWMplxUwWIb
 U58kjuY70PhhyByfASYy/X4LoovkAvw=
X-Proofpoint-GUID: rtjqJzaPm0NR9v-a0ZQ_1UAwBThNgUl2
X-Proofpoint-ORIG-GUID: rtjqJzaPm0NR9v-a0ZQ_1UAwBThNgUl2
X-Authority-Analysis: v=2.4 cv=Aa6B2XXG c=1 sm=1 tr=0 ts=6a685f14 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=Wp413ln0MjA_3K6qQysA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2NiBTYWx0ZWRfX3Os++ouMeKwh
 BUxjHLXfR5MVqvOftjcu3ViNoBLfoTgHiq2QFsWzSfeZ4k+H8Po8N1VysuHr8Juu48Cuc5xcGiv
 Gcg2DIzHv8kdkrhJv6779iL37Z14p+cmArL8a/TvrGTfB1ORY6tkmKuCpngOJogFwRQF6Twc6Vj
 ByMwlt274iTtFp2HoBoaJZFH07mPgrzAkf2yY6BJiBqO5IKOkY/ja6bGzasRcG1k3+v8VQIhzs6
 loubdQv1i26bUztRD9phgtNftggKCCywHkfWXLLLu5PV/BKgB7F6EDrR/2SK/Q0bpHvSeXGFpI7
 2sT96z/PEwm7JImhLBgCr6Cs/xuTBlM9WTuUzguM59zpG9XfjkkMSMdVWGtqMTd2Dy0UERnAi4v
 eD0uVTg/SMdeIe9GNp0blFrVOQyKGaNVaI3GauYjChT2i5hpkUssL3y//VyGfHzDJJMUZMmkw1L
 7NN757cH4xHlWEulp7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280066

Hi Daniel,

Gentle remind the pickup the patch.
just checked that it can apply cleanly on the latest linux-next tag.

Thanks,
Jingyi

On 6/19/2026 6:20 PM, Haritha S K wrote:
> Document the Temperature Sensor (TSENS) on the Qualcomm Maili SoC.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Haritha S K <haritha.k@oss.qualcomm.com>
> ---
> Changes in v2:
> - Updated commit message.
> - Link to v1: https://patch.msgid.link/20260617-b4-maili-upstream-3-v1-1-1b8cb7e425d8@oss.qualcomm.com
> ---
>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index f0efaa8349ee..5a8f7673e730 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -58,6 +58,7 @@ properties:
>                 - qcom,glymur-tsens
>                 - qcom,hawi-tsens
>                 - qcom,kaanapali-tsens
> +              - qcom,maili-tsens
>                 - qcom,milos-tsens
>                 - qcom,nord-tsens
>                 - qcom,msm8953-tsens
> 
> ---
> base-commit: a76326dca329a7a738ba367529868dfbafb4a403
> change-id: 20260616-b4-maili-upstream-3-b198aaa8969f
> 
> Best regards,
> --
> Haritha S K <haritha.k@oss.qualcomm.com>
> 
> 

