Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C5371899
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978996; cv=none; b=r1/qt1YoJDdX8zVaGPN6fPDXD++TG3q2HNiHOjxZ/3ruA3e2Fhri1OknJuhFn0p7sx1u4KTYwJu3AgicQcVFWIeGSpNaptFNCgMCshWK8NGjTXHjeucowmKGBVSrtjKzEYcds6qySGGeR8trSZqCxC0slwGxQXOVL+hyXgtFpuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978996; c=relaxed/simple;
	bh=VTIfmTGTxvevC6B8X6TbPKbB2RVm5xX8myttI1OJqdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPT/gevJIcfnXavqnIr+4/68Y2dLtVe42g8a8xOmYB0Z7iV5ko4/MDwXkXLdY2yJ2y9Q8xwhR7O0/7Rr1zdL1JKO2LrsMTYREVcUxfjQ3+EKmH3Vu7DnMtMHiWuU1IFrr+XFwBKAsH9iG17LKNsgwyypjCnqQAIKwHEgZ/Fy6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f9fHyVhI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PmHvIKNp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f9fHyVhI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PmHvIKNp"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H7UBx2065001
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 18:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mIQgohTE2rOvQzNapNCth9eVCnLrSjsevoHbhxyKhm8=; b=f9fHyVhIBtdv6EUr
	DlNghKVHtEJRyrLKeXFDlVLXSO1UAA+Yn7hGbI1f0UYI1DNCkSV2lKeExYYLGD6g
	CSPcVJVcKhiTXh+Xxk/ETQTYTWiD579T5wEStNDRoul/rvzTnmVWP+boZ79lxeYB
	FXY6hC14K1DEc4aUkeAYYXllFrx0NuolQS0A1f6pVA4SDRMZaY7G+8AWxlJU+/m5
	q6QTEC2o3J+6eOxTUhYEmqbFUC7PKOZIsJUYrpGkhwey7ynH8YGPR2uJl30S6bXj
	1vlfmR5qjsJ07tSDg2GrWJP2dkDKKKIPmCtHs7DDLTuwk43KCYv1lOSTaNjljB4R
	hLNSRA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk78x1vep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 18:36:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so12581745a91.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788978993; x=1789583793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mIQgohTE2rOvQzNapNCth9eVCnLrSjsevoHbhxyKhm8=;
        b=PmHvIKNpVc6ZotrI6heO/ZDvyuB8TevD4Rs95IxZbut4Euv9d4quBKttlnAtVdmx/L
         mgKydzdugHxlB0MYFjo6gM+QQmSekCKdN/RH5YgCZzPc+9OgFalJKBAn5vK9WsVBNt9a
         5jygq7OwaT0I95L+uraqQn+SYIzNbGAxsu2uf6nPfWma5fzSyzzAZuKFupafXy6C0qO4
         8ut20mizBpsIyNoP3eD9GzEk57O23xYrEfNkiPcMjx5XrSeVBHrqFM6OX0XrfG3w2Gtu
         hmbq/lyuproOr+EHVwn2Rfy85wkZWUi1ZknIZNzdD81bULFVkBly95Y5vcigMdGd2fFV
         hCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978993; x=1789583793;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mIQgohTE2rOvQzNapNCth9eVCnLrSjsevoHbhxyKhm8=;
        b=igqAoi+lB34giy53hIF8UIRAgNfZ+1XgYvzzxZQZ9rT8xFzj1WUmCGcZVhibsKklb7
         w+s2OB7j8BfGHVTRDq9Y2TbXrs8p6iIvQevgjwJSXY0sE9FzJTj3NamFg3qe4CZIl9CJ
         ce1HmRSyq5vPfmW8EsabzlzblyPT3pwudyyly17xMAWsluFVZbG9hvdlNTU2PU/yamsH
         iEZoKs2ZIF83D2Tuf0IfXEh+DrvNId/EYFTE4d+iNSX3s8qLSqLq39sUXJKAGRDdQmyo
         QcFTivDtvmdVa61FZyrKnadXXEhiQmFJcGg4inFoyh9dTjsfa6nLt5RrzZRUfkx+3sFV
         5VLA==
X-Forwarded-Encrypted: i=1; AKwUvBxLuKWjKjMCZq0xNPe9Qc0d3ZYvrcQ6cmyVnD0erSjBy1EuCUCAUu2BFVY/kPf6NIHRlDGs3BA95Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lT8rA3sA8yWc1i8b083vtyiStJ3scCgM8P3VF4QO0P/H2AK52m
	zM0YdL288sL8m8Eoms5SFMOrtugdGGL8cU3M/c3TEXPHBowULpPKSOSQQuWjGF/SGV3xU3G64ai
	JqGW1naOKYIgnz4aog9+rkJ2r8twGrksujE1v799ABNf+mmjly6KVgaaGgUZWOg==
