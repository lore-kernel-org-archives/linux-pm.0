From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Warn if interrupts are enabled
	during suspend-resume of sysdevs
Date: Sun, 5 Apr 2009 19:39:29 +0200
Message-ID: <200904051939.30170.rjw__33694.5378840484$1238953392$gmane$org@sisk.pl>
References: <200904042323.19866.rjw@sisk.pl> <20090405135108.GC25250@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090405135108.GC25250@elte.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org

On Sunday 05 April 2009, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Sysdev have to be suspended and resumed with interrupts disabled 
> > and things usually break in a way that's difficult to debug if one 
> > of sysdev drivers enables interrupts by mistake during suspend or 
> > resume.  Add extra checks that will generate warnings in such 
> > cases.
> 
> no objections - but obviously the real solution would be to finish 
> PeterZ's "detect assymetric kernel functions" patch:
> 
> That patch (Peter posted an initial version of it already on lkml) 
> works the following way:
> 
> the ftrace function-graph-tracer plugin is utilized to instrument 
> every function call in the kernel. That is extended with the 
> following check: every function except __lockfunc and __sched 
> functions must be 'balanced' - i.e. they must enter and exit with 
> the same IRQ flags, preempt count and lock depth counter.

Nothing wrong with that, but I'd also like to have checks that don't depend on
ftrace. :-)

Thanks,
Rafael
