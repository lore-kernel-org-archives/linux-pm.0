Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399718;
	b=hVCy337gKoPnUNMLtkyBAAomSZca/+ZQFesEAuUjYjyWZyrYz14Uq1IIuKJqWG1QjBZS
	 IAEUsjno3N2M1iSNUmGpq4qK5x0+vaYy27LzbzHI8mvTNM9WV0j1rY4QAc+cd3Ya3MMy+
	 wEOfAdDSjCJpAUycqmtVya1s1O+TIFzEdpyoP7PgZkEvbHxO/P0UNGVWfH5a2/c8F879F
	 2Ca66nFnKu3huf5ofhl8Eq84nLMlrPSAN/cGu5ADKoMBxbjk2gdXEwJXBGbq+mHKZ76uw
	 rhVE0lBtO+s/cUzz9wgsiNIjq2DCax/XDG2hWUDGX7PLwxLZLacUjMckX4s42MsdIcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399718;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rEnsFZzlpyzFwAmK5owjX1ORB7VURNjWd4s4pQhdDGM=;
	b=EIU9w6YGvllJP70W4GHnYAxSbWVNXPU/hx6cQSeRUg+5U++urH18FqHXt8J6Gl9xhBgg
	 I9LVgS+Ku+Fey2Yi4vafzd37UgpWf/Lautv3w1ZMbzLHHY+AxydMLnv5fZGSZ8FJ+cW+q
	 Of2yKufFWd8s3J+0F1mYLhqW/MV4A91ynDdGJsKt4sLI/qdviwx/RyF72my7vwUcryx2x
	 nNE8VSGJKGufMQ+Ftc7EG7ztzAAeiAPx3PBErteyhAbg03O7YbVhSNdAugCD1XDlpajVL
	 zD0dZeZXtP4nBe2vUUtxUKYBTjM/1QiCi2L5G1dY15L3+Wyh/LRCXMQhefjIASZoECg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZyUigaQu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=euolciG4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F8606A31C
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF0F8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZyUigaQu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=euolciG4
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABBVSHL864189
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rEnsFZzlpyzFwAmK5owjX1OR
	B7VURNjWd4s4pQhdDGM=; b=ZyUigaQuy41E2c5G19su31Xc/jqb/gKyPXDjcewM
	QwreyS6yEc363VV99LD2H6rJCX8FpJiGd2P4CpYa8q8f0OKgeYtn+nhP7BgtuWZi
	go1ccZmztAwnrFOAY3kg/d+fbLt/ZNSntbPhWuW87S3P2yISkswGgkRBMfFgcpOf
	VxVRbhpAZasJQeAL016IKvrI7SgfodIE8UiApbrxtPn6lqJAiZXcY2Vur4Yj6m0r
	wPKa+0J/Yxj8SIi55sMdehrXNaDn/q0x6JN/m2AaR2TnvGUX4Cz2c9rb0tGBrHp2
	fpGItqBGcD+AwRAhZoYkWdffk/lGeh34/tOPkEHOSMqTow==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawj37k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:21:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ade5b3ae97so2475292a91.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 04:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794399716; x=1795004516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rEnsFZzlpyzFwAmK5owjX1ORB7VURNjWd4s4pQhdDGM=;
        b=euolciG4d08G51U366Vxf2N2vdn1HVGehtNzI/kQWrRCCXpwY+lndXfMvm7PkzYx6t
         yjX+IzvscRt1Hbw+8xnxMGUYXqYGx6OEyVzwLFThiVjXX9UYz/WkQ3Y5mjyI3XaX75ip
         lp9yr7K7r+hRDtRm5fAFa1y88M2A3X2zqg7J9++qSnUOT32g+QsnJquk8xhDTAfdre5i
         u9ldpKVJ4RbNvcu6+yntJuyulXQsJISJlZ+0fCmmrDsPlO+iqCTZnN/RSPDslsxwOxZe
         TzIo/aXf44nGMg5Wg0yr5Zc2gb183ytmPCtX7KpEugsQNv3+k8rvqdnza56lTrnXsBIR
         5wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794399716; x=1795004516;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEnsFZzlpyzFwAmK5owjX1ORB7VURNjWd4s4pQhdDGM=;
        b=nZIkN3QCkWg+muTw449mHUjEzAdvwZvKgCc7J8DUXzgHVAgsWYeCyoQj3CMuxaGSXm
         WjBdARNdI3zZMzsXrtqQda6i0hBO+Ek/s6j+fV5R3Gx4ZunuydblCNUntf7ytgXZ+PDo
         2+Bme/NbJ+LQzRzLBoGvoEGWaHHnMjcAkFIJYa++IVjQEWdrCk6XbLY4QrNUed+01jL/
         xYx6fOeP5wqH/7EhSajX2vihFcr8ITxAOvKWUqS7vYoSSb699+mgAPen6XSdTrTY9MQb
         QzEK3TGuAA6vNeSwQt4RcjYabYUjm5jUGL05/eI+6PuGK1LeX0UPazz6GSyFt4gdKI/a
         TPFg==
