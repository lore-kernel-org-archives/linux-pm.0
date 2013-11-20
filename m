From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/7] idle, thermal, acpi: Remove home grown idle
 implementations
Date: Wed, 20 Nov 2013 18:55:21 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311201851040.30673@ionos.tec.linutronix.de>
References: <20131120160450.072555619@infradead.org> <20131120162736.508462614@infradead.org> <528CE611.8040903@linux.intel.com> <alpine.DEB.2.02.1311201814410.30673@ionos.tec.linutronix.de> <528CF028.2040002@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <528CF028.2040002@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, lenb@kernel.org, rjw@rjwysocki.net, Eliezer Tamir <eliezer.tamir@linux.intel.com>, Chris Leech <christopher.leech@intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 20 Nov 2013, Arjan van de Ven wrote:
> On 11/20/2013 9:23 AM, Thomas Gleixner wrote:
> > On Wed, 20 Nov 2013, Arjan van de Ven wrote:
> > 
> > > On 11/20/2013 8:04 AM, Peter Zijlstra wrote:
> > > > This does not fully preseve existing behaviour in that the generic
> > > > idle cycle function calls into the normal cpuidle governed idle
> > > > routines and should thus respect things like QoS parameters and the
> > > > like.
> > > 
> > > 
> > > NAK on the powerclamp side.
> > > 
> > > powerclamp MUST NOT do that....
> > > it is needed to go to the deepest state no matter what
> > > (this is for when your system is overheating. there is not a lot of choice
> > > here... alternative is an emergency reset that the hardware does for
> > > safety)
> > 
> > So that whole machinery falls apart when the thing which is running on
> > that hot core is a while(1) loop with a higher or equal FIFO priority
> > than this thread. Even if you'd run at prio 99, then there is no
> > guarantee that the cpu hog does not run with prio 99 as well and due
> > to FIFO and being on the CPU it's not going to let you on.
> 
> the idea was to at least give people who know what they're doing a chance to
> run

You can't be serious about that. Even if people know what they are
doing, they have no chance to prevent the occasional high prio runaway
bug. And then you shrug your shoulders and tell that guy who spent
time to tune the thing proper "bad luck" or what?

This is the worst of all approaches and you know that. You fought such
crap tooth and nail not so long ago.

Thanks,

	tglx
