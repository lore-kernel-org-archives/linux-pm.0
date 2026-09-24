Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2578442FA0
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241367; cv=none; b=UubG3Kz9EiOfsfNGOmSIzOOI8uSoW+Jxm7YS5OjMhMNRCnbw6Sgbd+BnMOISwi7UJ264vOSydAVJF4LmPggEMPB1hgxRwukyD3vPPisceA5r+ncN5+X9qvSNWWBF2y58jMukkmThlUwxxgX9vqFYTCQeER6QOc34i9W9osEArcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241367; c=relaxed/simple;
	bh=UVYxTLF3orwylggdZ4gWvmbd1Lhn0cOSEnzX/WKEq58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fm6Xi1FWvM4q3nCoWjaPsZFCB0LIVo7/TnZ1HsYNenw4JuAhlxqLBLaAZWEMJiZOEloJJ2GeFf+8X9RlSch37TQIv9l8s0BpStjaS+hjR+WAni2C9a3J2x/oglBpUOQx5RLdO7yP9FioHsgyVV4ml1SpWlizwybxaTCrphvP0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XqR6OSKo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RM63hGn4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XqR6OSKo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RM63hGn4"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eWYB1741992
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 09:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8+eOrLzw/Qpo7C09lkfiDnHmTyrPwyIYLHlIG3/Q0ls=; b=XqR6OSKoDeyKxwqe
	3QNwzc0Vyy/TtVOkIwKybv9y8tZjZ6Bw+z3fBQewLAxs5LE0LFMjGW90qkH9rSe5
	J+57T7AK0f2GK5W1+ygkzzPzbiV1gtdLPtGceBawFB/kKCN3RPCGeT05VWEyAgMj
	QkCNyj3Gee1FE/55JXVIJbm55kCHebrOUpk0+kVK8tCGuNIYLlyZCcq9TjU5uWKO
	N6WjU/egXui8t7WKKHCGRFIu08ciu1htyfQNnJmiWjqktY1YKBeizl1x9KM4Q4oT
	CQbDkTsWlaxvgA0+zG+VkhboDrca2BjM7Lu0JXKReCjlBldv9JaurYzs1EU6L5Wf
	I1CQWQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfkbm8hm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 09:16:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-32861f5448cso1660378eec.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790241362; x=1790846162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+eOrLzw/Qpo7C09lkfiDnHmTyrPwyIYLHlIG3/Q0ls=;
        b=RM63hGn4ymuPyQQNbJuyrez+q1dwCiMPkexxKUUqHa2CD8B7aloIDjTxyDGv7J34Ri
         TlJUZVwDpRE5p4KizKVyNn/N+SGmWW8szORp43/JbmKOVg0OXTFeZp3Zh5tw1V25eHxF
         rQf8KmaAJTbLtHZEk41qAOaQoUxAvpx3fyuqYismTlVlE0uR6psBcXtH3E3Zj3mv4rVA
         WoIKA6XaR9UNf258ZsFpIIceBpblBRbKy48UTJCQXA+61MKQ3hWZOQqY8how2A5cWMwo
         yBzQJOLW6uWlAIUmgVLbAYT6ittmqU9OB6j5YPICQYPQ5Ko/EUUaLKw7NvytlRmisuWS
         C1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790241362; x=1790846162;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8+eOrLzw/Qpo7C09lkfiDnHmTyrPwyIYLHlIG3/Q0ls=;
        b=K2U+8crA6/BPTmxrP0/9VN1KSVnZX0kkY0Hkj5x5HZbmev0lhBftBVbfHX9JKxVn8B
         ZZzLKFQhPM/SLefylROK97WTxbPA9SVJZGCY4FyVxOwzRDXtq4eKiHIk3bggjTgMh8c0
         rYLeMBi0NOWKCbdGSFpdE3WH5V8j/6d1zMxAiY8P7JkURJTjcZL/NK91qaqdXs55NZBC
         d2nQ1YN81TXqqY+2hHxnuvfye5hzRwp11tSmrVuTbvwUmoAlOPTemSVQnwfV4LjMd4ng
         j+H1eneBKJJgjHFot9aiUiZhWW8SWWp/+DgnV3xuLW/07BfhacbuncPknzD1NypoE9OE
         rZsQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/PkH/DqZb0nRcA7JPclCgoCJv4cMAo0XbzgAbYRj6ptXIwP2EgsbtF9OTsR3L5pHQgEg4X3IGYw==@vger.kernel.org
X-Gm-Message-State: AFuF++kHhy4xzeE5/Cb2LuGnF4V6364YRL3Cu/62TzznHbMRjqbLdt1N
	slKkoOlgndPd/TjAItgYDoiQD5C3jPetnn0SWZTnQ/hSc1dBo1MXPZBwfzHYCeQOFqNaJP4dVCv
	tPaUuVvE8+kbNZw3Yg+xvGiZi/FWxBB6Z6aG+Ka9PS+3BMm0uqEkLv4gZzKPMNA==
X-Gm-Gg: AYBFou3nb0VaYaXWuJom+KvfvMUQeYjHFI68yLIo7O+4531caNipBOBioWzkUFeAOL8
	RK+hbx4pBfgyw8VV9ZxEFZZuoFapTwRbzme7bIS4US+6mW+rPpS3d+Sm9VHNYXa/VAAyGZGSx7K
	rXU69SmRME570rWeR71NsAjo4W60lCkg1qoj72j0W3VpOEPg/L0U/kj5W6AP/xoCRoX0Js9cxiZ
	1WoE2oHQhs53jPrfDTXngaIonfe4lkwqkMFeBqJJrOJco+mpBrdiXDLCvZvgdTbBZXIV6EZ/7We
	mpVXP45VitQXuRnXozJEPkCAc7WQp+I8wlE8A6hOIMQHWYsvb5MVr+WNKCO3/aBSMtOZ+LAGVVh
	rjaPWXWKLTufDQoYTzYL4vdHOYtO6NcA43QhOrOVbGCn9