X-Forwarded-Encrypted: i=1; AL+hErEIZLfpdk3AzLoGtRJT+q7D7gko8hd+PyPR3Ez2VR3xpQtM6qaAOgSalIiLMrhzlbgMbeVGpXuBpg==@vger.kernel.org
X-Gm-Message-State: APuU4Z85GSA20jpsWyPYfVpxYa4vmzHrbdXirwMv6P7m36NYpwqnDg9L
	FhDkNzEBvHRmtEzUDP2dQGCmRGJlBvqxKYkp5Fi/vtsVTfwzWbeLZ8rwelaO7qIIdIJiCCaKXoh
	ZcBOAFXsLsW6daZydCeA5NssWfqokrdr5obwCFMg4SJyWiOajIU8EJt1jBwsgEw==
X-Gm-Gg: AYBFou2PDOtOZqLMiP6M9ZASQc/nQhMuZNf50KbiOAhp56adNXyQQgBVJGwUYVWUMBw
	+3wbwr2WTMl+eekUI0O/qoGAQrprKHFo82BkGlS61lIBKLTcLiFjGqaVyqB04WFbaiBzI4qD7o7
	nH4bgegk5ewUpZky1yk67rw+iFMTpTNhv3NxfTX1cnElHlUJ1FRErET1tOAZ05zjSRICw1ZFIGf
	ztpFmB5doauI0BmBFK7psO7AIzjOlVKKrM4eLO676YgJzcc6vLay0VkXjh4T4ZrEK8UQMLm1zDb
	HDk8tHkbltU584NvXhm8CrGyxMADvju0cDtnlMgz+/Cnv9Ne8HH0bzlCOTByeJblIzY53NomY48
	aFOMrsidTUOxNZDGtsrRVllsGOxo/Vw0peO+6+z6G4gEh6a/5xpxMV8KypBYf0Qy3YzL8XrdQmW
	QpCcAcvwqaGDw7E0xYujlCwZs/hGT+Xv/AaiJuG58hCMRNoFA4vBLOcS/ZxehHlno=
X-Received: by 2002:a17:90b:5345:b0:3b0:e388:d9c9 with SMTP id 98e67ed59e1d1-3b182edecf2mr1500144a91.12.1794399716186;
        Wed, 11 Nov 2026 04:21:56 -0800 (PST)
X-Received: by 2002:a17:90b:5345:b0:3b0:e388:d9c9 with SMTP id 98e67ed59e1d1-3b182edecf2mr1500126a91.12.1794399715646;
        Wed, 11 Nov 2026 04:21:55 -0800 (PST)
Received: from hu-anancv-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17e0d550dsm4315816a91.8.2026.11.11.04.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:21:55 -0800 (PST)
Date: Wed, 11 Nov 2026 17:51:49 +0530
From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jie Zhan <zhanjie9@hisilicon.com>,
        Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oleg Keri <okerixx@gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: fix policy max not returning to
 non-boost freq on boost disable
Message-ID: <avRd3YVDXs26hrow@hu-anancv-blr.qualcomm.com>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>
 <41f328b2-0825-4023-b86c-48136ba6ecd2@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f328b2-0825-4023-b86c-48136ba6ecd2@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0OSBTYWx0ZWRfXx1JLhYOnyztP
 mQq7eecZF0D6lukfCCAREgCJpxJcyfE8Z7VOL1Yt7RHel3d83qymdZNsuj2L+Biq0vwsnsIQqWN
 1AUrIdaE7ZMK69gRiEaMB4FrRpw9qPE=
