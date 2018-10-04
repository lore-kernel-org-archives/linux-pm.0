From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / core: Clear the direct_complete flag on errors
Date: Thu, 4 Oct 2018 16:40:00 +0200
Message-ID: <CAPDyKFodNLoHcCJQ0MnoPb6nJ4Nr7V57V16EAYBrk0B01uKagg@mail.gmail.com>
References: <61559514.Vym8FNvob2@aspire.rjw.lan> <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
 <CAOGqxeXCsXbxOcDrdjsgLXXxOtFfyzE0-zVEU6Y9kLxUaVfDiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOGqxeXCsXbxOcDrdjsgLXXxOtFfyzE0-zVEU6Y9kLxUaVfDiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cooper <alcooperx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 4 October 2018 at 15:59, Alan Cooper <alcooperx@gmail.com> wrote:
>> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > If __device_suspend() returns early on an error or pending wakeup
>> > and the power.direct_complete flag has been set for the device
>> > already, the subsequent device_resume() will be confused by it
>> > and it will call pm_runtime_enable() incorrectly, as runtime PM
>> > has not been disabled for the device by __device_suspend().
>>
>> I think it would be fair to mention that is related to the async
>> suspend path, in dpm_suspend().
>
> This also fixed the issue and looks cleaner.
>
>>
>> >
>> > To avoid that, clear power.direct_complete if __device_suspend()
>> > is not going to disable runtime PM for the device before returning.
>>
>> Overall, by looking at the behavior in dpm_suspend() of async
>> suspended devices, it does look a bit fragile to me.
>>
>> My worries is that we put asynced suspended devices in the
>> dpm_suspended_list, no matter if the device was successfully suspended
>> or not. This differs from the no-async path.
>>
>> In the long run, maybe we should change that instead?
>
> I originally looked into this. Currently dmp_suspend moves async
> devices from the prepared list to the suspended list as they are
> queued and I looked at moving this to __device_suspend (after the
> checks for async_error and wake_pending) but realized that this would
> change normal resume ordering and was afraid that would be too
> disruptive.
>

I understand, however, I would be surprised if that would be a real
problem. But who knows. :-)

The hole async thing is opt-in, and it does also assume that
drivers/subsystems to cope with devices suspend/resume ordering to be
based upon device relationships, like parent/child,
device_link-supplier/consumers. If it's not working, drivers should
disable the async option, at least in my opinion.

Kind regards
Uffe
