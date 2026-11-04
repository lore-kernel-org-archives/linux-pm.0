Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806425;
	b=kTS2ejdmejtgJ6C/nmODY0XJPROUdo71j6tgQksLtt2gHPblTydXVHc8kjxvfvRzKmAw
	 WSFGZ3jYjnTxwwONMZjDUNzvLuAywWiURQwSl2Y0AvvlzhBJJn7lpT9drz5t8JJw/D40r
	 0hPJFE6rwmFF6LKTeeJeFMegrqjEszpQ9eVvsgZTk1jhaYliTVjr+NH7nsoPAwZ6qtsdv
	 nPw/a4D93Fs4zpyamuhgp6hqhSzalzvH/Iits0eYrQN/eOxyVCiaTFVWvwLb6BZF19MaS
	 9binv/5VrC3U2BilBOTfzQ39DDKfX5ybpAIacAqS54tjm6B99Mh8aIeHHfjvSTDf4IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806425;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Oc+EV5R5qicUTnDYhrGYR2No2F9ftwOjqvoIR/sc2KI=;
	b=kwfHadm6SziYJJT2m9P9hwx9jwJR0kNBQFRc3hO/TL0UcJEKsggiXJFXyvihMLuAfSjj
	 cMDcdKrOkvt2HN0e2M8JRwLbJ4RdLuImPv8bImZKPMUUX8Ghyir62j7UFT2WnoAoxQSsB
	 tdlBLUeTURoiQw4L+OSuA1EdJ4GkW4YjIm1H1Ml5JkppmEIUTpkb4lGHwk3FL9Orn2ye3
	 kvzbILsoTIKoPFtyBm7x014EDCOICbcG6mUVm1Q/F4toYnEbiBt8vB6HgurOyKE1dRh1K
	 P+/x+BlaExxEzAutS9RrbAmM1OGglY7YuhJQBRiJ677RpgtJ4l5xdWWzaOCtZoZtz7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n5lDlPE1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AdNqXRki;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735E606A329
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 15:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6735E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n5lDlPE1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AdNqXRki
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BZurm119370
	for <linux-pm@vger.kernel.org>; Wed, 4 Nov 2026 15:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Oc+EV5R5qicUTnDYhrGYR2No2F9ftwOjqvoIR/sc2KI=; b=n5lDlPE1Uf7O6RF6
	4aa5Gvgir9U27o1EbZODmoUwDgwjOWiv5/ppwo6knHP4Vb9nxIjcgla/YcjcmzgN
	dDZRaKgUUUioKyYZhYZpvPrFve1FhHOhXv8XUV9GW78Y/fZ9x5+ArmWJ1Bw9ljT0
	mN7vyXaR2qJwjTrXUK0zXvq7d6UFeT6DM3vH6ZIHD4k2ArykiVWhcRd0ZJIflV+X
	jX/SkjczYp89DQ7rwA2/YAMK99u0ltVdXBRSDTDAusYMP4nxtRy9UpaCnQlLZ9B0
	nhuvFMGu1/gVjUT2ek2uOejjr3mo65yrl0G8O5I24084agccrSdLaxIDPuyRe2ql
	G2aduA==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqwb0anmb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 15:33:44 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-46a5954cdfcso812492fac.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 07:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793806424; x=1794411224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oc+EV5R5qicUTnDYhrGYR2No2F9ftwOjqvoIR/sc2KI=;
        b=AdNqXRkiMfDwId68bO+bfVDeeCQG1h3ebhnQzScYGZ7xelaC2/RLLSt0T5K2wTua0v
         eXhnOJPJyQJ3faAkV0sx75gGppi4zq1ylpfrXYoVyUMSCfTptyjD71jC37Ai7uxcryC8
         UXboldzNzuZCtx7oNyk1Ch/zVN1TjLRxS018wfscC7Wz9ripAxqulhBUkSj6XTbKqQ9u
         kiiSA2+YpXPfs9u0MlCdjKsSWvMVDcvWLoBaSgL4AeT9GtlcYgl2vtK7DjcVVKgtEyy8
         XPUi9TrBLY6r+NdcPV+mU6tWN3+lrbdTLOEdDeq5xVoWn5fzcbmo6y6wQgdoTi+hrjf1
         rFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806424; x=1794411224;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oc+EV5R5qicUTnDYhrGYR2No2F9ftwOjqvoIR/sc2KI=;
        b=i0AaeLA7AghEZxVNVB/jTVmOrbTn45BSQlRycPdlV/i16XSV6STuD4nt1GZu8GyywS
         TY5txM0n62ABDeVTT9axn5N13QpjwmD3ny9S7nmCVoiDiFKI7Skj/Toe/EDlJiUlTC54
         7U9rhCD63U90lujahQtl/UqmrQba60l+yVNTq1ASBPvGOAH8XOL20KN3mr+IwFq9X5VV
         kZPDvRU2Qc2PihsroW9d3+lyhI1h8jL0+Td20O+I4Hy7rhT5VU3eDhI8kzOshEpN7e95
         ObaXI6gwVUjpHdZGPhwRv1SGHHvqdEVgMta7RPGGRW8pDWzMaKj0LeKtzq5XTWGaaFsi
         f7QQ==
