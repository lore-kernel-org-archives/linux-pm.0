Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613406;
	b=jobbFG7HZ2ZlCaIS0qBGrZwgBYmD0VfZFW4kseCIMwNI8xfniZaU/79ls9mxN5RxyQEO
	 j27rGtCSLc8euIlYT6y9uJqa/y/laVeA8OTyU6UoGGRNNI1QWJUVjo0SwfRaINv1mPDnL
	 gn5NJqzRpSJSksXmfKA+oePwbU8h5BSTskOIiDAlQojN08koMTuNvUkjiCmE7S3VIc137
	 Bo1/EeqIDMVCzh5P7SBBlSckE1Usn1c7unQ5kgwfHC2eEAQtNniTx27/fCQgQ14xBwfgr
	 oGs6NrO1MTqJ1mIn2+IKIQ3aq3cjkS31Btx9Avr3GvEXpBESIFyU0COb3eTuC2vmV4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613406;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=smDMy6su2v5TRuoxvIhH6UcIUozCziMfy5Wm2BlMQwM=;
	b=A3ChtXGPAROAr/MeX7rRR7h3BQpwjuUdS7yXodKpby27dbSuzbrJVt4KjneUdlpqrs+O
	 zWkc+3IWe1T7FDoTK9Yvefd0ZGBg0IhadYk86eK5bMupVQAVlIRxqwX1JTcsAcp9lAVDH
	 V2gb9BqvNC021z4mPDqYn9stc+ZXTtz8HMB3oY2P1vOQxjTs6bgoyvELuS1z+uLMI+nVc
	 K/orsQ0xPGH33EhAagGePMbsRoSsDnznzxqC6P0cJu+R1kqCWmRtxdAn2V8e3tTfvIQUR
	 FDn1UI0i2UieH95mpuRop1iQJuYCQg6jj/9xQJ4wzg642Ne6VebL4CMv6lnsnFZLtmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F6sKIbB1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dF7U4VqU;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE32606A338
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EE32606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F6sKIbB1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dF7U4VqU
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9m8qi4130788
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	smDMy6su2v5TRuoxvIhH6UcIUozCziMfy5Wm2BlMQwM=; b=F6sKIbB1nsAton51
	paC/HxwfC9i0kGF1D9KX0zAFIRfCWqW2aeJh9oyVLl0UnKGQcq3kwi+qrTkjRXko
	zuy7pubBK6K7yvaqsAVvB1Lpu7Fu0BMJrnCf6lJ4/ZPteXflK8hoOttyeCZbkk4G
	9BQ1YFw6tsrIilIRMmFEdGgX1ZFihlDneueV0zmo919xxM/HU7rnLLWvwBvhDGTl
	26VgkQeU4UtPIsekC9HB9IIu5SQJfE3WDZMGxAetqDZFxeYV9EAGeIlq9RbIpjAf
	0HgZwofUi6zcUB3xXDdYGCh5WMRYq6bNDo0eOJy2UClk4BjnSZ1BK/xVVSP7jCy3
	N0wVyg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhs1xx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:30:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94975041698so1444261785a.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 05:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795613404; x=1796218204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=smDMy6su2v5TRuoxvIhH6UcIUozCziMfy5Wm2BlMQwM=;
        b=dF7U4VqUeXP89S/oo+7JKc7+IRUJEeScod58I4v9l/XRffoYx/uBuVa62RIhf8XOsB
         3tzjZBCqUyHD3P1/KheTIPn0m1XbkRj3Pk8a55CRcy+lFuCVua2Jf8VJcYSnv4G0zSRK
         bIqCvOH7ceLXVsM4lLH6CPr9LXcR78bWU3D835505iEBXx6/ilHrPuY4ShyHOmk5b//V
         w9kaWNtWe2bBA7mRbNvqU6UU2bEOL1jTLDLy5BjIrhWFziaofRjWa1GUtXWsaoNWBKy8
         q9WpJtCi61vHchhGTRxaSpXvJshgVKqs1EHhCr7uA1jYvdbh5O/A+pgzcSTWdFLAOAAY
         1qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795613404; x=1796218204;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=smDMy6su2v5TRuoxvIhH6UcIUozCziMfy5Wm2BlMQwM=;
        b=jEj+gffuwP0LXjZItDAyCRCf5me+bJaVjE32Uow3T9g8m7SYnE2fy/Xa7m2ZoVZGZ1
         kFKUrPEseA8uWsZ1Lc4cxmTgEX0BPvSuW5qaddMa1ayvLI7nDvmCYaK9P1GJjI8JwN2k
         dbK+1jVLP6th2WvKyB+Y5S+INNpBfY+PK6+hLYmvXYdGz4ubkIPfjN7kOkUGY+T9SPki
         ak20Js/vCz8PJkwMdcEhFghBmquL9zzVj9EmbvtaWifC3zgDJIgvNAHqPao3DvHbmM9B
         qrNH1O+4wsga4atB6hnfKbFytb/DkucIaNnZs5MDpe6q0XHFF5sg3a+gOM86oRcr/HLh
         9UQg==
X-Forwarded-Encrypted: i=1; AL+hErG6+SzkFGvUPQR8sGxr2kVGtcYGvQVF2QTGCP+iZCuHPmXTDlExI3eBlIQHuCJ3XQoRdJ4xWVygPQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+FyKzCjy+CMAwOVUY1jF3aGBCQgUXP2EIbWUgbtSCw4SgiRzbz
	wpWkPnCQ+oLT0NZo75HqoZ6Nin/jEkbCpamh9mNgI9v00Sq63ulP+Wg7mMs26zGjb+95sgsHf7S
	DSlZ3CYbs4BIAzVdylNmVl0NPm/fAKVd1x+Jvz7cvQeVXO9P9QKjahln9bLbOCQ==