X-Gm-Gg: AYBFou0CoBIbueBveOga2DOlkvDGBJvUKZEV6t0meHTU0TXImapjsGq8GpqoKfsKNSL
	bh2naPA1XoT7suXb2YwkfmLevKjTltzfwLbi1Y4b+wQ9RRPveS0aRgbhM8H2tWGDW8ipKA0E2nE
	SKJx0fICAsrdsHfweSGWfDyk2rTVLgebcNubexzXv4J+pVFXXGb/WZx0dq1N3Ir1Yn3JcqgkJ2k
	MQ0Oyu4eU1LpnzF3oA2a8/nZ5R5kH87JrOp4w3BPbmo29HThtRc/p7y8cmcNjjEgZRh7mwiXzo0
	Ljc0SaPYqj3IjMndXyy4kgMMOXDRkFjkqdI9Zm/vEqkqLqGySPgnZoxj/sBXANWAS9WdXRyzIOQ
	JIdAU0CTochfZbxzW1W3QGX9ws8s=
X-Received: by 2002:a17:90b:1d4f:b0:398:9be5:b417 with SMTP id 98e67ed59e1d1-39b26221eb1mr53821138a91.18.1788978992918;
        Wed, 09 Sep 2026 11:36:32 -0700 (PDT)
X-Received: by 2002:a17:90b:1d4f:b0:398:9be5:b417 with SMTP id 98e67ed59e1d1-39b26221eb1mr53821108a91.18.1788978992503;
        Wed, 09 Sep 2026 11:36:32 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1433171a97esm50371041c88.12.2026.09.09.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:36:31 -0700 (PDT)
Date: Wed, 9 Sep 2026 11:36:25 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Oleg Keri <okerixx@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Beata Michalska
 <beata.michalska@arm.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Prasanna Kumar
 T S M <ptsm@linux.microsoft.com>,
        Russell King <linux@armlinux.org.uk>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Sudeep Holla
 <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich
 <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, driver-core@lists.linux.dev,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/2] arm64: topology: fix arch_freq_get_on_cpu()
 overflow above 4.19 GHz
Message-ID: <20260909113625.000063be@oss.qualcomm.com>
In-Reply-To: <08ee55292c1cedf26067d1a2b02fa5657d9650e8.1788712186.git.okerixx@gmail.com>
References: <cover.1788712186.git.okerixx@gmail.com>
	<08ee55292c1cedf26067d1a2b02fa5657d9650e8.1788712186.git.okerixx@gmail.com>
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
X-Proofpoint-ORIG-GUID: og99i17-ZL9HWiF3MmrrcVfJRwUmtRh0
X-Proofpoint-GUID: og99i17-ZL9HWiF3MmrrcVfJRwUmtRh0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIwOCBTYWx0ZWRfXwmV2OGjdYSml
 dkfmBB8H29LBj3iQeA/9RRcDVrQhYUlpzAnvSCYHR9zP+U5UIvJxRtsOSpsY2DnTtBwG/6QX7Fq
 SX8je/Y1UI6d+AyCc+5TVx+Py8rHZYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIwOCBTYWx0ZWRfX6MnXv0f+32sf
 Onu9v3wP8O8/gswr60iPNuG99Si5WBoMWeHqGtgjgGy0t9vn7dhhfqOvVqvxbJa87tgz76PLxpD
 UFHDJs/C8K2u/WO6AikSyXd+s7bauk9fmkV4cEawmTotvMY09VIT+TfSbdU+Wm69ztfUka8skc8
 EbggjK7rJyg2NeCzTuSOvAdug18DxJ2CvB0R7lxaWs3ASWgaAkjez5PBpeRmxyDnO8+y98G7+dQ
 3vyrE7LR9V6UFUdid1oyfLmJHhCz5XvsEIJTawmCN5mW6C2Yz6M7VGny08kQc351UIEVKpBnCdZ
 esLXbnMKlyFUNQ5GdBbe5HRNujZvd8a5rzzdt9b4o2wNyjCDwP7NRcnD8ZTlk6b0R+R1kU54Zlr
 wB+xNuVEoADA3fpDWj3+HzmPKHYePxfKFW6r0OrtdEInzPfgxDQnUYA/nH4IdZbM2jWWVE3Pf0o
 22YgPZ4IB7GpRTD+Bng==
X-Authority-Analysis: v=2.4 cv=SvWgLvO0 c=1 sm=1 tr=0 ts=6aa1a731 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=vZYCpiARan6kKAuTxo4A:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090208

On Sun,  6 Sep 2026 18:37:14 +0200
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
> Signed-off-by: Oleg Keri <okerixx@gmail.com>
> ---
>  arch/arm64/kernel/topology.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index d28438f8b83f..804758eeb63a 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -245,8 +245,9 @@ int arch_freq_get_on_cpu(int cpu)
>  	 * (see amu_scale_freq_tick for details)
>  	 */
>  	scale = arch_scale_freq_capacity(cpu);
> -	freq = scale * arch_scale_freq_ref(cpu);
> -	freq >>= SCHED_CAPACITY_SHIFT;
> +	scale *= arch_scale_freq_ref(cpu);
> +	scale >>= SCHED_CAPACITY_SHIFT;

Maybe just do it all one line?

	freq = (scale * arch_scale_freq_ref(cpu)) >> SCHED_CAPACITY_SHIFT;

I was going to suggest that you roll in the arch_scale_freq_capacity() as well
but then we'd need a cast to ensure maths was done in 64 bits and that was uglier.

I think this should end up the same as what you have.

Thanks,

Jonathan


> +	freq = scale;
>  	return freq;
>  }
>  

