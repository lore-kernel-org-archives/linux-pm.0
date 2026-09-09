Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458646C4CC
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992423; cv=none; b=OtHG9od+J5Oqws/0L1ik/dgDlJGibVBfZTNMkiAvE8tFUCxAA/6gMxiJW8EI9lp4qhPH7maskA8CxiIe3uL5Tys5wkaeDgc2t+WQ2P/8P9PdHeL35kNy8pU8FeBdOM9pZG4DDK2xQUSYzeDTjKoUfYso604uIf0+GLk39tgFvkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992423; c=relaxed/simple;
	bh=8l+ami9ldrVu3hr0kXGLYQ6blpuZnPW3oAN2iwaBd/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hl7/gfoncUWFN5HT+02KieJ3os9IpkrosOCpABjIwx8+8OZAcntqpogcQe6e9dl9gy1v5ciHvH2EOUvjaJwJrA5bDb+D9tRiWszN9pWArJCbCIxN7xjJaOS7eFGYEZcQW0hqRF3HSjOCm3f83pBsx074A1uen6dWW6WWPj76KSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nz85hBmb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D9jrlQzW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nz85hBmb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D9jrlQzW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689M9Yjb3216013
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 22:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BeK/1z0Ffq++309QbXgeNFfaNMYbnkujkRsfU6JzN9s=; b=nz85hBmbk8CF/1HF
	vTbyg+KZf8S/LNo2l7OjmmbgE6jb/RLqXJZdXx/7KYe21yZXFTVCre8/zf9vuEjT
	Gwnk4rQ356tz9ul05I9yxskqShI8GX4s2iQeZXOABk6ey4K1iSCCJ9V5i0lPpxv4
	V9tPOriHxMK7eLuOgElzHggEBXrpL4HyySQPlJPFhhW+gi5N6+1W2ULGEKGB3eTC
	vW+C5kul7NAkiIj6B4eKLhIkaSolGj23ti7/B2aRh095fvIMj+wOG/YdUMb3kUwY
	KcoH9tg26lUD3KFlRiFzbuVd3gufBeg0AK9RL9ToYc3SG69/O/VhL4agBbyLx0mr
	cXB2lg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyd0t9b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 22:20:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398fe469aa0so10496163a91.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788992419; x=1789597219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BeK/1z0Ffq++309QbXgeNFfaNMYbnkujkRsfU6JzN9s=;
        b=D9jrlQzW20KzABKaS6Xo6XZYM2BbqZ7JR7g56v3cNlmXYMdNRgNAJ0ineJC10sGgUG
         ESLBU5Yrat1SEmfo9Ew3snzg5NWt9AzBhXrf4NPzzWa0e1lPY0Wx6TfzdTb72KpkhFqo
         YdJ4xviy/nJ77pYwtB4g+XLXlJOdH8VaDh1N2sqMB+F36foxkhOFxLwCmbFhp9TOVSRH
         HrOHocCW0l+jOXSz4CluoCt8Sq1xpgPmNyfU666Gx3c8vtzPnsDwnKfGxPscln2orHxp
         uRVl1/6JMw/2EuNoJRHIx1TanDHhS1f7mEg98rkhVFvP+9JD8WEZkwj1HZXAOlvKEaBr
         lsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992419; x=1789597219;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BeK/1z0Ffq++309QbXgeNFfaNMYbnkujkRsfU6JzN9s=;
        b=J3m6LgrP4NXe+M+5PcpzaOiM4ACxsHw1L6l+zEMMKdrzAim1+wiQ3IB4Z7hrkf6ilM
         08fh6St/LeJfT3wgAqgdtDWbwoK6+oXRNJwQCVLFM3tJdCWKcnnQly1VcdXPvQOpc0Lb
         y+icsbDZUJQ2hl46QLaDCavMZwjaBiq+EPdj0ApjQUgW3kVT48UOgi1JhF+rFiG4UQVX
         cEeey996BTaF8n4nBWGlLzXdCX/aqyl1pCCYkybMh0MCXE3x1ST+lG+B363pvpxi4ySi
         wwqX5LtDsOO0zmRvkTGylNNWLzNluDLBOPk9G6ij6Yk+g7oyfezbs4J+WxshgVfuwSko
         zOIw==
X-Forwarded-Encrypted: i=1; AKwUvBwtn/3qJHTE+MN9tW3n0bq7lUP6I8iIfmk5/WDD76G9mW9O1yuGKvneWf3IUvfk1sDWoWxKY0yrVw==@vger.kernel.org
X-Gm-Message-State: AFuF++k4yni6/0RZtn8wJoLiKkocp+UZHQA2Eo46J1ksxoRPvcOb+hF4
	uPQWn8pfeiGbzEE5PX9MQj3xzHgdsAaRo+BeKajJjt8yRmMydBTl51Io/dSTPx8OJROCLL+U+qJ
	JUuhwsvNYB//vCw/t8QSYC6IelZqkIhJ1eMS/XyjvWWgeD1V/MBT73T7n19u9+g==
X-Gm-Gg: AYBFou0CPQdkTW4KiPCLx7vOukD+wbOL4NLO9ywVhXePxdHD68yhpBXrnbS2uocMKJr
	3UWyj1Vt9C47dXNrPTnp65sVdsOvLkDQd4F8hn5SxpOLV8KHGr+804v7NAMKkNeNPXvrFJ/cVJ/
	ccApMaYckGBZWOkgniBT4FEXNPrJgBELhaZy6C9tu7Lgbqgk/2ha3L7Nny6YE3XqKwi7QReAdSK
	en0gtmm+Cn39AOXjOAXyd8wUvZIOcMKdnCs3WQvcSFeZrOWHzHvh9xj56wouVRzVsb3JRpayJ48
	uWJXSieqR9f8qe5yol5cKlvq1TxJ1m/NbT5sAg/Rcu+gKfppMD6W9vpT4NiEOT3Gp5T8YCrkK5E
	ShQeyYTOGnkBZElnetbXE39EzS5Q=
