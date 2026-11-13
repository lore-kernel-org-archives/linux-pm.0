Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551231;
	b=U3DtMpy38cdsmN8TJkoxwpDkdBpQpxyjvX/QuGXNiClTUqMGCOip+Dw+hilLaMfyC+BD
	 ehfR3/MfPg/01qql1vq80hoRpB/l4YKt+E65E5R15PiCG3nO6E6V2nVGnG+Rj6KIvzLZK
	 aFlNDGiKC9yx5AOZ0r8yBlD7fhq+0o5VrNHbBFmO2kSKNvIFl2us7+xPvcH4LEQ90eaDj
	 /TGGt0nMtjFEWrrshp1KBhEf8spPsJdmP/oWjHqKePQ6vnvPs3Oie9uWoBfgbQd7XlAJP
	 6KJBvN87qX6f+fb45TjO8K8pOqJQJWp5btbKa0Zr2hGtEkdkbvJKzSegs4oSqOS6hrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551231;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AlgFrUiA3pOQ3uGH57qpKKGg8XjQji+BQGfvlCSkshY=;
	b=SEtRBuo+XqNKxrWFU1+nv7DZV7KejhF1278foS1EWGCwVUlzxYqbr0051AeI2VvzVdMF
	 p5ZVWT/MQO5EIKpFKv6yhf21kU0sCQDggeyCwc01pu1e4SYR4TpBA4S9BWr+TdkVuQdsS
	 BqNqin4X4+twGw/A7ExEsm/DzQRKmyOlawOUZJ9WuevtqtDkObKeiKjH1a/zD/mTIBv2E
	 U4Y+GwY6wnNByJe3/2jcXk8YqTJwLo5iEh/wBd3NdgPur0JHoWmGg1Bb6nKld15g9PSJ2
	 XyW7dlpOkIaPWPRWR977P7SCOS3u3onqcbgbsStE+M3yi9+jpirdFfS3a2+Mhbk7eVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lmzINXMx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S31CyudU;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D394606A323
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 06:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D394606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lmzINXMx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S31CyudU
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD56vUC3556917
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 06:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AlgFrUiA3pOQ3uGH57qpKKGg8XjQji+BQGfvlCSkshY=; b=lmzINXMx0AmdeTqv
	TQv9Bx+8GBJzu9iAlM0skxs+1qq7+LEWCvOlL9ykD9RmL9sEo88/DP/5joFs9ezE
	wXbs87mfKQ5JpbFSKE4ELeIeof2IcuaehYkckVnbC3nF4sPEVNIVd0bEwWCVoIBI
	7/0fLqsKf3vpSBqtStS3IRHdZXutEvfRE7fAjIym6CGbP4Je47MEWwMaTZdj+YTq
	KCNdoVR57RcLaiPxN0reGKPCYfyTiONNM3wqMDlc04eqMLjPutJ4r6YQtG3lA0Do
	PJwG5mDB9N2x2EJbNsvKyF8M+IFhr5OAf1KnQLGF41US7z2XcaaNz1PhUDjfz80i
	YSO13A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkfdhwqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 06:27:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so452489a91.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 22:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794551230; x=1795156030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AlgFrUiA3pOQ3uGH57qpKKGg8XjQji+BQGfvlCSkshY=;
        b=S31CyudU2BtYAHssNXbWU6WfJ4C5edX1FTBwws9xvxNe3ULba2pgGnmKF95DzzsHtw
         sFCC9r3wO51xRww2KYcYGE1cwlU0wQ48qS4Gd1cWwqUmCbq6mW63UGLXWmG1Y2MyyMUr
         5kFOyRtSG0d3jUIET0w/qSTvYzonTB8Sj/IC2oDFSGf8xu1PwI5KpgIs5a1irkBgz/2V
         kyxLQ4TTOFm06/7Idjue7/cUbd3eyVYyoRFiHX2BIK89PvTp3bcjLbyXzI3Kt/HStjm/
         nD4FktwT0NxlnbX+h53YKS+BqSCQAMqJUpgb5T8U9Uqafg3wYpE1pmHg5ufOnwzH1c4F
         Wyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551230; x=1795156030;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AlgFrUiA3pOQ3uGH57qpKKGg8XjQji+BQGfvlCSkshY=;
        b=wiX7s/r4xco+wVFivXzseDmu19fRGAHbjM+Ql6rcDRK2hZWrsvnPK2Ys7otWujAAYt
         /A9cEh0AamuFQ9auDrsPQCml+jFp626sfXYKhgi2DeoWcEY53HU/n977kxKGmeHF37C5
         NtNHKXTrAIC21yw79CJo8ih/dyBwwS+xP8QSSglDK/uR1wwUL7j7qC0aF2lKgM+YuSWk
         tBv1EqPNxQ6JECzsNkKjRk4XTcLjcpzzg3iYALElQOVa3h7h04jxTf5UhR6mzICea2p3
         q0qq2p6tEGaqyrGlJk/6Kzrz+bYbcrA2hGaKWC8Y7N13cnRAoxZAXMG+4gvXr8fW/KJv
         KJYw==
