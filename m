Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580045;
	b=lSNlnBqO28xbW4+qAV8UOifDo/WsWT2y8PVwHPyDl8VlRlmFeiQjDqlzk/X+NXZ2NOEb
	 bIR4E80GLxm/OdQJch7LSm+szL/OFelDIaW+L6sYsOcRLqNXu+qUKbct6I7MxKk8c2zdR
	 1lgVnuQ1Jvc+d5RNxH44Riifqx9bJiITuJeAisn8IXFRiJKOjr5WEq5SICkxjsTrAxT5j
	 YvXL6AUmHRFHEhOTpHg+VoGD1gqfUh65Ly9k1cU5SaYnvkYeq2sHh5UViiqohNagjdhCu
	 aQMJK5774izwSHtgfOL3BydNueth6bJbDbhhQ66cvx7HgYrWyHJOxteXuxlqe2zjIKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580045;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Po7/jVChBR1NOFetcDnMahCqqv+8JqoxDTHPUu+Quo0=;
	b=naNCSTFHadky/ggMVU1bdNjG6s1p3gw5eAfFguax1wFzyvmOfieQgB5uzEqMsNAaV+Nx
	 UarGMpsOIKzGrVwHZrYEqMCnJG2gsHtJ+Zbi9gjDPVKDF3yD+FQQm+rliMZfWV0Y92WRH
	 1im2oYHCo0xMDy0GZXWO+NPFfI4BDgRJ4div4IuFVAusyVexLpSlQV5651aKvy8QvwCr+
	 H1umxcErEHASX8OicjbWWNPjIadrzaX6W4f+Tonye7G5dgfhpHH490AXG24vAhX+Z7+pf
	 OA6BCSFgg21Zdagcp9MjZVCx92JdXUMrSwVbe/YyHUS/RqWsp5GHobE438VWnKdwcfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rr8hG/+u";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983D606A319;
	Wed, 21 Oct 2026 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rr8hG/+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807FD1F000CA;
	Wed, 21 Oct 2026 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792580044;
	bh=Po7/jVChBR1NOFetcDnMahCqqv+8JqoxDTHPUu+Quo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rr8hG/+uR/z7eFLBUztuoFJ+EtF5jHC6daPRxv6jodJ1LpHvEYGFgNUlbbzziNmXz
	 yVoMl4luThud+sj10uoMEIKC0xjlVqDCQ62w3WuWFpEQ/R2YOhiwctqU8tQVqQBn0a
	 MdpJk1+CzrvsV9Kzxd+W+ghULNkVWyNickVr1HDqPhkd6F5kOD/IZ08C5jO00vXT0y
	 YJWY7ZqC7ip2JFm5aAsXI66sbRIYTdW6RU2zbNXtUWHGVOKvaqytLUsOLwkcYIl/6z
	 HcDcZ8cJ3/FL8lZHhKsaN302rjzuXRTWkpLd8FycVcZt5Jxk19LZ/X7pGYACfI04pv
	 puR+uIYwgEQGw==
Date: Wed, 21 Oct 2026 12:54:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Sadrul Chowdhury <sadrul@google.com>
Cc: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, John Stultz <jstultz@google.com>
Subject: Re: [RESEND 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
Message-ID: <20261021-miserabel-zahnrad-gepachtet-9bacbeb24a4c@brauner>
References: <20261020121159.2154649-1-sadrul@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020121159.2154649-1-sadrul@google.com>

On Tue, Oct 20, 2026 at 12:11:58PM +0000, Sadrul Chowdhury wrote:
> During system suspend (freeze_processes) and resume (thaw_processes),
> threads blocked in epoll_wait() sleep in TASK_INTERRUPTIBLE. When
> try_to_freeze_tasks() executes, it must wake up every sleeping thread
> with a synthetic signal so the thread can schedule, run try_to_freeze(),
> enter TASK_FROZEN, and sleep again. Upon resume, the freezer wakes them
> all up simultaneously, only for each thread to re-enter ep_poll(),
> observe no ready I/O events, and call schedule() to go back to sleep.
> 
> On systems with numerous event-driven daemons (where hundreds of
> threads idle in event loops), this causes a large wakeup stampede and
> thousands of redundant context switches per suspend/resume cycle.
> 
> An earlier attempt to make epoll_wait() freezable in commit 1c441e921201
> ("epoll: use freezable blocking call") was reverted in commit
> c511851de162 ("Revert "epoll: use freezable blocking call"") due to
> reports of userspace corruption (Bugzilla #61781). Under the legacy
> freezer design, freezable tasks could wake up prematurely while
> hardware and peripheral drivers were still suspended.
> 
> With the 2022 core freezer rewrite (commit f5d39b020809 ("freezer,sched:
> Rewrite core freezer logic")), the legacy fake-signal mechanism was
> replaced with the TASK_FROZEN state. Tasks sleeping in TASK_FREEZABLE
> are safely frozen in-place without waking them up, and the scheduler
> guarantees they cannot be woken until thaw_processes() explicitly clears
> the frozen state.
> 
> Mark sleeping tasks in ep_poll() as TASK_FREEZABLE. Benchmarks on an
> ARM64 test device demonstrate that combining this with freezable
> select/poll reduces thaw latency by 63% (from 20.64 ms down to 7.55 ms
> mean at fixed CPU frequency) and reduces context switches during
> freeze/thaw by 87%.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
> ---

Seems you generated this against an Android tree. Generate it against
current mainline and resend, please.
