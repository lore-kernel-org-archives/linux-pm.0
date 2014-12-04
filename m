From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC] PM / Runtime: Better support for nested irq_safe
 drivers
Date: Thu, 4 Dec 2014 13:58:02 +0200
Message-ID: <54804C4A.1010703@ti.com>
References: <Pine.LNX.4.44L0.1412031018300.1538-100000@iolanthe.rowland.org> <547F3210.2010604@ti.com> <3000850.k2XQxVDQvU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50835 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420AbaLDL6N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Dec 2014 06:58:13 -0500
In-Reply-To: <3000850.k2XQxVDQvU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, pavel@ucw.cz, t-kristo@ti.com

On 12/04/2014 01:11 AM, Rafael J. Wysocki wrote:
> On Wednesday, December 03, 2014 05:53:52 PM Tomi Valkeinen wrote:
>>
>> --9XMi52Vjv8MSaMHnoh2EDME1sPQ9gtiND
>> Content-Type: text/plain; charset=windows-1252
>> Content-Transfer-Encoding: quoted-printable
>>
>> On 03/12/14 17:22, Alan Stern wrote:
>>> On Tue, 2 Dec 2014, Jyri Sarha wrote:
>>> =20
>>>> Is there something seriously wrong with the code part too? Or is this =
>>
>>>> just a matter of updating the comment (sorry that I missed that)?
>>>>
>>>> If the thing I am doing somehow fundamentally flawed, I 	apologize.=20
>>>> However, this was an RFC patch after all and the problem I am trying t=
>> o=20
>>>> solve is real.
>>> =20
>>> What exactly _is_ the problem you are trying to solve?
>>> =20
>>> When I first wrote the irq_safe stuff, I considered doing something=20
>>> like what you want.  But there was no demand for it at the time, and=20
>>> leaving it out seemed simpler and safer.
>>> =20
>>> However, if you have a genuine use case then I don't object to allowing=
>>
>>> parents of irq-safe devices to enter runtime suspend, provided the
>>> parents are also irq-safe.
>>
>> OMAP Display subsystem hardware has one main module (dss) and multiple
>> submodules (dispc being the important one here). The submodules require
>> the main module to be enabled and configured to work. These are modeled
>> as a dss parent platform device, and a number of child platform devices.
>>
>> The DRM driver for OMAP (omapdrm uses the dispc device, and uses runtime
>> PM to control dispc's power state. Unfortunately on some cases omapdrm
>> wants to access the hardware from atomic context, and needs to enable
>> the dispc first.
>>
>> omapdrm could be changed not to touch the hardware from atomic context,
>> but that is a big change, requiring rewrite of its core logic. I hope we
>> get that done some day, as it would be a performance boost also. But as
>> for today, omapdrm will crash in some cases when it happens to call
>> runtime_get from atomic context.
>>
>> So... If what's proposed in this patch is messy and risky, I think we
>> should skip it and try to change omapdrm as soon as we manage to. If so,
>> I'd still be interested to hear what problems this might cause, as we're
>> planning to apply it to our internal tree to fix the issue with omapdrm.
>
> It is sort of fragile.
>
> Currently, irq_safe causes PM callbacks to be executed with interrupts off.
> That may potentially lead to the execution of quite big chunks of code
> with interrupts off (imagine a suspended device, with a suspended parent
> and a suspended grand parent, all with irq_safe set).
>
> In your patch that won't actually happen, because the pm_runtime_put(parent)
> is still executed with interrupts on, but I'm wondering if that's really OK.
>

That was my choice. I decided there should be no hurry on suspending the 
parents and grandparents (currently they are all locked to enabled state 
anyway). I considered swift execution of suspend more important.

>> But as the functionality in this patch sounded sane and something which
>> could be usable for others also, we wanted to try this approach.
>
> To me, it requires quite a bit of consideration.
>
> Definitely, I don't want to make changes that will work for platform devices
> only and that will require some special conditions to be met to work.
>
> Anyway, can we get back to that next week?  We're likely to have a merge window
> in a few days ...
>

I'll send a new version of the patch with all comment updated according 
the the code change. I don't expect you to merge it. Just for the record 
I want to make the patch complete. Maybe someone else is struggling with 
the same issue and finds the patch useful.

Best regards,
Jyri
