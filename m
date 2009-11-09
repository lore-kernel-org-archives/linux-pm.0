From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Help needed: Resume problems in 2.6.32-rc,
	perhaps related to preempt_count leakage in keventd
Date: Mon, 9 Nov 2009 15:26:02 +0100
Message-ID: <200911091526.02147.rjw__48448.0586638258$1257776764$gmane$org@sisk.pl>
References: <200911091250.31626.rjw@sisk.pl> <20091109124937.GA21114@elte.hu>
	<alpine.LFD.2.00.0911091452300.2725@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0911091452300.2725@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 09 November 2009, Thomas Gleixner wrote:
> On Mon, 9 Nov 2009, Ingo Molnar wrote:
> > 
> > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > 
> > > On Monday 09 November 2009, Ingo Molnar wrote:
> > > > 
> > > > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > 
> > > > > [ 2016.865041] BUG: using smp_processor_id() in preemptible [00000000] code: events/1/29920                                                                                         
> > > > > [ 2016.865344] caller is vmstat_update+0x13/0x48                                          
> > > > > [ 2016.865522] Pid: 29920, comm: events/1 Not tainted 2.6.31-tst #158                     
> > > > > [ 2016.865700] Call Trace:                                                                
> > > > > [ 2016.865877]  [<ffffffff811608e8>] debug_smp_processor_id+0xc4/0xd4                     
> > > > > [ 2016.866052]  [<ffffffff810a9ae1>] vmstat_update+0x13/0x48                              
> > > > > [ 2016.866232]  [<ffffffff81051ee6>] worker_thread+0x18b/0x22a                            
> > > > > [ 2016.866409]  [<ffffffff810a9ace>] ? vmstat_update+0x0/0x48                             
> > > > > [ 2016.866578]  [<ffffffff810556a5>] ? autoremove_wake_function+0x0/0x38                  
> > > > > [ 2016.866749]  [<ffffffff81288803>] ? _spin_unlock_irqrestore+0x35/0x37                  
> > > > > [ 2016.866935]  [<ffffffff81051d5b>] ? worker_thread+0x0/0x22a                            
> > > > > [ 2016.867113]  [<ffffffff8105547d>] kthread+0x69/0x71                                    
> > > > > [ 2016.867278]  [<ffffffff8100c1aa>] child_rip+0xa/0x20                                   
> > > > > [ 2016.867450]  [<ffffffff81055414>] ? kthread+0x0/0x71                                   
> > > > > [ 2016.867618]  [<ffffffff8100c1a0>] ? child_rip+0x0/0x20                                 
> > > > 
> > > > a bug producing similar looking messages was fixed by:
> > > > 
> > > >   fd21073: sched: Fix affinity logic in select_task_rq_fair()
> > > > 
> > > > but that bug was introduced by:
> > > > 
> > > >   a1f84a3: sched: Check for an idle shared cache in select_task_rq_fair()
> > > 
> > > I guess these are tip commits?
> > 
> > yep, tip:sched/core ones.
> > 
> > > > Which is for v2.6.33, not v2.6.32.
> > > 
> > > The one I saw was in the Linus' tree, quite obviously.
> > 
> > ok, then my observation should not apply.
> 
> I think it _IS_ releated because the worker_thread is CPU affine and
> the debug_smp_processor_id() check does:
> 
>     if (cpumask_equal(&current->cpus_allowed, cpumask_of(this_cpu)))
> 
> which prevents that usage of smp_processor_id() in ksoftirqd and
> keventd in preempt enabled regions is warned on.
> 
> We saw exaclty the same back trace with fd21073 (sched: Fix affinity
> logic in select_task_rq_fair()).
> 
> Rafael, can you please add a printk to debug_smp_processor_id() so we
> can see on which CPU we are running ? I suspect we are on the wrong
> one.

Well, I can add the printk(), but I can't guarantee that I will get the call
trace once again.  So far I've seen it only once after 20-25 consecutive
suspend-resume cycles, so ...  you get the idea.

However, running on a wrong CPU would very nicely explain all of the observed
symptoms, so I guess we can try a House M.D.-alike approach and assume that the
answer is "yes, we're running on the wrong CPU".  What would we do next if that
was the case?

Rafael
