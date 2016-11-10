From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] iommu/exynos: Add proper runtime pm support
Date: Thu, 10 Nov 2016 02:15:07 +0100
Message-ID: <20161110011507.GP13978@wotan.suse.de>
References: <1475136751-31340-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20160929081240eucas1p231c1ab5c5936886cbec6bc3f5267c940@eucas1p2.samsung.com>
	<1475136751-31340-3-git-send-email-m.szyprowski@samsung.com>
	<20161006173756.GK3296@wotan.suse.de>
	<87aeb58b-bda0-93c5-e51d-ab9be0b9d518@samsung.com>
	<20161108221437.GC13978@wotan.suse.de>
	<9cf5829a-baac-9297-b231-17212d0195b1@samsung.com>
	<CAJZ5v0iEZNsjzb4sxzG39UzNYuiqQErD5diE7WmdBKqQM9_S1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iEZNsjzb4sxzG39UzNYuiqQErD5diE7WmdBKqQM9_S1g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Linux Samsung SoC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Mark
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 01:36:29AM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 9, 2016 at 4:07 PM, Marek Szyprowski
> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> > Hi Luis,
> >
> >
> > On 2016-11-08 23:14, Luis R. Rodriguez wrote:
> >>
> >> On Mon, Oct 10, 2016 at 03:32:06PM +0200, Marek Szyprowski wrote:
> >>>
> >>> Hi Luis
> >>>
> >>>
> >>> On 2016-10-06 19:37, Luis R. Rodriguez wrote:
> >>>>
> >>>> On Thu, Sep 29, 2016 at 10:12:31AM +0200, Marek Szyprowski wrote:
> >>>>>
> >>>>> This patch uses recently introduced device links to track the runtime
> >>>>> pm
> >>>>> state of the master's device. This way each SYSMMU controller is
> >>>>> runtime
> >>>>> activated when its master's device is active
> >>>>
> >>>> instead of?
> >>>
> >>> instead of keeping SYSMMU controller runtime active all the time.
> >>
> >> I thought Rafael's work was for suspend/resume, not for runtime suspend.
> >> Is it for both ?
> >
> >
> > Yes, it solves both problems, although the suspend/resume was easy to
> > workaround just by using LATE_SLEEP_OPS.
> 
> Right, but that's just in this particular case, because the dependency
> chain is of length 2. :-)
> 
> If you had a longer chain, you might in theory use  the _noirq() stage
> somehow, but that has limitations.
> 
> >> Because as far as I can tell this was painted to help
> >> with suspend/resume ?
> 
> It helps with three things, (async) suspend/resume, runtime PM and
> shutdown (that last part is the hardest to figure out).  The ordering
> in which all of these are carried out is analogous and cannot be
> determined correctly by the device registration ordering itself in
> general (which has been a known fact for years, but some localized
> workarounds were put in some places to work around that).

Thanks for the clarification, this is due to the implicit sort you
had explained (and I provided notes for on ksummit-discuss) right?

Can you itemize a few of the workarounds that are used today?
As you clarify below, getting this order of device registration
correct does not necessarily guarantee devices will wait for their
provider to be ready.

> Moreover, even if the list ordering (of dpm_list, for instance) is
> correct, it still doesn't guarantee the right ordering of actions that
> are carried out asynchronously.  They are all started in the list
> order, but they may be running in parallel with each other and
> complete at different times.  For this reason, there needs to be a way
> to ensure that, say, the suspend operations for consumer devices
> complete before their suppliers will become unavailable and so on.

Thanks this helps as well!

> Both runtime PM and system suspend/resume have this problem.  It is
> not present in the system shutdown case, but it still helps to get a
> correct list ordering (ie. such that won't cause supplier devices to
> be shut down before their consumers) in this case too.

Is the fact that its not on shutdown just because we don't care about
being sloppy about shutdown ? Shouldn't some devices care about that
order ?

  Luis
