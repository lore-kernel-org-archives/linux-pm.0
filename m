From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/4] PM/Hibernate: Use memory allocations to
	free	memory (rev. 2)
Date: Mon, 4 May 2009 11:31:21 +0200
Message-ID: <20090504093121.GB30306__1096.88992747596$1241429439$gmane$org@elf.ucw.cz>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905030224.21471.rjw@sisk.pl>
	<20090503115127.GA9661@localhost> <200905031822.55260.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905031822.55260.rjw@sisk.pl>
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
Cc: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun 2009-05-03 18:22:54, Rafael J. Wysocki wrote:
> On Sunday 03 May 2009, Wu Fengguang wrote:
> > On Sun, May 03, 2009 at 02:24:20AM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Modify the hibernation memory shrinking code so that it will make
> > > memory allocations to free memory instead of using an artificial
> > > memory shrinking mechanism for that.  Remove the shrinking of
> > > memory from the suspend-to-RAM code, where it is not really
> > > necessary.  Finally, remove the no longer used memory shrinking
> > > functions from mm/vmscan.c .
> > > 
> > > [rev. 2: Use the existing memory bitmaps for marking preallocated
> > >  image pages and use swsusp_free() from releasing them, introduce
> > >  GFP_IMAGE, add comments describing the memory shrinking strategy.]
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  kernel/power/main.c     |   20 ------
> > >  kernel/power/snapshot.c |  132 +++++++++++++++++++++++++++++++++-----------
> > >  mm/vmscan.c             |  142 ------------------------------------------------
> > >  3 files changed, 101 insertions(+), 193 deletions(-)
> > > 
> > > Index: linux-2.6/kernel/power/snapshot.c
> > > ===================================================================
> > > --- linux-2.6.orig/kernel/power/snapshot.c
> > > +++ linux-2.6/kernel/power/snapshot.c
> > > @@ -1066,41 +1066,97 @@ void swsusp_free(void)
> > >  	buffer = NULL;
> > >  }
> > >  
> > > +/* Helper functions used for the shrinking of memory. */
> > > +
> > > +#ifdef CONFIG_HIGHMEM
> > > +#define GFP_IMAGE	(GFP_KERNEL | __GFP_HIGHMEM | __GFP_NO_OOM_KILL)
> > > +#else
> > > +#define GFP_IMAGE	(GFP_KERNEL | __GFP_NO_OOM_KILL)
> > > +#endif
> > 
> > The CONFIG_HIGHMEM test is not necessary: __GFP_HIGHMEM is always defined.
> > 
> > > +#define SHRINK_BITE	10000
> > 
> > This is ~40MB. A full scan of (for example) 8G pages will be time
> > consuming, not to mention we have to do it 2*(8G-500M)/40M = 384 times!
> > 
> > Can we make it a LONG_MAX? 
> 
> No, I don't think so.  The problem is the number of pages we'll need to copy
> is generally shrinking  as we allocate memory, so we can't do that in one shot.
> 
> We can make it a greater number, but I don't really think it would be a good
> idea to make it greater than 100 MB.

Well, even 100MB is quite big: on 128MB machine, that will probably
mean freeing all the memory (instead of "as much as needed"). And that
memory needs to go to disk, so it will be slow.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
