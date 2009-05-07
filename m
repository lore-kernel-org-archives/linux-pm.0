From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Fri, 8 May 2009 00:05:43 +0200
Message-ID: <200905080005.44589.rjw__47389.2145710581$1241735838$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905072336.11383.rjw@sisk.pl>
	<alpine.DEB.2.00.0905071439370.24404@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.0905071439370.24404@chino.kir.corp.google.com>
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
> > > The fact is that _all_ allocations here are implicitly __GFP_NO_OOM_KILL 
> > > whether it specifies it or not since the oom killer would simply kill a 
> > > task in D state which can't exit or free memory and subsequent allocations 
> > > would make the oom killer a no-op because there's an eligible task with 
> > > TIF_MEMDIE set.  The only thing you're saving with __GFP_NO_OOM_KILL is 
> > > calling the oom killer in a first place and killing an unresponsive task 
> > 
> > That's exactly what we're trying to do.  We don't want tasks to get killed just
> > because we're freeing memory for hibernation image.
> > 
> 
> Then, again, why can't you just lock out the oom killer as I suggested if 
> __GFP_NO_OOM_KILL is actually implied for all allocations when 
> preallocating?  It prevents adding an unnecessary gfp flag, sprinkling it 
> around in the hibernation code,

In one place really.

> and a comment would actually explain why it's the right thing to do (i.e. no
> other threads other than kthreads could possibly be executing the oom killer
> and if they are oom then we'll have to kill a userspace task anyway when
> thawed).

Quite frankly, I prefer my freezer-based patch to this.  I'm not really
inclined to fiddle with the mm internals from within snapshot.c .

Still, I trust the Andrew's experience and that's why I'm going to try the
__GFP_NO_OOM_KILL first, as I already said.  If there is a problem with it,
I'm going to use the freezer-based approach.
 
> > > but that would have to happen anyway when thawed since the system is oom 
> > > (or otherwise lockup for GFP_KERNEL with order < PAGE_ALLOC_COSTLY_ORDER).
> > 
> > Are you sure?  The image memory is freed before thawing tasks.
> > 
> 
> If you try to allocate any non-__GFP_NORETRY memory such as GFP_KERNEL 
> with order < PAGE_ALLOC_COSTLY_ORDER and direct reclaim cannot free memory 
> (and the oom killer is implicitly a no-op whether you specify 
> __GFP_NO_OOM_KILL or not), then you could loop endlessly in the page 
> allocator.  When allocating GFP_IMAGE you need to ensure that can't happen 
> and __GFP_NORETRY may not be your best option because it could fail 
> unnecessarily when reclaim could have helped.

I'm really unsure what you mean and how that is related to your previous remark
about what's going to happen after the thawing of tasks.

Thanks,
Rafael
