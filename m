From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3] cpuidle: Handle tick_broadcast_enter() failure gracefully
Date: Sat, 09 May 2015 22:11:41 +0200
Message-ID: <10239011.l6QLHlKIVm@vostro.rjw.lan>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com> <8680371.ymYIEaFYPT@vostro.rjw.lan> <554D9FDC.6090608@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59904 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751233AbbEITqf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 May 2015 15:46:35 -0400
In-Reply-To: <554D9FDC.6090608@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: peterz@infradead.org, tglx@linutronix.de, rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org, rlippert@google.com, linux-pm@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com, linuxppc-dev@lists.ozlabs.org

On Saturday, May 09, 2015 11:19:16 AM Preeti U Murthy wrote:
> Hi Rafael,
> 
> On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:

[cut]

> >>  
> >> +	/* Take note of the planned idle state. */
> >> +	idle_set_state(smp_processor_id(), target_state);
> > 
> > And I wouldn't do this either.
> > 
> > The behavior here is pretty much as though the driver demoted the state chosen
> > by the governor and we don't call idle_set_state() again in those cases.
> 
> Why is this wrong?

It is not "wrong", but incomplete, because demotions done by the cpuidle driver
should also be taken into account in the same way.

But I'm seeing that the recent patch of mine that made cpuidle_enter_state()
call default_idle_call() was a mistake, because it might confuse find_idlest_cpu()
significantly as to what state the CPU is in.  I'll drop that one for now.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
