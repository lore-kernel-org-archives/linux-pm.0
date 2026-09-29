Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103C4FC8FF
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675901; cv=none; b=Z890KHlQjoR/r5iXkoMtvfmqGo/IyZ4QYzos8uL+602hRlXAlcH7tvTb7s1xwODNoMxcmK+UskeUI8h0647znwEE8TxnsGX9TZlzc6IQjqpdPX1Lz2Zu3QY0ebHVFYfbNgKBZJplh1AGg39sjhHDPJ0q0r7+REnY+iesaYlsSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675901; c=relaxed/simple;
	bh=AyQlhHn/ZGofFAIPNVNLtAHbPpfbmqfVZrPlxdgxWDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOntJt3myToWe1lHyobsr9hWfejIZNR40Ei7eYDcB0Ou/zlUrgPvWc6qeKWbXbSc2C56eAaBY75ZhXuWyUtAXRGR8qPbRyEqXcDAujMXmcU3zff5WUa4rTxZUtR+bnbfVm8TT3gzTAlDYpw+fsGu2DJHSgI+qstuq9HCn/2ammI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QK5JIihT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UP4Qsvup; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QK5JIihT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UP4Qsvup"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7TmcL300865
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 09:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hrf/BRu9vxuRgHvHJCDyLhP6Fml6xeXWnXwjv05Uq5M=; b=QK5JIihTRv/kofqt
	4QaoUpy65LqzTQHfXDhdtFjOwFKUi6/+nsI95VEXDSggZ6Vc9mnegaKosyoeccz/
	FhGi/AKvkoqLzJtIDjpJ1DdwBoIR1gxXqFLYpz9n2yNbqfMpuBlhVwqVykDWWGgO
	lRVFWKWRqUj9gFFdfJxdwvD5glXbu90v8CaRD+zz1DEiXOJmGXpHtdV3kIVxaOKI
	m0R4Y7o+Tj2ulR5f8dDNeSeWvX+bKhSECwaSUT43d5g9yhzn6GwdKpNBnGqcfPjQ
	Zd6/gS8utn/fuhwPpsZM1L/t2KeCMG4GhjnF2baHaDUkLpiEamySAi85hRi0AwdL
	nKkJHw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxhbb8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 09:58:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so4681005a91.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790675897; x=1791280697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hrf/BRu9vxuRgHvHJCDyLhP6Fml6xeXWnXwjv05Uq5M=;
        b=UP4Qsvuplc3TWyDX7e9qHDigqDhHaPfPJAWb0zOJxuQz8fk3b87R0NMvnwH7DCcCAu
         dKFFRmjJMzXV09C6rXSXFiCyJH0OXtRePLbYpiuo0R7N/PWnggYc+pvNZTJEea/KiEbU
         RTAcFG4aba29vgFdGwwvMMN290Vtai4iodeQPkQl/5ooTzKruwLZjF5eWQgDcuPoSvLg
         WUeCEZdKfqrkznMx3JAadB75IqLBti2mRpRzYQmpeML3b6ddie9gdIX+ShO+rLnmJo78
         iI3jE/LXX6JpvPKI41t+X2LfuD1gaCQNkGwlKEhL2Pt4ZJOQalMWfYmtqn5TwKsU+2gG
         gbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675897; x=1791280697;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hrf/BRu9vxuRgHvHJCDyLhP6Fml6xeXWnXwjv05Uq5M=;
        b=L03d8omcHvM/hWLhMUWvxBg+ImbLgI0ChXWkIZOWMVO9KNER2Fgs8BuTVazVorWWjV
         UXuuxtxEsl+XLXRpixbnmhUmB1BgaguxwPpdFSlNCoFoNk6hc3WVV0+TsAPtCG2xWRk7
         8D1sOj3MZoGnyDbpqA3bfWPGhGVaMjkhV+cVP7SYUdpe3cxbK1PJLGvBQbVqM6IKO3bv
         G1VS1b+dwQzHRQoodvLwQA8q3+UMfqF359pHt+YVjSmuo8ZBQlhKpvpcMoY7gRrGJm/J
         Xk+A8r+EbnltM9zAYjUlrTatP0q3jRIPhBRJdKJBRUO7ggHLrjN65c6dlyovHtr/lJXo
         ktrQ==
X-Forwarded-Encrypted: i=1; AKwUvByD5y6Rf9qArYxIl8y1TeIKfiF/BD/kIEk38eieCyp2fTV9zm/JZh6xV1Kq6IZXaTcXgAfccvTaBw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIEPMcBmJfDkTOnScJeM7CrHgAvg5yMlvKb7rzdThrmut62Xnpj
	tP7M2q9u7l+S1PJeiIN5TKrrEYBNNXr3xJvz5CDbQM7K1UdEt2iosF8fDy/LYyrz0P1j/6Gy6YV
	2VnMr63S+nZAOE+VVW7xNzRC1iUILUtGlBVUN+qm7bc5JFU5jFq1tmSrSG5vHmw==
