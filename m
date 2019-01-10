From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [driver-core PATCH v9 1/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
Date: Thu, 10 Jan 2019 09:37:32 -0800
Message-ID: <0a72b8db91f9151ecc7f215b465ec8e69adc239c.camel@linux.intel.com>
References: <154466182249.9126.3905559325944768059.stgit@ahduyck-desk1.jf.intel.com>
 <154466189880.9126.10737761541647369077.stgit@ahduyck-desk1.jf.intel.com>
 <CAJZ5v0hSWOb4b7FWJmfi86mYY+T1kedtC=ydS8VMUvpH4ctzbw@mail.gmail.com>
 <20181220152844.GA27498@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20181220152844.GA27498-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, bvanassche-HInyCGIudOg@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, Lai Jiangshan <jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Luis R.
 Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2018-12-20 at 16:28 +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 19, 2018 at 03:27:48PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Dec 13, 2018 at 1:45 AM Alexander Duyck
> > <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > > 
> > > Add an additional bit flag to the device struct named "dead".
> > > 
> > > This additional flag provides a guarantee that when a device_del is
> > > executed on a given interface an async worker will not attempt to attach
> > > the driver following the earlier device_del call. Previously this
> > > guarantee was not present and could result in the device_del call
> > > attempting to remove a driver from an interface only to have the async
> > > worker attempt to probe the driver later when it finally completes the
> > > asynchronous probe call.
> > > 
> > > One additional change added was that I pulled the check for dev->driver
> > > out of the __device_attach_driver call and instead placed it in the
> > > __device_attach_async_helper call. This was motivated by the fact that the
> > > only other caller of this, __device_attach, had already taken the
> > > device_lock() and checked for dev->driver. Instead of testing for this
> > > twice in this path it makes more sense to just consolidate the dev->dead
> > > and dev->driver checks together into one set of checks.
> > > 
> > > Reviewed-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> It's too late for 4.21-rc1 as my tree should be closed by now.
> 
> So I'll hold on to these in my queue until 4.21-rc1 is out and then
> queue them up and see what breaks in linux-next :)
> 
> thanks,
> 
> greg k-h

I just wanted to check on on this patch set in terms of workflow. Since
it looks like we now have 5.0-rc1 out I was wondering what the ETA for
this patch set being pulled was, or if I need to resubmit the set.

Thanks.

- Alex
