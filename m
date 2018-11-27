From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [driver-core PATCH v6 6/9] driver core: Probe devices
 asynchronously instead of the driver
Date: Tue, 27 Nov 2018 09:57:56 -0800
Message-ID: <785e7a944b60cd237680075064477efad1e9c39a.camel@linux.intel.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
         <154170043123.12967.3591757325647337726.stgit@ahduyck-desk1.jf.intel.com>
         <CAPcyv4g0LNJZ38NKMXsBY+GgmGbHR4VrTM1gkm3m4bg6fOrfsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4g0LNJZ38NKMXsBY+GgmGbHR4VrTM1gkm3m4bg6fOrfsw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>, bvanassche@acm.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-11-26 at 18:48 -0800, Dan Williams wrote:
> On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
> > 
> > Probe devices asynchronously instead of the driver. This results in us
> > seeing the same behavior if the device is registered before the driver or
> > after. This way we can avoid serializing the initialization should the
> > driver not be loaded until after the devices have already been added.
> > 
> > The motivation behind this is that if we have a set of devices that
> > take a significant amount of time to load we can greatly reduce the time to
> > load by processing them in parallel instead of one at a time. In addition,
> > each device can exist on a different node so placing a single thread on one
> > CPU to initialize all of the devices for a given driver can result in poor
> > performance on a system with multiple nodes.
> 
> Do you have numbers on effects of this change individually? Is this
> change necessary for the libnvdimm init speedup, or is it independent?

It depends on the case. I was using X86_PMEM_LEGACY_DEVICE to spawn a
couple of 32GB persistent memory devices. I had to use this patch and
the async_probe option to get them loading in parallel versus serial as
the driver load order is a bit different.

Basically as long as all the necessary drivers are loaded for libnvdimm
you are good, however if the device can get probed before the driver is
loaded you run into issues as the loading will be serialized without
this patch.

> > I am using the driver_data member of the device struct to store the driver
> > pointer while we wait on the deferred probe call. This should be safe to do
> > as the value will either be set to NULL on a failed probe or driver load
> > followed by unload, or the driver value itself will be set on a successful
> > driver load. In addition I have used the async_probe flag to add additional
> > protection as it will be cleared if someone overwrites the driver_data
> > member as a part of loading the driver.
> 
> I would not put it past a device-driver to call dev_get_drvdata()
> before dev_set_drvdata(), to check "has this device already been
> initialized". So I don't think it is safe to assume that the core can
> stash this information in ->driver_data. Why not put this
> infrastructure in struct device_private?

The data should be cleared before we even get to the probe call so I am
not sure that is something we would need to worry about.

As far as why I didn't use device_private, it was mostly just for the
sake of space savings. I only had to add one bit to an existing
bitfield to make the async_probe approach work, and the drvdata just
seemed like the obvious place to put the deferred driver.