X-Received: by 2002:a17:90b:4d86:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39d70980956mr4531210a91.5.1788992419311;
        Wed, 09 Sep 2026 15:20:19 -0700 (PDT)
X-Received: by 2002:a17:90b:4d86:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39d70980956mr4531105a91.5.1788992418800;
        Wed, 09 Sep 2026 15:20:18 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b9f68e4sm51299924eec.24.2026.09.09.15.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:20:18 -0700 (PDT)
Date: Wed, 9 Sep 2026 15:20:14 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Oleg Keri <okerixx@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sumit Gupta
 <sumitg@nvidia.com>,
        Beata Michalska <beata.michalska@arm.com>,
        Prasanna
 Kumar T S M <ptsm@linux.microsoft.com>,
        Russell King
 <linux@armlinux.org.uk>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, driver-core@lists.linux.dev,
        linux-pm@vger.kernel.org, Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] arm64: topology: fix arch_freq_get_on_cpu()
 overflow above 4.19 GHz
Message-ID: <20260909152014.000055d8@oss.qualcomm.com>
In-Reply-To: <20260909192351.33910-2-okerixx@gmail.com>
References: <20260909192351.33910-1-okerixx@gmail.com>
	<20260909192351.33910-2-okerixx@gmail.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zbnRG5BmcTrsJJaJrSSKO60ylokOL9rX
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aa1dba4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GPoSAeC3DJVMy4bTL1oA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: zbnRG5BmcTrsJJaJrSSKO60ylokOL9rX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDI1MSBTYWx0ZWRfXy8NMzBvuTWFr
 JQpacS5/wPj5c6UhNF5GyET9pff1eQ7wgb74ufgcvSYe90xUixSpyKLqn3YnlQWm0Ev4XLJYr9j
 duCTkurXDOTZlUz/qPq83oeHMP409gM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDI1MSBTYWx0ZWRfX8ZpuZD7xF/g6
 IIpIz8/gWAah6/roYsjB/Qul5cIwaSxggEExYXdIET7jWLBZelYEK721vHj7Nb0HXM2FQuc76gS
 usxsRRh/zXdOK+Yl/UJiCTnYBqVjNIEEABv6OaxVQzzvJP0aN7+6arDmCwrx4nsTLE8ONGGbUPi
 NVWjRJNJEI4ytkHbzkqBZYeqQhnLvgkXjyX/XyPg9KCGQoiLaj+gAIvAhZAKuVEcFRJkpseqMB7
 gA4H3GMZXGKjhvWug52MEA9QI4cb8ptM/5SkeA7DAffQFJNEgV2ErZQPIYMQGi4vDl8gX4i3C4S
 7ZuD1svNYcG/S/GCzF8khxRnMKygQyp4fbhKcIGNOdedHKY6fn1dK5G206zSCOSDd9INnWGM6eN
 XNHJbHM4sRGmL/3oaOiGD/pvUmXAr04OsNyEzG2pIztfy7UzTR5VW2WFBHzw9tMWs14hQr7Z4R4
 5NvBTwsKGf5PJ5hTNng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609090251

On Wed,  9 Sep 2026 21:23:50 +0200
Oleg Keri <okerixx@gmail.com> wrote:

> arch_freq_get_on_cpu() computes the product of the frequency scale and
> the reference frequency as a u64, but assigns it to an unsigned int
> before shifting it back down:
> 
> 	freq = scale * arch_scale_freq_ref(cpu);
> 	freq >>= SCHED_CAPACITY_SHIFT;
> 
> The product is truncated to 32 bits before the shift, so the result
> wraps once arch_scale_freq_ref() exceeds 2^32 / SCHED_CAPACITY_SCALE,
> i.e. 4194304 kHz.
> 
> On a Snapdragon X2 Elite (Glymur) laptop, whose boost OPP is 4723200
> kHz, cpuinfo_avg_freq reports 524283 kHz instead of ~4723200 kHz while
> the CPU demonstrably runs at the boost frequency: a fixed workload
> completes in 1.72 s at the 4723200 kHz OPP versus 2.01 s at 4032000
> kHz, matching the 1.171 frequency ratio.
> 
> Keep the arithmetic in 64 bits until after the shift.
> 
> Fixes: 16d1e27475f6 ("arm64: Provide an AMU-based version of arch_freq_get_on_cpu")
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
You don't add that for a review comment unless it results in a whole new patch.

+CC Sibi who is a whole lot more familiar with Glymur than I am!

Jonathan

> Signed-off-by: Oleg Keri <okerixx@gmail.com>
> ---
>  arch/arm64/kernel/topology.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index d28438f8b83f..0eca321ff113 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -245,8 +245,7 @@ int arch_freq_get_on_cpu(int cpu)
>  	 * (see amu_scale_freq_tick for details)
>  	 */
>  	scale = arch_scale_freq_capacity(cpu);
> -	freq = scale * arch_scale_freq_ref(cpu);
> -	freq >>= SCHED_CAPACITY_SHIFT;
> +	freq = (scale * arch_scale_freq_ref(cpu)) >> SCHED_CAPACITY_SHIFT;
>  	return freq;
>  }
>  

