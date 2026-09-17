Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6152A4F3907;
	Thu, 17 Sep 2026 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660552; cv=none; b=VcPK05zlKlufUNO6J+AHyLTHZxE4kV/mvMuFq4Nvzbyhssh/7oBa2V6jcvUmtP6BHOSriV61vKQsyj676xu3wwaYL/7ByY+yWdaN1xe7y9kYQAgtI7JpEieLyCCzmwE3rNX/iy2rBQdP9UiJ6F/gVmRCBwONhUjV+RfU+tilorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660552; c=relaxed/simple;
	bh=pu6OxP7sHRarHbFxvyGvIy2jdeMp3whl0Ww+2w+Yqk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0HvXZ7LrtkAn7SOT/7IP3UXc3We82ZfXiMqUO8pmoEDdMKz0QJyTbDnwtJSKqSTQ4Z/dBIU1y9To9b/0nAV95fMpgmZjBBPH8+7UqO1mLikac19qaPcd9B+Y4IoYWt4IMYGHo1wVuOSALAheUbgoRV3+vmbGALHrjAYbLVmSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FLgeeuFP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FLgeeuFP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0819A1476;
	Thu, 17 Sep 2026 08:55:46 -0700 (PDT)
Received: from [192.168.178.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA3B53F7B4;
	Thu, 17 Sep 2026 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789660549; bh=pu6OxP7sHRarHbFxvyGvIy2jdeMp3whl0Ww+2w+Yqk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FLgeeuFP12OYalq4ufgX2DESTMiE2Tp/2noR1ohfQnyzFdFKH/4YTsCF7BL2DiffS
	 yxR8VV9A+e9avG4QOYLmvQPUlvbQisERazLgW5Sg35hefwU7+8YHgN/SAyL/A5/1+4
	 JIApr13pTg/Sab2zAkV1CufEkYRfeIXMoxFgX9VE=
Message-ID: <b7fbe8bc-56b4-4705-b5d8-4a377eb062ee@arm.com>
Date: Thu, 17 Sep 2026 17:55:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: topology: fix arch_freq_get_on_cpu()
 overflow above 4.19 GHz
To: Peter Zijlstra <peterz@infradead.org>, Oleg Keri <okerixx@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Sumit Gupta <sumitg@nvidia.com>,
 Beata Michalska <beata.michalska@arm.com>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-pm@vger.kernel.org
References: <20260917125112.2283-1-okerixx@gmail.com>
 <20260917125112.2283-2-okerixx@gmail.com>
 <20260917153224.GJ4121339@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20260917153224.GJ4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.09.26 17:32, Peter Zijlstra wrote:
> On Thu, Sep 17, 2026 at 02:51:11PM +0200, Oleg Keri wrote:

[...]
>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>> index 709a2dcf4c73..0a4ee12a98d5 100644
>> --- a/include/linux/topology.h
>> +++ b/include/linux/topology.h
>> @@ -351,4 +351,6 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
>>  
>>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
>>  
>> +#define cap_scale(v, s)		((v)*(s) >> SCHED_CAPACITY_SHIFT)
> 
> This might not be a very good generic helper, since it relies on either
> of the variables to be u64 for correctness.

So moving it to a static inline function instead?

static inline u64 cap_scale(u64 value, u64 scale)
{
       return value * scale >> SCHED_CAPACITY_SHIFT;
}
