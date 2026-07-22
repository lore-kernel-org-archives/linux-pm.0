Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34540DB5E
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736615; cv=none; b=PoEcFovmoMY5ahKdwN+YGaXI2L5d4G54KaHez0/K3Q8d9JUTzvd2O/OU8T69/xl3oCtvaooFDOqKW1EhQW6Al9RBH4BznnUF3CD6G9obADG7PCn+DpK/alQlhs/kz9kxoQB2QT6Iyar8g2tHKbzfEf5Ap9z3Ft5AgFtrHYm6JYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736615; c=relaxed/simple;
	bh=ygsI4zv/jW+3AX1zDcDFKyDT2frDw4My01kgEz4hjOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utM6xpdBzFVDR5nQBMUR/kUElmYFEfQPWVRLuFjfEcHBVghX6bVUAJru/vO1uksbCLBfRaAMw2aE+2uK7fGTdqed5fUnfms2DsUKaZu4Ll9Q4SDIloMmCAfpjocznG01hVpR/Al/P664rRcgTcEZkkRJykGzFoaDo4r4w3PIAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pcVkMAgs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZGMuTHk2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pcVkMAgs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZGMuTHk2"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFXxuJ1051500
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 16:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9UqeA08xtr2nYCM1EGeFESAXA0YISWIb/8TTe1aDw94=; b=pcVkMAgsaSsCHVhA
	uoc6RFvZ8ScHTvSEt+1cCYKdWiBxCh5gCx8RF5CjewSL9CJ587SBR1WV/sI5ozQl
	7VWLOK+T8QT8mfbbgYGYigw5cKaMimgjhPSbslZCpDLpUlr8E9EE/I5Z3iV9AOIa
	CDVndRxFhTgdS2J3ARS0iX8prYlxxEDn/BXOPphfJF6EOYF02hvCONtfKxSF1KNu
	NlK5AwB4qM6mSNVZeh6xaxjukqT0Qjf3Rp4VlF0qkIXcCzMMs1mMX7+bHEhia3JS
	CMx7mMzvwHdyRX5DNDgWvMwXgb8lpjjvr7LUuvTgxtlBIsygvoXGi6mkD1Rt12Ck
	s3DAvg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2swbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 16:10:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca860baea9fso22400725a12.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784736562; x=1785341362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UqeA08xtr2nYCM1EGeFESAXA0YISWIb/8TTe1aDw94=;
        b=ZGMuTHk2dpU/J5nUIXAEYdx5TAWyFKog0OQzfgaKktWoXiexiqjLHB/o63rlKRu1qQ
         WsqubdlEkdziYNIsyKchOUfXGXXY6jcfCMNcLJ7jobBGIV1XiAMOtHypuR0px9F3gIA0
         Chmruka4149+8gwj1ROiUDGNpAEi8ytsuvYP+W4Ho9f/y0JKTiaHbuWtF9dERMDCrMKC
         ozco8hc6/dcZ0AtAw4jQv/lRVzgXoLBliCz61rZfvOQ3Z/kh0yg1hyccmjmjmZCVvhao
         9N2wR+GIZ0MCVWfkVY26I5zAL2iuqy9y7RkKGgUy1yaU6dxuvqVnyWKAhVGZwppDqIo9
         rvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784736562; x=1785341362;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9UqeA08xtr2nYCM1EGeFESAXA0YISWIb/8TTe1aDw94=;
        b=I81Cu++csM4ChmfbyjvuwSQQ7CBN5wxhpAZjKTuAi+cTukaB1xT9HLHaPGGqnQ2tjX
         YysH0u8O+a1l3ATWJmGxK2d5zg5mONa1EDII81LFxpm6ArJpft4Lk91jA/18maizrBzq
         mBzgsZn6EQEKwbJhfsmMvFpp8+NVuU1h/4SwalEOL3MXoBkwJ6R3YtO0CG5Rg3uo1Ctn
         mE3cSWKVYRqNNzOP32OHLYmHR/y6ltXgD4y1A7YANoYt+n16qW6ULBx2ENByJvlpeUMG
         CHG94DLCpa3sXNC+HMt3n2KRCOF+wz0i2Nc2v9fVcF4DPoBxNqmy1afcBfu58fgB+kQm
         PaoA==
X-Forwarded-Encrypted: i=1; AHgh+RrvQewthH/CX7tnhijYrO3sTCanXOIrLbnqwJcIDpngzoAhnCA0BQmvcNlcDZlr/oknfU4vMzuxvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRlO9qec0KNHJ63Qha4R+hrcaQNfSB7MFc1WSZ/qFj312ylrO
	Wt+eC8tItICX1uJFXaFcT/8wpi8hz/wYVjjuyq9h8yLx9p7J80zT1XUnXSzDbqaEv3OXVl2ewLI
	kwA3XgohcSyrDxv0UB12ZHWGp87EEAZx0uMJYd8UInzHyhBLOJXqwC0XzU5us8A==
