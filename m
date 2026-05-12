Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06D49550B;
	Tue, 12 May 2026 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574967; cv=none; b=ovJk/ULfmmFTHIBKJzKJCmPKfzUsTYOIxiKOJvrAEfjNUT2cfErgxKi3LRg2DfOzG8Apjfczk1wTA5fVxkWl8npe0mCaNNDMGHrNpyvUddtWnJICBF/TqPMU24BS3H8YqIPEtRb9CUp/aZ74IImX7r2X1/YQaAy/H2LvvHv5/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574967; c=relaxed/simple;
	bh=RNF0f73Db5YZRFzMaXRzGlLkqGQ3wjgy2dW1t6TRE/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuTnvWVFrBQC9qg4OQUV3hubJEn6rerXmvdbv37hDxoMGw/Xv9kfolIELvnCbNDeD+gZ1B0IKDWfqWacRSp+5BYx07IbTS3a4HJC8nDM1jVOeyGM79gC2qydA3xpYcB3cEI7ySbp9L1vc4XO+8mGwlloQ4cbchigP/gROFM4REw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tY17iWY6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tY17iWY6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=36nQWEc3NBQXxwDJu68IBhPgFU6fV8wcKUh/x/U3ERw=; b=tY17iWY6DSwvPy7QLXhWc6IQh6
	JDzzPzn6SDMUVZ1JZP0mW8t9EU6nEbufzxZ9kDmJc+yInbZpmYPLLwCeu/QbnlH2wXjL0+Sdpe0zp
	Ud3eDhgpGQQecuolgRzqg8Yrxr0JpvxzngOayY7xkuWpHEz6ckGnWWjZVA5bTRB8At8BMox1NSfIV
	MV9mGGcLsU/FOtJHWGnPIu5aqbGM5+kyFPYEkEX2hrV/2Ki2OvRpdrJo5MeceFwdvme2g7VrPEqew
	HFfnNDc1tTsPV7wBsfUcgKrzkKaRjkW+EyMCARP/Ho5wZ5eybqavF89hZ24czfiMCKEcon4z+TmpV
	NeWoB2kw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMiW0-00000009R2L-1SIn;
	Tue, 12 May 2026 08:30:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CEC82300882; Tue, 12 May 2026 10:30:54 +0200 (CEST)
Date: Tue, 12 May 2026 10:30:54 +0200
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
Message-ID: <20260512083054.GM3102624@noisy.programming.kicks-ass.net>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-9-qyousef@layalina.io>
 <20260511105704.GR3126523@noisy.programming.kicks-ass.net>
 <20260512075809.5on43u3wrnelqe4i@airbuntu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512075809.5on43u3wrnelqe4i@airbuntu>

On Tue, May 12, 2026 at 08:58:09AM +0100, Qais Yousef wrote:

> If you saw schedqos code

I was in fact looking for that, but found this series did not include
it. Didn't get around to looking harder yet..

> I already have to parse procfs to discover all existing running processes/tasks
> after connecting to netlink socket to listen to new forks/execs (and plug the
> race). 

