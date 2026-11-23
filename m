Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447062;
	b=SrhTumDNRCT9C+TGiWITjdmkw1PaUAPBhhwgar/LMsifgNDjysjKOFWla0hrxKgSKyZ8
	 aYemAP6HSkOvL/+tHRCPifJMdFShWLwuoty1+yS+PHxq4jT2Lf1yzsZhl0lJXaV7eFJzV
	 4I813ZSKPFsnumV+yVXZYHy+N04czOa4w0YH2JQRSxfDhHe44pju1G7ZFCRnQg9nT5Nwx
	 vhZi60lCvYWtmXwyVjLEOX+9KnWdRVCONsC+Dca1XFFJ+6fJFaNFVH6af8KL4y2Z8ghnj
	 1NU+YbI7q7b9YdzVuWU6OyP9NaV413ir1IC0Z8vdsgxP/HnJRG5hyBxgWApYnaAb+0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447062;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vkrEv+PVcuudxd6R0af2wrFICM2sOzSUBrjd2eADlIY=;
	b=SwpG8ZgVIqfDXavbBY9KfmUDn3JGqHD/DbaV7OaCCKe5/23npV62zZIHGtezzyl7jcJ9
	 VVWtn70I8vEpi/Kib0ZQQlaGh28aiK2KCc3BMd9G+xgF0Vv2O5ixAmdBgjDzYfVx80BE5
	 ecmZ7yiI953LpLvHICZE7ymSiuBHfQXad1KvGkN6ZOM151+UgiduXcNtQxSG51DwYT3wP
	 3eKGHu6C8KRb+EZpCzKzj3svzqQ8nQKVqrq3JUfHJey5NzBdfeS9mBhklTzFtiPrQ72Rj
	 0J7dsUdODD4mp+C7N8vJQ47ueRtY2N1H4RO6ir/lKVnFr1/aGAe/omUhU7360cT0slA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Bj+jtzy/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zx7yn2de;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F223E606A327
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F223E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bj+jtzy/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zx7yn2de
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDLHnW4030540
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vkrEv+PVcuudxd6R0af2wrFICM2sOzSUBrjd2eADlIY=; b=Bj+jtzy/tW5+Zv1Z
	cRybiJR+ZWrYLOqOFQtKGMxbyFu6GynHDh8jLV2d9h+PTox/EcjUYSbS2VxoMen2
	OXfbgM9SpL9kBKkC42r8AgV095FZ54A+bL8hc/YDnbHlZ3lnKaUZC8LGlvKO1XcR
	ITM8cHjmLdHbOWVUnC3x0osLeuYWQ3njziraoQ+krm+dawdLVUnpoL/oXmkJIjP9
	Bcii4gXGoXmmGsfkoyFwCbpA8vE1jLobzftEwENNfk776EyLjyC0ud/yeVAeNuN/
	6we9X0EnbjBsPyMjUx5iDXt6vZWFjM3D/0iNfAfU7TgC5YTsG4ZUc7YPcRBLUh/2
	Obs8uQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evsj7fu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 15:17:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad5f977673so540624a91.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 07:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795447059; x=1796051859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vkrEv+PVcuudxd6R0af2wrFICM2sOzSUBrjd2eADlIY=;
        b=Zx7yn2deOWtV6BkEV/IUz8rql8RAxl0MZ+jGj6cWSSMTW9u7gVKAXqvlAqMaFQhyTc
         KyL+pQTaxkG5B1k/mmi8K525T5hKGmjS4iYq5fdy4uurXKY5hSxqoJh9bbz8b1G1HY/E
         LBBWjvikleOm0joC3ueIPqs/J/J9TN0fbFTC1SmrHb/2PSQPMTc95MXEhnVwYVbZ11BN
         7afn2/qh3mJLNP3g4LEfrl2TZJQtblUgQgAumCm7TkiKWvIUqy27AsbS7fD6mjBA7VSt
         IjNba93q9j8KY4E81FXlHKI5uM0Sbtqw8ysHOM9udFAj5HuU7QqXhPKJ4jMTV2NnFvy5
         OiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447059; x=1796051859;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vkrEv+PVcuudxd6R0af2wrFICM2sOzSUBrjd2eADlIY=;
        b=QTdoiv8+gnUA5KS2bHyFkJIKhaCe978AkB5ONUjy5pfE1UGGs4UBi08VcqCaGQztqT
         ABBvQ091BtkGNHsDw2ozNUtT1z2zv20L2tner9wnCKWTenBp4gbfkXMWxOnpGoERjvbe
         cGBF9itO7WmjxcWwsnyvmHBic1FHGoNI1mhOXZkhhFddt5DuyMUmqr1AihqbhvmWdsj4
         XdPSEhZRvakpVbyacIEzKsI8dKKSaMeWn6bze7VzTEKOmEZbIC9SG2fal8Ypa/QAf+7I
         VHUkexX9apsa088mHAChaU5DuIiJic7IGCyTnq2m+w1ioRlsSWG8iXzBZgdQuKzASFns
         8X2A==