X-Gm-Gg: AR+sD10Ep3XXvahXolUKsha0phizVzLm/jFaXAtP7dCjdg6KL8IGZtIlpegpB3QynHU
	NZDAj9MV+14Sn8U0puzSv3wJsY7fnyKB42l1rK2ZU1BssiEkabNwdy+BMGI57l+UYrJX2MGXdXy
	ghsMXM2dQ2659biH5UibRUrenNOitoOh6AFnogAwSpHUqip5P045MuKGB3tWH5b1fUjHoA86b2w
	W1jBxxE2pK2MmC2fzNiMfyggYIKD5xZl6aWZKI7dygVuDfjUvoUQq+CMlKoSb/Isfysdka/qtdv
	pXU0UBxJEpyRU9HwBXeSRz0E03w/NNvFZNC+7n2bKtbQdL09v4Hn40t8+cd/Kl4Gp/G6atZtgQE
	iGKnAMoOCCq+Z6/U0oO7UCXLijzdyztc=
X-Received: by 2002:a05:6300:6702:b0:3c4:302e:803c with SMTP id adf61e73a8af0-3c4302e81c8mr4231485637.61.1784736561813;
        Wed, 22 Jul 2026 09:09:21 -0700 (PDT)
X-Received: by 2002:a05:6300:6702:b0:3c4:302e:803c with SMTP id adf61e73a8af0-3c4302e81c8mr4231428637.61.1784736561391;
        Wed, 22 Jul 2026 09:09:21 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.203.111])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1a6adsm10322604eec.6.2026.07.22.09.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 09:09:20 -0700 (PDT)
Message-ID: <b99f7d35-c54e-49bb-a477-577ef61ef553@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 21:39:11 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Anurag Pateriya <apateriy@qti.qualcomm.com>
References: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
 <20260720-shikra-dt-m1-v7-10-7dc99100c6dd@oss.qualcomm.com>
 <5houmyc3fu3grxqajn6ivucct25yz34p66lwha3icmcuj2fb7f@ypz3r3mqwzwe>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <5houmyc3fu3grxqajn6ivucct25yz34p66lwha3icmcuj2fb7f@ypz3r3mqwzwe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX5t5Iz1Uy8lVi
 34Ww2+lC2556LpWtySauciiPAS02tYQBvWTxxupFszMxoxm1FBSEdzU2gBRlbuvXmNcf+b5Cz1n
 nj4u0RWP62oVAbOiqpnK0rxMBH3FMcm1YPApRdB3lLFTy74ngp0b0nZkkcLjuRBzPvBuK02U+fr
 bAqUyy/UMeRXrVHhXfR6Ph8deKqIV6qvvDIZY1egmk0ca12ALIUhMIBZyQsWOO527w1MyVmk/9Q
 yCcLZ9yCkoIJnooFgdG3o9i0SpqzNVWYZIB9q1etHLk3+6Kk4Oh56+mAqXE0gnjyd4NAIUtg4Hh
 9CNmQiz/VCE2OLiAzY//zSysIPX8sz9X2LIgHrQc6DnfZ8pM8UdHUyxtse42eBtgempw0sTT9tz
 cMzjH1IeKle8ZN7nMHuTE8Fy6XDtNTaKZqW/h9K3CoJoRZUPLMcpNciMoE4+4TTBST/ifI7DlAE
 5LwkM3OoGBufpu0ikuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX5PyQFOw5V9ah
 xdHygROJpG7TmpdU4nYeL6uh4Oq8hKijnvALk2QfGi9ZrjaMZMmhTIM8DqSyxAGylQ/gKWg6rcP
 MReIT/4HBW3EA2SodZc0gI/sos0HaFo=
X-Proofpoint-GUID: r6Hdhry1G8q-hWGYA4R_PVThxZjkuzQg
X-Proofpoint-ORIG-GUID: r6Hdhry1G8q-hWGYA4R_PVThxZjkuzQg
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a60eb63 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=WGt2SA6sb8UO62j07QM/GQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=aBxXs6P8EyRdFk8ceQ8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220159

On 7/21/2026 3:49 AM, Dmitry Baryshkov wrote:
> On Mon, Jul 20, 2026 at 04:19:26PM +0530, Komal Bajaj wrote:
>> Add gpio-reserved-ranges property to the TLMM node for both Shikra
>> SoM variants (CQM and IQS). These reserved GPIOs are inaccessible
>> from the non-secure world and dedicated to fixed functions.
>>
>> Signed-off-by: Anurag Pateriya <apateriy@qti.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> Who is the author of the patch? Why does it have two SoBs? Should there
> be a Co-developed-by?
>
> Other than that:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

You're right, I missed the Co-developed-by attribution for Anurag.

Please add:

Co-developed-by: Anurag Pateriya <apateriy@qti.qualcomm.com>

Thanks for catching that.

---
Komal

>
>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 6 ++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 6 ++++++
>>   2 files changed, 12 insertions(+)

