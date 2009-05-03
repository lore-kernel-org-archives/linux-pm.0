From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/4] PM/Hibernate: Use memory allocations to
	free memory (rev. 2)
Date: Sun, 3 May 2009 18:22:54 +0200
Message-ID: <200905031822.55260.rjw__47748.288306366$1241367899$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905030224.21471.rjw@sisk.pl>
	<20090503115127.GA9661@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090503115127.GA9661@localhost>
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
Cc: linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, kernel-testers@vger.kernel.org, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 03 May 2009, Wu Fengguang wrote:
> On Sun, May 03, 2009 at 02:24:20AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Modify the hibernation memory shrinking code so that it will make
> > memory allocations to free memory instead of using an artificial
> > memory shrinking mechanism for that.  Remove the shrinking of
> > memory from the suspend-to-RAM code, where it is not really
> > necessary.  Finally, remove the no longer used memory shrinking
> > functions from mm/vmscan.c .
> > 
> > [rev. 2: Use the existing memory bitmaps for marking preallocated
> >  image pages and use swsusp_free() from releasing them, introduce
> >  GFP_IMAGE, add comments describing the memory shrinking strategy.]
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  kernel/power/main.c     |   20 ------
> >  kernel/power/snapshot.c |  132 +++++++++++++++++++++++++++++++++-----------
> >  mm/vmscan.c             |  142 ------------------------------------------------
> >  3 files changed, 101 insertions(+), 193 deletions(-)
> > 
> > Index: linux-2.6/kernel/power/snapshot.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/power/snapshot.c
> > +++ linux-2.6/kernel/power/snapshot.c
> > @@ -1066,41 +1066,97 @@ void swsusp_free(void)
> >  	buffer = NULL;
> >  }
> >  
> > +/* Helper functions used for the shrinking of memory. */
> > +
> > +#ifdef CONFIG_HIGHMEM
> > +#define GFP_IMAGE	(GFP_KERNEL | __GFP_HIGHMEM | __GFP_NO_OOM_KILL)
> > +#else
> > +#define GFP_IMAGE	(GFP_KERNEL | __GFP_NO_OOM_KILL)
> > +#endif
> 
> The CONFIG_HIGHMEM test is not necessary: __GFP_HIGHMEM is always defined.
> 
> > +#define SHRINK_BITE	10000
> 
> This is ~40MB. A full scan of (for example) 8G pages will be time
> consuming, not to mention we have to do it 2*(8G-500M)/40M = 384 times!
> 
> Can we make it a LONG_MAX? 

No, I don't think so.  The problem is the number of pages we'll need to copy
is generally shrinking  as we allocate memory, so we can't do that in one shot.

We can make it a greater number, but I don't really think it would be a good
idea to make it greater than 100 MB.

Thanks,
Rafael
