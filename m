From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 07/17] input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
Date: Wed, 23 Sep 2015 09:53:48 +0100
Message-ID: <5602689C.30000@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-8-git-send-email-sudeep.holla@arm.com>
 <20150921232132.GE11284@x1>
 <CAKdAkRRWWxwWREiBiBcqBwBcZ6q0GHDgR1pyKfBXw=trP3cX_A@mail.gmail.com>
 <20150922210632.GB3442@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150922210632.GB3442@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-pm@vger.kernel.org



On 22/09/15 22:08, Lee Jones wrote:
> On Mon, 21 Sep 2015, Dmitry Torokhov wrote:
>
>> On Mon, Sep 21, 2015 at 4:21 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>> The $SUBJECT is not correct.
>>>
>>>> The driver handles wakeup irq correctly using irq_set_irq_wake. There's
>>>> no need to use IRQF_NO_SUSPEND while registering the interrupt.
>>>>
>>>> This patch removes the use of IRQF_NO_SUSPEND flag.
>>>>
>>>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>>>> Cc: Lee Jones <lee.jones@linaro.org>
>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>> ---
>>>>   drivers/mfd/qcom_rpm.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> ... code is fine though:
>>>
>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>>
>>> Please re-submit with the subject line fixed.
>>
>> What's wrong with the subject?
>
> This patch has nothing to do with Input and the first word of the
> explanatory sentence should start with an uppercase character.
>

Ah my stupid mistake, I didn't realize it. Sorry for the noise, will
fix it and send.

Regards,
Sudeep
