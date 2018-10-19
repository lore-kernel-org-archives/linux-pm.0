From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
Date: Thu, 18 Oct 2018 19:31:12 -0700
Message-ID: <1e061fe5-9be4-77be-5350-4cb7175afdf8@acm.org>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
 <20181015150926.29520.45280.stgit@localhost.localdomain>
 <1539886275.81977.17.camel@acm.org>
 <e870da1d-48fa-7f2e-6909-b168a06633f2@linux.intel.com>
 <1539893636.81977.29.camel@acm.org>
 <CAKgT0Ucf-v3FNTA0z=3nPR-xS=0NYeqDjRfDW-KjDE5Ed-n1_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKgT0Ucf-v3FNTA0z=3nPR-xS=0NYeqDjRfDW-KjDE5Ed-n1_g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: alexander.h.duyck@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 10/18/18 7:20 PM, Alexander Duyck wrote:
> I see what you are talking about now. Actually I think this was an
> existing issue before my patch even came into play. Basically the code
> as it currently stands is device specific in terms of the attach and
> release code.
> 
> I wonder if we shouldn't have the async_synchronize_full call in
> __device_release_driver moved down and into driver_detach before we
> even start the for loop. Assuming the driver is no longer associated
> with the bus that should flush out all devices so that we can then
> pull them out of the devices list at least. I may look at adding an
> additional bitflag to the device struct to indicate that it has a
> driver attach pending. Then for things like races between any attach
> and detach calls the logic becomes pretty straight forward. Attach
> will set the bit and provide driver data, detach will clear the bit
> and the driver data. If a driver loads in between it should clear the
> bit as well.
> 
> I'll work on it over the next couple days and hopefully have something
> ready for testing/review early next week.

Hi Alex,

How about checking in __driver_attach_async_helper() whether the driver 
pointer is still valid by checking whether bus_for_each_drv(dev->bus, 
...) can still find the driver pointer? That approach requires 
protection with a mutex to avoid races with the driver detach code but 
shouldn't require any new flags in struct device.

Thanks,

Bart.
