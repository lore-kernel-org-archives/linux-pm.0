Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A783DEAC4
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670384; cv=none; b=CF3A1D6vwfzE53nedqZJAEaTYz8sfnaVW/mwPwsyWl/wvrjJYa5h9hOnhK16jUlzVWO4rlJdIkiJbe7VdN6PEGWqITEjcJG6WKpP3qntUm58nx94RN3OY7AYWFyLErtVt4EDlaKl1ck0THutBYiJEOob9PMuAr+GutliPN+M+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670384; c=relaxed/simple;
	bh=O1UPrahGCevcQyrI6uYwBLnwz8VUW6bBv/tVqUPIrIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPWFUd2oNzbA1F6XWk6iJEOARUIm342VRHx42VxLmsMa7kaH3swAwpL7eLzBIOunbJObULJrCqqF1mkySl373wU5E5Dmc54keBeP+PdO4UE4yEzjMgrhiDu+7U39W3PuJ9caTy573Z9OWKKwyJiJD5WZPqvfVGgRYErZR5kyxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EKzxBWNY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E/QmrS0U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EKzxBWNY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E/QmrS0U"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7TfFT300665
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lj57R/YmZD/4Sj5RKNgxE3jSaNf76h7dCY8rZUL46zs=; b=EKzxBWNYBMtLcPz7
	/BCQFrhl/ke8baY6roWkO8tR1LgkVy12Oz+pbm5PPTZrtoJMYn5d8StPqA5bPB6j
	+ncyNGLBE2iCUSB44/2QawwYIdfKvvU5g3VX8g92PwP6/tnWGqi4oL37Z9coJpyz
	DwE3ehJ94WzN+ylUwxKIhrqAcZFUE2hvI8A18xRSxa3Oow6N3hIVPXqdLHss1MQ9
	CA+bH83x0q4njg+AgY2qVZKwl5RTHrqiR5I4UTFBdcus0PFRtVza76E0VNi6TdIv
	kn9l0UXeQqoY16o7j/GsOumaLFULZH+3kLUVagI6aicugHbKCz95N7w60M8wYTLI
	qc+5OA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxgxw2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:26:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92eebb130dcso54766785a.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790670381; x=1791275181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lj57R/YmZD/4Sj5RKNgxE3jSaNf76h7dCY8rZUL46zs=;
        b=E/QmrS0UGJZpE8+nZzc9yD3+1Tslgv6qUybVteGi0JbPnUnhrCP3oypMy1MvSlBY/e
         FTrq68fjm7J76XGQawOYITlxFooWBj0DytmW234VbKpW8C+GIuPWdB8eVgHjDzfZS+AO
         hmXS7vVy1YE2KO7xEXmVAfBTFyb9e5+GU2LhxKBTowaZ0EIJ3nxUueXbHfwuJRS4lxBF
         5xy+WI4sh6g61i4Sdcv6ry1xzdtFklLiVAC/Ehz/ZsIcyViPNfI8m1HsJM3rMzQLBU+4
         +y2AFDmSxsExNbKJR5vHgDPnmJWFv9m9yN2MWwF+xP08PZlcTUpTw506qjzFAsWLZ7nm
         O3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790670381; x=1791275181;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lj57R/YmZD/4Sj5RKNgxE3jSaNf76h7dCY8rZUL46zs=;
        b=mZMMtXiSs0UY3V+ZDP56Qsbi0LFPi2xb4YHbnMNY0P8liIutN7sJbam6wayszgx6l0
         H6pIwiyuWzMFki3OzUOntQgxP6EWZIDbxSniR0JcBmFQoarJfrQGwo+QNjaAzdnv2Dxp
         oCoSpCcFvpSK/gOci3Dt3fWYRVkUvDovRFIZqJZIYCzIiNgnMK24BGxNeQJ79J2CQeKo
         y+cEKYT7SHlV6CMP4DG511bvyJ2dBfhf9TZmaDAJOCufn+kBui1MGmVXqUL6/xO6ouf3
         pRIiY/659RdR68X/kaByKU3mcyhXnKUkSkikP6brY3CzPjn4tK/uUtQGdiVS9apNFSQ6
         uQzA==
X-Forwarded-Encrypted: i=1; AKwUvBwqadSawB77OnTwsYPWyZSt0MXr+huJekBd31+ZSPqX8lCti+oglWbftYld1HG1tB1lfLXyhJ8Qhg==@vger.kernel.org
X-Gm-Message-State: AFuF++mppqyo0nyiy/1ck0sJPBPEEsTOaL8zcH1pSzYkA+8esJy3zhfR
	CIauyhmVQGAsssB0rLJzQ3exhV/glnkkpLNcSiPHRTuI/9Zm1JpRH8GKghSaNYoEiBuni/PrNMA
	zJe7qbiHoYk5crV+Sot3sujDLzS6dkWFYiEbS0O6hfG2Z/XccvJoI+OwSJ1IhuA==
