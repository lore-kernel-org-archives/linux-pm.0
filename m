From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [driver-core PATCH v8 2/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
Date: Mon, 10 Dec 2018 11:35:02 -0800
Message-ID: <15b6817fd945a1622afe673b46b028bacefad72b.camel@linux.intel.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
 <154403072403.11544.10419282512791659652.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4jH_Op-xHTd2FwQizPaWFx_2FE-pVsOLLmZAEK8EVPrYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4jH_Op-xHTd2FwQizPaWFx_2FE-pVsOLLmZAEK8EVPrYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, bvanassche-HInyCGIudOg@public.gmane.org, linux-nvdimm <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux-pm mailing list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-12-10 at 10:58 -0800, Dan Williams wrote:
> On Wed, Dec 5, 2018 at 9:25 AM Alexander Duyck
> <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > 
> > Add an additional bit flag to the device struct named "dead".
> > 
> > This additional flag provides a guarantee that when a device_del is
> > executed on a given interface an async worker will not attempt to attach
> > the driver following the earlier device_del call. Previously this
> > guarantee was not present and could result in the device_del call
> > attempting to remove a driver from an interface only to have the async
> > worker attempt to probe the driver later when it finally completes the
> > asynchronous probe call.
> > 
> > Signed-off-by: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/base/core.c    |   11 +++++++++++
> >  drivers/base/dd.c      |    8 ++++++--
> >  include/linux/device.h |    5 +++++
> >  3 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index f3e6ca4170b4..70358327303b 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2075,6 +2075,17 @@ void device_del(struct device *dev)
> >         struct kobject *glue_dir = NULL;
> >         struct class_interface *class_intf;
> > 
> > +       /*
> > +        * Hold the device lock and set the "dead" flag to guarantee that
> > +        * the update behavior is consistent with the other bitfields near
> > +        * it and that we cannot have an asynchronous probe routine trying
> > +        * to run while we are tearing out the bus/class/sysfs from
> > +        * underneath the device.
> > +        */
> > +       device_lock(dev);
> > +       dev->dead = true;
> > +       device_unlock(dev);
> > +
> >         /* Notify clients of device removal.  This call must come
> >          * before dpm_sysfs_remove().
> >          */
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 88713f182086..3bb8c3e0f3da 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -774,6 +774,10 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
> > 
> >         device_lock(dev);
> > 
> > +       /* device is or has been removed from the bus, just bail out */
> > +       if (dev->dead)
> > +               goto out_unlock;
> > +
> 
> What do you think about moving this check into
> __device_attach_driver() alongside all the other checks? That way we
> also get ->dead checking through the __device_attach() path.

I'm not really sure that is the best spot to do that. Part of the
reason being that by placing it where I did we avoid messing with the
runtime power management for the parent if it was already powered off.

If anything I would say we could probably look at pulling the check out
and placing the driver check in __device_attach_async_helper since from
what I can tell the check is actually redundant in the non-async path
anyway since __device_attach already had taken the device lock and
checked dev->driver prior to calling __device_attach_driver.

> ...and after that maybe it could be made a common helper
> (dev_driver_checks()?) shared between __device_attach_driver() and
> __driver_attach() to reduce some duplication.

I'm not sure consolidating it into a function would really be worth the
extra effort. It would essentially just obfuscate the checks and I am
not sure you really save much with:
	if (dev_driver_checks(dev))
vs:
	if (!dev->dead && !dev->driver)

By the time you create the function and replace the few spots that are
making these checks you would end up most likely adding more complexity
to the kernel rather than reducing it any.
