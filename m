Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450394A1E12;
	Wed, 16 Sep 2026 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557050; cv=none; b=awiD77BLDnvhi2vsEF1mx5aHkyQXAKiuRwyxwc6m9DsYMARx1yg9S/y4+GBDX/kfS9d1Qnnb5rTae2msrlIXdfKrMHoE8HzuxViwFC9mpjx6v0bHsoNh4wDpWtxlcHYNo/IBZwaOZNK/H0ZIraqa+HG9aWf+5UFzEeQgAAmFD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557050; c=relaxed/simple;
	bh=mathEgzzR7eRS3urb+X7mzdUfdtyv9AcODkNHtsKJc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1fOEDpeC5zjT0U817Nwm58PJJLbRMU9Gr/hwYMRRfR/rXhaY7PvHR1YPn6wRoyizmmMVp/tjpKmTvHxlxgBvAIy5fCzj0tbU9jJBILVp9r/4sunBIAhZZwP1rUptzFPBvvBnrCnqOjGTMMCQYtqyjZcaC6dG3n3yFfXVezTdV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sWBr/t7V; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sWBr/t7V"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D88152B;
	Wed, 16 Sep 2026 04:10:28 -0700 (PDT)
Received: from [10.0.129.72] (unknown [10.0.129.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70EFE3F86F;
	Wed, 16 Sep 2026 04:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789557031; bh=mathEgzzR7eRS3urb+X7mzdUfdtyv9AcODkNHtsKJc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sWBr/t7VKdjdq8qAIPLclh8TaoWmDEoLi3E9DDqVh9kl57R2IO3PedvWGLti7Tl9n
	 mUP6orlwtNKgRaoIyOBuikBdOGNBqRma5JvImffHXqTdswPOM4UAwfaBN7AaPzxkIb
	 OHoqX6H6bAoOKsmF5MOQaiy6OBkg5da7Hn2Q8h00=
Message-ID: <0b986953-acaf-4204-814a-77116e0db6dc@arm.com>
Date: Wed, 16 Sep 2026 12:10:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Randomize equally shallow slow-path
 candidates
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: beata.michalska@arm.com, cl@gentwo.org, daniel.lezcano@kernel.org,
 dietmar.eggemann@arm.com, elif.topuz@arm.com, juri.lelli@redhat.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 rafael@kernel.org, rostedt@goodmis.org, sh@gentwo.org,
 vincent.guittot@linaro.org, vschneid@redhat.com
References: <20260916100116.701206-3-christian.loehle@arm.com>
 <20260916110603.24230-1-kayracizmeci@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260916110603.24230-1-kayracizmeci@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/26 12:06, Kayra Cizmeci wrote:
> Hello Christian :>
> 
>> Picking the first eligible idle CPU leaves a scan-order bias. Concurrent
>> slow-path selectors can choose the same CPU before either task is enqueued.
> 
>> Use reservoir sampling in the tie branch, resetting the candidate count
>> when a lower advertised exit latency is found. Use the per-CPU scheduler
>> PRNG and reciprocal_scale() to avoid variable division or a second scan.
> 
>> This reduces deterministic convergence without reserving the chosen CPU.
> 
> OK. 
> 
> But, your test platform was 160 Cores too. I don't think randomization has the same effect on lower
> CPU systems.
> 
> Let's create a scenario:
> 
> On a 80 Core System, that %50 of it's CPU's are idle the randomization's chance of choosing the same CPU
> is low. Since there are 40 CPU's to choose from.
> 
> But on a 8 Core System in the same idle conditions, randomization's chance of choosing the same CPU
> is really higher. Since there are only 4 CPU's to choose from.
> 
> I think this solution works better on higher CPU counted systems. 

Yes, this mostly works for higher CPU count domains, but the
issue I'm trying to fix basically doesn't exist in the 8 CPU domain
in the first place (first of all fewer chances of having simultaneous
slow paths running that can race and also the slow path is much faster,
i.e. the race window much smaller).

> 
> And I don't think it fully removes the issue. Just better than the original tho.
> Thinks can still go bad on this one too, just harder.

Fully removing the issue would require some synchronisation which the
numbers (which admittedly are pretty modest already) just don't justify.

> 
> Maybe we could add a fallback. Because the real concern is the selected CPU's state
> changes when we come to enqueue. If possible tho, I did not really test anything.

And then do what? rescan?
I don't think increasing the slow path is justified at all, when this relatively
straightforward randomization already significantly reduces the chance
for the 'pathological' test platform.
