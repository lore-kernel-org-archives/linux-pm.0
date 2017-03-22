From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: schedutil: Always trace frequency if it does
 not change
Date: Wed, 22 Mar 2017 15:21:16 +0100
Message-ID: <20170322142116.qpe2faqwbmlmhft7@hirez.programming.kicks-ass.net>
References: <10655562.4O9KtquB0A@aspire.rjw.lan>
 <20170322092951.GX5680@worktop>
 <CAJZ5v0jFDQ9fxHwVWM_Dg-Or5y6o_YJ5=sdyQDZ3Dt0U2bqy_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759745AbdCVOVX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 10:21:23 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jFDQ9fxHwVWM_Dg-Or5y6o_YJ5=sdyQDZ3Dt0U2bqy_A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

On Wed, Mar 22, 2017 at 01:52:04PM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 22, 2017 at 10:29 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > So why not fix the tools?
> 
> Because I can't.
> 
> I just can't go and fix all of the tools binaries that people use out
> there and I want them to use recent kernels at the same time.
> 

Thing is; you're now letting random tracepoint user dictate kernel
implementation. That's a bad state to be in.

(and why I hate tracepoint to begin with)
