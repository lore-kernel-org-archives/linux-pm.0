From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH][RFC] x86, hotplug: Use zero page for monitor when
 resuming from hibernation
Date: Mon, 6 Jun 2016 18:40:33 +0200
Message-ID: <20160606164033.GD30154@twins.programming.kicks-ass.net>
References: <1465222749-8388-1-git-send-email-yu.c.chen@intel.com>
 <20160606142506.GE30909@twins.programming.kicks-ass.net>
 <36DF59CE26D8EE47B0655C516E9CE6402876CB97@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54836 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbcFFQky (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2016 12:40:54 -0400
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402876CB97@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Borislav Petkov <bp@suse.de>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>

On Mon, Jun 06, 2016 at 03:59:06PM +0000, Chen, Yu C wrote:

> > > +	if (hibernation_in_resume())
> > > +		mwait_ptr = empty_zero_page;
> > > +	else
> > > +		mwait_ptr = &current_thread_info()->flags;
> > 
> > Why is this conditional? Is there any case in which the zero page is not also
> > correct?
> I'm thinking of avoid unnecessary wakeup for normal CPU offline,  for example, 
> if one  driver uses  the zero page and access it.

Writing to the zero page would be a major fail.