X-Forwarded-Encrypted: i=1; AL+hErEzDB5FqyY8OZRnOLzqJIk9zKlmTFqDD9Fixw6FMwH/fDZ/wklwcvNXUVOelALbIqk2lwaFtbC4ZQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+QVxR2JfwnhwggbqkrnUbPtNn9iiJtmJWw/bpRUOD9CeiQNqgM
	bd74giG0x/1unjl0wljhm3YjvRpayGWkFjIbzDMzC8nqSg2Sb6TqMkv/hM3fTYPtgiypr3LO4R4
	L+4/dcJ90PfF02ygNhPnHVEMtzd/m/QMeuGcYS4TLhjRfIhlOMxIqEM8anwngVg==
X-Gm-Gg: AYBFou1TyjEkT6XgMpU3lxi0Je8grQT1wsKs+LW4IYJUXD3sw/Jzs0e+VuiGsNRnLs3
	AIVfFP32T/ykahDbgrN3n5y6se+FquuN+wgEMLnA3Vx/Xs8E981lx1TQDz9hSvfmud0Epmxd6um
	97AM7cyOqGqepG2RnsFDb8DbJ/RcA0E2C7xtQbjA7ORTvosi1K8c/CQjS+K6yAdtHjUGwVhdPsK
	GnOMXXP8xtCA2aXNS/7EX/NTgttFUcHfaZabsCm1yEmqpcnydszGSgLI6WgaqgjAxKB5cxF6gGJ
	gHwvGWBsSWGNyyhX9cg04V2t4N1JqWAJL0NU2cnTc+/PWYhWkeg1iZhN51xk6Fo8RSNFbxWMna8
	wnnbNo4/4U1GzwWRZy7wxNbKUmq2RErQYqCulsWtCgq75hWRWivKZKN0wtGd9/JnOyk0GCTmd+u
	Jw5oYQeLzZyHwd13OXCuDdosr7Z1JtAhASUceMbVAwSR0q
X-Received: by 2002:a17:90b:5647:b0:3ac:b2e6:3181 with SMTP id 98e67ed59e1d1-3b1b0a0eafbmr1304916a91.37.1794551229559;
        Thu, 12 Nov 2026 22:27:09 -0800 (PST)
X-Received: by 2002:a17:90b:5647:b0:3ac:b2e6:3181 with SMTP id 98e67ed59e1d1-3b1b0a0eafbmr1304887a91.37.1794551229084;
        Thu, 12 Nov 2026 22:27:09 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b24938bdsm1066615a91.1.2026.11.12.22.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 22:27:07 -0800 (PST)
Message-ID: <b3125fa1-6a7a-4f87-a7fa-64c42f6b98e2@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 14:27:02 +0800
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
Subject: Re: [PATCH 1/9] cpufreq: tegra194: move MPIDR read to CPU hotplug
 callback
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: bbasu@nvidia.com, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261104181521.3003578-1-sumitg@nvidia.com>
 <20261104181521.3003578-2-sumitg@nvidia.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261104181521.3003578-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAyNSBTYWx0ZWRfX0Aw0DXrgvGYT
 Gmd5ZVOZLcsUWLn2L1DmRiUu+WRIBs4nu9x593Hnkw8IgQHwP7efYzHOqX5veJ3x3xCBBxLyeL4
 riPuzV4Zgyl2db3FNhVZH1cqGKlcZJ4=
X-Proofpoint-ORIG-GUID: c2c9hrZnrN_6VCH_maALbYh-4koecfeM
X-Authority-Analysis: v=2.4 cv=DoTDa2/+ c=1 sm=1 tr=0 ts=6af6adbe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Ikd4Dj_1AAAA:8 a=YW4SVfrvFGduW5-3T3kA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAyNSBTYWx0ZWRfXwFn+Qb+JI2uc
 BgxooS6LgWGuKvkZUig2gaSLZ6Zrpyvr58ZiTNoqDFJTkErbuj2dO/zR+LhVuPaCkA7ZXov+zTY
 b671lnBOgw77eO8H9t2tJ8w8h6bm48XWBDUC0jL+SUTKTCqeKyz6nlaOhhnXO2a/RUQ4O79Ky6v
 IEtfZRQZhC/EWciHmRCIKrsb6GQHo0n+4nnZr6ezpBcauOI9jOO3LZaUrIqkFA1xSD61wdnm3ue
 CDNYMjS4iNd1Ew3caAqjnK7XRV+JbtS2DazU2e7DUdbZqKtRrEvUSOr2NEF4VUMci4zxMqLIzvd
 ZA4JEUvsXSUeBKxIkNN2AVvzQpHlPPZstTHQn80i5a4dAgjDdQy6QXLNOtv1BpQQKVqfHJleyZg
 csaKoRS7WEd2joR8OZ8z2oM/QTC3YuYl/kYpNeIaARNIRHW7yBy7Db/YUz84dX7CabVYHAZtC3C
 13pGFYxl8blNkHYlWyg==
