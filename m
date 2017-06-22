From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 7/9] PM / ACPI: Enable the runtime PM centric approach for
 system sleep
Date: Thu, 22 Jun 2017 23:28:29 +0200
Message-ID: <CAJZ5v0gYUbULWNRDLt2MFHuraJ3L_LGVbxR3fNLJ2-PHAQsGcg@mail.gmail.com>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0jL-0TKUv5nK7tFLm+X7nE7J2e3hm21i=+FBFBzQLQ=Xw@mail.gmail.com>
 <CAPDyKFpYpLqPiyfqp16JT8fA7xwhanAcfhdnYm6MgeXyq0QfNQ@mail.gmail.com>
 <2162861.FQgDXG4xnB@aspire.rjw.lan> <CAPDyKFpbn2Ao7YBTtFVM7uO=O4Atu==R17_aA2oxY-j7jAaaZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpbn2Ao7YBTtFVM7uO=O4Atu==R17_aA2oxY-j7jAaaZQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 22, 2017 at 11:14 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 22 June 2017 at 16:32, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Thursday, June 22, 2017 11:42:11 AM Ulf Hansson wrote:
>>> On 21 June 2017 at 23:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> > On Wed, Jun 21, 2017 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> >> This change extends the interpretation of the ACPI's no_direct_complete
>>> >> flag to be used to enable the so called runtime PM centric approach, for
>>> >> devices being attached to the ACPI PM domain.
>>> >>
>>> >> The principle behind the runtime PM centric approach is to re-use the
>>> >> runtime PM callbacks to implement system sleep for drivers/subsystems.
>>> >> Moreover, using the runtime PM centric approach gives an optimized
>>> >> behaviour around avoiding to wake up a device from its low power state
>>> >> during system sleep, unless really needed.
>>> >>
>>> >> To deploy the runtime PM centric approach for a subsystem/driver, the
>>> >> following adaptations needs to be made.
>>> >>
>>> >> First, the runtime PM callbacks may be called when runtime PM has been
>>> >> disabled for the device. This serves as an indication for the callbacks to
>>> >> understand they are running in the system sleep sequence, instead of in the
>>> >> regular runtime PM path. In some cases, a callback needs to take different
>>> >> actions depending in what path it is being executed in, as is the case for
>>> >> the ACPI PM domain.
>>> >>
>>> >> In particular for the ACPI PM domain's ->runtime_suspend|resume()
>>> >> callbacks, when those finds runtime PM being disabled for the device, it
>>> >> instead executes the same operations as normally being run when
>>> >> ->suspend_late() and ->resume_early() callbacks are invoked during system
>>> >> sleep.
>>> >>
>>> >> Second, at the PM domain level, it is expected that the driver for the
>>> >> device makes use of pm_runtime_force_suspend|resume(), to re-use the
>>> >> runtime PM callbacks to put the device into low power state and to wake it
>>> >> up when needed during system sleep.
>>> >
>>> > What if it doesn't do that?
>>> >
>>> > Do all drivers of devices that may fall into the ACPI PM domain use
>>> > pm_runtime_force_suspend|resume()?
>>>
>>> No, no - the runtime PM centric path is optional by all ACPI
>>> devices/drivers. The default is still for the ACPI PM domain to try
>>> the direct_complete path.
>>>
>>> However if an ACPI device/driver (i2c designware in this case) likes
>>> to do that, they need to inform the ACPI PM domain about it. Then they
>>> call acpi_dev_disable_direct_complete() and makes use of
>>> pm_runtime_force_suspend|resume() to deal with system sleep.
>>>
>>> Does that makes sense?
>>
>> Overall, yes, it does, but then it should be made clear that when you use
>> "no_direct_complete" (all what you are going to call that eventually), you
>> also must use pm_runtime_force_suspend|resume() as your sleep callbacks.
>
> Okay, so I will clarify that in the header of
> acpi_dev_disable_direct_complete() and I guess I should also update
> some documentation around ACPI.

I think it also would be good to make
acpi_dev_disable_direct_complete() check the conditions and throw a
stack dump if they are not met.

>>
>> Otherwise things may not work correctly if my understanding is correct.
>
> Correct.

OK

In that case the no_direct_complete flag should be set for the entire
time the driver is bound to the device.  Therefore
(a) It should go into struct acpi_device_power_flags.
(b) It should be set at the probe time and cleared at the remove time.

Thanks,
Rafael
