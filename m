From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/4] PM / core: Direct DPM_FLAG_SMART_SUSPEND optimization
Date: Tue, 19 Dec 2017 17:35:05 +0100
Message-ID: <CAJZ5v0hEP6L-dPSLhQohQSQgk+-gJDxjj5m55D_4yO1-_=p9LQ@mail.gmail.com>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <252167445.OQUXi2Ca9Y@aspire.rjw.lan>
 <CAPDyKFpC0xLfGLqyWUZwnSVdeY9Ojs-JUtPzEkRr=KAuSXDfmQ@mail.gmail.com>
 <CAJZ5v0hFP4zP+Q1znQ9ZnUTLunNaStmSR4-h-AqKn6UaF-d9Vw@mail.gmail.com>
 <CAJZ5v0h97zsjG=xKHz=zjaQiLz-ER5YfsQz=c3k7ZFafG8H8Cg@mail.gmail.com> <CAPDyKFqd6qk66C4M0h-4WzLjt_p=LyS1unCAzLxKrUYoSMbz6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqd6qk66C4M0h-4WzLjt_p=LyS1unCAzLxKrUYoSMbz6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 19, 2017 at 2:15 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 19 December 2017 at 12:19, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Tue, Dec 19, 2017 at 12:13 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Tue, Dec 19, 2017 at 8:38 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> On 10 December 2017 at 01:00, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>
>> [cut]
>>
>>>
>>>> Moreover, what happens when/if a driver that has deployed this
>>>> solution, starts being used on a new SoC and then additional
>>>> operations during system suspend becomes required (for example
>>>> pinctrls that needs to be put in a system sleep state)? Then
>>>> everything falls apart, doesn't it?
>>>
>>> Then you runtime-resume the device in ->suspend() and the remaining
>>> callbacks will run for you just fine.
>>
>> BTW, I guess you'll need a middle layer in that case anyway so that
>> the driver doesn't have to distinguish between platforms it has to
>> work with which makes the argument somewhat moot.
>
> No, this isn't the case. Let's take the pinctrl as an example.
>
> The pinctrl system sleep state could be optionally defined in the DT,
> depending on the platform.
>
> All the driver shall do, is to try to set the state, if it has been defined.

And how exactly does the driver know what state should be set during
system suspend, say?

Anyway, though, as I said, nothing forces you to set
DPM_FLAG_SMART_SUSPEND.  Don't set it if it is not suitable for you
and no one else is going to be affected.

Thanks,
Rafael
