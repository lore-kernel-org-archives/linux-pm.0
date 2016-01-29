From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Fix NULL reference crash while accessing policy->governor_data
Date: Fri, 29 Jan 2016 04:33:58 +0100
Message-ID: <1958686.xNEGILnNaB@vostro.rjw.lan>
References: <1297c8fc8135f8b5359f9c49d220a939c0ee640e.1453741314.git.viresh.kumar@linaro.org> <3004241.yqvZmcL5vE@vostro.rjw.lan> <20160128021553.GC3935@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46733 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751606AbcA2DdF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 22:33:05 -0500
In-Reply-To: <20160128021553.GC3935@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, "# v4 . 2+" <stable@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, open list <linux-kernel@vger.kernel.org>

On Thursday, January 28, 2016 07:45:53 AM Viresh Kumar wrote:
> On 27-01-16, 23:54, Rafael J. Wysocki wrote:
> > So I've applied this, but I'm not sure it is sufficient yet.
> 
> At least, this solves the crash Juri was hitting on a multi cluster
> box.

Yes, it makes the crash go away in his setup.

> > Have you double checked whether or not stuff cannot be reordered by
> > the CPU and/or the compiler and no additional memory barriers are needed?
> 
> I don't think CPU will reorder things before a function call.

It can do that in theory.

First of all, functions may be inlined by the compiler.

Second, even if they aren't, the call instruction only means "take the next
instruction from that other location in memory" to the CPU and the instructions
following the call go into the pipeline along with the ones preceding it and
they may be reordered in the process.

> It can reorder lines,

Not lines, but instructions.

> which CPU thinks aren't related but it can't assume the
> same in this case. We have tons of code like this.

Code that relies on specific ordering of instructions executed by different
CPUs for correctness usually requires memory barriers.

Thanks,
Rafael