X-Gm-Gg: AYBFou01UUrT7KZAc2CwvDGHvSLdBqOOlluF7eaMwXCwRsVAHGf+oVK8SwDFgt5dWCQ
	wJWLZqhpYuoc1b2yFDky7EGhsyq+LaX0YZ3e3EOlkPjTQlF5dYqowjHKdyk9ILP6JAAoi75F1mF
	C43C/tECSbskBvXXEKSwSxV7vFhXaprdttKpl9EScAYQRPFBOof2rT3OjN8fc7bez//1hW2vEq4
	KYE/oQWAZ+KExRTiJhIfju64BcUjUXuNDdG7mUiFZWoRXsdObygYJV/ifbzY7ikBrNJgpY1ueRu
	jfmf0PtyKLIWqBUZf1HHa2w+clmT0yvgOPMP8rrr5miJTRQFdULRf81VCbkaK0o2SqF8WoKW6/s
	Vyc53Xn6JHsN8GZQ8VBKN+w==
X-Received: by 2002:a05:620a:468f:b0:93b:c6ec:780d with SMTP id af79cd13be357-93c43dd5b7emr2345655885a.5.1790670380747;
        Tue, 29 Sep 2026 01:26:20 -0700 (PDT)
X-Received: by 2002:a05:620a:468f:b0:93b:c6ec:780d with SMTP id af79cd13be357-93c43dd5b7emr2345654185a.5.1790670380282;
        Tue, 29 Sep 2026 01:26:20 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6acb9057d20sm380135a12.32.2026.09.29.01.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 01:26:19 -0700 (PDT)
Message-ID: <c341b7ab-fc59-4234-a25f-715035fc1779@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 10:26:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/15] ARM: dts: qcom: Add initial device tree for Kuno
 SoC
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
 <20260827-kuno-soc-support-v5-15-6d47636a8f09@oss.qualcomm.com>
 <97fd5a30-9469-482b-be0c-0ed6da6424e8@oss.qualcomm.com>
 <5a55edf8-bbcd-4e2e-aa08-c9b62e527a43@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5a55edf8-bbcd-4e2e-aa08-c9b62e527a43@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMyBTYWx0ZWRfX5cQpFK6DPKld
 FizGa+CTYWoPCFL3U22u/5vI0yZVyFbT6GdIvxCDF/tJYRyFG8ChuZmI7MhtQL4ZxF+lkXSkxwr
 uqvLJwD/p3UfYclJ6hAdiejPneLA79o=
X-Proofpoint-GUID: 8buj5Lk8-W_WD_89Rrx10kHmfctP_TOi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMyBTYWx0ZWRfX4OW/K2D4pFZe
 zbp3I3CC5eEGwG8pYcolGNQSGIZzVlGT7xLTUmatUCdWY72LDziv3s77FwDF3+/MCFjLHa1qu+g
 7f6b6SpwLhKcmmNNUHcR/ZGNjo/A9UccIxAtwmgqFdbyhmI8z62XA73scuYi+6fG8iyfXuauOSS
 Szd16Z/BJ7LVBIubx5PmIT8XFh+AUZP+Kx8g3uvG/7dRSTcQ7QhnbTEdvyJrj4198ZMQvxZafWs
 zMt6y2EspsLHWccg0ZVEz4PT+5v1i0XVQmoLrPnyFqPHarMBPcHorM/BtTFKPiLIoVv8ptKod95
 5pS4muCIdy3RGBzL+vqNi7nfPLV5IUUt2ZUT7p3U1Yk+X6aYoIp7S2YCNj4JfBS+qp/+r9ldRkY
 ekvT+8GbFVXjMuEbcdzs2DXEuPoyGnnK4V+dCk/1+RTnBTbIJy0Ro5sO5W2TnFxjCVgEZ8IF5VL
 yUyOaH6G7xIiGHFc3Aw==
X-Proofpoint-ORIG-GUID: 8buj5Lk8-W_WD_89Rrx10kHmfctP_TOi
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb762d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=-jS8umMHsOJWnNsN0pIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290033

On 9/29/26 8:59 AM, Hardeep Sharma wrote:
> 
> On 9/3/2026 4:27 PM, Konrad Dybcio wrote:
>> On 8/27/26 7:51 PM, Hardeep Sharma wrote:
>>> Add SoC-level DTSI (qcom-kuno.dtsi) and IDP board DTS
>>> (qcom-kuno-idp.dts) for the Qualcomm Kuno SoC.

[...]

>>> +            ranges = <0x0 0x0 0x0 0x0 0x1000000>;
>> likewise here, you don't need to precisely limit this.
>>
>> Konrad
> 
> Hi Konrad
> 
> Here I cannot use ranges;
> 
> An empty ranges; only works when the child node uses the same number of address and size cells as its parent. That can't happen here:
>   - The binding fixes qup0 at 2/2. qcom,geni-se.yaml requires #address-cells and #size-cells to be 2.

Fix the binding please

Konrad

>   - soc is 1/1. It uses 1 cell for addresses and sizes, like the other 32-bit Qualcomm SoCs.
> 
> Best Wishes
> 
> Hardeep Sharma
