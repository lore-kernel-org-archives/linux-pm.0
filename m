From: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.24-rc5-mm1 -- inconsistent {in-hardirq-W} ->
	{hardirq-on-W} usage -- pm-hibernate/9940 [HC0[0]:SC0[0]:HE1:SE1]
Date: Wed, 19 Dec 2007 20:11:39 -0500
Message-ID: <a44ae5cd0712191711q47d575a9l335a663adb142625__46196.8961907134$1198113419$gmane$org@mail.gmail.com>
References: <a44ae5cd0712190517t7c80e15bv759fa5486dfca234@mail.gmail.com>
	<200712200029.31709.rjw@sisk.pl>
	<Pine.LNX.4.64.0712191511310.2001@schroedinger.engr.sgi.com>
	<200712200109.20452.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712200109.20452.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Walker <dwalker@mvista.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Christoph Lameter <clameter@sgi.com>
List-Id: linux-pm@vger.kernel.org

On Dec 19, 2007 7:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> On Thursday, 20 of December 2007, Christoph Lameter wrote:
> > On Thu, 20 Dec 2007, Rafael J. Wysocki wrote:
> >
> > > > We could reexport drain_local_pages() again but then I do not understand
> > > > why we would only drain the pages of this processor and not of all other
> > > > processors as well. It seems that software suspend intend was to flush
> > > > them all right?
> > >
> > > Well, not exactly.  We are on one CPU at this point, the others have been
> > > disabled.
> >
> > Ok so the others are flush. Here is a patch to re-export
> > drain_local_pages() again and use it for software suspend:
> >
> > Signed-off-by: Christoph Lameter <clameter@sgi.com>
> >
> > ---
> >  include/linux/gfp.h     |    1 +
> >  kernel/power/snapshot.c |    2 +-
> >  mm/page_alloc.c         |    2 +-
> >  3 files changed, 3 insertions(+), 2 deletions(-)
> >
> > Index: linux-2.6.24-rc5-mm1/kernel/power/snapshot.c
> > ===================================================================
> > --- linux-2.6.24-rc5-mm1.orig/kernel/power/snapshot.c 2007-12-19 11:59:25.233961700 -0800
> > +++ linux-2.6.24-rc5-mm1/kernel/power/snapshot.c      2007-12-19 15:16:34.179661929 -0800
> > @@ -1203,7 +1203,7 @@ asmlinkage int swsusp_save(void)
> >
> >       printk(KERN_INFO "PM: Creating hibernation image: \n");
> >
> > -     drain_all_pages();
> > +     drain_local_pages(NULL);
> >       nr_pages = count_data_pages();
> >       nr_highmem = count_highmem_pages();
> >       printk(KERN_INFO "PM: Need to copy %u pages\n", nr_pages + nr_highmem);
>
> You've omitted the second instance, right before the copy_data_pages() call.

I will wait for a revised patch and then test.
(Sorry for the duplicate message.  I am resending because I
accidentally sent an HTML
message the first time.  Whoops.)

> > Index: linux-2.6.24-rc5-mm1/mm/page_alloc.c
> > ===================================================================
> > --- linux-2.6.24-rc5-mm1.orig/mm/page_alloc.c 2007-12-19 12:01:00.630421258 -0800
> > +++ linux-2.6.24-rc5-mm1/mm/page_alloc.c      2007-12-19 15:12:19.850545818 -0800
> > @@ -930,7 +930,7 @@ static void drain_pages(unsigned int cpu
> >  /*
> >   * Spill all of this CPU's per-cpu pages back into the buddy allocator.
> >   */
> > -static void drain_local_pages(void *arg)
> > +void drain_local_pages(void *arg)
> >  {
> >       drain_pages(smp_processor_id());
> >  }
> > Index: linux-2.6.24-rc5-mm1/include/linux/gfp.h
> > ===================================================================
> > --- linux-2.6.24-rc5-mm1.orig/include/linux/gfp.h     2007-12-19 15:13:51.926950065 -0800
> > +++ linux-2.6.24-rc5-mm1/include/linux/gfp.h  2007-12-19 15:16:11.951564369 -0800
> > @@ -229,5 +229,6 @@ extern void FASTCALL(free_cold_page(stru
> >  void page_alloc_init(void);
> >  void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
> >  void drain_all_pages(void);
> > +void drain_local_pages(void *dummy);
> >
> >  #endif /* __LINUX_GFP_H */
>
