Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF33B27FA
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908938; cv=none; b=XjWyFL5fTDGchcEx1SxujeUpx4+w53GlMU3NYlWfxIYkoopH7X3qqcyqoHimXdIJDjtOo8ASLNrDuFqyH1GDFa/8C+tkDjCWFMj5v/7CVluP6bMIFqRHYmoNfpFiUAsI+16eISkCBs+pRfpzOQCYAi+Kq1IAZb7M1xkAZQjdK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908938; c=relaxed/simple;
	bh=fBerNiWf+MDgAZrSmTXySSQ3C8VQubBzWw+Rofp9O60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N94jDJfdsiOCFXndFzpE3Sw+jYqbDqDWoCONAbzTkidAQiPSqAvZQQrrPo/BvEjy6yID6aMWkQdJPN20HC0rRdWUISInFvYiRQGQ4SPgFAqEJPmVFQzEHxH86+ZnmX7nnE02D4tW1oIGa0bIOIjB7UsLC6CoyIe+XfGjZMgD+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QYv+LLyj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I/FeeAAP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QYv+LLyj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I/FeeAAP"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OrMJ2274544
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 08:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6ua1qIQefsn0KzCMxDrvAnd9Wib/2gaov9ZIiLNLNqA=; b=QYv+LLyjuU5ToV6J
	TXdyJnl3g1VRUt43hsHCzXqjBXEeTJ4o2jTCmX68L5wsdDiOAYNmw0m8khGn6uma
	zKk1NsBJA6hVxC9hmFNP6p3pck+cTYLjHHvq3QsSxnMfiuGtMc40hGgtWOwjz/B3
	jDj6Df2PIT4Blfp+Fv4gXkmyethc7IboVu9w8qpnnmzcetPeuqp+FDsj4MYpCa9M
	kYuqSTYTfWYxXt8+iDZJbtaVGc4eV2z+Ld11dmkVVcOhVNjLzbtQW2M+BGuj/Hj+
	hNFdBmBaiXk2UPhk+/PWHbY536bxMKDVNBESky+8xVvs1LUlbY1bN10RwYwZQJ+8
	lImZZw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgxmju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 08:55:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51768e1d798so10402911cf.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780908936; x=1781513736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ua1qIQefsn0KzCMxDrvAnd9Wib/2gaov9ZIiLNLNqA=;
        b=I/FeeAAPffJTARlSl96lMRgZRMThnr/AjGeAHQwiYPYnl6N2XbvXFLo8JLaXSEj75c
         9g+L658ewepekTXe/iNDsEts4zE+J/MhfvpfDxDercc5LrfvY/Z8a5F4yiZiRYBf5ggc
         sP5eUbBr/oV5u4jkFRHH/51G0vUcymNYHTdnF1JXGNIrZgg5/5fUmFVu7D/0PvBiq4R4
         Tv1laHyuoeo2oEAOUfoZJPzx5AaIv4m2SiWMbB3MDmUDgySbImNqrulXUjSEZiRkfsJg
         5YO3ENfQn0w7NUJQETuAjPxa1sp/d9lSAtaxJ+Zgobs+8SRWQckfQ+BWSePajyWo/NR0
         4Dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908936; x=1781513736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ua1qIQefsn0KzCMxDrvAnd9Wib/2gaov9ZIiLNLNqA=;
        b=Pn+3b8njfykmrvyTkW2v9VAmeUGKsb/3FwORJm7T7fvwI1MzbzNH2OWtXk+Ycg500c
         Cf8/pTH0ACtk74AlipTWR8EQ33QDIym+Kso0iOPTzwaoAxnlmuiXjkWRG/eHgfcbGKCX
         zauYaQYBmAWD3sPIjj7lwWJOMP0mLyfEmqMrxHLHo//rkyRRbr2rP9gZRwHS/vnahVp7
         ApZpk9QbGimkjPu3lu9EYKMcERnvLWzVFdXqkMlo+kpbOGkx6hyb+1TQ/kzXkiIEFvo+
         RrZUuFTy/StvmFW9ytf+2OhE4Ul0wCp2ZcproeIDAk19xT+psTPRLm2s0H2pjhwHa8jZ
         uW3A==
