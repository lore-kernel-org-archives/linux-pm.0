From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 10/11] PM / Hibernate: clean cached pages on
 architectures that require it
Date: Thu, 12 Nov 2015 11:52:33 +0000
Message-ID: <20151112115233.GB2657@red-moon>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-11-git-send-email-james.morse@arm.com>
 <20151111114039.GA8375@red-moon>
 <36DF59CE26D8EE47B0655C516E9CE64028672FF5@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35741 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754339AbbKLLvk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 Nov 2015 06:51:40 -0500
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64028672FF5@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: James Morse <james.morse@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>

On Thu, Nov 12, 2015 at 02:53:35AM +0000, Chen, Yu C wrote:

[...]

> > > static inline void do_copy_page(long *dst, long *src)  {
> > >  	int n;
> > > +	unsigned long __maybe_unused start = (unsigned long)dst;
> > >
> > >  	for (n = PAGE_SIZE / sizeof(long); n; n--)
> > >  		*dst++ = *src++;
> > > +
> > > +	flush_icache_range(start, start+PAGE_SIZE);
> > >  }
> How about invalid all icache lines before doing do_copy_page, since
> do_copy_page might deal with both data pages and execute pages, that might be
> redundant to do it for every page?

The point here is to make sure I-cache and D-cache are in sync, because
the page we are copying can be executable code, so flush_icache_range is
there to make sure that the code is cleaned from the D-cache to a cache
level that is visible to the I-cache (yes, the I-cache range is
invalidate too in the process).

I agree it is redundant for data pages, the point is, you do not really
know what you are copying at this stage, we can extend the snapshot
code to flag the pages accordingly, but it might well be overkill, so
we posted this patch to get consensus before proceeding.

Thanks,
Lorenzo
