Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410618;
	b=sdvDRlPznR8hLQkYfMify0xyN0eNCs9W5UibG3x3B0sf06i5my+kfzDE4U0g4NYvhw1+
	 +aYNFMqRErYWiFylXmyKW2FOOdRB9p/sIZBX4hH2E1fM9iTbSjglDzIQhw1ul2kBJ15r1
	 buuR8yVJcOgoG6j2k5WgcB3P1WDeWsRdlf0Kc1i9liKEJC0cMP+p19ivH3xRg10jPY925
	 ureHE7l/YDox//kSPZp4+KeYSnVELxrzqB4iv/2pffJl22GhO0IiYsaaMKJrm2ybucIV0
	 qfG5oREDh/v+wr2nng+oFZWyIvtJI7fdXGLtSKuBJ3SNU1uZs/eI5bc1srbDGJ+450g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410618;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dcTKXulzRQhqk7SHUdDgxKTnOqSUNRHcerQerqP9It0=;
	b=b1Zaanecq9z9N5hlFXyTLvTYk+Bgq8TWwGkqMbk/6Td8Lx8WHYWWxbJv8EOt/lAHA2By
	 e/kixjzLO/kPA27rzhaSxOjyqZBYuMaY1X6unAP60yW05JvN/yERaiYAJLri2LoCrzTrK
	 uSLSkEuEHdxQjuDIjeSuEs/KTmlZYPGvlBjk6t5ThCbl5Noao67pJu9GghV5bZ5r7COYb
	 upzdUoxqOVCWFatJHKF8oiFyOXtNvIUmsnrihLyma8tFKvMXpB6/LW7AqEjdhV1YdGgJx
	 iHE37a5Bh4Ex44Xp6wQ9hyvhlNpuHHrRcDAxO6TjKhIoUVeZKzTgPhvV9ctKj2jseBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="i1VWQW/Q";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="GQD/TldO";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2330606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2330606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i1VWQW/Q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GQD/TldO
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN51OGb1333809
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dcTKXulzRQhqk7SHUdDgxKTnOqSUNRHcerQerqP9It0=; b=i1VWQW/QBB1gv1A8
	RKIwklZmxhkyOWOs8cD3B9huo+JZl9t4+nHGhd4M5waCSTsomMijeTRaTIxQgwL2
	PHSMb+DJ+ZkUWmUMAEfIk6bqA8r7suirhjMCGQoCJfjwt0yCi5dIwF2PLrn4QiWX
	PNM0Ln+DKiXOdxRcTlkj0b2HXBunuTGDEL2+r3PY2q+U9Gu4sQ8DGz7IxDhEj/X9
	3XDWjA/C0mKXyF0nVeplx/Gis8kEBDbTXgEBn2JwWgZjPZkUexJH9RBWeqhNfPiw
	qGbnQn+LQyrgCGIOWqdw7a74ffYpNMwW/Yuq3LQurRjIXmHvG7VjFhFWuzo3PtfD
	3rOz3Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j33cu57rq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:10:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b3f3e256e8so2878612a91.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 21:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795410616; x=1796015416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcTKXulzRQhqk7SHUdDgxKTnOqSUNRHcerQerqP9It0=;
        b=GQD/TldO7irpuOVoV+abuYYVJNO+zzMhyKjO3MkcAVnMexlGFNwQ9IMSWjeJAoiOJS
         S6tSOarR/xP5K8C9vx3bAI1r3UMYa6TNYDR93BKHTD+G1ZUV+c/xZmLCDX5A4DWX8VUp
         yipI0A1TL+O7pDFys96UCfqJPAntYbOleRiD3wJ7lOC0D33QQ4tFXEniRYXn4cAbZytl
         aFwv1PT+LX65Ckjs12NUjRP54GVlhQrqcI7uKzMA4c+2svuyhmYBKjMTZ2y4SgLrg3Sz
         D6gFPvag51NF8CgMGyhRyo0uCQIWKE1S499FIVz8t/kuEgeDSQOSLv73jrEO4/b3bRsF
         PDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795410616; x=1796015416;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dcTKXulzRQhqk7SHUdDgxKTnOqSUNRHcerQerqP9It0=;
        b=lG6QEIdDjDVansF4riA3Hix6/joyul4BYZuQZqcN1Y5b3RiHarb4yD4g4/BbcBofls
         JNpgujsD1Rlhwc40x0wZYBZUBHv4v7/gnd6XpSM+L9B41PVmwqdB+Ypq+yuizxHapIT1
         lJqw3B8w5P5Fo+va59toXmaf095W1FTXlXPSRW2cCBWLBfhj33gCSRSt+GDYss6PXQrS
         MLyNRO9bWMhjiwJ3w5HKpKaIAbDLhr5gdV6geLVudrNyqVnzCu0sX8dkiJ0Hgd1m9chc
         1dJ2nU7ghgfpcE1l6FlQR9XIal4OS2AtmWjqk6t+naKTsqueOUBbC3gXQh79C/KvfvCc
         aOQA==
