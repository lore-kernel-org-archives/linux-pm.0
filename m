Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551192;
	b=pmve4OL7P/l0VVEdUQCbySwtkSEJX5gMNpH7M1Kf3hS8rzeaOAG9KDuEcjrYjL991ZxM
	 pHvS+EBaU1FWt4BOv6CoEu3eC+w9N+FbNjS/bTTxFwJ/ckq4OgGSrjEniQz6ksKfNh+GL
	 5rkUFlGwgYc4MYuNskP0IWboXPJHNsgYe+l17SXWkI94dYuaH/enRWyJgSIvan/dbnqmu
	 DkT1IvHkBV9H1qtRnlAmueHpZEJMreNHPE5ALE0LdfJrzpd7OgEv6y+MDA2QPEE0Ad90k
	 YV865ojgY/UVkvt3NGEKNTYmWbudqro0pLsIYgQ6AMU1/u8sl2+wK5u/DSp/MQhjUVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551192;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=itr4hIklB4kc7LTeKoS1h6ZFX1PCmH/V8dMF2IRMWzE=;
	b=w0VYTEY0H4jxoWndiB+uuV4AniOTV3RVr+jmKjMgzZLQse4toB37YGyymXAxaH6PTm8G
	 jt/CWJLsc0sLWxbIcOL0joskyLMV749tSdLb4kEXCA368mDI7xXe4qrqwdcTNkP9/19qA
	 R0uYLvaz2gT9PSolpx4xykUfLRtSYGQz/jzKx/Nj6MzRE6HVH6Yg9L9/QwX7gbCdfwps/
	 yp5OE66C65n3kc/Mkh3ZLXpiEtAeGssG8d46Efksj39Ctr6twn7yn5S7hr2gdHTY0r/9E
	 TK7mO9CicpDz58np/Ehi/wihk3sYhVhHbPCgAEMgbyLc11SJNoVdN8fA0vnBQTle0gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S+mc+OJR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jAUyyfEF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CDD606A321
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 06:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70CDD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S+mc+OJR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jAUyyfEF
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD576u5073410
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 06:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	itr4hIklB4kc7LTeKoS1h6ZFX1PCmH/V8dMF2IRMWzE=; b=S+mc+OJR8Tza8cqE
	ttsLlcZhQsGIaUb+Vb53f0GPoESZhh6D1X2ihb9qGoxj7mZdJSejtEfiCYGx04Yy
	03U3LRrJPi4wZ/D5HqaDWVYn4p89m7WQ/Ax0vzjhyxNuny2wBDnW+GQh1smHyrgE
	j+lSOVX6VinapGZ7cvgyV90LePfTGE8/eqffQ9wThHuCHuhrVNW5kccRFDAnrS4M
	hXucLCr4gGxP/eBpc0lqiEGumbhU4lOO0EnAUXXLDiHd/LPwMj5uPBG7TiIk+UIa
	gMq7j1Nw9gzcunbqq8QlAoiuM8E/Il7cLCsrgevEO7ffxgqIbgW6Ckt9p68HvtoS
	t0vIaQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs03t3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 06:26:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae19907a31so623086a91.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 22:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794551190; x=1795155990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=itr4hIklB4kc7LTeKoS1h6ZFX1PCmH/V8dMF2IRMWzE=;
        b=jAUyyfEFe/Hu6xdj5D9L6vAvDzpPZYJfZsba1u4EYZ1ZNa0iVGlICFzJJDGNeGz216
         VDS2TrQDdnib+8crRK7TsPuyPqZ6gM9O5JewtVipBYerRvQY6apj+9VvHmrYmDGw7Njh
         +pF3ccrAz22naOd2KElVxF2hSz+W15oy8/N8eCJ9XZsniMuLvlSQM/G9Xd2vjk8DuqCy
         DkXxASwrg8XA28X+CJJnwKQjHdRXd/dGjoJjIGdOJ/MZx4X5ak2LZqqt4brwQJwVDpML
         ZX579KQqR8oLCgMuwnuXftDlcN/3Er2Q7hAelJbMc69z+yODHOGBtf0/0cBLiMzH+Qh4
         hEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551190; x=1795155990;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itr4hIklB4kc7LTeKoS1h6ZFX1PCmH/V8dMF2IRMWzE=;
        b=AhQq3V3Rv+36c+HhE5jXhzHQ/i92T56Y+A3ye3UnKrUys48DJkBIrNAayoKeRJW/MX
         QO+j1O0BjaD/kzLVOxs8VOpjK8RQoQCfOLbwvuQoKHrpKZXUKjURa32ft6ruT+Z3/d8M
         5gLpTQyg0/OA9x5YPGapQ9Wy772e2ozydqOwCx2XCVeRVRShU+rS60rPDI3oke0zeYaz
         ho50WB8nPbBFRe3R8UKQ2MNLIkBg57IQgXOZuLS2CnTkY0MYyVCHgOAyb7ftGaNlQ9z2
         k5uPTbjrVO0mdQpeoPdeInTg6VG4HJo512K6Y2MHSeRSJFgsp/Z1F2HnYsXlXjdvICQO
         MrZA==