X-Proofpoint-GUID: c2c9hrZnrN_6VCH_maALbYh-4koecfeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130025

On 11/5/2026 2:15 AM, Sumit Gupta wrote:
> At probe the driver reads the MPIDR of every possible CPU with
> smp_call_function_single(). For a CPU that is offline at boot, the call
> fails and the error is ignored, so the CPU's core and cluster IDs come
> from an uninitialised variable.
> 
> Read MPIDR from a CPU-hotplug online callback instead, which runs on the
> target CPU and caches its core and cluster IDs and MMIO scratch address.
> This covers CPUs online at probe and CPUs onlined later.
> 
> The check that the SoC data covers all CPUs moves to probe, against
> nr_cpu_ids. A CPU whose MPIDR does not fit the SoC data gets no scratch
> address, and its NDIV access is skipped.
> 
> Fixes: 6b121b4cf7e1 ("cpufreq: tegra194: save CPU data to avoid repeated SMP calls")
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   drivers/cpufreq/tegra194-cpufreq.c | 114 ++++++++++++++++++++---------
>   1 file changed, 79 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index 1eb96e9f3310..be81ffd23edd 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/cpu.h>
>   #include <linux/cpufreq.h>
> +#include <linux/cpuhotplug.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> @@ -13,7 +14,7 @@
>   #include <linux/slab.h>
>   #include <linux/units.h>
>   
> -#include <asm/smp_plat.h>
> +#include <asm/cputype.h>
>   
>   #include <soc/tegra/bpmp.h>
>   #include <soc/tegra/bpmp-abi.h>
> @@ -77,6 +78,8 @@ struct tegra194_cpufreq_data {
>   	const struct tegra_cpufreq_soc *soc;
>   	bool icc_dram_bw_scaling;
>   	struct tegra_cpu_data *cpu_data;
> +	enum cpuhp_state cpuhp_state;
> +	struct hlist_node cpuhp_node;
>   };
>   
>   static struct workqueue_struct *read_counters_wq;
> @@ -113,7 +116,7 @@ static void tegra234_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
>   {
>   	u64 mpidr;
>   
> -	smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
> +	tegra_get_cpu_mpidr(&mpidr);
>   
>   	if (cpuid)
>   		*cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> @@ -121,11 +124,44 @@ static void tegra234_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
>   		*clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 2);
>   }
>   
> +static int tegra_cpufreq_cpu_online(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct tegra194_cpufreq_data *data;
> +	u32 cpuid, clusterid;
> +
> +	data = hlist_entry(node, struct tegra194_cpufreq_data, cpuhp_node);
> +
> +	data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
> +
> +	data->cpu_data[cpu].cpuid = cpuid;
> +	data->cpu_data[cpu].clusterid = clusterid;
> +
> +	/* Derive per-core register address only when ccplex MMIO is mapped. */
> +	if (data->regs) {
> +		if (clusterid >= data->soc->num_clusters ||
> +		    cpuid >= data->soc->maxcpus_per_cluster) {
> +			pr_warn_once("cpufreq: cpu%u: bad MPIDR (cluster %u, core %u)\n",
> +				     cpu, clusterid, cpuid);
> +		} else {
> +			u32 index = clusterid * data->soc->maxcpus_per_cluster + cpuid;
> +
> +			data->cpu_data[cpu].freq_core_reg =
> +				SCRATCH_FREQ_CORE_REG(data, index);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int tegra234_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
>   {
>   	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
> +	void __iomem *reg = data->cpu_data[cpu].freq_core_reg;
> +
> +	if (!reg)
> +		return -EINVAL;
>   
> -	*ndiv = readl(data->cpu_data[cpu].freq_core_reg) & NDIV_MASK;
> +	*ndiv = readl(reg) & NDIV_MASK;
>   
>   	return 0;
>   }
> @@ -135,8 +171,12 @@ static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
>   	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
>   	u32 cpu;
>   
> -	for_each_cpu(cpu, policy->cpus)
> -		writel(ndiv, data->cpu_data[cpu].freq_core_reg);
> +	for_each_cpu(cpu, policy->cpus) {
> +		void __iomem *reg = data->cpu_data[cpu].freq_core_reg;
> +
> +		if (reg)
> +			writel(ndiv, reg);
> +	}
>   }
>   
>   /*
> @@ -208,7 +248,7 @@ static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
>   {
>   	u64 mpidr;
>   
> -	smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
> +	tegra_get_cpu_mpidr(&mpidr);

.get_cpu_cluster_id() now reads the local MPIDR, so the cpu argument is
ignored. Could it be dropped?



-- 
Thx and BRs,
Zhongqiu Han
