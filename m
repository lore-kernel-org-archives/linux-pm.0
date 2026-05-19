Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7A39282C;
	Tue, 19 May 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184077; cv=none; b=eN7UeQa7cZmZFyvz8v3YAaXLy0mh0ZmH4oCTlWUNXe/MUakQ1qKWfAZ0K8PW/dqdgxrcESQAt/fBBlKNIPbp3TynTlMNqZwLXlAOvC6Yu+FMV9Dj+SMsyYl8MuY6FbEppR3CZx4BcS5nTx0cbX+Qzg/YnFE7VckoC9LIgsEQR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184077; c=relaxed/simple;
	bh=syW4TzScO095LY74Om7zWDpbbY1uK0nZH3Cg1VsSSuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ6jx8l+vJYC2jVgmKEqPGpCqlVTKApTUDZys1A7Z7YtmOw2Q//7up4U5z+XPEgv0B4itTo5lli8uHQ95oj78u6DXLrPQCyY+Jl2KHTt8z34Gj0HN4c+tvG69pzbeLt+UA9GhAq3LbmUOdzLP3sAcxhDo/RG3Vecfryn+YljmGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qo8KXtLh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qo8KXtLh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=syW4TzScO095LY74Om7zWDpbbY1uK0nZH3Cg1VsSSuY=; b=Qo8KXtLhNbX3xDrUGyooskE+ST
	L5MJX67tQkQR0STDp3HveKM63VoDydTqWIUI6ckGLCXFLVrC0AE6IBKCbQVXBnbyl+yqs2sbpV3v/
	Am9jBgzIM530liwvSnXrRFmd1gekAQiad98sEnpEJ+vkXCaVzdAZAC+HJj6bHZFSncD4wnI6ukJwu
	+1W4u7usoeoGpp/iQNh/tlBVVlvk8KV/vc1H5yt/vpodARXhjpizOPGI3pTXTGfUiJKoO5qFphjat
	AcVe+6/u73lL2rn/CnF2EZCHBtoUSrtChBr+1E3d4LByocJRd3dGYc2UQuO4gOGt5VTYgnaafvg22
	cmAjBzkA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPH3C-00000005l11-323N;
	Tue, 19 May 2026 09:47:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6718C300182; Tue, 19 May 2026 11:47:45 +0200 (CEST)
Date: Tue, 19 May 2026 11:47:45 +0200
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
Subject: Re: [PATCH v2 RFC 08/13] sched/qos: Add a new sched-qos interface
Message-ID: <20260519094745.GC3126523@noisy.programming.kicks-ass.net>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-9-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504020003.71306-9-qyousef@layalina.io>

On Mon, May 04, 2026 at 02:59:58AM +0100, Qais Yousef wrote:

> QoS is treated as a scarce resource and the intention is for the
> a syscall to be done for each individual QoS tag. QoS tags are not
> inherited on fork by default too for the same reason.

This is somewhat awkward. Most all state is inherited on fork. And all
our tools are built around that. This is for example how I set a shorter
slice on proton when launching a game (chrt -o --sched-runtime 280000
0). Tagging each individual thread that comes out of wine / random .exe
is going to be painful.

Can't we have both by using something like SCHED_FLAG_RESET_ON_FORK
combined with setting a hint?