X-Proofpoint-ORIG-GUID: Lo-Znbgh1pTGiAg12gE3GVfYQFhpdPIZ
X-Proofpoint-GUID: Lo-Znbgh1pTGiAg12gE3GVfYQFhpdPIZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0OSBTYWx0ZWRfXzAF44d6k6Jc5
 HsQiteuykrdvI6L9wW/OxDih4i87DpFELIN7XPl0Iv3Yt1cpmmWkbR34soet/3ej+qqc5Q7ONvq
 KM6FRkNlyd/NahXoZiCqbZ1l5TaKbpPZV8rPQFcOBUoI9j+5ROu42E9UTXk9z/sXM9u6gdfeUms
 Eto3wbP+HZDnSwh/SABrTfOeC4TXU2x21DNbaJaw1d5sVxbUfgxt7atrzZmpGmrL6Ogu/O1FZQ/
 TwtBo9/QWvo2ORy0HeBl0F/PR7GFTKWwrVQqDyOcLuCFa6I5uhn2YwXKNsLhGB11E3ogYUZlB1s
 kiMGlkrJ05lszZcHWcg8ufIxMgqNzv9KklqfXPTOwfPL4lXm8dxRLraK7d8gd1gElgrLpXUBc4/
 W7kxzFAUetb+K+huila8bKrzisKAtOuh+/VlUIJKq9rOsWShMovTusWFRFSqUwif+qIumECmYxM
 4CTKdI0wNc2PkfSbC0w==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af45de4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=CKxPtk3aFwTzAyx1bQcA:9 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110049

Hi Zhongqiu,

On Sun, Oct 11, 2026 at 10:17:14PM +0800, Zhongqiu Han wrote:
> Patch 2/2 currently depends on a helper introduced by patch 1/2, which
> prevents it from being backported independently. Since 2/2 is an
> independent fix that should be backported to stable on its own, I think
> it should be placed before patch 1/2 in the series and kept self
> contained.

The idea was that currently patch 2/2 would serve no actual value without the
fix in patch 1/2, and that is why it was the second one. But yes, we cannot
fix 1/2 and leave 2/2 as is, which would turn the current benign issue to an
actual problem, so the order should be probably reversed. I'll work on that.

> To avoid introducing a new member that is only used by frequency-table
> drivers, please consider the following implementation instead:
> 
> If there are boost entries in the frequency table, the table is the only
> source of cpuinfo.max_freq, so let cpufreq_frequency_table_cpuinfo() set
> it unconditionally in that case.
> 
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index ea99464..8c8bad2 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -33,14 +33,17 @@ int cpufreq_frequency_table_cpuinfo(struct
> cpufreq_policy *policy)
>  	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
>  	unsigned int min_freq = ~0;
>  	unsigned int max_freq = 0;
> +	bool has_boost = false;
>  	unsigned int freq, i;
> 
>  	cpufreq_for_each_valid_entry_idx(pos, table, i) {
>  		freq = pos->frequency;
> 
> -		if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
> -		    && (pos->flags & CPUFREQ_BOOST_FREQ))
> -			continue;
> +		if (pos->flags & CPUFREQ_BOOST_FREQ) {
> +			has_boost = true;
> +			if (!cpufreq_boost_enabled() || !policy->boost_enabled)
> +				continue;
> +		}
> 
>  		pr_debug("table entry %u: %u kHz\n", i, freq);
>  		if (freq < min_freq)
> @@ -50,17 +53,20 @@ int cpufreq_frequency_table_cpuinfo(struct
> cpufreq_policy *policy)
>  	}
> 
>  	policy->cpuinfo.min_freq = min_freq;
> +
> +	if (min_freq == ~0)
> +		return -EINVAL;
> +
>  	/*
>  	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
> -	 * it as is.
> +	 * it as is.  This does not apply to tables with boost entries, because
> +	 * the table is the only source of cpuinfo.max_freq then and it needs
> +	 * to go down again when boost is disabled.
>  	 */
> -	if (policy->cpuinfo.max_freq < max_freq)
> +	if (has_boost || policy->cpuinfo.max_freq < max_freq)
>  		policy->cpuinfo.max_freq = max_freq;
> 
> -	if (min_freq == ~0)
> -		return -EINVAL;
> -	else
> -		return 0;
> +	return 0;
>  }
> 
>  int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy)
> 
> 
> >   	/* in 10^(-9) s = nanoseconds */
> >   	unsigned int		transition_latency;
> > @@ -791,6 +792,8 @@ struct cpufreq_frequency_table {
> >   int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy);
> > +bool policy_has_boost_freq(struct cpufreq_policy *policy);
> > +
> >   int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy);
> >   int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy);

I wanted more discussion on this part regarding finer implementation details
and hence went with a working version, and I think I asked in the last revision
thread regarding what are people's thoughts on this added field. I am also not
keen on adding more fields, so this is useful suggestion. If we are to continue
this implementation route, I'll keep this in mind, thanks.

> Thx and BRs,
> Zhongqiu Han

Best,
Ananthu
