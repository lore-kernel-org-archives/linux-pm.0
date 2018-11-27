From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [driver-core PATCH v6 4/9] driver core: Move async_synchronize_full
 call
Date: Mon, 26 Nov 2018 18:11:19 -0800
Message-ID: <CAPcyv4ibARHP1Gji2cZQ704BeiKL26Bh13G58eyB+PjQJSD58w@mail.gmail.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170042103.12967.5841784115552956171.stgit@ahduyck-desk1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154170042103.12967.5841784115552956171.stgit@ahduyck-desk1.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.h.duyck@linux.intel.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>, bvanassche@acm.org
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Move the async_synchronize_full call out of __device_release_driver and
> into driver_detach.
>
> The idea behind this is that the async_synchronize_full call will only
> guarantee that any existing async operations are flushed. This doesn't do
> anything to guarantee that a hotplug event that may occur while we are
> doing the release of the driver will not be asynchronously scheduled.
>
> By moving this into the driver_detach path we can avoid potential deadlocks
> as we aren't holding the device lock at this point and we should not have
> the driver we want to flush loaded so the flush will take care of any
> asynchronous events the driver we are detaching might have scheduled.
>

What problem is this patch solving in practice, because if there were
drivers issuing async work from probe they would need to be
responsible for flushing it themselves. That said it seems broken that
the async probing infrastructure takes the device_lock inside
async_schedule and then holds the lock when calling
async_syncrhonize_full. Is it just luck that this hasn't caused
deadlocks in practice?

Given that the device_lock is hidden from lockdep I think it would be
helpful to have a custom lock_map_acquire() setup, similar to the
workqueue core, to try to keep the locking rules enforced /
documented.

The only documentation I can find for async-probe deadlock avoidance
is the comment block in do_init_module() for async_probe_requested.

Stepping back a bit, does this patch have anything to do with the
performance improvement, or is it a separate "by the way I also found
this" kind of patch?
