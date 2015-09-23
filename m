From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 17/17] mfd : ab8500/db8500: fix the abuse of
 IRQF_NO_SUSPEND
Date: Wed, 23 Sep 2015 10:44:07 +0100
Message-ID: <56027467.1020803@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-18-git-send-email-sudeep.holla@arm.com>
 <20150921232027.GD11284@x1> <560127BE.9030604@arm.com>
 <20150922210322.GA3442@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150922210322.GA3442@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org



On 22/09/15 22:03, Lee Jones wrote:
> On Tue, 22 Sep 2015, Sudeep Holla wrote:
>> On 22/09/15 00:20, Lee Jones wrote:
>>> On Mon, 21 Sep 2015, Sudeep Holla wrote:
>>>
>>>> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
>>>> be left enabled so as to allow them to work as expected during the
>>>> suspend-resume cycle, but doesn't guarantee that it will wake the system
>>> >from a suspended state, enable_irq_wake is recommended to be used for
>>>> the wakeup.
>>>>
>>>> This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
>>>> enable_irq_wake instead.
>>>>
>>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>> ---
>>>>   drivers/mfd/ab8500-core.c        | 11 +++++++++--
>>>>   drivers/mfd/ab8500-debugfs.c     |  2 +-
>>>>   drivers/mfd/ab8500-gpadc.c       | 15 +++++++++++----
>>>>   drivers/mfd/db8500-prcmu.c       | 24 +++++++++++++++++-------
>>>>   drivers/power/ab8500_btemp.c     |  6 ++++--
>>>>   drivers/power/ab8500_charger.c   |  6 ++++--
>>>>   drivers/power/ab8500_fg.c        |  9 ++++++---
>>>>   drivers/thermal/db8500_thermal.c |  5 ++---
>>>>   drivers/usb/phy/phy-ab8500-usb.c | 10 ++++++----
>>>>   9 files changed, 60 insertions(+), 28 deletions(-)
>>>
>>> Is there a reason for bundling the changes in all of these subsystems
>>> together into a single patch?
>>>
>>
>> No, I understand this needs to be split. Since I was not 100% confident
>> about this change, I wanted LinusW to review and provide feedback and
>> gets things working before I can split this changes. I must have added
>> RFC, but usually it gets ignored :)
>
> Best if Linus reviews the correct patch-set.  Please split and
> resubmit.
>
Sure, but would like to get some feedback before I proceed just to
ensure my understanding is correct.

Regards,
Sudeep