X-Forwarded-Encrypted: i=1; AL+hErGC/1HYqYixWfqrSoO4EMKeWLycTF65JYBv0TGbPMypxMmSNLich1hhibSx+pDzFyaDioBfbEQtZw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Xk+iBj7h3RxVx8bme7IF5tPNEujeHvjqYEghs0Jf/pbBO0B2S
	nOW/DHEPbnTvwnQ6jP2+IK7k8VL4ZQ2bphnt51I3dHbah/+/rYg5HKJyK7j0tiIkmNX4fQ0cPic
	JDpOKROPSgVK9pgwC5SYPJTB4zmIGBnXsEtLxDihFJ1jGCtrUxmfA3ZOGenRrbg==
X-Gm-Gg: AZFdTZe3avfKevYRKa+mEJsKGKH2R0Skwjm+qZZX2t+QyHB15MUbKtqalpd655B7fEb
	dwbK+TuPjyQYsAiuP6QCQVjLmseYJWJjI5Jz2CLT3SOIWPTddTdnhsdTDj2eBwOe7ZBSEImNst/
	BAd79rxGvPa++lTZRuH5zphLxRqsrvt5z0MyIJUPxU6ldIqvA54MjaJ7g69KtJwoVOkh5pcrR6n
	+bwC0Gfldnl0QX9ydBBZdbsQB1c6uqtHXnNrDusFOfRIUvZsi+Cf9N+vlaibKj2tUzOyoJNw8no
	5Y9c7FDhn4WNuW6pUOJ/KuZKqQOQAy4TN9AFlG8RIJ3m/Llm0M+v+J5w4ZlkxvF9TdjWyJGZdxr
	RRLIfFUw0zOoRNcDxRAuQuZVPuCJcOIkc87yrnBTh9KRm+997WIUlzjpc1rdHv7DEt3ml7MW+dJ
	5WIytymdtYgNZJhsEIut1XZphDVkcBm6efPyWNm/IfwqmH
X-Received: by 2002:a05:6a20:a108:b0:3ed:bfd2:7e36 with SMTP id adf61e73a8af0-4014bb52e75mr11192652637.29.1795410615662;
        Sun, 22 Nov 2026 21:10:15 -0800 (PST)
X-Received: by 2002:a05:6a20:a108:b0:3ed:bfd2:7e36 with SMTP id adf61e73a8af0-4014bb52e75mr11192629637.29.1795410615177;
        Sun, 22 Nov 2026 21:10:15 -0800 (PST)
Received: from [10.133.33.103] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e456a7sm4841567b3a.29.2026.11.22.21.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 21:10:14 -0800 (PST)
Message-ID: <07a533cc-80e4-44c5-89c9-8b94b0a255b2@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 13:10:09 +0800
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
Subject: Re: [PATCH v3 0/9] cpufreq: tegra194: add Tegra264 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bbasu@nvidia.com, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261119111217.902071-1-sumitg@nvidia.com>
 <2698e091-17e9-4a1d-acf1-19981ee604da@oss.qualcomm.com>
 <20261122-elfish-amusing-muskox-d6cdef@quoll>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261122-elfish-amusing-muskox-d6cdef@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XAclWvrCnzYVp-KsWi6OR3Th-sbnNUZ1
