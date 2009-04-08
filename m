From: Ingo Molnar <mingo@elte.hu>
Subject: Re: pm-hibernate : possible circular locking dependency
	detected
Date: Wed, 8 Apr 2009 14:26:13 +0200
Message-ID: <20090408122613.GD18581@elte.hu>
References: <d82e647a0904050253n31bd2654s9b216465eec4d038@mail.gmail.com>
	<200904071356.29914.rusty@rustcorp.com.au>
	<1239087953.798.5513.camel@twins>
	<200904081247.08712.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904081247.08712.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Tuesday 07 April 2009 16:35:53 Peter Zijlstra wrote:
> > On Tue, 2009-04-07 at 13:56 +0930, Rusty Russell wrote:
> > > Looks like this will be fixed by Andrew's work-on-cpu-in-own-thread
> > > patch which I just put out the pull request for.
> > 
> > Would it make sense to teach it about a short-circuit like:
> > 
> > work_on_cpu() {
> > 
> >   if (cpumask_weight(current->cpus_allowed) == 1 && 
> >       smp_processor_id() == cpu)
> >     return do_work_right_here();
> 
> Does that happen much?  I guess put a counter in and see?

a temporary tracepoint or trace_printk() for the workqueue tracer 
would also tell this, without any long-term overhead (it will be 
easy to remove it).

	Ingo
