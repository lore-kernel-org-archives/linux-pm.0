From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] PM: Drop shrink_all_memory (rev. 2) (was:
	Re: [PATCH 3/3] PM/Hibernate: Use memory allocations to free memory)
Date: Sun, 3 May 2009 02:20:57 +0200
Message-ID: <200905030220.57933.rjw__21548.8509893932$1241311845$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905021346.34967.rjw@sisk.pl>
	<20090502104947.2720f173.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090502104947.2720f173.akpm@linux-foundation.org>
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
Cc: linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, kernel-testers@vger.kernel.org, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 02 May 2009, Andrew Morton wrote:
> On Sat, 2 May 2009 13:46:34 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > > Do we need the bitmap?  I expect we can just string all these pages
> > > onto a local list via page.lru.  Would need to check that - the
> > > pageframe fields are quite overloaded.
> > 
> > This is the reason why we use the bitmaps for hibernation. :-)
> 
> grep the tree for page->lru and you'll see that quite a few page
> consumers are using it.  So you'd be pretty safe doing it this way.
> 
> Whether it's _worth_ doing it this way is debatable, given that
> hibernation uses bitmaps elsewhere.  But it would shrink the patch a
> bit I expect?

It probably would, but it turns out we need not create the new bitmap, we
can use the existing ones for marking the allocated pages.  That also has
the benefit that we can use swsusp_free() to release them.

Modified patch series follows:

[1/4] - your patch introducing __GFP_NO_OOM_KILL (I decided it would be better
        do it this way in this particular case.  The fact that the OOM killer
        is not going to work after tasks have been frozen is a different issue.)

[2/4] - move swsusp_shrink_memory to snapshot.c, no major changes

[3/4] - use memory allocations to for making the room for the image (added
        comments, used the existing bitmaps, cleaned up a bit)

[4/4] - new thing: do not release memory allocated by [3/4] and use it for
        creating the image directly.

Thanks,
Rafael
