Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90B7346766;
	Thu,  8 Oct 2026 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484190; cv=none; b=hvoe3uVNTDpb2D5EA4xabg7QHQwBuNmqOnS9q5yUrTg2g+8RM8aHn7HtUd+sLK9hwu1aQVAgc1z0yEEV7kMKQq3S7/5wMvS4f8D8LQy9Iww1rVemHeSTWQr/1v5ehvTlvtBZjwg4U5FY1iMKsBBZCFfFbe3+qrM25RYMTTorQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484190; c=relaxed/simple;
	bh=vY+DHnrPUYQ4w/x+EPipU/aShx4L9+0X30ChAt5L5yY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u8j9R3NQjBbpNqxNa0ly7oKX7CJJ7yVQD6oP27rdTdZcF/n8rk3iqWH/aPmpZILI61FE8qXm3uXtnpEQ+wwGNdc4+N9cfevchXZ/zRcmpVdGjm6SjaEVqivk0BxusQQDiQgq85hLcL52xk9H3pWjnuKNZ3zUzsn/76OJRArCBJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cqsPYpmJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cqsPYpmJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8C741477;
	Thu,  8 Oct 2026 11:29:43 -0700 (PDT)
Received: from [10.57.87.21] (unknown [10.57.87.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ACE13F66F;
	Thu,  8 Oct 2026 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791484187; bh=vY+DHnrPUYQ4w/x+EPipU/aShx4L9+0X30ChAt5L5yY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=cqsPYpmJypoUMspja+EqmZVZg4SBH7WG+bED3zhKtdumfyFtaq2cBLjWhnJjaf06G
	 mrUHVzUH/vt9TQeRygdY+oDDViUHh5+QGfJzi5mxOS2ZpfJmiDg3mjd9l07e08pxP4
	 a9VthWom4SLH98Zj8zLPUsPf4TKXuKCZZsU/lxwY=
Message-ID: <faf34e6e-ecd9-471a-b30e-3aa79e3ee063@arm.com>
Date: Thu, 8 Oct 2026 19:29:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: Add the shallow governors
From: Christian Loehle <christian.loehle@arm.com>
To: Roman Kagan <rkagan@amazon.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nh-open-source@amazon.com
References: <20261008-b4-cpuidle-shallow-v1-1-c19e71127b14@amazon.de>
 <e18bd763-0d6d-4bfd-b59e-78f952c94aa2@arm.com>
Content-Language: en-US
In-Reply-To: <e18bd763-0d6d-4bfd-b59e-78f952c94aa2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 19:17, Christian Loehle wrote:
> On 10/8/26 19:06, Roman Kagan wrote:
>> The idle states offered by a platform trade wakeup latency for energy
>> savings, and there are situations where the trade is not worth making:
>> while a latency-sensitive workload is running, or during a live update
>> via kexec, where everything from the outgoing kernel stopping the
>> workload to the incoming kernel resuming it is downtime, and deep idle
>> states may lengthen it.
>>
>> The mechanisms currently available for that are all one-way.
>> cpuidle.off=1, idle=poll and idle=halt can only be requested in the
>> kernel command line and cannot be undone, and the PM QoS interfaces
>> (/dev/cpu_dma_latency and the per-CPU pm_qos_resume_latency_us
>> attribute) can only be used once user space is up, so they cannot cover
>> the boot of the incoming kernel.
> 
> You can also disable all but the shallowest idle state in sysfs:
> echo 1 > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
> 

And I'd probably prefer having that exposed via the cmdline rather than
two separate governors...