X-Forwarded-Encrypted: i=1; AL+hErE3nouac/uOHxliQ7efLVBV0tojWQOzkXPtG+cGE5Lv4VQnID1nJX8FaEJHsJpuMGlGKNuWVljiZg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8oXGVtMGuGn64c8aCcA2GWu4/wh0ghT3ndertl92yprTXjyVfe
	HtIVS5nUf5px6rWkioSJCTbpt2Mxap9z9IyFYo5XU/9Bm6ubT2JLklX/3Jkml0HEH0OrfzZIy93
	x5AHLbImihkXHLFtw3EBf+8S6bXKY3onBXs8r9FImGCnTL1dN8mg0RiDfUf970g==
X-Gm-Gg: AYBFou0qX1enex9mGo8os/mADFghxVnL4mdhyX8z2gWDbn5lJqr86RaMfz4SyIep2Hs
	BpGNG6paraitoo1ci7J/qzpBJKPm2+DrsON9S+JBWjL9+wBS21Hn0xFEq8gzys1aqIO8R3q7dGa
	DElDXCqYi+pGfIscaGqxCcWrRR5h2KxxugYCedVVS6CogyeXw84M6Eq/v/hi9Pt+yAOlWnxea0S
	zg8HdZ/RiyaAH364YjyRczOFOkU7fBlYykyW8kolB6M4D4GCWLdEcyxkE51L796GHGLgJu6cVK7
	7g4Sp0XTihS8yda0A9vBqrV+kRYvRnSTCYYOdYmdOt9P7zyWTvFxR5mODlkQmQZyDeLLjh8R7LT
	hY5CULHuhMJnXabTG3/uAXdGQIzuEWjzFoMIS4ClwLs/KVjz1CdUfLvwDNVJKiWN9SJk/vkFtSJ
	aHTGKSswMe3tWBgeTrOJ+yLzzGGVRiPmG7JwGlaQn9mrLWEQ==
X-Received: by 2002:a17:90b:54c5:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3b1b087b75emr858166a91.3.1794551190124;
        Thu, 12 Nov 2026 22:26:30 -0800 (PST)
X-Received: by 2002:a17:90b:54c5:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3b1b087b75emr858146a91.3.1794551189608;
        Thu, 12 Nov 2026 22:26:29 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae981c55sm2933013a91.1.2026.11.12.22.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 22:26:27 -0800 (PST)
Message-ID: <904f7ac1-d488-4700-8839-ae981b04a71b@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 14:26:22 +0800
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
Subject: Re: [PATCH 0/9] cpufreq: tegra194: add Tegra264 support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: bbasu@nvidia.com, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261104181521.3003578-1-sumitg@nvidia.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261104181521.3003578-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAyNSBTYWx0ZWRfX1TDNxdiQUliK
 UhiwUn6UuRbxhqF3ArHnxjhE8PI77sjOBtRZyl6yKgj4KSnF+7uqO2WxqDmkyZmknIIuRXl5zpn
 xulasXDsJSq0vdBXY3OF08parQ+vCkv6GQFyA0W9c57c9KAjTM3T13TDlD14pjs3tOEHFG2KuSh
 jxtWekWFZjG4FPePAb6JYGFiHsu0x+jLHhTYeLn/Fy/ylF5xR5UT5n3G8AyxEiYOrZPq5Rp7Vcm
 lq6wuepFKNpMF8fntj49WC4p5dN/QxHltFw+rdWTGV8MdZFWM79xn7Fp62xcqksji6immIQcH+a
 ZwYRUnc3WRnN2lHKLKV0YqWeoqnd0QWs6jMgO3znXVeTkOzG1bmtJSLmO6lJCOGTIZlu4BFlkWX
 0q4SmM7mKcLBu7+sN527MMxW22nsGWo/ExnAaVSAKPTl19V1NbRXDECeLA87RWl0f5O0WfNde/H
 cXZ3Rn6hO6smk61jeog==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af6ad97 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=I7BNmAFbTgjmseqQuzQA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAyNSBTYWx0ZWRfXyNtjqJuf4pVc
 fsZMP0ZFFMGyljV/L77lZxjWTJhXJQtK1BeCt1XGbbUOUuQrp+DPJRyOanEZx4xzqU3woz5pif7
 HxvajlhY8bxRD8J8rqOVT+ZDBc4Fxow=
