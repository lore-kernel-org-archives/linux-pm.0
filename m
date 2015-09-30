From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [RFC 0/3] sched/idle: run-time support for setting idle polling
Date: Wed, 30 Sep 2015 14:01:43 -0400
Message-ID: <20150930140143.7b187451@redhat.com>
References: <1442954062-28578-1-git-send-email-lcapitulino@redhat.com>
	<1593595.NpzC8TsdGC@vostro.rjw.lan>
	<20150930154835.GP3604@twins.programming.kicks-ass.net>
	<20150930131610.1c2ba9c2@redhat.com>
	<20150930172713.GV3816@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37124 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932260AbbI3SBs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Sep 2015 14:01:48 -0400
In-Reply-To: <20150930172713.GV3816@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, riel@redhat.com, rafael.j.wysocki@intel.com, mingo@kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, 30 Sep 2015 19:27:13 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 30, 2015 at 01:16:10PM -0400, Luiz Capitulino wrote:
> > On Wed, 30 Sep 2015 17:48:35 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Ideally every cpuidle driver would get 'polling' as a
> > > default state and the QoS constraints might select it if nothing else
> > > matches.
> > 
> > So, I didn't know we had support for polling from the idle
> > thread via cpuidle. This solves the first part of the problem.
> 
> I'm not sure we do; I'm saying that's what we should do ;-)

Yeah, but I think it's done already. Although I haven't tested it yet:

[root@localhost ~]# cat /sys/devices/system/cpu/cpu0/cpuidle/state0/name 
POLL
[root@localhost ~]# 

This is installed by drivers/cpuidle/driver.c:poll_idle_init().
