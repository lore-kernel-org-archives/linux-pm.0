Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188ED41D638
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693520; cv=none; b=BKk6piPclnvpJX9VuGESCzLaQBgJ3nyQV8s1JdwY+cEuETbd+Hwlwy+1D9lj9KsRDq4hnpbe8bTHg1xEoUrJk2DB11J7nauk7ql4LmZ+DcHJp4gRc1mngzJtWz7a6KnKioAAkUkvBsMiFn6D+tCEECP0LzXNOnBUvPtRkSrR2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693520; c=relaxed/simple;
	bh=43VP93M2bCuUQt4J5zmUp5pqSrHi4cXLggSwgWzuaiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nev0r2apQEHnm0sZgTh01VtnhGfzbMuGuA/seCPwzWpqxeozrZr/NKNQOe+snHLIdShDCMriYFN7TZUCUsnSTVzAfbS5d4+R0jJVFirnTbE5dIPWScjDWx2BTDnJBLf93kKXs9S+vGU3u4d47J1pX0emo0hO47hbXrSKCZsjPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Edlwjcgh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QfS3aFxQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Edlwjcgh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QfS3aFxQ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7fRcV1079117
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Re82H9AabKnC5fSLI6YMte6BlqAQaCg3tkq8ao0UmjA=; b=Edlwjcghl7ohqAmZ
	SIgVvj1wkl4cozP0PfranZPJAploNGnv5EtekAnUxrfRHfqSIGfuIUXr6nUQEGLl
	rADfxu2iKI5A6StpNrXyMdQOcNnTnA/y7jepk2PbOKPrMUgADAprBooDFh80c+42
	Rjg7qKY5V/+/3PcZ6H41EMnd6leB2bxP00n6KTdh9hc+OeL49P6Q9qsNarGiwctY
	UcAwhDlVUDaj3xzQvANq2/KL6XdHZ0++9pH8L/nloCiJHRJr+BNRbFbsBZJSuixP
	b5xjBo3dqWpJuA1u6QN5EL+SR2yJlb7I61jdgKCpnY6m7kxFnFhsZPMEAOOmHvC5
	cLqlzA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1xexg3jb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:45:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbf293831so1587063a91.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786693506; x=1787298306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Re82H9AabKnC5fSLI6YMte6BlqAQaCg3tkq8ao0UmjA=;
        b=QfS3aFxQvSy1JGV8Pwn43dB8LxwL95Gv0h5kxCu2NDAhPQjydjKv/yMg+Lc0F1mxor
         G5qhU8hN/zcKuNUPNqXQ4c8a3I7yJC984Ax5iakcTLroaGt1ttGgmT+OZHIqckOgwbjD
         wC1uBIA+3WHzL0QoPhXlPRTtddZ+7gJRKDij6Ur3aj3plHC60YAEv2D0mTUBHY84jApL
         WQtQ8HYQlSYgObxEuZzovN2/8NSijY1taXJcJN0n7+Imexggi2y395Qh/pcVU79jLyJX
         gvSPsgcCoR5PP8Oii7AfxuPBZvsWEBrU+B2Imumfal7MLsqhhAT8jAxCmQicUkV7Ao1D
         X89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693506; x=1787298306;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Re82H9AabKnC5fSLI6YMte6BlqAQaCg3tkq8ao0UmjA=;
        b=jfQdypp45WduwfsymAif7AKEyQ5HyMVMUhEHtifH4mS2kye3en/X+x1Oz1MGVoFtVl
         mUhXYIsuL8YJSfjKFv9SL6snNysQgvvl5ffBGE7l1INeOfqA1sGq6qiDdDsV8iZZYJxg
         1Qt50yb4cWqNULtvdfQQVJDfjhTE8uY0OZR3IK3MR6YQ9yPGwdyYnoPap9ztBhD+Err7
         xI+o6DPRWaJmt999Vc2aSh8CmkjTwBuUOiEfrGqmLGVNngzMEoFCnNQEQBGWE/X5m3Vy
         NOpC0WL0g/3YPLLD7es7ohoJ5vpKsIIlrKTwS64TCZQoZcGm01tqON8As76EFdewSZ0P
         Hx8g==
X-Forwarded-Encrypted: i=1; AHgh+RqJ99/CdrHV7cAPmq1BRDuZeO1rMW/3sP1UAW/7j/6eZlAdSTKTSIYT/ypLfShx/CvRc7/Bd3UIjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2KaTKY4u7kphlcYp+3C7pSK/UkFUiX8azT49HwIFFRrwukWl
	BFjuEHr/hbgcSRe5vuDUAEoYtpKPWzWtwO8Kw79QsrLu4fmls6qyGTbi8+NQsnqECGmudeO0UWt
	LwhPs2OIf2MHrD7kYH1GyWXrDTZ9XMLuNt3sA2/2UyzxyzhtWE1UGGL9LY2691A==
