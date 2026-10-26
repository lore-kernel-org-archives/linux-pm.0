Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027087;
	b=5kNeSufl938vitgIfWEzJ25mVBaIf4UDhrmUTjWW3juPl7jM9eFc2LZ63AfHeJDPW9Yk
	 tzz2tq25c3h0/BaNNkj8uKWnS2q/kDMvcqv3YPhVHWHn24+dJlq3X0NvmaogZXWRq1Rfv
	 wmFqlO2tYFBZwnKsTu9aKvyP/X1OwUN0iESSGGrkThvGxIkZDsuEyuPWhzy365bXd8w6u
	 gcxr9k51WrQn7hHwWJETZvz9PmGJq9y2DpbU7EmmZroj/rW5IwCpv6MqTURW+atg9dEy5
	 dF2zJIia5VtGb53DAyESl7yfjpg+n1kMIZB/VPBq9eouKz5gTHeUpzNlKXJ44Js8WKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027087;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=;
	b=Stm9dizEys8+6wQNVpboAi7efahgg2S8T2o2aBlMcLf8PB5JG1JA4vo1IuGcoqCnCqiC
	 97kY2dVz08NECMGz3mHxCFQjcxoTxZA7kuGy8Ulf44Z+01p1o/TQmUp0HdXY8olsMfSUe
	 qFXwOBqImztRC35cO5ehiOfpD7zPxFuhDgcuquB3IPFy7nCISWJbQZV27A+TeoHNlNCtN
	 e7IRocWiINsbHeGnA3lVLZdvFT159q2oWAWJ1VUV+tr78Lyv23kNyY+wpr0f0FHCY7Xoo
	 ygW4W2iSXIBeYtrxE2duJGKvOuOFQ4nQGu43vMwLA7OV17GxNtthKPIcVy32RfzS9TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MQCM+Rmp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="hi3CS/w0";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B4606A33E
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 15:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 731B4606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MQCM+Rmp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hi3CS/w0
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEviVR4098768
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 15:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=; b=MQCM+Rmp+OZKHlj/
	ciKNByeD1VCOEeHm/cod6l/pyvN2YTQHAFlhorvZqwiKHrUqvJkCMMcy5+8NzsJe
	dMMeh21KUtXzbdhwyWnjSTWfoqDqaz+ua+npTwqYYVPbVaR4wcuIPmXxaV+Z0Soj
	7bvziDtshD6feN3rD3xS4cQSlN466v/4zq9C1aaPSG7sL5YezH66fQWFD4B1SgW2
	ANjibawOqc4WYIMXjujy6A1t0z72lzPVBkAtQJQnbGl+/fMMAOcyHF6r9cpgBhJE
	oDxNwtLwXz3Hw58HMTyQswM9SIaYHH9TunVE28H5F6B9VDmUJRw/Q2bHUg0ZM1dv
	zrVBdQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s915x1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 15:04:45 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-51ef737332dso438499b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793027085; x=1793631885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=;
        b=hi3CS/w0VZhpnvpAzVfNK1wzX0z9QvpV8ZWs51pe3ru7ISKFgRpjPHnnoGHumVU6qr
         f5DOUQt00G4rL0bQe/BEXfvgBFAzug/jtsdCOuYpn+lRZyDSeX69OnetF74gB/0AGby+
         Su3o4a4D7xdrMifOcemeeE/7vPf6hs2cWiDdXTrNugPCICgLLWn0BQxJNodWyEz6KItf
         UpkItjM+H52+K3Hnm6ZZJrSIkbG1ZnCWArtwtseSLBifS8j02eVJVPVJgNW7vi10dQ/l
         UiGUBjCFqpV4OSARb8Sydc8r3QEVh/B62xeJ31LO0ZsZW1t6OzIkXvrDfjCIjhMyEt/C
         jQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027085; x=1793631885;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=;
        b=iBreY27IqASUwfKxakXEzLMGnWqGMoz/YEHRN+evCuPiddoYWTZeO+bhaW/UWiRyZh
         okYBcSfPEvIKEno5MnPaOH8eAzlyHSmTaY2/Fdm9yGEyefOGoUiPQ5JHdyzsQpqN8c5b
         sQgKlvNXjW0PHe7r41V7cAvZKCJF+7TJWz01NoX7+DvrRtEvUe65SLr6eADMKQlx8/vO
         j8120F2naQ/TZ+FuPuzcDNuXQnruHGgC6klth5I4XozZ7zYBuDJ4J+YhvUGM04L/b13B
         d93kydINntJPp+gfwOF/CqCO+HfPEFuhLMWehC2Y7ESpbZCPZksJns+1TBvnTo+N6gE9
         p1yw==
