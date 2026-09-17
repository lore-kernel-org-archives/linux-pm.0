Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528D275870;
	Thu, 17 Sep 2026 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631248; cv=none; b=e9tggdVqSIDFDowdC1mgIC1FB3GgowFFNNPDm74XWgDnaM+C+daNIyNkqpMbCGEGmhY4L9pt+LmOaPH9nUV56S6DcoInxqMCaPmqygl9b/Ggpr9ao7BIT1bJlt0S5ROBtaudN5X7AsuIZKvrdkG5wS0dsxrcMQeAs9gffXtU5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631248; c=relaxed/simple;
	bh=ktcusHIkXn1+6Uz/mencBJRQikVjIe+atsE/UsdaOIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Srf91KxkSvRbL/QMToBsc12Tb50YSyRwugdocRE7sNhA35xZruWDqkaHKBAcRfGzvAu37imWZdvg5kZbln8Bpo9/TXen/FzU1e1RD6s6JRQ1jUiaJHkLKlvzmChNDGVNSXD8v0xs0wI7Yko3tqSzWjxU+wdqLkJwa2bHSBZL4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=byJv6E5n; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="byJv6E5n"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DF6C1476;
	Thu, 17 Sep 2026 00:47:21 -0700 (PDT)
Received: from [10.57.50.144] (unknown [10.57.50.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBD013F7B4;
	Thu, 17 Sep 2026 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789631244; bh=ktcusHIkXn1+6Uz/mencBJRQikVjIe+atsE/UsdaOIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=byJv6E5nWK10S42UoSkt4o6y0tciC41sLAUTN5gJs9u1CV7PnDPKlsjC3+gctvSZp
	 a6oIvtgmAN7NS/uf/07t+ntW9yPLV8TMdqgAVeKZmrp0tZYvtTmMKcwLVDZLVsfIjn
	 mIu73Gf9GKMTcIP8DJ/K8eHUfQHi7qVmtAiQh0MI=
Message-ID: <e11d588b-e597-4210-baa3-278eaeb0cf52@arm.com>
Date: Thu, 17 Sep 2026 08:47:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Randomize equally shallow slow-path
 candidates
To: Shubhang <sh@gentwo.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Beata Michalska <beata.michalska@arm.com>, Elif Topuz <elif.topuz@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260916100116.701206-1-christian.loehle@arm.com>
 <20260916100116.701206-3-christian.loehle@arm.com>
 <08339e62-1787-e203-569c-a7fd3026395f@gentwo.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <08339e62-1787-e203-569c-a7fd3026395f@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/16/26 20:43, Shubhang wrote:
> Hi Christian,
> 
> On Wed, 16 Sep 2026, Christian Loehle wrote:
> 
>> +            } else if (!idle || idle->exit_latency == min_exit_latency) {
>> +                nr_candidates++;
>> +                if (nr_candidates == 1 ||
>> +                    !reciprocal_scale(sched_rng(), nr_candidates))
>> +                    shallowest_idle_cpu = i;
> 
> available_idle_cpu(i) ensures that this is an idle CPU, but !idle means that no active cpuidle state, meaning no exit latency is available for comparison.
> 
> [PATCH 1/2] treats such a CPU as a fallback i.e. it is selected only when no idle candidate has been found yet. Here it becomes an equal reservoir candidate, even after selecting a CPU with the minimum known exit latency. That is, it is added to the random selection pool and can replace shallowest_idle_cpu.
> 
> Is that intentional ? If not, should reservoir sampling be limited to
> candidates with `idle->exit_latency == min_exit_latency`, while retaining the first !idle CPU only as the fallback?

Hi Shubhang,

Thanks for taking a look. Including !idle candidates was intentional,
although you're right that this changes their treatment.

I think there's a case for giving NULL a zero ranking. With a working
cpuidle driver, NULL can mean the CPU is preparing for entry or finishing
after exit, making it a good low-latency candidate.
Architecture fallbacks are also reasonable candidates AFAICS.
In any case, I'd prefer to address that separately (perhaps through a
helper in the idle/cpuidle code rather than embedding those assumptions
in fair.c and will drop !idle CPUs competing with min_exit_latency CPUs,
the patch doesn't need it.
Thanks!
Christian
