Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476176;
	b=iq5mtAwEb/IUCHkoA/py+8wUDb6YnQUmWTMInvbEiDJRMlwKhKuAA7nN6H/l7PzmgzB4
	 F/0xzsqLdoTrdQKTNlFFZPqQy6hNsWOUIr0bAhvG5J2yNAwfeyf2gMglBDo757iYnj3ge
	 za2vDoD48VOJQZIkGi8KkPecal1iS8i44tE3Ri+gNs7NPVWx3vBhmKkaZKmpPU6TRIcY/
	 pZkQUycwxdBousxt9xuX2U14GDSs/Gsuar2BnDJLN+VDitdFnig5dTgb+bcdyBTCxS4Vx
	 CeNcF3q4cgcUrzeT1FEeRXbTOLYF5xPqnja1UIFmfT+dBnjHBzz3at9DAcjntPqO1YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476176;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=V1TkxtIoqBqUbcf4pVuMk71T3cTQnXgCiyjTV81SiFs=;
	b=sUylPOOlVUoxdlKgaylvP0qi4F8PzQY/a7envXmchUr/atQ6DzhFJ6qKaLU7rSDiGtVH
	 uW94RTohySYKj5GGk11ItT0V3i42OXQrJ8OJJ767qugdC4pJuUllVqtq5qZIDzyqu3EUK
	 vI564gcDpZ5O1RyBuERkTx4t2dxWb5lOkKGlgt3dOjZW0ZJHpKv9f29IQdY69Exsc/MId
	 WVtRR6dIG03Xim9YtJEeMUXupllatqm50wmf7Y6IHwyrgBbNxmS7sxFDgdTT0N0IRX5WM
	 NaBYVvaFvPQWSciWkZcDJ6OD2hftLcvA38NAHUvxCWiVaarVhFDg8uZ9Vhwb0n6RMaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZX4JBcG8;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF5606A31C;
	Thu, 12 Nov 2026 09:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CCF5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZX4JBcG8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V1TkxtIoqBqUbcf4pVuMk71T3cTQnXgCiyjTV81SiFs=; b=ZX4JBcG8ovXTD6PwDl9mNjOVZI
	+NIiAx2batLWNl7YChL/mDnXVzn2ZQW1D2cmWDEJ5gwnpiIyJDW1k4lDjug2DlC6OaxDM4TRMOSUJ
	LjgKIVoAuZusv6UluuynERhsWL0LZ1Kp3KhO4HIXH0Cz6vY3VFQAs+mAKXGz/RG3nXTPurFJSpBbc
	gFdQwpe9wZuAwI8yTTmM0y6EWrov7VTI/+6bVLWwNsQG50UiYsVFVRNiNGg9IevdkO6a9aJrAdL1a
	TjIFZ7TZupdecQvI1j+sesQVt+AYVRdS//eyfqYtvOeuoANykTUjRxj0apwHU3YSFVTN0Fj5waQn+
	GQqrnLIw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRRE5-00000005aEe-2gbb;
	Thu, 12 Nov 2026 09:36:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 35A83300400; Thu, 12 Nov 2026 10:36:13 +0100 (CET)
Date: Thu, 12 Nov 2026 10:36:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Francesco Nigro <nigro.fra@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mike Galbraith <efault@gmx.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [REPORT] sched: ITMT + DELAY_DEQUEUE: woken task waits ~1 ms
 behind another task on the preferred CPU while allowed CPUs are idle
Message-ID: <20261112093613.GJ2668804@noisy.programming.kicks-ass.net>
References: <20261103154603.1893325-1-nigro.fra@gmail.com>
 <5af4860d-096a-4e9d-a3b3-0b8277924146@amd.com>
 <CAKfTPtCGmZQ9XVYJL_5f603qTf6_CdeKsq_pAYM_Ldqs3NaXaA@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCGmZQ9XVYJL_5f603qTf6_CdeKsq_pAYM_Ldqs3NaXaA@mail.gmail.com>

On Thu, Nov 12, 2026 at 09:59:02AM +0100, Vincent Guittot wrote:

> If the root problem is the migration of a delayed task during
> newly_idle load balance which transiently make the CPU not idle
> anymore for another task waking up simultaenously, can't we just
> prevent migrating delayed task for newly_idle case in can_migrate ?
> Migrating a delayed task to a newly idle CPU doesn't really make sense
> because it will be the only task that will e migrated and will be
> immediatly dequeued.

In fact, I would suggest just dequeuing it right then and there. If it
were actually runnable, it would get to run on the new idle cpu.
Therefore it is not contended anymore and its lag can be dropped.

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11771,7 +11771,7 @@ int can_migrate_task(struct task_struct *p,
> struct lb_env *env)
>          * 5) are cache-hot on their current CPU, or
>          * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
>          */
> -       if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
> +       if ((p->se.sched_delayed) && (env->idle == CPU_NEWLY_IDLE ||
> env->migration_type != migrate_load))
>                 return 0;
> 
>         if (lb_throttled_hierarchy(p, env->dst_cpu))