X-Forwarded-Encrypted: i=1; AL+hErE7MMNpOCba9mKOm6JTsdnzVl+/ZcEGNzYPzBUuG0ApPddCeTm1ppPaZMCK7a7X40/2MrIZpKuKrg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9otQYotSZ2xSvRuBkskv16stewp3DmTAS6bpEgkX5mEfUkcmP9
	+WuLqAa4rsztkBe9xVPsS/uadoJLp0xAaXQrbDieopglyr2AYA0y5bF0Y7+n89WgTAJya0nQ9fa
	iEig+QeqVuBpWyhHiar6O+w7Tp1zd+/8BrzRQPZLJJTNIoUh0LQV4ULSgLU9/dQ==
X-Gm-Gg: AZFdTZf48WCECj919wav8Ez9g6Iob7Xx/LlCxSfljaL6vSXbCXdz0TEV9bhPDAuPTMM
	N/HtWezIvB2qOSzP8Grx5s6aqmdLxyVJNVfQjWsUI6MV5aYW1TQ9HtrNHorHO5o9v/bL36PvBXh
	107VS1yESUbZEDYAP3I/YhmIwTqhcjcgv2aqU4YwG8v2OG6Hca78wMSTRRAuGqEDJDULVhoRkeR
	bZNuSmqCF3Acmix5yjpNns8q65Hww7Pei5RFiFthZV+cfmMiuvLnpJdjZgZXbiNxxAko40E8kIZ
	HXUa+peWunZf3gfnZu+Cs3E1GlfpF+Ye3vFi9aa1fZPFbdhg/aDjfPRdWq+lFW9P8eroC81gSH1
	NGrSvySKHk68zUMMB8QxdD6I7kYWsTNgXtP5ybiPrtWzS0nenGPfD6+uMsfXMKtggfPEHkg4=
X-Received: by 2002:a17:90b:388c:b0:3b4:393:453c with SMTP id 98e67ed59e1d1-3b41c96fdc2mr18071178a91.6.1795447058721;
        Mon, 23 Nov 2026 07:17:38 -0800 (PST)
X-Received: by 2002:a17:90b:388c:b0:3b4:393:453c with SMTP id 98e67ed59e1d1-3b41c96fdc2mr18071093a91.6.1795447057989;
        Mon, 23 Nov 2026 07:17:37 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea28f4sm430944366b.33.2026.11.23.07.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 07:17:37 -0800 (PST)
Message-ID: <c4509c17-2c67-4f76-899d-548edc47069c@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 16:17:34 +0100
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261122-qcom-socinfo-id-dt-bindings-v1-2-eeee0ffa25da@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b045914 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JVp1Gilkp8drtUWwDXwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: rgVvkpIm9X6NNS-QNBcggCdVcs7sS3Dv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MCBTYWx0ZWRfXwBZPdrRsWTrr
 o1X8/zsBaQNzgOb7CyNjrFy67WFdeRaAhu0DSrcsc+/hMkGSeBdkonr+oGRVgAqH5QtuMVr/fgt
 YJAK3+EuDKP8awKsUYbq3cCbukWD26FEPf7HFU3Li+e68MLsByat3lPU1PfoixQPNpBCIPor7bX
 Wz+0l87fQOLTiiA47E/zxuVhME+HPIoEFLz7snAX1fzunuubAAEbcBl4vjg1r3LgFjB6M5O6C0k
 12mSzjcvygmuSXawhuczbOXpfTk9mSqFxzBV1N9r5iq1gHn5Qq2DL1vjHx8/ynR2y0Beve5CBKr
 SwLAAms+FPR2QpIIsh2Z4OpZ9RkmXGA6eTvzcfju0LX0jv2NJr8SpEWsndLX8RYjM//Czn6ogLS
 vrFmIfh0nUW1BoHWn39yFcA3MCOmig1hglcOUeZNT0PjlSDaEfhlCv9xrckUNV3LUVrppXDXOZA
 ya5ciafJB2WKcu1CMEw==
X-Proofpoint-GUID: rgVvkpIm9X6NNS-QNBcggCdVcs7sS3Dv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MCBTYWx0ZWRfX7SvzcL+cGGTI
 EkA0IWhw4vGcWtwDxuBdpxbsccEoUvX9GAT9e+tS+Sejf2XQMhh5F+0GvlHb8QMpcMpg+vGHL1I
 KxV5yff+IOJRgLX8CqzpFNqp2u/Gghs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230060

On 11/22/26 6:46 PM, Krzysztof Kozlowski wrote:
> The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
> currently used only in the socinfo.c driver.  There should no and there
> is no in-tree DTS user of these, so none of these constants are really
> proper Devicetree ABI.  IDs of older SoCs were being used in DTS, thus
> that part matches the concept behind DT bindings.
> 
> Driver have local copy of these defines, thus these can be dropped.
> This has no impact on in-tree ABI, but any outside users would be
> affected.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

I think we can move it altogether, to prevent a situation where one has
to take time out of their day to analyze which one of these is right..

To me, this is the same case as e.g. glymur-ipcc.h where the values are
some foreign constants that are specifically NOT bindings

Konrad
