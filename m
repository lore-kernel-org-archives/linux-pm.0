Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66D4D37C1;
	Wed, 16 Sep 2026 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587803; cv=none; b=gkoMRriJaa+bmVu2tEjwNNZCIsi/i5Fd+V302s96/g0bT9ltUBUhWG/3k3kttcB3pibbxb37eDjAzyWxQr3PmoaeqRWKEbCWiFUDouFNqNLogLMscf4wCGuG0QmQdklNJcamSkekxE7QtEhXkZ0mZcF6/zlhlmYblZHldEJspVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587803; c=relaxed/simple;
	bh=R+1IkSGKairv43cSZqBmXGyYyusblntXw5vra3ZuaQc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KVqZmRPAGDNNE7tfuVVWE3TM02xQflwyWXaHmMS7VLVgi9k7T4ToTcn5U+wHHQqmbM6a6Gkmfs2EAJpfESo+6UOWejy6Mr9eLXtlvIdiAR1Mvkc3VKW/8b3+yVoPT1/naiWCdlN3iMhMGUM/UhEnBSQwtp1XtKjycysvYWWby+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=hpia7Miw; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="hpia7Miw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1789587795;
	bh=R+1IkSGKairv43cSZqBmXGyYyusblntXw5vra3ZuaQc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hpia7Miw0vNHg7qffvt/I3DcHxI5zLGoQsSJ9iI/VJzy8pY5FDo5wEkK7rTZC9dr2
	 p8iAWcJR/08sQakNTB8rvh0eEzg04BviXa+OL1XAX+kRARgcs4hg5+vxtGKieT96JJ
	 cEcFNp0Igta7ftP/4tWG5AdtrV6h8X8CsT+F69Ok=
Received: by gentwo.org (Postfix, from userid 1007)
	id 61DE5401C8; Wed, 16 Sep 2026 12:43:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 607F54010E;
	Wed, 16 Sep 2026 12:43:15 -0700 (PDT)
Date: Wed, 16 Sep 2026 12:43:15 -0700 (PDT)
From: Shubhang <sh@gentwo.org>
To: Christian Loehle <christian.loehle@arm.com>
cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
    Juri Lelli <juri.lelli@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Valentin Schneider <vschneid@redhat.com>, 
    K Prateek Nayak <kprateek.nayak@amd.com>, 
    Beata Michalska <beata.michalska@arm.com>, Elif Topuz <elif.topuz@arm.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@kernel.org>, 
    Christoph Lameter <cl@gentwo.org>, linux-kernel@vger.kernel.org, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Randomize equally shallow slow-path
 candidates
In-Reply-To: <20260916100116.701206-3-christian.loehle@arm.com>
Message-ID: <08339e62-1787-e203-569c-a7fd3026395f@gentwo.org>
References: <20260916100116.701206-1-christian.loehle@arm.com> <20260916100116.701206-3-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Christian,

On Wed, 16 Sep 2026, Christian Loehle wrote:

> +			} else if (!idle || idle->exit_latency == min_exit_latency) {
> +				nr_candidates++;
> +				if (nr_candidates == 1 ||
> +				    !reciprocal_scale(sched_rng(), nr_candidates))
> +					shallowest_idle_cpu = i;

available_idle_cpu(i) ensures that this is an idle CPU, but !idle 
means that no active cpuidle state, meaning no exit latency is 
available for comparison.

[PATCH 1/2] treats such a CPU as a fallback i.e. it is selected only when 
no idle candidate has been found yet. Here it becomes an equal reservoir 
candidate, even after selecting a CPU with the minimum known exit latency. 
That is, it is added to the random selection pool and can replace 
shallowest_idle_cpu.

Is that intentional ? If not, should reservoir sampling be limited to
candidates with `idle->exit_latency == min_exit_latency`, while 
retaining the first !idle CPU only as the fallback?

Regards,
Shubhang Kaushik