X-Gm-Gg: AYBFou3eW73ltyB8pCqZ6Qc1p1CyHkw1aJZ2CHWx3MgzdONRx3YfynBeMl0ZrDd71XW
	5sonWoyRicG5vl9YHXLb6XYBZ1NV9uWBntz7vuZ8ZjszpAdC1wsMGTGCkDzJUbBCV0oX2RzP/J6
	mxm4iKWNDqIwKzX9sUORURJjKb7x8FYrJxzOxuNDKQKJ5AXeGrFtW+azK2XePNMkSxwKHIuby2w
	jgHooNjtMyyQKQh37iM1MLxjfpenWEri+1aoCNHt9WpBqANvwixhiky1pCy6j7+/XFEK9BRbe1w
	eX++iKGE97PHrOZ0EEQ9lgj5Rd6sHBQyh1R8ylGL54WmColHBH34nHL8TyRYvOYLs3JyzIWrW1/
	JcDxryZWYPOF6ap3kauMbAWOc0uSzg/wGF8vmH63aYFIA8HjqBe+RA9UhOh7oExQMYeH+5sGT98
	JaVewB+TFicI0xdN5n5ezq
X-Received: by 2002:a17:90a:ec8c:b0:39e:2e7c:d43c with SMTP id 98e67ed59e1d1-3a0bb552ff6mr9601345a91.7.1790675897483;
        Tue, 29 Sep 2026 02:58:17 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8c:b0:39e:2e7c:d43c with SMTP id 98e67ed59e1d1-3a0bb552ff6mr9601308a91.7.1790675897013;
        Tue, 29 Sep 2026 02:58:17 -0700 (PDT)
Received: from [10.149.102.240] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498057a62sm4634983a91.13.2026.09.29.02.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 02:58:16 -0700 (PDT)
Message-ID: <ca8e656a-50b5-4cb2-a2e6-c6b275fb7b5d@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:28:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/15] ARM: dts: qcom: Add initial device tree for Kuno
 SoC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <c341b7ab-fc59-4234-a25f-715035fc1779@oss.qualcomm.com>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <c341b7ab-fc59-4234-a25f-715035fc1779@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOSBTYWx0ZWRfX63L8I8RYymVZ
 sGNrw3IjWlaRzHzibr0LJzuIt5d7utBUAioavH8Ipn2uoQS3dS7QMqXfGYuDN6GCj9avW+X4JWd
 3nvCXpTJDnF4KaQpd6mTeRXqa0qFwA8=
X-Proofpoint-GUID: es7V2EfCqHVg3JHL-SoHKIdaw-mSdqa3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOSBTYWx0ZWRfX7NfIznIJEl1D
 H5H/04Fyd8YGw48fUHOrbQx/bdwKHkZNxl542eyTCmNU0RhOHV65CqjphEIGwvFxsHLH4y5goc2
 XU1YdO+NTBqfUwrRjVkGgekLK4V7meLHqxe8B/pdKkwT1TTkXqPLF725Bw+PYnNcX5bWFDzq8vQ
 kGV/XVnJq7TDm0AcWlcWHqWb6CWHsOvZ/wfQIbsOaV5UNSyjKmdl4mzT15IUt8DHjNdsr+bs5I2
 LrJzRi2NA6mBdwze8B7bm9ZUhdx9eseLWTLKgDeUQTzm0Z4ophaOTyyF2hJmHFUgJ0c2xsWNxeX
 VviPD2H44QN4NvbPzYU0gx+WYTw7VH1S7Dx+8TkP1FLnQ4XcaGTncM+rMVP6dx4qZIM4jaJTObr
 9TEVI25MoFepADiF+6KIP9LlOGQntuS5jZu4MuONU8VvDIbksP9w8eBg2g4na72Xqa12K5W0bSA
 mc6rR5nf5C4WWBhQ6/Q==
X-Proofpoint-ORIG-GUID: es7V2EfCqHVg3JHL-SoHKIdaw-mSdqa3
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb8bba cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=eAyIkxj0YKcLyhwK4dIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290039


On 9/29/2026 1:56 PM, Konrad Dybcio wrote:
> On 9/29/26 8:59 AM, Hardeep Sharma wrote:
>> On 9/3/2026 4:27 PM, Konrad Dybcio wrote:
>>> On 8/27/26 7:51 PM, Hardeep Sharma wrote:
>>>> Add SoC-level DTSI (qcom-kuno.dtsi) and IDP board DTS
>>>> (qcom-kuno-idp.dts) for the Qualcomm Kuno SoC.
> [...]
>
>>>> +            ranges = <0x0 0x0 0x0 0x0 0x1000000>;
>>> likewise here, you don't need to precisely limit this.
>>>
>>> Konrad
>> Hi Konrad
>>
>> Here I cannot use ranges;
>>
>> An empty ranges; only works when the child node uses the same number of address and size cells as its parent. That can't happen here:
>>    - The binding fixes qup0 at 2/2. qcom,geni-se.yaml requires #address-cells and #size-cells to be 2.
> Fix the binding please
>
> Konrad

Thanks Konrad for review.

Fixed in v7 : 
https://lore.kernel.org/all/20260929-kuno-soc-support-v7-0-530f62dc4020@oss.qualcomm.com/

Best Wishes

Hardeep Sharma

>
>>    - soc is 1/1. It uses 1 cell for addresses and sizes, like the other 32-bit Qualcomm SoCs.
>>
>> Best Wishes
>>
>> Hardeep Sharma
