From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Should drivers like nvme let userspace control their latency via dev_pm_qos?
Date: Thu, 22 Sep 2016 18:40:57 -0700
Message-ID: <CALCETrW-WgrK4bchNF3DG+uLYYuxWaV37=NKhYwhNXzP9pkuXA@mail.gmail.com>
References: <CALCETrUsgA2H=TuwZMuwW2XpXZ7KPrEYu6xckmTbhU8oZwr6Nw@mail.gmail.com>
 <e15e94c5-efa0-8ec2-11b1-bea254b38513@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e15e94c5-efa0-8ec2-11b1-bea254b38513@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, J Freyensee <james_p_freyensee@linux.intel.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 22, 2016 at 6:26 PM, Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
> On 9/16/2016 5:26 PM, Andy Lutomirski wrote:
>>
>> I'm adding power management to the nvme driver, and I'm exposing
>> exactly one knob via sysfs: the maximum permissible latency.  This
>> isn't a power domain issue, and it has no dependencies -- it's
>> literally just the maximum latency that the driver may impose on I/O
>> for power saving purposes.
>>
>> ISTM userspace should be able to specify its own latency tolerance in
>> a uniform way, and dev_pm_qos seems like the natural interface for
>> this, except that I cannot find a single instance in the tree of *any*
>> driver using it via the notifier mechanism.
>
>
> That's because the notifier mechanism is only used for the "resume latency"
> type of constraints.
>
>> I can find two drivers that do it using
>> dev_pm_qos_expose_latency_tolerance(), and both are LPSS drivers?
>
>
> That's correct.  Nobody else has used it so far. :-)
>
>> So: should I be exposing .set_latency_tolerance() or should I just use
>> a custom sysfs attribute?  Or both?
>
>
> dev_pm_qos_expose_latency_tolerance() adds a single latency tolerance
> request object to the device and exposes a knob in user space by which that
> request object can be controlled.  There may be more latency tolerance
> request objects for the same device if kernel code adds them.  The effective
> latency tolerance is the minimum of all those requests and the callback is
> invoked every time that effective value changes.
>
> This also is described in the last section of
> Documentation/power/pm_qos_interface.txt (note that if the
> .set_latency_tolerance callback is present at the device registration time
> already, the latency tolerance sysfs attribute will be exposed automatically
> by the driver core).
>
> If that mechanism is suitable for the use case in question, I'd just use it.

OK, I'll play with it.
