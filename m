From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Thu, 7 May 2009 14:25:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905071417160.24417__7302.95007019794$1241731660$gmane$org@chino.kir.corp.google.com>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905072218.50782.rjw@sisk.pl>
	<alpine.DEB.2.00.0905071321440.646@chino.kir.corp.google.com>
	<200905072238.14558.rjw@sisk.pl>
	<20090507135615.e7db550d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507135615.e7db550d.akpm@linux-foundation.org>
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
Cc: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 7 May 2009, Andrew Morton wrote:

> > > All of your tasks are in D state other than kthreads, right?  That means 
> > > they won't be in the oom killer (thus no zones are oom locked), so you can 
> > > easily do this
> > > 
> > > 	struct zone *z;
> > > 	for_each_populated_zone(z)
> > > 		zone_set_flag(z, ZONE_OOM_LOCKED);
> > > 
> > > and then
> > > 
> > > 	for_each_populated_zone(z)
> > > 		zone_clear_flag(z, ZONE_OOM_LOCKED);
> > > 
> > > The serialization is done with trylocks so this will never invoke the oom 
> > > killer because all zones in the allocator's zonelist will be oom locked.
> > > 
> > > Why does this not work for you?
> > 
> > Well, it might work too, but why are you insisting?  How's it better than
> > __GFP_NO_OOM_KILL, actually?
> > 
> > Andrew, what do you think about this?
> 
> I don't think I understand the proposal.  Is it to provide a means by
> which PM can go in and set a state bit against each and every zone?  If
> so, that's still a global boolean, only messier.
> 

Why can't it be global while preallocating memory for hibernation since 
nothing but kthreads could allocate at this point and if the system is oom 
then the oom killer wouldn't be able to do anything anyway since it can't 
kill them?

The fact is that _all_ allocations here are implicitly __GFP_NO_OOM_KILL 
whether it specifies it or not since the oom killer would simply kill a 
task in D state which can't exit or free memory and subsequent allocations 
would make the oom killer a no-op because there's an eligible task with 
TIF_MEMDIE set.  The only thing you're saving with __GFP_NO_OOM_KILL is 
calling the oom killer in a first place and killing an unresponsive task 
but that would have to happen anyway when thawed since the system is oom 
(or otherwise lockup for GFP_KERNEL with order < PAGE_ALLOC_COSTLY_ORDER).
