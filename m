From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: pm-hibernate : possible circular locking dependency
	detected
Date: Thu, 9 Apr 2009 09:15:17 +0930
Message-ID: <200904090915.18644.rusty__39994.004488881$1239234551$gmane$org@rustcorp.com.au>
References: <d82e647a0904050253n31bd2654s9b216465eec4d038@mail.gmail.com>
	<200904081247.08712.rusty@rustcorp.com.au>
	<1239194906.13185.93.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1239194906.13185.93.camel@twins>
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
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 08 April 2009 22:18:26 Peter Zijlstra wrote:
> On Wed, 2009-04-08 at 12:47 +0930, Rusty Russell wrote:
> > On Tuesday 07 April 2009 16:35:53 Peter Zijlstra wrote:
> > > On Tue, 2009-04-07 at 13:56 +0930, Rusty Russell wrote:
> > > > Looks like this will be fixed by Andrew's work-on-cpu-in-own-thread
> > > > patch which I just put out the pull request for.
> > > 
> > > Would it make sense to teach it about a short-circuit like:
> > > 
> > > work_on_cpu() {
> > > 
> > >   if (cpumask_weight(current->cpus_allowed) == 1 && 
> > >       smp_processor_id() == cpu)
> > >     return do_work_right_here();
> > 
> > Does that happen much?  I guess put a counter in and see?
> 
> Ego spotted the case where cpufreq calls it from an cpu-affine
> workqueue, it seems to me in that case its desirable to have the
> short-cut, and currently that's needed for correctness too as it will
> generate this circular lock thingy.

Well, the correctness issue is fixed by Andrew's work_on_cpu-via-new-thread
patch (hmm, which Linus hasn't taken, re-xmitting).

So it's really a pure optimization.

Cheers,
Rusty.
