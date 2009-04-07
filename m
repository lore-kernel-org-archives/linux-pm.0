From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: pm-hibernate : possible circular locking dependency
	detected
Date: Tue, 07 Apr 2009 09:05:53 +0200
Message-ID: <1239087953.798.5513.camel__27889.4546012909$1239088173$gmane$org@twins>
References: <d82e647a0904050253n31bd2654s9b216465eec4d038@mail.gmail.com>
	<200904051212.53353.rjw@sisk.pl> <20090405134454.GB25250@elte.hu>
	<200904071356.29914.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904071356.29914.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2009-04-07 at 13:56 +0930, Rusty Russell wrote:
> On Sunday 05 April 2009 23:14:54 Ingo Molnar wrote:
> > 
> > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > 
> > > On Sunday 05 April 2009, Ming Lei wrote:
> > > > kernel version : one simple usb-serial patch against  commit
> > > > 6bb597507f9839b13498781e481f5458aea33620.
> > > > 
> > > > Thanks.
> > > 
> > > Hmm, CPU hotplug again, it seems.
> > > 
> > > I'm not sure who's the maintainer at the moment.  Andrew, is that 
> > > Gautham?
> > 
> > CPU hotplug tends to land on the scheduler people's desk normally.
> > 
> > But i'm not sure that's the real thing here - key appears to be this 
> > work_on_cpu() worklet by the cpufreq code:
> 
> Looks like this will be fixed by Andrew's work-on-cpu-in-own-thread
> patch which I just put out the pull request for.

Would it make sense to teach it about a short-circuit like:

work_on_cpu() {

  if (cpumask_weight(current->cpus_allowed) == 1 && 
      smp_processor_id() == cpu)
    return do_work_right_here();

  queue_the_bugger();
}

?
