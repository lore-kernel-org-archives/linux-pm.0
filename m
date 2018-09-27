From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC workqueue/driver-core PATCH 2/5] async: Add support for
 queueing on specific NUMA node
Date: Thu, 27 Sep 2018 12:48:42 -0700
Message-ID: <CAPcyv4iJeb-tJZVWRziwHQ-ug2P8Hgov2FSGvaXDOjw337kfMg@mail.gmail.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215143.13512.56522.stgit@localhost.localdomain> <CAPcyv4iJOYiM+rHsM4GPifKNJ=X+AtV2MgWTn+f7u0VBzXb2og@mail.gmail.com>
 <d16cabf9-28f7-31e2-c43d-027738185518@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d16cabf9-28f7-31e2-c43d-027738185518@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.h.duyck@linux.intel.com
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, Greg KH <gregkh@linuxfoundation.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, jiangshanlai@gmail.com, Pavel Machek <pavel@ucw.cz>, zwisler@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 27, 2018 at 8:24 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
[..]
> >> - * Returns an async_cookie_t that may be used for checkpointing later.
> >> - * @domain may be used in the async_synchronize_*_domain() functions to
> >> - * wait within a certain synchronization domain rather than globally.  A
> >> - * synchronization domain is specified via @domain.  Note: This function
> >> - * may be called from atomic or non-atomic contexts.
> >> + * Device specific version of async_schedule_near_domain that provides some
> >> + * NUMA awareness based on the device node.
> >> + */
> >> +async_cookie_t async_schedule_dev_domain(async_func_t func, struct device *dev,
> >> +                                        struct async_domain *domain)
> >> +{
> >> +       return async_schedule_near_domain(func, dev, dev_to_node(dev), domain);
> >> +}
> >> +EXPORT_SYMBOL_GPL(async_schedule_dev_domain);
> >
> > This seems unnecessary and restrictive. Callers may want to pass
> > something other than dev as the parameter to the async function, and
> > dev_to_node() is not on onerous burden to place on callers.
>
>
> That is what async_schedule_near_domain is for, they can call that. The
> "dev" versions of the calls as just supposed to be helpers since one of
> the most common parameters to the async_schedule calls is a device, so I
> thought I would just put together a function that takes care of all this
> for us so I could drop an argument and avoid having to use dev_to_node
> everywhere.

Yeah, makes sense, I guess I was reacting to the fact that this
expands the number of exports unnecessarily. The other async routines
are exported because they hide internal implementation details of the
async implementation. The async_schedule_dev* helpers can just be
static inline wrappers.