X-Forwarded-Encrypted: i=1; AKwUvBx09F8QYSzfMhG8H8gkC7YeDEhYzdC3D+ub+B4qm35iGeJWQRbon+lCHwVH5x42KIVhEDH2/DKClQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIKen3Es4FqVg/QEzONCex6gkTJ6fhk+P9UoZfIAzrPDDxN1DRw
	44K2QdU1ISbiijDW5imwBQwWJuFR0v63urR+ye6CFfAaZQ1CdIzvEWN3gre+pn5GRUGPxSy0htb
	jjZZr9jppMTP6QgXMHLXzeqCBt8i5qFsrbV9YiXjaVw6eD51/cgroRpeT+jeO+Q==
X-Gm-Gg: AYBFou30e3WlSVj8D3z4DJZcJw7hisKut2+rk9JvbOzNH8Wf6l90aZ8PsHO1Y8Ul9e/
	ZcJ9uFudxK461e1AKc8fUcdPRjW6P+NAsogyP08ctOQkf8rtR3TwMfLPD656cMe/Sy+QlPGtG0+
	i4NxpSLgd4KzTWN0DGp1eKWAd3shlopfFuh1yCVf4oZYov9IzTBoWYKhw9RMLrQhWduGxWfqPdK
	nXYP50ZZ7Dcxgje6W8e6J6bBf4UbD2R9lwEz+E6Uss+qdxsy1nB+mPdD234AF/CYYR3b76ERM7d
	K4cp+xiSxrTGRWo+sAkX7HeqLPQSVZZFM9S2SRi+Xn7aSgyO6ENSYgm9ZdObnQ8/q7KxfE9s0X7
	bL/3oPF7TDfVpd6QlqbtEJw==
X-Received: by 2002:a05:6808:30a6:b0:549:e9e3:9460 with SMTP id 5614622812f47-55bffd26cf3mr6808483b6e.0.1793027084570;
        Mon, 26 Oct 2026 08:04:44 -0700 (PDT)
X-Received: by 2002:a05:6808:30a6:b0:549:e9e3:9460 with SMTP id 5614622812f47-55bffd26cf3mr6808389b6e.0.1793027083999;
        Mon, 26 Oct 2026 08:04:43 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b44595e70asm3844350a12.9.2026.10.26.08.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 08:04:42 -0700 (PDT)
Message-ID: <2d4e66f6-7187-4642-9371-4385a46bbfed@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:04:38 +0100
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
Subject: Re: [PATCH v5 7/7] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org
References: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
 <20261011-msm8952-initial-support-v5-7-1857074992ec@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261011-msm8952-initial-support-v5-7-1857074992ec@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1OSBTYWx0ZWRfX28CvDe9xlBph
 dQdlzDKC6X2LZdBukTTazURGJXFGzdzL3duHPceIjE6RXjM+NfyFqLRigvXKvF1S2xgML+FKDyF
 H3M40zkHqLdMKptMnSK/ikItOO1digWNxF39EWBHowxtfxhPQVlKUgRgOi3ybn7zxr0cOgFsK7W
 LeTgsaE2Ss9bmO38IzAVZF+BoiV750QJKEAZ6Mpky/RLXdKVry9l/ytl89llwY5PfhW/OWjyTgD
 gqMWTEaUfMPHRfvjwxtcChUmuWQm/3SL+zy/vPPY7pd0TFG+4UkA5SkjSkjdRwDaMQyPOlWDuVN
 BO8zasuOvjPttF6oDi7GAVvunQIZYgmv9VBrVWB7UTljEs54XOxqrm6KamH4I4h2fz8HRh0Tujp
 bUmUWh+XyJJDqqLo30ZSS3b2PrbhsfZfQozlcQlO5SZWrFwQr6EHjPlGrTKUVnI2ISEJqYVittJ
 eNWeD7CXq8D9IfXjeYg==
X-Proofpoint-ORIG-GUID: Hik3GO8tlMdIn11ShZ3f9tT5Xm_ivlq7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1OSBTYWx0ZWRfX4oXfQX9NDnyl
 aAxpYIU8qn7WxwNiJddBzF9ND9AptXunpHi4Xy82rMaBab9gP7pIm5dMTsc6IY73BBihGxwf9Z3
 G6uaHLkSurRuy4BvHvPiRTWQBM1Aii0=
X-Proofpoint-GUID: Hik3GO8tlMdIn11ShZ3f9tT5Xm_ivlq7
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adf6c0d cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NCdQflJRAAAA:20 a=OuZLqq7tAAAA:8 a=CrGEZSrvnsKXYSFoqd0A:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=TPnrazJqx2CeVZ-ItzZ-:22 a=AKGiAy9iJ-JzxKVHQNES:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260059

On 10/11/26 6:51 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed
> similar to L9300. Downstream reference is [1].
> 
> [1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

[...]

> +/ {
> +	model = "General Mobile GM 5 Plus";
> +	compatible = "generalmobile,shamrock", "qcom,msm8952";
> +	chassis-type = "handset";
> +	qcom,msm-id = <QCOM_ID_MSM8952 0x0>;
> +	qcom,board-id = <QCOM_BOARD_ID_QRD 1>;
> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */
> +		serial0 = &blsp1_uart2;

You need to enable this console if you want to use it (stdout-path
also points to it)

Konrad
