From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [driver-core PATCH v6 4/9] driver core: Move async_synchronize_full
 call
Date: Tue, 27 Nov 2018 12:35:20 -0800
Message-ID: <CAPcyv4gKT1CDA-xVh5LCYEVUeXLB5ktCFqpFhPWzNK7+QbQdvw@mail.gmail.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170042103.12967.5841784115552956171.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4ibARHP1Gji2cZQ704BeiKL26Bh13G58eyB+PjQJSD58w@mail.gmail.com> <ec672fcf5924ef267f35b11c13ddc50c815b1a9f.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ec672fcf5924ef267f35b11c13ddc50c815b1a9f.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.h.duyck@linux.intel.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>, bvanassche@acm.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 27, 2018 at 9:38 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Mon, 2018-11-26 at 18:11 -0800, Dan Williams wrote:
> > On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > Move the async_synchronize_full call out of __device_release_driver and
> > > into driver_detach.
> > >
> > > The idea behind this is that the async_synchronize_full call will only
> > > guarantee that any existing async operations are flushed. This doesn't do
> > > anything to guarantee that a hotplug event that may occur while we are
> > > doing the release of the driver will not be asynchronously scheduled.
> > >
> > > By moving this into the driver_detach path we can avoid potential deadlocks
> > > as we aren't holding the device lock at this point and we should not have
> > > the driver we want to flush loaded so the flush will take care of any
> > > asynchronous events the driver we are detaching might have scheduled.
> > >
> >
> > What problem is this patch solving in practice, because if there were
> > drivers issuing async work from probe they would need to be
> > responsible for flushing it themselves. That said it seems broken that
> > the async probing infrastructure takes the device_lock inside
> > async_schedule and then holds the lock when calling
> > async_syncrhonize_full. Is it just luck that this hasn't caused
> > deadlocks in practice?
>
> My understanding is that it has caused some deadlocks. There was
> another patch set that Bart Van Assche had submitted that was
> addressing this. I just tweaked my patch set to address both the issues
> he had seen as well as the performance improvements included in my
> original patch set.

I tried to go find that discussion, but failed. It would help to
report an actual failure rather than a theoretical one.

> > Given that the device_lock is hidden from lockdep I think it would be
> > helpful to have a custom lock_map_acquire() setup, similar to the
> > workqueue core, to try to keep the locking rules enforced /
> > documented.
> >
> > The only documentation I can find for async-probe deadlock avoidance
> > is the comment block in do_init_module() for async_probe_requested.
>
> Would it make sense to just add any lockdep or deadlock documentation
> as a seperate patch? I can work on it but I am not sure it makes sense
> to add to this patch since there is a chance this one will need to be
> backported to stable at some point.

Yes, separate follow-on sounds ok.

> > Stepping back a bit, does this patch have anything to do with the
> > performance improvement, or is it a separate "by the way I also found
> > this" kind of patch?
>
> This is more of a seperate "by the way" type of patch based on the
> discussion Bart and I had about how to best address the issue. There
> may be some improvement since we only call async_synchronize_full once
> and only when we are removing the driver, but I don't think it would be
> very noticable.

Ok, might be worthwhile to submit this at the front of the series as a
fix that has implications for what comes later. The only concern is
whether this fix stands alone. It would seem to make the possibility
of ->remove() racing ->probe() worse, no? Can we make this change
without the new/proposed ->async_probe tracking infrastructure?
