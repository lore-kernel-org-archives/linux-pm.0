From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: Performance of low-cpu utilisation benchmark regressed severely
 since 4.6
Date: Sun, 23 Apr 2017 18:21:33 -0700
Message-ID: <1492996893.21220.6.camel@linux.intel.com>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net>
         <000a01d2b9e6$393afef0$abb0fcd0$@net> <000301d2bb31$c0037790$400a66b0$@net>
         <000501d2bc46$ad4b1fc0$07e15f40$@net>
         <CAJZ5v0gBhVOYJ5a7YWpRHSH20qx3Cjx_Lg0qk52st-p+fQS9bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:37251 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163887AbdDXBVf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Apr 2017 21:21:35 -0400
In-Reply-To: <CAJZ5v0gBhVOYJ5a7YWpRHSH20qx3Cjx_Lg0qk52st-p+fQS9bQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mel Gorman <mgorman@techsingularity.net>, Rafael Wysocki <rafael.j.wysocki@intel.com>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Mon, 2017-04-24 at 02:59 +0200, Rafael J. Wysocki wrote:
> On Sun, Apr 23, 2017 at 5:31 PM, Doug Smythies <dsmythies@telus.net>
> wrote:
[...]

> > It looks like the cost is mostly related to moving the load from
> > > one CPU to
> > > another and waiting for the new one to ramp up then.
Last time when we analyzed Mel's result last year this was the
conclusion. The problem was more apparent on systems with per core P-
state.

> > > 
> > > I guess the workload consists of many small tasks that each start
> > > on new CPUs
> > > and cause that ping-pong to happen.
> > Yes, and (from trace data) many tasks are very very very small.
> > Also the test
> > appears to take a few holidays, of up to 1 second, during
> > execution.
> > 
> > > 
> > > > 
> > > > (performance governor, restated from a previous e-mail: 1776.05
> > > > seconds)
> > > But that causes the processor to stay in the maximum sustainable
> > > P-state all
> > > the time, which on Sandy Bridge is quite costly energetically.
> > Agreed. I only provide these data points as a reference and so that
> > we know
> > what the boundary conditions (limits) are.
> > 
> > > 
> > > We can do one more trick I forgot about.  Namely, if we are about
> > > to increase
> > > the P-state, we can jump to the average between the target and
> > > the max
> > > instead of just the target, like in the appended patch (on top of
> > > linux-next).
> > > 
> > > That will make the P-state selection really aggressive, so costly
> > > energetically,
> > > but it shoud small jumps of the average load above 0 to case big
> > > jumps of
> > > the target P-state.
> > I'm already seeing the energy costs of some of this stuff.
> > 3050.2 Seconds.
> Is this with or without reducing the sampling interval?
> 
> > 
> > Idle power 4.06 Watts.
> > 
> > Idle power for kernel 4.11-rc7 (performance-based): 3.89 Watts.
> > Idle power for kernel 4.11-rc7, using load-based: 4.01 watts
> > Idle power for kernel 4.11-rc7 next linux-pm: 3.91 watts
> Power draw differences are not dramatic, so this might be a viable
> change depending on the influence on the results elsewhere.
Last time a solution proposed to have higher floor instead of min-
pstate for Atom platforms. But this end up in increasing power
consumption on some Android workloads.

Thanks,
Srinivas
