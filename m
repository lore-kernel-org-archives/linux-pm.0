Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11A36404E;
	Mon, 11 May 2026 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497720; cv=none; b=kqsSyrR7exj5toFERiHjgbpJZw2VE7VyuPy4jzXyDr5A2CvUfvM0OgUgufngSFASVUbgosp9gMQcCbpvFjr09X2rwseX0hoVpqK56aPLn7wzL/U5UsXGeMj3kgfUKy8e98sEVXoOp4VYEiiX7GEpolmFkdzXKd822H6ipkksz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497720; c=relaxed/simple;
	bh=0MtkruYdiJ/eX05jsubsBwfsJcwY9DBytdxP0f/j3Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz/L3fyRV0RY+uXIjmWyFwz+szXtrsfFSTPHE4sU4ROWmXuHpUZ5SplBwJ/0Mxd2ERmLKq3RVrTSC06VtakMJ3J4PxboOGshqPj37sSoaPB2V3aexvR4Ed+Xym4ll561iCpLuP/YHnKDOCVne5qo9MAY83Is+wqyUNtFR6IskYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jVGUP9nC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jVGUP9nC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XuJXmr8s0yqIVHFukyAe7prwO8NvqLASLSTUigYSBiU=; b=jVGUP9nCI+/HWeqhJ3Y7PfyhaW
	sv9quOy8s1vblm3jg0HCz6U8TD6ok2aIjXlsDEAP/yUFXSxcSJndD3QHsSsP8LmYKlUgbo6bv2utx
	oCqDEzPkrvJeezuqEClglCWDVfxs37pyqaTzjvuhPFqezYpXszaTP9ecGGea4fk6lqM4z0l3mGR9f
	WawqK0CLslAQ6davs+KkNIPYSczqIbOderulYyyW0TXMfEyB217gXJk6eZOePwgG3rur4bPezhGKA
	Byz2h+i+xqLIkzbON04rqT3DTtHPgwjWJJKFFdfWQAXSmbjmWpwRgTeRM7zAWTc1o7VKs3BkE+sPd
	3hNutkiQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOQ5-000000082Mi-1Akd;
	Mon, 11 May 2026 11:03:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9CF8430075A; Mon, 11 May 2026 13:03:28 +0200 (CEST)
Date: Mon, 11 May 2026 13:03:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 09/13] sched/qos: Add rampup multiplier QoS
Message-ID: <20260511110328.GS3126523@noisy.programming.kicks-ass.net>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-10-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504020003.71306-10-qyousef@layalina.io>

On Mon, May 04, 2026 at 02:59:59AM +0100, Qais Yousef wrote:

> diff --git a/Documentation/scheduler/sched-qos.rst b/Documentation/scheduler/sched-qos.rst
> index 0911261cb124..f68856f23b6b 100644
> --- a/Documentation/scheduler/sched-qos.rst
> +++ b/Documentation/scheduler/sched-qos.rst
> @@ -42,3 +42,25 @@ need for extension will arise; and when this happen the task should be
>  simpler to add the kernel extension and allow userspace to use readily by
>  setting the newly added flag without having to update the whole of
>  sched_attr.
> +
> +2. QoS Tags
> +===========
> +
> +SCHED_QOS_RAMPUP_MULTIPLIER
> +---------------------------
> +
> +Controls how fast util signal rises. Affects frequency selection when schedutil
> +is in use. And affects how fast tasks migrate between clusters on HMP systems.
> +
> +It affects bursty tasks only. Perfectly periodic tasks are well described by
> +util_avg and the rampup multiplier will have no effect on them.
> +
> +When set to 0, util_est will be disabled to help further with power saving.
> +This behavior can be controlled via UTIL_EST_RAMPUP_ZERO sched_feature.
> +
> +Value is not capped to retain flexibility, but it tapers off very quickly to
> +notice a difference above 16. Roughly it takes ~200ms to reach a util_avg of
> +1000 starting from 0. With 16 it should take ~12.5ms. A range of 0-8 is
> +advised for general use.
> +
> +Cookie must always be set to 0.

So this is a very specific feature. This is made possible by basically
having a huge type space, allowing for throw-away hints (as per the
previous email).

I suppose having these specific hints is easy, but as per always there
is the discussion about describing task behaviour vs implementation
details. With the argument being that task behaviour might be a more
lasting / stable hint, while implementation details are far easier to
actually do.

I'm missing this discussion.