X-Gm-Gg: AR+sD10lrZpnaRkOnL9oBzlhWol0lDXNNyef84tyvZKsAdt4lggLkok7bEr2eoqV2vG
	rrc9RDEz/dOZ2X6N7zJ3b8BVDTEcFoxK8gAg2QZrDdRlSwAifMMB1tNJcab4Lw1epUb4cdABvu0
	sY8oZDnjtaMULMR4hsAUYxekvImoTs0hOrbneqSW/KfticVGy9jMUWqe60CMK7m7zpdAZIJThWV
	lCe+V6JY6LfEWOe71CSODPtO+gTD8LBw1C2xV6paEtfMySI1K16wyNWUPSeRFJt0+4puTvVKZlL
	+2SWSKxECB+dyN9HkFefTEZUiKG+oNowGCe+dLBhon+UBQ4j4xNYdGaJhAXchs9//97FHr8RnoU
	W8BDLf0Ul1URH5MJLLdHiP+T+XkuVwGsmtg34QN88+Bo4JR64B0QNnbDHizTuOeEzPWfs1HYWVs
	Uwa6h5pf44VZdiLe3Xbj4=
X-Received: by 2002:a17:90b:4cc4:b0:38e:101f:c867 with SMTP id 98e67ed59e1d1-3933b927a55mr4432355a91.18.1786693505554;
        Fri, 14 Aug 2026 00:45:05 -0700 (PDT)
X-Received: by 2002:a17:90b:4cc4:b0:38e:101f:c867 with SMTP id 98e67ed59e1d1-3933b927a55mr4432281a91.18.1786693505033;
        Fri, 14 Aug 2026 00:45:05 -0700 (PDT)
Received: from [10.79.117.20] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339b2c1b1sm1061663a91.0.2026.08.14.00.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 00:45:04 -0700 (PDT)
Message-ID: <ca6818ee-82ce-4cb5-be6f-055372cc00d4@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:14:56 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] dt-bindings: arm: qcom: Document Kuno IDP board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-14-5e0ede4a0c72@oss.qualcomm.com>
 <20260813-audacious-cockatoo-of-brotherhood-098c9d@quoll>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <20260813-audacious-cockatoo-of-brotherhood-098c9d@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OSBTYWx0ZWRfX5EJgE8dmnJ7y
 Iz0PHbr0msA0Ans0VyePARmirWCLDU7LwZh4eMUQXrUye17HcpnE/LAWhrSmc42hTVh4WJty3a5
 btcHhb1C/jeIGUDS+SEnA7mAnVjWY2E=
X-Proofpoint-GUID: 0mMMCXXY4WtU6lPT5WLujY9ba9Uapp1U
X-Authority-Analysis: v=2.4 cv=eO4jSnp1 c=1 sm=1 tr=0 ts=6a7ec782 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7zRd6dj2QFuN70SSHgAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OSBTYWx0ZWRfX7b3ANDq+Sjh/
 d16RfT6bMFW9tZnbr+9scqsWfjyZymqdq/wMs9+feH1ch3Yo6zDwkGt6WSLJJISwefHPmUldNJ4
 U3s3UKZHEiS7/hdp0tB0Jv8CtHaUIeNxyLACeVnWNImqc+SAFb2YU+kip7svVsUOjJUHUeLuWw9
 z3vOeE7bxylSzSpwUoHPb/mfre2XKyBiiEeyknP5X26tWIa0NaXb5oxBSl71JJ8ntIJMbP6ixZM
 YWdIJfIROTo8Vlek2NnjmFHVwgV5jdZtoIPRRTC/D78mWuq915NDnQqLhJhcMXUC8PoOrIcLVA/
 dg+5eZLulv/+a+H1hwRS1AqOCJMeykAprBIwVRWkDPSLLmpL/6qbuMYxAlkxl57DrTrMMwkX20G
 mKjD6IIj349QTRrR5jN4zneXySi0NQcE2xzpKdoqNZ3mgo/zDmL95D5SyAhxgmg4Bw95v1AAbzC
 58PL7BI9fFwhIdbZ46g==
X-Proofpoint-ORIG-GUID: 0mMMCXXY4WtU6lPT5WLujY9ba9Uapp1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140059


On 8/13/2026 3:12 PM, Krzysztof Kozlowski wrote:
> On Sun, Aug 09, 2026 at 12:57:13PM +0530, Hardeep Sharma wrote:
>> Document the Qualcomm Kuno IDP board and allow the legacy qcom,msm-id
>> and qcom,board-id properties for the qcom,kuno SoC.
>>
>> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index c7c9a9279684..f87ff5d923f8 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -174,6 +174,11 @@ properties:
>>                 - qcom,kaanapali-qrd
>>             - const: qcom,kaanapali
>>   
>> +      - items:
>> +          - enum:
>> +              - qcom,kuno-idp
>> +          - const: qcom,kuno
>> +
>>         - items:
>>             - enum:
>>                 - qcom,mahua-crd
>> @@ -1322,6 +1327,7 @@ allOf:
>>                 - qcom,apq8026
>>                 - qcom,apq8094
>>                 - qcom,apq8096
>> +              - qcom,kuno
> No, this list cannot grow.
>
> What you miss is to update qcom-soc.yaml
>
> Best regards,
> Krzysztof

Thanks for review.

Done in v2 : 
https://lore.kernel.org/all/20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com/

Best Wishes
Hardeep Sharma