X-Proofpoint-GUID: rx2u2qd2gap8GipX9BjhhNi3SQhRifCX
X-Proofpoint-ORIG-GUID: rx2u2qd2gap8GipX9BjhhNi3SQhRifCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130025

Hi Sumit,

On 11/5/2026 2:15 AM, Sumit Gupta wrote:
> This series adds cpufreq support for Tegra264, which joins the SoCs
> already supported by the tegra194-cpufreq driver.
> 
> Tegra264 keeps the existing model, where BPMP provides the NDIV limits.
> The driver derives the current frequency from the core clock and
> reference counters.
> 
> The main differences are:
>   - Frequency read: through system registers, as on Tegra194, but from
>     the 64-bit architected AMU counters. The reference counter ticks at
>     the system counter rate (CNTFRQ).
> 
>   - Frequency request: through MMIO, as on Tegra234. The driver writes
>     NDIV to a core_freq_req register in the CCPLEX register space. Each
>     register controls a cluster-clock unit shared by two single-CPU
>     clusters, so both CPUs form one cpufreq policy.
> 
> The patches fall into four groups:
>   - Fix (patch 1): read each CPU's MPIDR from a CPU-hotplug callback
>     instead of at probe. A CPU that is offline at probe then also gets
>     valid cluster and core IDs.
> 
>   - Preparation (patches 2 to 5): cleanups, mostly of the counter code,
>     to make room for a 64-bit counter and for an MMIO mapping without
>     ACTMON counters.
> 
>   - Improvement (patches 6 and 7): group CPUs by the generic
>     "performance-domains" property, which cluster-based grouping cannot
>     express on Tegra264. Device trees without it keep the existing
>     grouping.
> 
>   - Tegra264 support (patches 8 and 9): the driver support, followed by
>     the device tree changes it relies on.
> 
> Patch 9 depends on "arm64: tegra: Fix address translation on Tegra264"
> from Thierry's series [1]. Without it, the ccplex@30000000 node does not
> translate to the CCPLEX registers.
> 

I have some inline comments. Please take a look.

Sashiko also has some feedback that may be worth checking:

https://sashiko.dev/#/patchset/20261104181521.3003578-1-sumitg%40nvidia.com


P1 and P8 don't apply on v7.4-rc2 / linux-next due to 4dd10fbbeb9c
(devm_kmalloc_obj conversion). Could you rebase?


> 
> Sumit Gupta (9):
>    cpufreq: tegra194: move MPIDR read to CPU hotplug callback
>    cpufreq: tegra194: remove duplicate counter sampling loops
>    cpufreq: tegra194: add tegra_counter_delta helper
>    cpufreq: tegra194: add per-SoC counter mask
>    cpufreq: tegra194: split MMIO mapping from ACTMON offset
>    dt-bindings: arm: nvidia: Document the Tegra264 CCPLEX cluster
>    cpufreq: tegra194: derive frequency domain from device tree
>    cpufreq: tegra194: Add support for Tegra264
>    arm64: tegra: Add CCPLEX cluster node for Tegra264
> 
>   .../tegra/nvidia,tegra-ccplex-cluster.yaml    |  27 +-
>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      |  21 +
>   drivers/cpufreq/Kconfig.arm                   |   4 +-
>   drivers/cpufreq/tegra194-cpufreq.c            | 422 +++++++++++++-----
>   4 files changed, 357 insertions(+), 117 deletions(-)
> 
> [1] https://lore.kernel.org/linux-tegra/20261030141101.845044-1-thierry.reding@kernel.org/
> 


-- 
Thx and BRs,
Zhongqiu Han
