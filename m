From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Sat, 9 May 2009 02:08:43 +0200
Message-ID: <200905090208.44381.rjw@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera>
	<20090508095010.GA26398@localhost> <200905081551.56577.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905081551.56577.rjw@sisk.pl>
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
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: David Rientjes <rientjes@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan-jenkins@tuffmail.co.uk" <alan-jenkins@tuffmail.co.uk>, "jens.axboe@oracle.com" <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "kernel-testers@vger.kernel.org" <kernel-testers@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 08 May 2009, Rafael J. Wysocki wrote:
> On Friday 08 May 2009, Wu Fengguang wrote:
[--snip--]
> > But hey, that 'count' counts "savable+free" memory.
> > We don't have a counter for an estimation of "free+freeable" memory,
> > ie. we are sure we cannot preallocate above that threshold. 
> > 
> > One applicable situation is, when there are 800M anonymous memory,
> > but only 500M image_size and no swap space.
> > 
> > In that case we will otherwise goto the oom code path. Sure oom is
> > (and shall be) reliably disabled in hibernation, but still we shall be
> > cautious enough not to create a low memory situation, which will hurt:
> > - hibernation speed
> >   (vmscan goes mad trying to squeeze the last free page)
> > - user experiences after resume
> >   (all *active* file data and metadata have to reloaded)
> 
> Strangely enough, my recent testing with this patch doesn't confirm the
> theory. :-)  Namely, I set image_size too low on purpose and it only caused
> preallocate_image_memory() to return NULL at one point and that was it.
> 
> It didn't even took too much time.
> 
> I'll carry out more testing to verify this observation.

I can confirm that even if image_size is below the minimum we can get,
the second preallocate_image_memory() just returns after allocating fewer pages
that it's been asked for (that's with the original __GFP_NO_OOM_KILL-based
approach, as I wrote in the previous message in this thread) and nothing bad
happens.

That may be because we freeze the mm kernel threads, but I've also tested
without freezing them and it's still worked the same way.

> > The current code simply tries *too hard* to meet image_size.
> > I'd rather take that as a mild advice, and to only free
> > "free+freeable-margin" pages when image_size is not approachable.
> > 
> > The safety margin can be totalreserve_pages, plus enough pages for
> > retaining the "hard core working set".
> 
> How to compute the size of the "hard core working set", then?

Well, I'm still interested in the answer here. ;-)

Best,
Rafael
