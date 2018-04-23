From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500 CPU (bisect included)
Date: Mon, 23 Apr 2018 11:27:36 +0200
Message-ID: <2120072.1825pzNyX4@aspire.rjw.lan>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com> <20180423091633.GU4064@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423091633.GU4064@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Diego Viola <diego.viola@gmail.com>, linux-kernel@vger.kernel.org, tglx@linutronix.de, len.brown@intel.com, rui.zhang@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 23, 2018 11:16:33 AM CEST Peter Zijlstra wrote:
> On Sat, Apr 21, 2018 at 11:19:55PM -0300, Diego Viola wrote:
> 
> > The problem only happens *after* resuming from suspend, in normal S0
> > state it never happens.
> 
> What kind of suspend are you doing? s2disk, s2ram ?
> 
> > My machine is a desktop and has a dual core E5500 CPU with 2GB of RAM,
> > I run Arch Linux and I use the i3wm.
> 
> That's a Core2 era chip; does it actually have stable TSC ?
> 
> > aa83c45762a242acce9b35020363225a7b59d7c9 is the first bad commit
> 
> That is most curious; that was supposed to only affect early boot. I'll
> try and figure out of there's some intersection with suspend.

Well, FWIW, I wonder if the flags that were set in init_tsc_clocksource() for
unstable TSC before the above commit may be involved in this somehow.
