Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9E23563DD;
	Wed, 13 May 2026 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691633; cv=none; b=LisKKkrkEbtFy7gIdQjrXgkYMA6GdywIkKC2rLJXzesgwtLuhj9M+a6sc1sYJTe1R9N+qkTY/RQ2g0l0tC/FSjSuPVR1QMisRF5h70HF0KkBJ+Ga6hXuy8qZpi9q7Ml9pN31K8bkvrwH+uOc6qMq1cj/KtyCzvDGchT4YYwrT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691633; c=relaxed/simple;
	bh=H+WlKgMjdyEQTBnDx0xCTFAelGgSo4QMvk58RSoQtmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCwDKx7LvxWcFIQWh0eD+oYNopte7zHBRtFbrnqh+pyLXRIWc01SaCsu1amPk+4LyGR7em77Unv9BwZkD1ck/dtKH46SjMUvT5ktUnAUq+9dE3xg9j67ols3JDfMu5+xA1YWEDAh8IfoFoRfA3uwQVGrZiVJiboa8AeaBuTl924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J/La2af8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J/La2af8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9425165C;
	Wed, 13 May 2026 10:00:23 -0700 (PDT)
Received: from [10.57.24.48] (unknown [10.57.24.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E2F33F7B4;
	Wed, 13 May 2026 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778691628; bh=H+WlKgMjdyEQTBnDx0xCTFAelGgSo4QMvk58RSoQtmk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J/La2af8Sm6mvK0GrqnjYMUnHO48R9nZvOAcZsGEdcvXbedbZV/jqLa85gbx27Qz0
	 rscpuBDu46A238ASzw5w4QATWUiRUy6JABB0VbM+apCuxtYdQniCoiN7A047WMxB4Q
	 x/UI+hNZyOPfR2pvX/1f/ry6iR7Gz1hANRobhsCM=
Message-ID: <436ce846-bd9e-45bb-bdc2-d2a0fd00dc25@arm.com>
Date: Wed, 13 May 2026 18:00:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V6 0/8] arm_scmi: vendors: Qualcomm Generic Vendor
 Extensions
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, andersson@kernel.org,
 sudeep.holla@kernel.org, konradybcio@kernel.org, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, cristian.marussi@arm.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, jonathanh@nvidia.com,
 thierry.reding@kernel.org, digetx@gmail.com, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/26 07:22, Sibi Sankar wrote:
> The QCOM SCMI vendor protocol provides a generic way of exposing a number of
> Qualcomm SoC specific features (like memory bus scaling) through a mixture of
> pre-determined algorithm strings and param_id pairs hosted on the SCMI
> controller. On Qualcomm Glymur and Hamoa SoCs, the memlat governor and the
> mechanism to control the various caches and ram is hosted on the CPU Control
> Processor (CPUCP) and the method to tweak and start the governor is exposed
> through the QCOM SCMI Generic Extension Protocol.
> 
> This series introduces the devfreq scmi client driver that uses the memlat
> algorithm string hosted on QCOM SCMI Generic Extension Protocol to detect
> memory latency workloads and control frequency/level of the various memory
> buses (DDR/LLCC/DDR_QOS). The DDR/LLCC/DDR_QOS are modelled as devfreq
> devices, with the governor set to remote devfreq governor. This serves as
> a way to get a basic insight into the device operation through trans_stat
> and provides for ways to further tweak the parameters of the remote
> governor.
> 
> Transtat data for DDR/LLCC/DDR_QOS is now available in this series:
> 
> #cat llcc/trans_stat
>>From  :   To
> 315000000 479000000 545000000 725000000 840000000 95900000010900000001211000000   time(ms)
> 315000000:         0         3         6         6         6         7         0        30    143956
> 479000000:         2         0         7         1         1         1         0         3       356
> 545000000:         7         6         0         5         5         0         0        10      1200
> 725000000:         3         0         5         0         6         1         0         6      2172
> 840000000:         8         2         3         2         0         4         0        12      1188
> 959000000:         3         0         1         2         2         0         0        13       272
> 1090000000:         0         0         0         0         0         0         0         0         0
> 1211000000:        35         4        11         5        11         8         0         0     21684
> Total transition : 253
> 
> QCOM SCMI Generic Vendor protocol background:
> It was found that a lot of the vendor protocol used internally was
> for debug/internal development purposes that would either be super
> SoC specific or had to be disabled because of some features being
> fused out during production. This lead to a large number of vendor
> protocol numbers being quickly consumed and were never released
> either. Using a generic vendor protocol with functionality abstracted
> behind algorithm strings gave us the flexibility of allowing such
> functionality exist during initial development/debugging while
> still being able to expose functionality like memlat once they have
> matured enough. The param-ids are certainly expected to act as ABI
> for algorithms strings like MEMLAT.
> 
> Thanks in advance for taking time to review the series.
> 

Based on this description I have a few questions:
1. Why we don't use SCMI notifications for this purpose?
2. Is it safe to assume that there was no extra frequency change
    during that polling sampling period?
3. Shouldn't we sample 2x faster than the changes that we try to
    observe?
4. IIRC there was some extension in the SCMI protocol for performance
    domains which allows to expose the stats like the one above but in
    the shared memory. Why we couldn't use this? It would be more robust.
