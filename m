From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Fri, 8 May 2009 00:14:48 +0200
Message-ID: <200905080014.49426.rjw__7937.74028211391$1241734737$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera>
	<alpine.DEB.2.00.0905071417160.24417@chino.kir.corp.google.com>
	<20090507145041.9b59f4eb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507145041.9b59f4eb.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-testers@vger.kernel.org, David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 07 May 2009, Andrew Morton wrote:
> On Thu, 7 May 2009 14:25:23 -0700 (PDT)
> David Rientjes <rientjes@google.com> wrote:
> 
> > On Thu, 7 May 2009, Andrew Morton wrote:
> > 
> > > > > All of your tasks are in D state other than kthreads, right?  That means 
> > > > > they won't be in the oom killer (thus no zones are oom locked), so you can 
> > > > > easily do this
> > > > > 
> > > > > 	struct zone *z;
> > > > > 	for_each_populated_zone(z)
> > > > > 		zone_set_flag(z, ZONE_OOM_LOCKED);
> > > > > 
> > > > > and then
> > > > > 
> > > > > 	for_each_populated_zone(z)
> > > > > 		zone_clear_flag(z, ZONE_OOM_LOCKED);
> > > > > 
> > > > > The serialization is done with trylocks so this will never invoke the oom 
> > > > > killer because all zones in the allocator's zonelist will be oom locked.
> > > > > 
> > > > > Why does this not work for you?
> > > > 
> > > > Well, it might work too, but why are you insisting?  How's it better than
> > > > __GFP_NO_OOM_KILL, actually?
> > > > 
> > > > Andrew, what do you think about this?
> > > 
> > > I don't think I understand the proposal.  Is it to provide a means by
> > > which PM can go in and set a state bit against each and every zone?  If
> > > so, that's still a global boolean, only messier.
> > > 
> > 
> > Why can't it be global while preallocating memory for hibernation since 
> > nothing but kthreads could allocate at this point and if the system is oom 
> > then the oom killer wouldn't be able to do anything anyway since it can't 
> > kill them?
> 
> - globals are bad
> 
> - the standard way of controlling memory allocator behaviour is via
>   the gfp_t.  Bypassing that is an unusual step and needs a higher
>   level of justification, which I'm not seeing here.
> 
> - if we do this via an unusual global, we reduce the chances that
>   another subsytem could use the new feature.
> 
>   I don't know what subsytem that might be, but I bet they're out
>   there.  checkpoint-restart, virtual machines, ballooning memory
>   drivers, kexec loading, etc.
> 
> > The fact is that _all_ allocations here are implicitly __GFP_NO_OOM_KILL 
> > whether it specifies it or not since the oom killer would simply kill a 
> > task in D state which can't exit or free memory and subsequent allocations 
> > would make the oom killer a no-op because there's an eligible task with 
> > TIF_MEMDIE set.  The only thing you're saving with __GFP_NO_OOM_KILL is 
> > calling the oom killer in a first place and killing an unresponsive task 
> > but that would have to happen anyway when thawed since the system is oom 
> > (or otherwise lockup for GFP_KERNEL with order < PAGE_ALLOC_COSTLY_ORDER).
> 
> All the above is specific to the PM application only, when userspace
> tasks are stopped.
> 
> 
> It might well end up that stopping userspace (beforehand or before
> oom-killing) is a hard requirement for reliably disabling the
> oom-killer.

In fact I think it is and that's why I wanted to make that freezer-dependent.

IOW, you need to freeze the user space totally before trying to disable the
OOM killer.  Reversely, if you _have_ frozen the user space totally, the OOM
killer won't really help, so why let it run at all in that situation?

FWIW, I've just posted updated patchset with the first patch replaced with
the one introducing __GFP_NO_OOM_KILL, but perhaps I should use the
freezer-based one after all?
