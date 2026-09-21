Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4968D4D8DAB;
	Mon, 21 Sep 2026 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005204; cv=none; b=Kj2hagNSRGRsc4BkQ+K4pthVgBvJxcYT/RbC/4Stdv0J7romBOrjaZoBZeBpaAsV7b5X0SjNZbM3BbVU867zb0WZz/PgMCUjg42w0i7qXQH6IIWHVSu69iQpmZW2XB8gRb2v9dbbndZWYHL554RCAtXPbBieLm2s/mN9hV+RnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005204; c=relaxed/simple;
	bh=8YbSKG1sZK+FnCRbWv3nMDyU6YpBB2r7aIxpnzo0kfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVScg/2spLiRawlygwHzLDXls6qgH8jArT2/5n901hEwlfHi00roR7NRv5/3qySU/xvE2qZgIOBQ+efTyoULYIo+Z5DN/dqCwQ/MlVgasT7y0Gg4LGie8HzLMDBhcuCx8Hx13RshAPah0Z4AQ9ybZOAZ0LuSvWpIervxvNElJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=govjCKyI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="govjCKyI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2700176C;
	Mon, 21 Sep 2026 08:39:57 -0700 (PDT)
Received: from [10.57.75.12] (unknown [10.57.75.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7D523F632;
	Mon, 21 Sep 2026 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790005201; bh=8YbSKG1sZK+FnCRbWv3nMDyU6YpBB2r7aIxpnzo0kfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=govjCKyIuThZiDAqYA+yK/WDEVocYh1ewcE9wWZHjKnpzaZnd70oqwVH4hcfE7xKX
	 KoJHBla36sZuREAi3NaOWTf0QMmM3KT9q/5Dl8SS49D4kXVbpLXPG2gcvADGrPF8At
	 xPiSPRinUcK7Wlj33Qm7GUOMf/cx8nuJjDoBRoLA=
Message-ID: <2d93f0c3-a3c6-4789-bd38-1b289634b8a2@arm.com>
Date: Mon, 21 Sep 2026 16:39:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sched/fair: Randomize equally shallow slow-path
 candidates
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Beata Michalska <beata.michalska@arm.com>, Elif Topuz <elif.topuz@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Shubhang Kaushik
 <sh@gentwo.org>, Christoph Lameter <cl@gentwo.org>,
 Huang Shijie <shijie@os.amperecomputing.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260917153915.1563875-1-christian.loehle@arm.com>
 <20260917153915.1563875-3-christian.loehle@arm.com>
 <CAKfTPtBft2pVrsZQGJu0UBjuqaGJ2ViE9N6YExLvBnpgEXDvag@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtBft2pVrsZQGJu0UBjuqaGJ2ViE9N6YExLvBnpgEXDvag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/26 17:06, Vincent Guittot wrote:
> On Thu, 17 Sept 2026 at 17:41, Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> Picking the first eligible idle CPU leaves a scan-order bias. Concurrent
>> slow-path selectors can choose the same CPU before either task is enqueued.
>>
>> Use reservoir sampling for equal exit latencies, resetting the candidate
>> count when a shallower candidate appears. Use the per-CPU scheduler PRNG
>> and reciprocal_scale() to avoid variable division or a second scan.
>>
>> Use a u64 latency key with U64_MAX for unpublished states. Published
>> states take precedence; when none are found, sample among the idle CPUs
>> without a published state.
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
FWIW some additional thoughts, in case the unpublished idle state handling
does end up causing regressions (but for now fingers crossed!), there's
of course the option of trying to bucket them into "entering idle" and
"exiting idle" by putting a threshold on rq->idle_stamp.
I've experimented with this, but similarly how it didn't matter if
unpublished states are treated as ideal candidates or worst-idle candidates
this also didn't matter. Throughout various benchmarks about 0.1-0.5% of CPU
candidates are in unpublished state window and with them now counting as
U64_MAX exit_latency they end up being the best candidate of the scan only
extremely rarely (and conversely even rarer is the tie-break between two
unpublished-idle-state CPUs).

> [snip]
