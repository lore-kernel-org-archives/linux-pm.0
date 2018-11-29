From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [driver-core PATCH v7 2/9] driver core: Establish clear order
 of operations for deferred probe and remove
Date: Thu, 29 Nov 2018 13:53:57 -0800
Message-ID: <53173cf971f5fbd33d744a1734dda87cb66c4206.camel@linux.intel.com>
References: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154345153672.18040.3771035148218843351.stgit@ahduyck-desk1.amr.corp.intel.com>
 <CAPcyv4gMswOJ3VTaY6P7f=iG_jNBKZyynn22CLrEBB13Fq-8vQ@mail.gmail.com>
 <a5b33ae899fc4131abf0f26af33a6c6b7f462431.camel@linux.intel.com>
 <CAPcyv4j2w6ygzuP-vEKPk6NGLCEB6FcKTVFQkUqr3HC471xJsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4j2w6ygzuP-vEKPk6NGLCEB6FcKTVFQkUqr3HC471xJsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Thu, 2018-11-29 at 10:55 -0800, Dan Williams wrote:
> On Thu, Nov 29, 2018 at 10:07 AM Alexander Duyck
> <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > 
> > On Wed, 2018-11-28 at 17:57 -0800, Dan Williams wrote:
> 
> [..]
> > > I think the flag should be named "cancel" and set it in the
> > > device_del() path. Otherwise this is encoding code flow state in the
> > > struct rather than device-state that the code needs to comprehend.
> > 
> > Instead of "cancel" what would you think of "dead"? In my mind once we
> > call device_del we are essentially working with a dead device object so
> > that might make more sense in terms of a state rather than "cancel"
> > which doesn't really tell us what should be canceled.
> 
> That sounds good to me.
> 
> > Looking over the code I could probably set it before we start calling
> > the notifiers for BUS_NOTIFY_DEL_DEVICE. The only thing I am not sure
> > about is if we would need to add any sort of synchronization primitives
> > around it.
> > 
> 
> I think it needs to be something like a barrier:
> 
>     dev->dead;
>     device_lock();
>     device_unlock();
> 
> ...where you can be sure that anyone after that device_unlock() has
> acted on dev->dead, or will see dev->dead.

Actually what I think I will do is set dev->dead to true with the
device lock held at the start of device_del. So something like:
	device_lock();
	dev->dead = true;
	device_unlock();

It seems like that would probably make the most sense and be consistent
with the handling of other bits such as dev->offline. It means adding
one more call to device_lock/unlock but it guarantees that the update
behavior is consistent with the other bitfields near it and that we
cannot have an asynchronous probe routine trying to run while we are
tearing out the bus/class/sysfs from underneath the device.