X-Forwarded-Encrypted: i=1; AFNElJ+llIMykjdAXYe9IwZPK2FpJIb53W6lMcOUjOz3mXcAc8QZxeuUn6C1kzwoXbjb8ZBp1IZoQWNiFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMu8zrZWeR2CFScv6Ikg1q1G7mvEMApuK7ktJCGAq5i/Z4kkEc
	L4msxgBCOUrY9KahciP6Z1A2YSdeQucJva0GgdP+SkBiIOs9QWMJkYY9RjhXKRZ71e7zTzTDw1O
	jYoEzjvopcq0sQC+VwmOFWrHXeCdkh1l0SjKLWUWjyqC3UlTL16e6wpcLPynj7w==
X-Gm-Gg: Acq92OE60GW02CmEh2eZh+/8WW4vbN8gdm7TW3C4VbzPZXUSClY6H8lSU5St9rPLXRH
	xAzJ/Dc2DMaYyN3v8S3Y2pUhKiDNjdAtvbO7pNW+znlT/EB20bfAJz+CDa/S//edjAVSVic7AcP
	YiMjGat/+I5Y3j4Z0BqiUp8ZSnawBYq/ld1IdzTuW6WMgQMgbQvl3PmlO/jiDntw3wOUdeu2fLB
	yYHcJR/ckc3GDXJ9LmbQBwD0ntuv40s51g3hYPrZoyHO/DvwYd4UvuilHv3O7nzvX5mQpQY3mBh
	lpbo4xaBHUJtKbhAMl7ZHT9QQGKfsvl1xKztn0j1mabPt2ugI4N/rzpSHODgujvMu6iiqfT8TSg
	kj2LpRYNYt9Zd5YtOaAIewWNbf0sGZ2nAcxztMjOJxJ+ogUISDbmKyljF
X-Received: by 2002:a05:620a:198f:b0:913:b4b9:5ec8 with SMTP id af79cd13be357-915a9db3db3mr1315258185a.6.1780908935917;
        Mon, 08 Jun 2026 01:55:35 -0700 (PDT)
X-Received: by 2002:a05:620a:198f:b0:913:b4b9:5ec8 with SMTP id af79cd13be357-915a9db3db3mr1315255885a.6.1780908935398;
        Mon, 08 Jun 2026 01:55:35 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e650287d9sm6980528a12.12.2026.06.08.01.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 01:55:34 -0700 (PDT)
Message-ID: <e0faf562-f882-454a-8719-1d5716ba6fac@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:55:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] interconnect: qcom: add MSM8x60 NoC driver
To: Herman van Hazendonk <github.com@herrie.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260606-submit-interconnect-msm8660-v4-0-6e1e5c5efa26@herrie.org>
 <20260606-submit-interconnect-msm8660-v4-2-6e1e5c5efa26@herrie.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260606-submit-interconnect-msm8660-v4-2-6e1e5c5efa26@herrie.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a268388 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=ClTuqyqIc_xs18_e7JIA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 0-eIo-xqH561oKabXzUiUxvCaD3pPjkL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4MiBTYWx0ZWRfX7vVKcwb0UqX/
 UuLz6xTw2AtDK6+2yD0Dh12d7H1B1wCq6HjtpJQH009P0zCiGt2ba0dRE4PHgC5AIjOqtJdFGxV
 aPOHuvDIcQ94ZCwLkdUtRZNwniSaXIomvpN4VbcbAnQCZ1IxyRMlwYGtjKB557e6Cu3Qq8vYNWR
 ayd3tkbFtS/7m6tcTp+hnXOF4XzFMoMyc0xIPeZBAWngx9ipYUwwpQrZWAS/CIOg4e5sS0WLLFu
 ZdYQaS23urW2Bba2uvsnIaL2q8mb0CdZUUouYrucKsjceuWP6n71miuaMokrpK4qPZSFMVOPVrP
 qZV5GJWG19BggA6nzfHQTbKFon4flGPykSRmDLSBCQgVPrSBVccbOd3zK+rEqV7jyc9reUfoXGC
 h3QE70TArvI7nnwdntE4t5Aqx/GV9LJFTfWVJHr3nI8Q6TL0JUqSEnWil0Hd6LxLFuCjDcPJiWa
 jr2YSZ5rGjN2Qh3+cng==
X-Proofpoint-ORIG-GUID: 0-eIo-xqH561oKabXzUiUxvCaD3pPjkL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080082

