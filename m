Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D184BD34F;
	Thu, 17 Sep 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662258; cv=none; b=X/V0TT5zDIIcDN4+Ah3v+2Ghz9BudC6sVhXxldP9kflcej2+Fo16Y2newAH2cpia9Xt83AIu0Q3Ta+6ODGoBmnaOO/qeBMPM6pZ0qSbXD6ticf26L3OOJACcnzk6zwB03RYnPWSowbJnsxG7OmwKQzE2PxqS/bsP1yu7pMFNbS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662258; c=relaxed/simple;
	bh=Agz2OBwfyMw7HSP4k52XwefCBTQXRZbqPYpbtyQGd3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmFT4TXMn8vW24eOrcTIDaNa2NROOExYdA7iJ84wHMjh+bIS6TxWFTIywat3Jll1zxfTs0xf6VPPYpCJy68IeD/8Ywa7vSMBd1bxjuYJhq65533z9b886Yj6cIZbpxtUaNvHMbOt6iFZwSAR0B12vSYfB2qYu3FHKrzgd4U6xBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iZokQmM9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iZokQmM9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AKWHLTxliGt+Tbh7hwbvU0Fa4GfVYbsFsDmdsrV9fPw=; b=iZokQmM9eeTmNj/Y8blbt93mJj
	5nwCSYOY/Pz/KAn70rWT6LUTfoGacPYa8LliAl+x79Z923zcIhM1bg1O3rErc5emL1u7AjAB2jhex
	6+nOJYYCPx/L8Pvj24vMocvdw2JEjDuGyf99pNQEreXkYQZLSzRpbHBN6tFL7htkdU9eFPic8NtS1
	4HdgOGD7GsIgSczdUauGDNEhRm/kBmBFERnmlDUO55f79v4jeFRducwm0z5Qvc0agteaA/SQCLgtX
	p9QwFI87Lu/CMI9x3Usecy9SA2PoP8SWn/1+sNT+/yVb8L5xV8OiyN2ro6wysEwqFKGFwhA7aGIia
	uk9Srrzw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Eu9-0000000B18W-2nOB;
	Thu, 17 Sep 2026 16:24:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 45739303078; Thu, 17 Sep 2026 18:24:09 +0200 (CEST)
Date: Thu, 17 Sep 2026 18:24:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Oleg Keri <okerixx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] arm64: topology: fix arch_freq_get_on_cpu()
 overflow above 4.19 GHz
Message-ID: <20260917162409.GQ4121339@noisy.programming.kicks-ass.net>
References: <20260917125112.2283-1-okerixx@gmail.com>
 <20260917125112.2283-2-okerixx@gmail.com>
 <20260917153224.GJ4121339@noisy.programming.kicks-ass.net>
 <b7fbe8bc-56b4-4705-b5d8-4a377eb062ee@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7fbe8bc-56b4-4705-b5d8-4a377eb062ee@arm.com>

On Thu, Sep 17, 2026 at 05:55:44PM +0200, Dietmar Eggemann wrote:
> On 17.09.26 17:32, Peter Zijlstra wrote:
> > On Thu, Sep 17, 2026 at 02:51:11PM +0200, Oleg Keri wrote:
> 
> [...]
> >> diff --git a/include/linux/topology.h b/include/linux/topology.h
> >> index 709a2dcf4c73..0a4ee12a98d5 100644
> >> --- a/include/linux/topology.h
> >> +++ b/include/linux/topology.h
> >> @@ -351,4 +351,6 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
> >>  
> >>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
> >>  
> >> +#define cap_scale(v, s)		((v)*(s) >> SCHED_CAPACITY_SHIFT)
> > 
> > This might not be a very good generic helper, since it relies on either
> > of the variables to be u64 for correctness.
> 
> So moving it to a static inline function instead?
> 
> static inline u64 cap_scale(u64 value, u64 scale)
> {
>        return value * scale >> SCHED_CAPACITY_SHIFT;
> }

Yes, that would be much better defined.
