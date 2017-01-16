From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Calling device_init_wakeup() on driver removal
Date: Mon, 16 Jan 2017 22:50:57 +0100
Message-ID: <CAJZ5v0hUPuG=L=vaFuoqSPDG-jt+iHVJp3zCx9Z8svYo=A-txQ@mail.gmail.com>
References: <b4f92201-77f6-4a15-81cf-8f2f384d0c1f@roeck-us.net>
 <3852101.qr97BxrLhj@aspire.rjw.lan> <d50f9cf4-99e8-b95e-dc6c-317b06d75cdc@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d50f9cf4-99e8-b95e-dc6c-317b06d75cdc@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jan 15, 2017 at 4:23 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 01/15/2017 06:49 AM, Rafael J. Wysocki wrote:
>>
>> On Saturday, January 14, 2017 08:46:05 PM Guenter Roeck wrote:
>>>
>>> Hi folks,
>>
>>
>> Hi,
>>
>>> while looking through driver initialization and removal functions, I
>>> noticed that many drivers
>>> call device_init_wakeup(dev, false) in the removal function. Given that
>>> the driver is about
>>> to be removed, that doesn't make much sense to me, especially since
>>> device_wakeup_disable()
>>> is called from device_pm_remove() anyway.
>>>
>>> Is it safe to assume that all those calls can be removed, or is there a
>>> possible reason for
>>> keeping them around ?
>>
>>
>> Removing them automatically might break things, because
>> device_init_wakeup(dev, false)
>> also clears the power.can_wakeup flag and removes the "wakeup" attribute
>> from sysfs.
>>
>
> I had the same concern, but I concluded that the wakeup attribute should be
> removed
> automatically, since it is added with sysfs_merge_group(), and the matching
> unmerge call
> is also made in dpm_sysfs_remove(). power.can_wakeup is part of the device
> structure,
> which is in the process of being removed, so I am not sure I understand how
> that can be
> problematic.

That's when the device goes away, but ->remove() is invoked when the
driver goes away too and that's the more common case (by far IMO).

>> I guess they could be removed safely in the majority of cases, though.
>
>
> How would one decide if it is needed ? I see some drivers call it on remove,
> but others
> don't. I don't see a clear pattern; unless I am missing something, it seems
> to be
> more or less random.

My guess would be that drivers calling it don't want the wakeup
capability to be exposed after they have gone away.  Most likely these
are the ones that expose the wakeup attribute on probe.

IMO the rule should be that whoever exposes the wakeup attribute one
init, should also hide it on cleanup.

Thanks,
Rafael