On 6/6/26 3:00 PM, Herman van Hazendonk wrote:
> Add a Qualcomm interconnect driver for the MSM8x60 family modelling the
> four NoC fabrics (APPSS, System, MMSS, Daytona) that connect masters
> and slaves on these Scorpion-class SoCs.  The driver implements the
> interconnect-provider API to manage bandwidth between specific masters
> and slaves via the RPM arbitration tables.

[...]

I'll skip the bulk of this for now, as Dmitry asked you to drop the
clock interface (and do rpm writes directly from this driver, see
icc-rpm-clocks.c and smd-rpm.c)

> +/*
> + * Minimum fabric clock rate to prevent bus starvation.
> + *
> + * When no consumers request bandwidth, the rate calculation yields 0,
> + * causing fabric clocks to drop to minimum. This creates bimodal
> + * performance: fast when other subsystems (like display) happen to
> + * request bandwidth, slow otherwise.
> + *
> + * 384 MHz keeps fabric fast during concurrent MDP display scanout
> + * and USB gadget traffic. legacy vendor kernel docs: "AXI bus frequency needs to be
> + * kept at maximum value while USB data transfers are happening."
> + * 266 MHz was insufficient - USB crashed during display activity.
> + */
> +#define MSM8660_FABRIC_MIN_RATE		384000000UL	/* 384 MHz */

So, are there any issues if the USB controller is offline, can we go to
the aforementioned 266 MHz rate then?

> +
> +/*
> + * Maximum RPM ARB buffer size across all fabrics.
> + * MM fabric is largest at 23 u32 words.
> + */
> +#define MSM8660_MAX_RPM_BUF		23
> +
> +/*
> + * RPM fabric arbitration data format (from legacy vendor kernel msm_bus_fabric.c):
> + *
> + * Each u16 arb entry: bit 15 = tier (1=TIER1 high priority), bits 14-0 = BW
> + * Bandwidth is in 128KB units (bytes >> 17).
> + * Two u16 values are packed into each u32 RPM register word.
> + *
> + * Buffer layout: [bwsum pairs] [arb pairs]
> + * bwsum[slave_port] = total bandwidth to that slave
> + * arb[(tier-1)*nmasters + master_port] = per-master arbitration entry
> + */
> +#define ARB_BWMASK		0x7FFF

GENMASK(14, 0)

> +#define ARB_TIERMASK		0x8000

BIT(15)

[...]

> +/*
> + * =========================================================================

Let's drop the =s

[...]

> +/*
> + * Pack bwsum[] and arb[] arrays into the u32 RPM buffer.
> + *
> + * Two u16 values are packed per u32 word: lower 16 bits first, upper 16 next.
> + * Layout: [bwsum pairs] then [arb pairs], handling odd boundaries.
> + *
> + * This matches the legacy vendor kernel msm_bus_fabric_rpm_commit() packing algorithm.
> + */
> +static void msm8660_pack_rpm_data(const u16 *bwsum, int nslaves,
> +				  const u16 *arb, int arb_size,
> +				  u32 *buf)
> +{
> +	int i, index = 0;
> +
> +	/* Pack bwsum pairs */
> +	for (i = 0; i + 1 < nslaves; i += 2) {
> +		buf[index] = ((u32)bwsum[i + 1] << 16) | bwsum[i];
> +		index++;
> +	}

FIELD_PREP(GENMASK(31, 16), bwmon[i + 1])) |
FIELD_PREP(GENMASK(15, 0), bwsum[i]);


> +
> +	/*
> +	 * Handle boundary between bwsum and arb for odd nslaves. When the
> +	 * fabric has no master ports (arb_size == 0) the arb[0] access would
> +	 * read out of bounds; pad the lone bwsum into the low half of the
> +	 * word instead.
> +	 */
> +	if (nslaves & 1) {

& BIT (0)

> +		if (arb_size > 0) {
> +			buf[index] = ((u32)arb[0] << 16) | bwsum[i];
> +			i = 1;
> +		} else {
> +			buf[index] = bwsum[i];
> +			i = 0;
> +		}

similarly as above

[...]

> +static int msm8660_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	*avg = 0;
> +	*peak = 0;
> +	return 0;
> +}

I think we can drop this

Konrad
