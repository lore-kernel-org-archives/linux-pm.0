From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Sat, 9 May 2009 01:55:43 +0200
Message-ID: <200905090155.44635.rjw__41572.2405109138$1241827185$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905072218.50782.rjw@sisk.pl>
	<alpine.DEB.2.00.0905071321440.646@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.0905071321440.646@chino.kir.corp.google.com>
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
To: David Rientjes <rientjes@google.com>
Cc: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, fengguang.wu@intel.com, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 07 May 2009, David Rientjes wrote:
> On Thu, 7 May 2009, Rafael J. Wysocki wrote:
> 
> > OK, let's try with __GFP_NO_OOM_KILL first.  If there's too much disagreement,
> > I'll use the freezer-based approach instead.
> > 
> 
> Third time I'm going to suggest this, and I'd like a response on why it's 
> not possible instead of being ignored.
> 
> All of your tasks are in D state other than kthreads, right?  That means 
> they won't be in the oom killer (thus no zones are oom locked), so you can 
> easily do this
> 
> 	struct zone *z;
> 	for_each_populated_zone(z)
> 		zone_set_flag(z, ZONE_OOM_LOCKED);
> 
> and then
> 
> 	for_each_populated_zone(z)
> 		zone_clear_flag(z, ZONE_OOM_LOCKED);
> 
> The serialization is done with trylocks so this will never invoke the oom 
> killer because all zones in the allocator's zonelist will be oom locked.

Well, that might have been a good idea if it actually had worked. :-(

> Why does this not work for you?

If I set image_size to something below "hard core working set" +
totalreserve_pages, preallocate_image_memory() hangs the
box (please refer to the last patch I sent,
http://patchwork.kernel.org/patch/22423/).

However, with the freezer-based disabling of the OOM killer it doesn't hang
under the same test conditions.

The difference appears to be that using your approach makes
__alloc_pages_internal() loop forever between the !try_set_zone_oom() test and
restart:, while it should go to nopage: in that situation.

So, I think I'll stick to the Andrew's approach with using __GFP_NO_OOM_KILL.

Thanks,
Rafael
