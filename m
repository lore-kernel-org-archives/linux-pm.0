Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3CC39EF33;
	Fri,  9 Oct 2026 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549958; cv=none; b=IOLcAm6ddv1OH8V5y83/XHpOV7S96qt4Fu2AeWmHwNknqcLlFXtgT+auVskcKwDUN7QV6Zowl41d5m5A+BcZ/myWzWvki06WZ0Q28a36+/PYLREund4ii3BEpFI9+ZFS5cRgCn1xanGJcGpeqpUpmUkyoCwXpXTOtszhrFRMBv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549958; c=relaxed/simple;
	bh=+XNdH8y169fMKCNtfDLtMucS75fvXgUGZ1gQ6tqsejk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uT9bRsjN4ctDwwFkr1SPDYAmLe0Lsau33RpwQz6W6j8DOWLJ4FJIG0ad8Di1rfuTjORtIX9gyiVKdY+3nmyfZ1MC5jFTCT4ncipFVnbr/pCAAIeqFmE4RNIRcfXSDWs30ylHb3tFgQV2khGmgYVpM3lfvFYDY4z4W5jrcac4+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BH4BIhGy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BH4BIhGy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E3671D14;
	Fri,  9 Oct 2026 05:45:40 -0700 (PDT)
Received: from [10.0.128.17] (e127648.arm.com [10.0.128.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 415DA3F66F;
	Fri,  9 Oct 2026 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791549943; bh=+XNdH8y169fMKCNtfDLtMucS75fvXgUGZ1gQ6tqsejk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=BH4BIhGyEm20Emlm18FjBq0CJ1q4Pz9CpuDF1oMsxtsJ24ro58u0yB2mhY73VO1HN
	 gGhKoIK5ci3xVVKodnZnkC2HnDmSEFP4zSANnr6t4rBpqB9bK9Wg/V95Y/Lf/zCcM2
	 g+WHGivtoIvOADanipH2s9mKh4PRzL7wVWnPFPbs=
Message-ID: <2e635fc7-3d5c-4555-b92b-9e6e405f1b23@arm.com>
Date: Fri, 9 Oct 2026 13:45:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: Add the shallow governors
To: Roman Kagan <rkagan@amazon.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 nh-open-source@amazon.com
References: <20261008-b4-cpuidle-shallow-v1-1-c19e71127b14@amazon.de>
 <e18bd763-0d6d-4bfd-b59e-78f952c94aa2@arm.com>
 <faf34e6e-ecd9-471a-b30e-3aa79e3ee063@arm.com>
 <asjaR_aPwevvBw_O@ub9ea591b72db54.ant.amazon.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <asjaR_aPwevvBw_O@ub9ea591b72db54.ant.amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/26 13:12, Roman Kagan wrote:
> On Thu, Oct 08, 2026 at 07:29:43PM +0100, Christian Loehle wrote:
>> On 10/8/26 19:17, Christian Loehle wrote:
>>> On 10/8/26 19:06, Roman Kagan wrote:
>>>> The idle states offered by a platform trade wakeup latency for energy
>>>> savings, and there are situations where the trade is not worth making:
>>>> while a latency-sensitive workload is running, or during a live update
>>>> via kexec, where everything from the outgoing kernel stopping the
>>>> workload to the incoming kernel resuming it is downtime, and deep idle
>>>> states may lengthen it.
>>>>
>>>> The mechanisms currently available for that are all one-way.
>>>> cpuidle.off=1, idle=poll and idle=halt can only be requested in the
>>>> kernel command line and cannot be undone, and the PM QoS interfaces
>>>> (/dev/cpu_dma_latency and the per-CPU pm_qos_resume_latency_us
>>>> attribute) can only be used once user space is up, so they cannot cover
>>>> the boot of the incoming kernel.
>>>
>>> You can also disable all but the shallowest idle state in sysfs:
>>> echo 1 > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
>>>
>>
>> And I'd probably prefer having that exposed via the cmdline rather than
>> two separate governors...
> 
> Doing this cmdline configuration per-cpu per-state is non-realistic.  I
> guess you mean a single option that would express a policy, like "for
> all cpus in the system, disable all but the shallowest state" or "...
> all but the shallowest non-polling".  But policy is exactly what
> governors are for.

Yes, I had something like
cpuidle.max_exit_latency_us=<N>
in mind that then sets the disable attribute for the applicable states.

> 
> Why exactly does having two more separate simple, narrow-purpose
> governors sound wrong to you?

Because it's a lot of duplicate code we have to maintain (and the
documentation).

