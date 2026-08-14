Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A23421247
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693558; cv=none; b=OhC6xv25xyEiHySuna1VPiQz8uolIjS6ABumOQQG5IVhftk4Z6DIb9ohBzX0SpL8Zt0IkOTHguGRBY/TQBprfsjnANVBWE51CVgY5YFbNq6eztDpGrwOQpWMcrGqR6vEU7UKr4Aa5jiAMTByJXBOROrxFn/qUmB/6/8lOmjCWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693558; c=relaxed/simple;
	bh=odhvjEz0uGc5n8RkpwlKDWDtDSKuyDnnEDBwtJ8W3tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLwJQknA2ULvLaPBA0qC+5lIrh0JDN99kUjDxryOVGSQbhhVFSZL7+V4a2hwYNwrFY55BKyBVS/wdBGe5FoER3de2sUFtax09MqttmCWYJWHb76XFb0amg6ZcYNXMojLvLZ5Q6IGt/CVKJYkH9o2XGKj6sf6Ot4bP4VMFBXn9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RInTndO5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MrrPanvn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RInTndO5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MrrPanvn"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7fP261600725
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7kZ2avGnMlg8Z6PBbfqxwFl8yWl21AGMezmqeMHyqZM=; b=RInTndO5652zutsi
	uL6WzNzZ57vg6GtW6Jv1ldEVYC0s1++YbS3JcVb/isfmlwL2wDwoYrTqI8exRUre
	ndB3EIH2wRm8i/SLNERLdHUONKioi0HEThYcZQue8Vtd81P1ITp9sgnRu7NFP6Ga
	jJMHdvVJrf/ZLVzil0LBw4Nveu81RBikaoC4F2mLrO+5mvnISHXicU4fye2VeADp
	r9qRiQMHBb5vGWn9XbiJQ5Rwowtd509/2QvOUoNVzgaKx4OCBHj0DmPzcKFAK55s
	1D2GtW3zhoGkYqvLF5YHWdsFZANMWpikDwlUUK8IQDEIea91s2nsH+ZFb9PM8qL1
	N7kf3w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1nugsvgq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:45:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so1061434a91.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786693545; x=1787298345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7kZ2avGnMlg8Z6PBbfqxwFl8yWl21AGMezmqeMHyqZM=;
        b=MrrPanvnTzUxjdX1Tnj0c1eNh0P1YlAWElKzUTs91vpaMIiC8K3reMTqQhousWRKPo
         he5PPMn+Fi8t4VfJO5FgTxL30wcYCGS7h5k87oimET9dkpzWtKQCvl4bIro2IonB/kg1
         eR8hLnCNqXBTw+apkHSuerl6jvZjo9MOQfX5tJ5EH2Cq+cYuZNRoyZ4zIL9LXD3NqF5D
         4473P/uaAlxosAF1DPapdH0F+eN8E9h2qbhMJN2Db2PDhPvsW6TOE4LiET9OB4p17mHx
         FrP5bW/H1IZeguGBjLo/CHtEcregPTLpo038Y5QLSKfZ+FZ3Y6TVE5BVxXu1vFe62prk
         ktwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693545; x=1787298345;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7kZ2avGnMlg8Z6PBbfqxwFl8yWl21AGMezmqeMHyqZM=;
        b=GYQgI2m0i/sGCWVmPnJ6gFwxZH6M1ld637LwsbFD9Cs6o39z+VB+h3LJojDs9qVAtY
         4MndR0p7A8NpLdl9V9YzeD9x97Da7Sao8jAYfXwCytqRxVHXAbfeHN4L+RhXZxNdBgwc
         dELPASbqZBG0Tuo7UCfgjdvNmlBW80Yf+7Mp4CQZ6STPGR8wZpg/yVZDGTVIUMG+YE/h
         QFtbm/W2UY07s8CI+r7Q/qtdkCTUsb1l/8AnR/gb24VmbNznrLQWBduKOqbhMRwjOR0w
         0ak4RH02Ta2W4uum/hZHPcevTEecW55powRvWV7l3FHuqFA9SujJAxaSrJT9c86Uq2zY
         hIhw==
X-Forwarded-Encrypted: i=1; AHgh+RoHf5yfXoKxb6g4ixwhgQoWw2MowyKA1dBBHZsaRk8stk4HOMuuHS7pGWnbQOEAZGeQaKraB0VJyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIT9VUwG2OpWBwknp+zCD4Ld3iNATG5kL5B6cyLqIsohqwSez/
	O6agDwTfmrFwJiG/lFFAbUEoFpmTkroGWAVmD4XNBod8axGecj7084GoagVhK55JHmZyWDnYMMw
	0rbniBNs+HmGVndQqfPmZ1QLIXCJ0xaFVe28FwSnWznTGDZj9tUDdhESlTDyM9w==
