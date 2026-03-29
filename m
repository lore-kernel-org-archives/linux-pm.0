Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83921EF36E;
	Sun, 29 Mar 2026 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774806604; cv=none; b=b4+hQjU3y4lWRNvambFqbn2ar0Wvt0ljgB96fI3C2O4XuWqHk8/AxACUuoEuxS1iFD5oJVoNWj1ig2SYjQBx+6LGAqOXNTvgZMwtbh+aMWDa4qKOf14aZyP0e5vEQJIdh5Z2XpUSJjEzppEC4Dxqd2Rw+MjUZUKWTb8rDVRJXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774806604; c=relaxed/simple;
	bh=AJFIwItCwy3dX/U406KlXfuFQQqeyfULuLmYCQuHfwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/O6aSkuzXVaZfwYHWs8sTBV3k0ocYdZT9DgpbBrGH7ZMY2FbpVzpYJNsDCZce02lxGL1oHrVumXjJqKG0LX+cl+Sa2uc+1gcQEoiihDtDfVMu5Am4txrKFpBNRQRr7R5bsynpmw8x2ZyHzy14OXUItKZnf75GLE/tS+PIzSY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mCSyqMuK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mCSyqMuK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 144043627;
	Sun, 29 Mar 2026 10:49:55 -0700 (PDT)
Received: from [10.57.21.30] (unknown [10.57.21.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B75E3F7D8;
	Sun, 29 Mar 2026 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774806600; bh=AJFIwItCwy3dX/U406KlXfuFQQqeyfULuLmYCQuHfwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mCSyqMuKAae0jnTQERlEeB7sFh1If8NKejdxXk42wptM898/0IxcRigRHBRAkhckX
	 aAP3Yt9tBYZ9A1NV1M/vxxnfVVqgxhp+ieGKSFxcmhLxtLrOHesKCkYCCBMams//l9
	 TSxBP1gBN8TKOJAu9bBF8HWkMtYpmpEShQUHw/KY=
Message-ID: <2b35d97e-11ea-495b-9439-f8f65209f344@arm.com>
Date: Sun, 29 Mar 2026 18:49:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64/sched: Enable CPPC-based asympacking
To: Valentin Schneider <vschneid@redhat.com>, arighi@nvidia.com
Cc: peterz@infradead.org, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, valentin.schneider@arm.com, mingo@redhat.com,
 rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
 catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
 rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 juri.lelli@redhat.com, kobak@nvidia.com, fabecassis@nvidia.com
References: <20260325181314.3875909-1-christian.loehle@arm.com>
 <20260325181314.3875909-4-christian.loehle@arm.com>
 <xhsmhy0jdffak.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <xhsmhy0jdffak.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/26 15:44, Valentin Schneider wrote:
> On 25/03/26 18:13, Christian Loehle wrote:
>> @@ -1753,7 +1760,7 @@ static inline int topology_arch_sched_asym_flags(void)
>>  #ifdef CONFIG_SCHED_SMT
>>  int cpu_smt_flags(void)
>>  {
>> -	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
>> +	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC | arch_sched_asym_flags();
>>  }
>>  
>>  const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
>> @@ -1765,7 +1772,7 @@ const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cp
>>  #ifdef CONFIG_SCHED_CLUSTER
>>  int cpu_cluster_flags(void)
>>  {
>> -	return SD_CLUSTER | SD_SHARE_LLC;
>> +	return SD_CLUSTER | SD_SHARE_LLC | arch_sched_asym_flags();
>>  }
>>  
>>  const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
>> @@ -1777,7 +1784,7 @@ const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cp
>>  #ifdef CONFIG_SCHED_MC
>>  int cpu_core_flags(void)
>>  {
>> -	return SD_SHARE_LLC;
>> +	return SD_SHARE_LLC | arch_sched_asym_flags();
>>  }
>>
> 
> So while the binning problem applies to more than one architecture, I'm not
> sure we want this to be generally applied to all topology levels. This is
> /technically/ not a problem since even if a topology level has
> SD_ASYM_PACKING, all CPUs at that level can have the same priority, but
> in that case it's a bit wasteful.
> 
> I don't have any better ideas ATM to keep this arch-specific via
> set_sched_topology(), like how x86 and powerpc handle asym packing.
> 

Right, I think it doesn't make sense at SMT level, but the rest seems
sensible IMO?
It is noted for v2, although unless Andrea sees vastly different results
for Grace than for Vera appetite for this is rather low anyway.
