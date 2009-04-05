From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] PM: Warn if interrupts are enabled
	during	suspend-resume of sysdevs
Date: Sun, 5 Apr 2009 15:51:08 +0200
Message-ID: <20090405135108.GC25250__41992.2275738374$1238939699$gmane$org@elte.hu>
References: <200904042323.19866.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904042323.19866.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Sysdev have to be suspended and resumed with interrupts disabled 
> and things usually break in a way that's difficult to debug if one 
> of sysdev drivers enables interrupts by mistake during suspend or 
> resume.  Add extra checks that will generate warnings in such 
> cases.

no objections - but obviously the real solution would be to finish 
PeterZ's "detect assymetric kernel functions" patch:

That patch (Peter posted an initial version of it already on lkml) 
works the following way:

the ftrace function-graph-tracer plugin is utilized to instrument 
every function call in the kernel. That is extended with the 
following check: every function except __lockfunc and __sched 
functions must be 'balanced' - i.e. they must enter and exit with 
the same IRQ flags, preempt count and lock depth counter.

	Ingo