X-Gm-Gg: AR+sD13jRVI6G4Td/WVMyHdpfGoShx1068f6yzb9jbeaOX0itiDhyMcrmb4zK9bH0Hq
	XCS0QUGim47oqxWySKoIsiwxJvg5MDRdMCSOwa2xg23W6IhslObEpdDLdHkigdYJkKFdmo29xlR
	GTapN0PS04nW1/dU/Cfm+Gllg0TehhGshgKnkdhf4nzGHcs3Ci87mhZ19o8DyH4JLGLJYx5u+oL
	S7xXPvzi7bfHCbKkz2Fu5941wjUBszSVHMxA+vPlFliNep8RX02XV3vDSeKVrxvpD4281F4wHhs
	n54LL1upAQNkpCn5J2l7KlD2zCtIb+LVNVxvGMYyHyGellDVeEXPwyZ3lGYlliwUuc7cQsnyZCU
	++91BsNS9bRLGrrS6oqw/3O2ZStuESvXz+WF3+8HHUA4UDdZnXp/WK12JRHgSZk5GFrXX9KE/vK
	0uECsJ1U6vJ6R/QSPLmLk=
X-Received: by 2002:a17:90b:268c:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-3933b84be0cmr4470091a91.9.1786693545539;
        Fri, 14 Aug 2026 00:45:45 -0700 (PDT)
X-Received: by 2002:a17:90b:268c:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-3933b84be0cmr4470024a91.9.1786693545103;
        Fri, 14 Aug 2026 00:45:45 -0700 (PDT)
Received: from [10.79.117.20] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b688035sm772468a91.3.2026.08.14.00.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 00:45:44 -0700 (PDT)
Message-ID: <3941f29d-3da7-4576-a852-9922b94007df@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:15:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] ARM: dts: qcom: Add initial device tree for Kuno
 SoC
To: Linus Walleij <linusw@kernel.org>
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
        Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-15-5e0ede4a0c72@oss.qualcomm.com>
 <CAD++jL=M1E+Bvfe9tHw3FaSTFgR1Nfzyn==xoLETvARLZHPrMQ@mail.gmail.com>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <CAD++jL=M1E+Bvfe9tHw3FaSTFgR1Nfzyn==xoLETvARLZHPrMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OSBTYWx0ZWRfX+qqW4+KCwSaq
 nAk0qCFXUpml2yqToNBsiuThpwUvDzJMs1q0hURigP2ot41f/+YZRtQftLXdU5wbze9N0LZI3pt
 1zOfR7FZ7l2k6sHLiLLfh+m3z53pXhY8JDLoH92TwfPU4AMnUBz+mwTopNiJwdnWklb5yIE97IM
 +d0/jHxnHw5sbc0nzzS6jfTW7+jSBST7t5NVLgzClIejG3iWmRE8W1mzP4IdJ1mO4fUa/g9udjY
 WRyT1cVGPWVZ32+KtBFhfulg084IJpRnMuPkmiDLsmTWA1mPEQ2NkSjPlxmtovuvdYdEik7FBYl
 +lUUkpQzscvjG/VyfqfvLcLpO8zV6pbPM4kMsRGZC0vCQjIuNlHWUAZhnZSK2o57IoxJs6rylO/
 aemsH6ncGzviP564Bywy6LlxZiAeDbCaznrSEeNPbNnKgoT8iWlMvgwSzI6SbBvyWqKr5zRae5U
 C9QZIIIuoapGPVRf3dw==
X-Authority-Analysis: v=2.4 cv=drfrzVg4 c=1 sm=1 tr=0 ts=6a7ec7aa cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EUvog4zVDZIPAgcz-YkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: GpcCu6QNRlo_d7Ada1zTmcdXhkw9HESy
X-Proofpoint-GUID: GpcCu6QNRlo_d7Ada1zTmcdXhkw9HESy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OSBTYWx0ZWRfX4A3UAvWN8LPe
 e1bRG8hOsxFznpo88L84yqevcYtCCh1nBnHTHTce+KmsArybFUAUlmnPt9bLg7J3Jf3ua98Wk+e
 PVdwvcdK3biz1rytokXKZqhIzNmacD0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140059


On 8/11/2026 1:33 AM, Linus Walleij wrote:
> Hi Hardeep,
>
> thanks for your patch!
>
> On Sun, Aug 9, 2026 at 9:29 AM Hardeep Sharma
> <hardeep.sharma@oss.qualcomm.com> wrote:
>
>> +       memory {
>> +               device_type = "memory";
>> +               reg = <0x0 0x0>;
>> +       };
> Since this is clearly intended to be filled in by the boot loader, then
> write that in a comment.
>
> Other than that is looks good to me!
>
> Yours,
> Linus Walleij

Thanks for review.

Done in v2 : 
https://lore.kernel.org/all/20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com/

Best Wishes
Hardeep Sharma

