From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / QoS: Fix default runtime_pm device resume latency
Date: Tue, 31 Oct 2017 09:40:15 +0100
Message-ID: <CAJZ5v0gvigyzgjwVocyfqFpfLC6rwfYE0Tvv3EfGahc5h0hYxw@mail.gmail.com>
References: <1509347446-26105-1-git-send-email-t-kristo@ti.com>
 <CAJZ5v0i8HMDfV907QDTD54YPaFpoBLVt+R4oeQ704+9_C8APoA@mail.gmail.com>
 <3227682.nATp9NGxKU@aspire.rjw.lan> <0bb15d6d-3353-90d7-8335-200dd9790632@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0bb15d6d-3353-90d7-8335-200dd9790632@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 31, 2017 at 8:13 AM, Tero Kristo <t-kristo@ti.com> wrote:
> On 31/10/17 01:27, Rafael J. Wysocki wrote:
>>
>> On Monday, October 30, 2017 11:19:08 AM CET Rafael J. Wysocki wrote:
>>>
>>> On Mon, Oct 30, 2017 at 8:10 AM, Tero Kristo <t-kristo@ti.com> wrote:
>>>>
>>>> The recent change to the PM QoS framework to introduce a proper
>>>> no constraint value overlooked to handle the devices which don't
>>>> implement PM QoS OPS. Runtime PM is one of the more severely
>>>> impacted subsystems, failing every attempt to runtime suspend
>>>> a device. This leads into some nasty second level issues like
>>>> probe failures and increased power consumption among other things.
>>>
>>>
>>> Oh, that's bad.
>>>
>>> Sorry about breaking it and thanks for the fix!
>>>
>>>> Fix this by adding a proper return value for devices that don't
>>>> implement PM QoS implicitly.
>>>>
>>>> Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>>
>>> Applied.
>>
>>
>> And pushed to Linus.
>>
>> That said, probe shouldn't ever fail if PM QoS is set to the
>> "never suspend" value.
>>
>> User space can set it that way, after all, so the drivers that fail to
>> probe
>> in that case aren't correct I'm afraid.
>
>
> Ok interesting. The probe failure we had was a second order issue. A driver
> (omap_nmailbox) was attempting to pm_runtime_get_sync() ...put_sync() during
> probe, and checked the return value of pm_runtime_put_sync() which was
> -EPERM and bailed out. Most of the time, drivers don't check the return
> value of this and will just succeed. I did a grep on kernel and there are
> few other drivers that check the return value also, didn't check if they do
> this during probe though but it can potentially cause various issues
> elsewhere also.
>
> So, you are saying we should not check the return value of
> pm_runtime_put_x() ever, or should check if it is -EPERM and just pass in
> that case?

The latter.

> Is there any point returning -EPERM from the runtime core at all
> then? This should probably be filtered out within runtime core as a valid
> situation and just return 0.

Fair point.

However, there are other situations in which pm_runtime_put_sync() can
return an error code which needs to be checked, like -EBUSY or -EAGAIN
returned if one of the reference counters is nonzero.

In fact, the "no suspend" PM QoS constraint is somewhat similar to
this situation, so what about changing the error code returned to
-EAGAIN, for example?