X-Received: by 2002:a05:693c:6392:20b0:33c:12b6:2bfb with SMTP id 5a478bee46e88-34002edeeb7mr1515514eec.24.1790241362193;
        Thu, 24 Sep 2026 02:16:02 -0700 (PDT)
X-Received: by 2002:a05:693c:6392:20b0:33c:12b6:2bfb with SMTP id 5a478bee46e88-34002edeeb7mr1515491eec.24.1790241361632;
        Thu, 24 Sep 2026 02:16:01 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fe502sm11845179eec.2.2026.09.24.02.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:16:01 -0700 (PDT)
Message-ID: <7bcffc7c-5dda-4ead-a053-7eb4980e43a4@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 14:45:53 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] dt-bindings: clock: qcom: ipq5332-gcc: Describe
 clock inputs per compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-5-d242e3d49648@oss.qualcomm.com>
 <62a5fabc-3a06-42fa-9c6b-6504650e712b@kernel.org>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <62a5fabc-3a06-42fa-9c6b-6504650e712b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzOCBTYWx0ZWRfX7mWAcqGUAJRs
 fgijCpuEGCQ+0VzJxmR5WZqutVLUyF76hFa0zfkJYkp23Qk+5gGUn3AkSZ5nGFZGWzvLAE1fSqO
 1IKyuzZVri7reqtFmsdOTFKf92QHJjU=
X-Proofpoint-GUID: yWoQDsJzBMEYnDABYDBw6OguWhnkM-hG
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ab4ea53 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=X-K6lUb4N05xD90F8XcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzOCBTYWx0ZWRfX871C1l8FAMsF
 72yvwnE5mKuyGozCnZDkN/yzvKGhJFPRoqGi/vLAQKmuojP+zYIK8MGQ4mowXhSQs5qjkW0LdL9
 A0nmlEC/stbyC/f1+XhDudLzOdtsFvX9wueErUq/SIsAkuVpaJ9UA7idk15ss4da+6qUoT7jMpi
 VKE8S+pEUBXMHcjImOGknXYO4fSwvO2smG4EwCRccXdGugShOGgHXmtGCOfLVqeaX9CekkWUgk2
 xkrkQ1LzavnO5pcHjD5XY1aGSVqVsqaHWUA6EgZWm+3cThm7KinYdFFU85S1I+ggfqi5/IZBw6J
 Q6WTxMzksu2BCcgRv8Wg1taNAs7fXKgEGL5Qz2NwLZ3h/yNRo2LLYPiAaqPadnOdfIZwGWbkcoZ
 DhJcTvZDDE2KTXBkzyJfCLGAX+IUl0oqokAnLixIeqmqmJJAcOre8bI8fiPG1SPirO61E0mKQhr
 FfIb3/pz+M14bHTWDWQ==
X-Proofpoint-ORIG-GUID: yWoQDsJzBMEYnDABYDBw6OguWhnkM-hG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240038


On 9/23/2026 2:17 PM, Krzysztof Kozlowski wrote:
> On 21/09/2026 08:19, Kathiravan Thirumoorthy wrote:
>> The IPQ5332 and IPQ5424 GCC blocks use different clock input orderings.
>> Document the clock inputs in compatible-specific schema constraints instead
>> of using a common clock description.
>>
>> Also add the 375 MHz PPE clock generated by the CMN PLL to the IPQ5424
>> clock input list.
>>
>> This keeps the binding aligned with the clock ordering used by the
>> existing DTS and GCC driver implementations.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   .../bindings/clock/qcom,ipq5332-gcc.yaml           | 26 +++++++++++++---------
>>   1 file changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>> index 1230183fc0a9..fb39dffca988 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>> @@ -25,14 +25,7 @@ properties:
>>   
>>     clocks:
>>       minItems: 5
>> -    items:
>> -      - description: Board XO clock source
>> -      - description: Sleep clock source
>> -      - description: PCIE 2lane PHY pipe clock source
>> -      - description: PCIE 2lane x1 PHY pipe clock source (For second lane)
>> -      - description: USB PCIE wrapper pipe clock source
>> -      - description: PCIE 2-lane PHY2 pipe clock source
>> -      - description: PCIE 2-lane PHY3 pipe clock source
>
> You are changing the order which is ABI break. Describe the actual
> problem to justify such change. Are you saying this was broken since
> beginning or what exactly is not working here? The driver was added by
> Qualcomm in 2024, so how did it even work? It's not some 10 yo legacy
> where we did some mistakes in binding while converting from TXT.
>
> Also, I do not get why the list cannot be shared.

When the bindings was posted, list is combined for both IPQ5332 and 
IPQ5424. But the driver wasn't updated and it was following the below 
order, so was DTS, which is not compatible the DT binding description.

enum {
         DT_XO,
         DT_SLEEP_CLK,
         DT_PCIE30_PHY0_PIPE_CLK,
         DT_PCIE30_PHY1_PIPE_CLK,
         DT_PCIE30_PHY2_PIPE_CLK,
         DT_PCIE30_PHY3_PIPE_CLK,
         DT_USB_PCIE_WRAPPER_PIPE_CLK,
         DT_CMN_PLL_NSS_375M_CLK,
};

So I'm splitting the description between IPQ5332 and IPQ5424 to matching 
with the DTS and the driver description.

>
> Best regards,
> Krzysztof