X-Proofpoint-ORIG-GUID: XAclWvrCnzYVp-KsWi6OR3Th-sbnNUZ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyMCBTYWx0ZWRfXyao05Gubjmrr
 g5YOXuebQfLyS2kZ5qmZ7qwsBMOtM7WCeSFz7hnVwfaLm18Ws7staJ9BsduaZxq0Rs8Xf0/LtGS
 bE5U2wvWSGTUpgaFyz7Js1j4fvW2OpPwHWj/Y1nLtQRveujc2lHqSlxhZbSb3YdiBYL4qQeuMvT
 v7RjP2tVYyw5RghZR0M3S92QnPCGyytjkmqqx0SlHl2L7+GmrEksWmQ7fdMkUKPDVnBV8IWZpiK
 XM2XQ/mAEOlreS54rElRurKWkVDfcbU2vKRgD99tVZZPvUm+DuOLk+4ufM37dztDPlhX7HwNBkb
 IYUKqMV9pch2VkI7iAIvhEFyOmaPOf2gTHlaQe9TyV3VlKJ8vKXwylwMxPycAyx4Las429P48V9
 dVV0Z9v3FC7S4DN0zvWHgIgLxapeMRL80RvIoqVSkVJetJO2nvlGcWDclK0vM39LDs6FbVK6RB+
 R/1fpyBBpTBCVJESYgg==
X-Authority-Analysis: v=2.4 cv=MM71C8Zl c=1 sm=1 tr=0 ts=6b03cab8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=K9XYs0MPe4wYk6c9fc0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyMCBTYWx0ZWRfXzLR25EeoXpRy
 Ky3C1A5PescpWANM2niHAG2BvdQamP3x1kHYlvlRpsPssdEkyHU6f96COKQ+VFEdue8zu8Mcdmq
 i+axEMUMfFPDUaOTEuZ01a8ztp+fGR4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230020

On 11/23/2026 12:53 AM, Krzysztof Kozlowski wrote:
> On Thu, Nov 19, 2026 at 07:41:34PM +0800, Zhongqiu Han wrote:
>> On 11/19/2026 7:12 PM, Sumit Gupta wrote:
>>> This series adds cpufreq support for Tegra264, which joins the SoCs
>>> already supported by the tegra194-cpufreq driver.
>>>
>>> Tegra264 keeps the existing model, where BPMP provides the NDIV limits.
>>> The driver derives the current frequency from the core clock and
>>> reference counters.
>>>
>>> The main differences are:
>>>    - Frequency read: through system registers, as on Tegra194, but from
>>>      the 64-bit architected AMU counters. The reference counter ticks at
>>>      the system counter rate (CNTFRQ).
>>>
>>>    - Frequency request: through MMIO, as on Tegra234. The driver writes
>>>      NDIV to a core_freq_req register in the CCPLEX register space. Each
>>>      register controls a clock shared by two single-CPU clusters, so both
>>>      CPUs form one cpufreq policy.
>>>
>>> The patches fall into four groups:
>>>    - Fix (patch 1): read each CPU's MPIDR from a CPU hotplug callback
>>>      instead of at probe. A CPU that is offline at probe then also gets
>>>      valid cluster and core IDs.
>>>
>>>    - Preparation (patches 2 to 5): cleanups, mostly of the counter code,
>>>      to make room for a 64-bit counter and for an MMIO mapping without
>>>      ACTMON counters.
>>>
>>>    - Improvement (patches 6 and 7): group CPUs by the generic
>>>      "performance-domains" property, which cluster-based grouping cannot
>>>      express on Tegra264. Device trees without it keep the existing
>>>      grouping.
>>>
>>>    - Tegra264 support (patches 8 and 9): the driver support, followed by
>>>      the device tree changes it relies on.
>>>
>>> v2[2] -> v3:
>>>    - Patch 8: read the AMU counters with interrupts disabled (Zhongqiu).
>>>    - Add Reviewed-by from Zhongqiu to patches 1-7 and 9.
>>
>> For patch 8/9:
>>
>> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> 
> Why you cannot respond to specific patch? Tags applied to cover letter
> work completely different!

Hi Krzysztof,

Thanks for pointing this out. I’ll reply to the individual patches with
the Reviewed-by tags in future reviews.


> 
> Best regards,
> Krzysztof
> 


-- 
Thx and BRs,
Zhongqiu Han