X-Forwarded-Encrypted: i=1; AKwUvBxR7w92iGXwLdd5626Fxq0stdAa5v3+ClPA33bIYxZ4w6nqbqgFWiquLUsOz9Wiz3k/3b4W77gzBg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+HkDV90V/m7MOPp6LAne+HcKu8LDvrflREzc2D/XMwbtl94cjN
	PlHlC2h9UL7DJckhZOVlIWNE5lzFfIPHa/bwfNpQo8fhz/FNdl6XTogAvV+XuklLYgcYSFCYbEq
	GUSdkjNuGlQudAgf3EtAXqg1cmlOXZJQbyQDJtVoyzA2x5Q7Up6lTWlrsFOHp7g==
X-Gm-Gg: AYBFou3+SoLeqWowNINYeF4k8LmwqZh0YZEb8YGv/UiviZhWUv2rb/2cQqtSW5fZEt0
	DnxNqeJJX48kGR1xC3ALt8KRzauGeEyD9Y/bSHG326O7Ekatpw5odlA+vxGaMphGdgz26U9ioaM
	fC7ZOAUQxMNp8P7ERjxeEcMxXVKN5ui3ZFRZ6ONFSiSEtt55aUpyzWbCulGCndJs4SmlCpJtX5O
	bkfc9XgKTKnwkULMbIN0UQLZnYdbz3xfdL9Tl6VG4TRzCJiHrMGYkvuVf1bRVOewSIL2j0OhnAF
	pLb+34yY5KJmlLAXn6+FoFxpYIoLYEwFOjyUSk19xyCK068TcIoKNjSxGZn4prVazoThZrKwOFG
	ea6JU/rCWSicQk/DTPC/wYZt78Ihf/PXzClBV0V/ebB1vKkHmIO/Q9+Rtjqydy6Ftx6k=
X-Received: by 2002:a05:6808:1996:b0:4f5:c4b9:dc14 with SMTP id 5614622812f47-5640dcb744cmr12375081b6e.13.1793806423727;
        Wed, 04 Nov 2026 07:33:43 -0800 (PST)
X-Received: by 2002:a05:6808:1996:b0:4f5:c4b9:dc14 with SMTP id 5614622812f47-5640dcb744cmr12375050b6e.13.1793806423309;
        Wed, 04 Nov 2026 07:33:43 -0800 (PST)
Received: from [172.20.4.37] ([192.210.17.203])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm1961627b6e.11.2026.11.04.07.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 07:33:42 -0800 (PST)
Message-ID: <98d01186-7d87-459e-8c18-db201baef34a@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 16:33:40 +0100
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
Subject: Re: [PATCH 0/2] thermal/drivers/qcom/tsens: Drop __init from the
 ->init callbacks