X-Gm-Gg: AZFdTZfrPRf3HASEVtpAQoFGv7SZ+q+Am8ctrgGkPp+4i2lwetPQiWHH4KsYs8/nxcx
	yz/1qeZI7S6DXt81jczVvt0P6XMo1OusMW4H2e6FDjpbfAAz1949Nn60syaWGDJZRHCuT6I8+wm
	RQfTV/AUgKHwL2X93Xn7OKQL078HF5Up5uBwNNUI102ncVrws3Wmo8bhiJMwVY7WZkbkn0pC191
	zxVE+lOndDHY9hZOR6PrGJ3DJ8GQABcjtua0wdD9Paj1tjezTprDnBGm1HHx4OL2AO9tzACINBF
	qUagyeemY6eh9ven0zmCQy+7FsbfNnqgR97M+ove5lrffnsBfns0x8dtXeuqjegQ292vQyAUie3
	+f0h75TEYlBcWakdSrjNRrNl3lxyDakIIdCTwdwnACNSY/upu4fmfO1sBhmbWxjbc6MAM9txTQa
	Ezdq608eT2r4qciO79zO/BImmKeg28SD7MNERGON0=
X-Received: by 2002:a05:620a:1727:b0:949:8109:67e7 with SMTP id af79cd13be357-949b3815a51mr3328608485a.36.1795613404403;
        Wed, 25 Nov 2026 05:30:04 -0800 (PST)
X-Received: by 2002:a05:620a:1727:b0:949:8109:67e7 with SMTP id af79cd13be357-949b3815a51mr3328600785a.36.1795613403766;
        Wed, 25 Nov 2026 05:30:03 -0800 (PST)
Received: from [192.168.1.27] (83.31.98.241.ipv4.supernova.orange.pl. [83.31.98.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm519677145e9.15.2026.11.25.05.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 05:30:02 -0800 (PST)
Message-ID: <f9190246-ea4a-4dde-9ef7-e29cbf6c5908@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 14:30:00 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: qcom: qcom,ids: Remove unneeded ID
 constants
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
 <20261122-qcom-socinfo-id-dt-bindings-v1-2-eeee0ffa25da@oss.qualcomm.com>
 <c4509c17-2c67-4f76-899d-548edc47069c@oss.qualcomm.com>
 <b10fa9da-39e1-4bfe-8c09-cc1d5cc007f4@oss.qualcomm.com>
 <786351d0-c7a6-4ebe-bae3-0c81ec20b833@oss.qualcomm.com>
 <c8e53787-adee-4fe6-8a8c-66fab28bbedc@oss.qualcomm.com>
 <403d0d8d-85f0-405a-a26a-54040272aeba@oss.qualcomm.com>
 <4276402c-9fa4-4bcb-99a2-4556ec59f3d2@oss.qualcomm.com>
 <ac7db1b5-ae9d-43c6-b553-ffeccc50e1b6@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ac7db1b5-ae9d-43c6-b553-ffeccc50e1b6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b06e2dd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ivW4MigAevuCEqTxTIunpQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=ks9rPHZIzW2PBVneSSAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 2IzMx0WIOB38tN5IhBlNiw6_-nLiqT1L
X-Proofpoint-ORIG-GUID: 2IzMx0WIOB38tN5IhBlNiw6_-nLiqT1L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfX8COQQS+rLu04
 5u3/OP5HX9tkKSQqy1ubNTffselEV2gXCx1PXu7RUfFysxgKRnWq1Mxjg+jFbTUVOhyXSAnvzdx
 9+SJPeWEKnnn84GeYTuIwEUrNiR+aX8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfX6nIKoIiKpA+h
 s01fJ3iIfXeJeY5liXY8BYFwnrReQxSp9YcNeCECa7XhazswrRmtQopAR/qIUWTtUunw85zHgnv
 IJ1xBSbovgedT9KwSciFwnZMekgM6TGn8P4g3FfDsU5aN0/Y4iCuCC35arJoHnEFoB28uLryZQZ
 qttvN1zsxvJk5bOmR1o9zXhNKRpdSzy+sjxJrAOyd1cOTn9E1sAJ0GVsvqzacT980ae9iFLDRoh
 wJ7GrkCoODfEsc7v94PA94OTX2cm4nV93+Q/raOziYQu3B4y46kU2hmA0W8fwGNVFgfDYu0l0P7
 jthvFpG9BDlgPs5o2t/WNC9sZ6Qu9pD04uoWhMEJ3ViA/BW3Aom5AL9FAH89JRfYWVsXow1VGvQ
 KwZaXPEbXndok0pjdQKHIDH0n5mywkuGH0I/pIXj2Pip4ARb4DGYVukBSQCC/eCQRU+KfR/g3AT
 LjrqJ1fNpEtljNpfq9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250053

On 25/11/2026 12:14, Konrad Dybcio wrote:
> On 11/25/26 12:05 PM, Krzysztof Kozlowski wrote:
>> On 25/11/2026 12:03, Konrad Dybcio wrote:
>>>>
>>>> True, not ABI in meaning something agreed between DTS and driver, but
>>>> the values are used by bootloader, DTS and the driver, so I would just
>>>> leave them as is. I rather care about not growing this for newer platforms.
>>>
>>> Right, but they are compared against a hardware readout of a
>>> well-defined value, not against made-up indices (i.e. these are
>>> not bindings). I really don't like this ending up with 2 files
>>> doing the same thing.
>>
>> Not two files doing the same, but one for legacy and one for new.
>>
>> OK, let's drop the bindings, but then what do you put into the drivers?
>> Hard-coded values duplicating another hard-coded values from DTS header?
> 
> Or we can have the defines live in include/soc/?

Then DTS cannot use them...

Best regards,
Krzysztof
