From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 1/7] cpufreq / sched: Make schedutil access
 utilization data directly
Date: Mon, 8 Aug 2016 12:38:24 +0200
Message-ID: <20160808103824.GB6879@twins.programming.kicks-ass.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <9887668.FEg7fVruKQ@vostro.rjw.lan>
 <20160801192850.GX19455@graphite.smuckle.net>
 <5472075.XX6bKsbQPI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5472075.XX6bKsbQPI@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 02, 2016 at 01:46:51AM +0200, Rafael J. Wysocki wrote:
> On Monday, August 01, 2016 12:28:50 PM Steve Muckle wrote:

> > Can the DL policy be left as-is and discussed/modified in a separate
> > series?
> 
> No problem with that as far as I'm concerned, but in that case it won't be
> a Peter's patch any more. :-)

No problem from my side though. I just did them together as an
illustration of the benefit etc.. Rip it up as you see fit ;-)
