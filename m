From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/6] setting the table for integration of cpuidle with
 the scheduler
Date: Thu, 30 Jan 2014 08:31:52 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1401300830340.1652@knanqh.ubzr>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org> <20140130092835.GL11314@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140130092835.GL11314@laptop.programming.kicks-ass.net>
Sender: linux-sh-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Jan 2014, Peter Zijlstra wrote:

> On Wed, Jan 29, 2014 at 12:45:07PM -0500, Nicolas Pitre wrote:
> > As everyone should know by now, we want to integrate the cpuidle
> > governor with the scheduler for a more efficient idling of CPUs.
> > In order to help the transition, this small patch series moves the
> > existing interaction with cpuidle from architecture code to generic
> > core code.  The ARM, PPC, SH and X86 architectures are concerned.
> > No functional change should have occurred yet.
> > 
> > @peterz: Are you willing to pick up those patches?
> 
> Yeah.. no objections. Should I pick these up or will you be sending
> another round?

I think you could pick them now, taking care of picking up the amended 
#1/6.


Nicolas