To: Christian Schmidbauer <opensource@grische.xyz>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261104145740.2623473-1-opensource@grische.xyz>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261104145740.2623473-1-opensource@grische.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MSBTYWx0ZWRfX0wOqMg1gOjnD
 VRmjEu2lclVJs0lmvRrqicioE4NGNNED3UiZ5jH657yYMAo8rV00BrNXWzfclBAYx2Pq1czu5u+
 Mp8KYdBmBRw3uc+m3yXxsarCyoNg8bs=
X-Authority-Analysis: v=2.4 cv=OfINnRTY c=1 sm=1 tr=0 ts=6aeb5058 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=3CSVYe8HblTQFsWiJzwA3g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7I9-Nl3zapt3FfmOfCcA:9 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-GUID: RGCBz8slspthPC8-GWN7aSTkfY2Qbj2J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MSBTYWx0ZWRfX7++4Lc9LiZfW
 ca+Wjb4hbfvb4B6hokjYdxoPth7NhE2wVXW/manAX2+CETMezsjf/3+MoTQqjGwd5RhSwKMHwID
 4YeSSgcceR0zwCZy1LRNryVMXkkWizDV9i0Pl6j+uYqJVblcDp/t9s5nlKKh3pmlYftoNzCJh8A
 rZcTb82wfhIrJeJS3QhbZQAJ1otg/V/RTRry5RLN6qkBm8yVXaKv4uSi8a7GUXDOoSX1eGNOQtM
 5Dj50ZFj1K+P5E8mco/tgWHUFirFouKeeU5703NvZLV9TC3M34pBZ4LkX/lFuYclVJWxzQgLqzY
 EDeGpRg6kVnQLykFIR7n360ith7Cz2rAGMbzpNaNOpdy7rjCiCbMNkpHw22uQIDrx598JIe9JiK
 AUW8r76o4txUQm+V81pqrrT38BxqpTfi6pUSAwrWTM1/OMuLXRjyV5q464TkeDpCrTegkrVRxVY
 wxlsM/JPIXgr6tQPIjw==
X-Proofpoint-ORIG-GUID: RGCBz8slspthPC8-GWN7aSTkfY2Qbj2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040061


Hi Christian,

I don't see the patches along with the cover letter


On 11/4/26 15:57, Christian Schmidbauer wrote:
> Every function that tsens_probe() calls through priv->ops->init() is
> marked __init, so a probe after free_initmem() jumps into freed memory.
> On IPQ8064 with CONFIG_IPQ_LCC_806X disabled, fw_devlink defers the
> probe of gcc and its tsens child until the deferred probe timeout,
> which expires after init memory is freed.  On an Aruba AP-325 the probe
> then crashes in init_common().  With CONFIG_QCOM_TSENS=m the driver has
> the same problem once the module's init function has returned.
> 
> Patch 1 drops __init from init_common() in a one-line change that
> applies to every stable tree.  Patch 2 drops it from the eight per-SoC
> callbacks.
> 
> Patch 1 was tested on an Aruba AP-325 on a v7.2-rc7 based tree.
> 
> Not tested:
> - Patch 2 on hardware.  None of msm8226, msm8909, msm8939, msm8952,
>    msm8956, mdm9607, ipq5018, ipq5332 or ipq5424 was available, so patch
>    2 is only compile-tested.
> - CONFIG_QCOM_TSENS=m on hardware.
> 
> Christian Schmidbauer (2):
>    thermal/drivers/qcom/tsens: Drop __init from init_common()
>    thermal/drivers/qcom/tsens: Drop __init from the per-SoC ->init
>      callbacks
> 
>   drivers/thermal/qcom/tsens-v0_1.c | 9 +++++----
>   drivers/thermal/qcom/tsens-v1.c   | 7 ++++---
>   drivers/thermal/qcom/tsens-v2.c   | 2 +-
>   drivers/thermal/qcom/tsens.c      | 2 +-
>   4 files changed, 11 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 2dc1f296b5754dd2441fc8b6613a362a47f6b98f

