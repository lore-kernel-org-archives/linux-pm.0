From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [driver-core PATCH v9 1/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
Date: Fri, 18 Jan 2019 11:00:24 -0800
Message-ID: <8d8c0ca38f329986084e6a8a4971fb4b3a1727ee.camel@linux.intel.com>
References: <154466182249.9126.3905559325944768059.stgit@ahduyck-desk1.jf.intel.com>
 <154466189880.9126.10737761541647369077.stgit@ahduyck-desk1.jf.intel.com>
 <20190118155425.GB5009@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20190118155425.GB5009-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bvanassche-HInyCGIudOg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2019-01-18 at 16:54 +0100, Greg KH wrote:
> On Wed, Dec 12, 2018 at 04:44:58PM -0800, Alexander Duyck wrote:
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
> > One additional change added was that I pulled the check for dev->driver
> > out of the __device_attach_driver call and instead placed it in the
> > __device_attach_async_helper call. This was motivated by the fact that the
> > only other caller of this, __device_attach, had already taken the
> > device_lock() and checked for dev->driver. Instead of testing for this
> > twice in this path it makes more sense to just consolidate the dev->dead
> > and dev->driver checks together into one set of checks.
> > 
> > Reviewed-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/base/core.c    |   11 +++++++++++
> >  drivers/base/dd.c      |   22 +++++++++++-----------
> >  include/linux/device.h |    5 +++++
> >  3 files changed, 27 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 0073b09bb99f..950e25495726 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2080,6 +2080,17 @@ void device_del(struct device *dev)
> >  	struct kobject *glue_dir = NULL;
> >  	struct class_interface *class_intf;
> >  
> > +	/*
> > +	 * Hold the device lock and set the "dead" flag to guarantee that
> > +	 * the update behavior is consistent with the other bitfields near
> > +	 * it and that we cannot have an asynchronous probe routine trying
> > +	 * to run while we are tearing out the bus/class/sysfs from
> > +	 * underneath the device.
> > +	 */
> > +	device_lock(dev);
> > +	dev->dead = true;
> > +	device_unlock(dev);
> > +
> >  	/* Notify clients of device removal.  This call must come
> >  	 * before dpm_sysfs_remove().
> >  	 */
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 88713f182086..74c194ac99df 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -731,15 +731,6 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
> >  	bool async_allowed;
> >  	int ret;
> >  
> > -	/*
> > -	 * Check if device has already been claimed. This may
> > -	 * happen with driver loading, device discovery/registration,
> > -	 * and deferred probe processing happens all at once with
> > -	 * multiple threads.
> > -	 */
> > -	if (dev->driver)
> > -		return -EBUSY;
> > -
> >  	ret = driver_match_device(drv, dev);
> >  	if (ret == 0) {
> >  		/* no match */
> > @@ -774,6 +765,15 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
> >  
> >  	device_lock(dev);
> >  
> > +	/*
> > +	 * Check if device has already been removed or claimed. This may
> > +	 * happen with driver loading, device discovery/registration,
> > +	 * and deferred probe processing happens all at once with
> > +	 * multiple threads.
> > +	 */
> > +	if (dev->dead || dev->driver)
> > +		goto out_unlock;
> > +
> >  	if (dev->parent)
> >  		pm_runtime_get_sync(dev->parent);
> >  
> > @@ -784,7 +784,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
> >  
> >  	if (dev->parent)
> >  		pm_runtime_put(dev->parent);
> > -
> > +out_unlock:
> >  	device_unlock(dev);
> >  
> >  	put_device(dev);
> > @@ -897,7 +897,7 @@ static int __driver_attach(struct device *dev, void *data)
> >  	if (dev->parent && dev->bus->need_parent_lock)
> >  		device_lock(dev->parent);
> >  	device_lock(dev);
> > -	if (!dev->driver)
> > +	if (!dev->dead && !dev->driver)
> >  		driver_probe_device(drv, dev);
> >  	device_unlock(dev);
> >  	if (dev->parent && dev->bus->need_parent_lock)
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 1b25c7a43f4c..f73dad81e811 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -957,6 +957,10 @@ struct dev_links_info {
> >   *              device.
> >   * @dma_coherent: this particular device is dma coherent, even if the
> >   *		architecture supports non-coherent devices.
> > + * @dead:	This device is currently either in the process of or has
> > + *		been removed from the system. Any asynchronous events
> > + *		scheduled for this device should exit without taking any
> > + *		action.
> >   *
> >   * At the lowest level, every device in a Linux system is represented by an
> >   * instance of struct device. The device structure contains the information
> > @@ -1051,6 +1055,7 @@ struct device {
> >      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> >  	bool			dma_coherent:1;
> >  #endif
> > +	bool			dead:1;
> 
> This really should live in the struct device_private structure, as
> nothing outside of the driver core should care about this, or touch it.
> 
> A number of other bitfields should also move there as well, your's isn't
> the only one that I missed this for.
> 
> So can you make that quick change, and rebase (you needed to for patch 2
> anyway), and resend so I can get this into my -next tree for people to
> start testing and basing their work on?
> 
> sorry this has taken so long, and thanks for sticking with it.
> 
> greg k-h

Okay. I will try to work it into my schedule and hopefully have the
updated patches ready sometime early next week.

Thanks.

- Alex
