From: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
Date: Thu, 18 Oct 2018 19:20:12 -0700
Message-ID: <CAKgT0Ucf-v3FNTA0z=3nPR-xS=0NYeqDjRfDW-KjDE5Ed-n1_g@mail.gmail.com>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
 <20181015150926.29520.45280.stgit@localhost.localdomain> <1539886275.81977.17.camel@acm.org>
 <e870da1d-48fa-7f2e-6909-b168a06633f2@linux.intel.com> <1539893636.81977.29.camel@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539893636.81977.29.camel@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bvanassche@acm.org
Cc: alexander.h.duyck@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 18, 2018 at 1:15 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Thu, 2018-10-18 at 12:38 -0700, Alexander Duyck wrote:
> > Basically if somebody loads a driver the dev->driver becomes set. If a
> > driver is removed it will clear dev->driver and set driver_data to
> > 0/NULL. That is what I am using as a mutex to track it in conjunction
> > with the device mutex. Basically if somebody attempts to attach a driver
> > before we get there we just exit and don't attempt to load this driver.
>
> I don't think that the above matches your code. __device_attach() does not
> set the dev->driver pointer before scheduling an asynchronous probe. Only
> dev->driver_data gets set before the asynchonous probe is scheduled. Since
> driver_detach() only iterates over devices that are in the per-driver klist
> it will skip all devices for which an asynchronous probe has been scheduled
> but __device_attach_async_helper() has not yet been called. My conclusion
> remains that this patch does not prevent a driver pointer to become invalid
> concurrently with __device_attach_async_helper() dereferencing the same
> driver pointer.
>
> Bart.

I see what you are talking about now. Actually I think this was an
existing issue before my patch even came into play. Basically the code
as it currently stands is device specific in terms of the attach and
release code.

I wonder if we shouldn't have the async_synchronize_full call in
__device_release_driver moved down and into driver_detach before we
even start the for loop. Assuming the driver is no longer associated
with the bus that should flush out all devices so that we can then
pull them out of the devices list at least. I may look at adding an
additional bitflag to the device struct to indicate that it has a
driver attach pending. Then for things like races between any attach
and detach calls the logic becomes pretty straight forward. Attach
will set the bit and provide driver data, detach will clear the bit
and the driver data. If a driver loads in between it should clear the
bit as well.

I'll work on it over the next couple days and hopefully have something
ready for testing/review early next week.

Thanks.

- Alex
