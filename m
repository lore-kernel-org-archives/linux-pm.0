From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Thu, 7 May 2009 13:56:15 -0700
Message-ID: <20090507135615.e7db550d.akpm__22086.8122684353$1241730244$gmane$org@linux-foundation.org>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905072218.50782.rjw@sisk.pl>
	<alpine.DEB.2.00.0905071321440.646@chino.kir.corp.google.com>
	<200905072238.14558.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905072238.14558.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel-testers@vger.kernel.org, rientjes@google.com, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 7 May 2009 22:38:13 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Thursday 07 May 2009, David Rientjes wrote:
> > On Thu, 7 May 2009, Rafael J. Wysocki wrote:
> > 
> > > OK, let's try with __GFP_NO_OOM_KILL first.  If there's too much disagreement,
> > > I'll use the freezer-based approach instead.
> > > 
> > 
> > Third time I'm going to suggest this, and I'd like a response on why it's 
> > not possible instead of being ignored.
> > 
> > All of your tasks are in D state other than kthreads, right?  That means 
> > they won't be in the oom killer (thus no zones are oom locked), so you can 
> > easily do this
> > 
> > 	struct zone *z;
> > 	for_each_populated_zone(z)
> > 		zone_set_flag(z, ZONE_OOM_LOCKED);
> > 
> > and then
> > 
> > 	for_each_populated_zone(z)
> > 		zone_clear_flag(z, ZONE_OOM_LOCKED);
> > 
> > The serialization is done with trylocks so this will never invoke the oom 
> > killer because all zones in the allocator's zonelist will be oom locked.
> > 
> > Why does this not work for you?
> 
> Well, it might work too, but why are you insisting?  How's it better than
> __GFP_NO_OOM_KILL, actually?
> 
> Andrew, what do you think about this?

I don't think I understand the proposal.  Is it to provide a means by
which PM can go in and set a state bit against each and every zone?  If
so, that's still a global boolean, only messier.
