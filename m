From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sat, 15 Jul 2017 10:20:27 -0700
Message-ID: <1a5ef0ae-16f3-5a61-ae4e-083664cb30c0@gmail.com>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <2497538.J9F6XFeBfd@aspire.rjw.lan> <20170715062838.GA20741@amd>
 <5864280.u6UQBsuXnA@aspire.rjw.lan> <20170715164626.GA1373@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34646 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdGORUa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2017 13:20:30 -0400
In-Reply-To: <20170715164626.GA1373@amd>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>



On 07/15/2017 09:46 AM, Pavel Machek wrote:
> Hi!
> 
>>>> I had an idea of using an enum type encompassing all of the power states
>>>> defined for various platforms and serving both as a registry (to ensure the
>>>> uniqueness of the values assigned to the states) and a common ground
>>>> between platforms and drivers.
>>>>
>>>> Something like:
>>>>
>>>> enum platform_target_state {
>>>> 	PLATFORM_STATE_UNKNOWN = -1,
>>>> 	PLATFORM_STATE_WORKING = 0,
>>>> 	PLATFORM_STATE_ACPI_S1,
>>>> 	PLATFORM_STATE_ACPI_S2,
>>>> 	PLATFORM_STATE_ACPI_S3,
>>>> 	PLATFORM_STATE_MY_BOARD_1_GATE_CLOCKS,
>>>> 	PLATFORM_STATE_MY_BOARD_1_GATE_POWER,
>>>> 	PLATFORM_STATE_ANOTHER_BOARD_DO_CRAZY_STUFF,
>>>> 	...
>>>> };
>>>>
>>>> and define ->target_state to return a value of this type.
>>>>
>>>> Then, if a driver sees one of these and recognizes that value, it should
>>>> know exactly what to do.
>>>
>>> Remind me why this is good idea?
>>
>> Because there are drivers that need to do specific things during
>> suspend on a specific board when it goes into a specific state as a
>> whole.
> 
> We have seen driver that cares about voltage to his device being
> lost. That's reasonable.
> 
> Inquiring what the platform target state is... is not.
> 
>>> If board wants to know if certain regulator stays online during
>>> suspend, it should invent an API for _that_.
>>
>> Ideally, yes.  However, that may be problematic for multiplatform kernels,
>> because they would need to have all of those APIs built in and the driver
>> code to figure out which API to use would be rather nasty.
> 
> Lets do it the right way. Big enum is wrong.

The enum offers the advantage of centralizing how many different states
exist for all the platforms we know about in the kernel, it's easy to
define common values for platforms that have the same semantics, just
like it's simple to add new values for platform specific details.

Is the concern that we could overflow the enum size, or that there is
not a common set of values to describe states?

> 
> We already have
> 
> struct regulator_state {
>        int uV; /* suspend voltage */
>        unsigned int mode; /* suspend regulator operating mode */
>        int enabled; /* is regulator enabled in this suspend state */
>        int disabled; /* is the regulator disabled in this suspend state */
> };
> 
>  * struct regulation_constraints - regulator operating constraints.
>   * @state_disk: State for regulator when system is suspended in disk
>   * mode.
>   * @state_mem: State for regulator when system is suspended in mem
>   * mode.
>   * @state_standby: State for regulator when system is suspended in
>   * standby
>   *                 mode.
>    
> . So it seems that maybe we should tell the drivers if we are entering
> "state_mem" or "state_standby" (something I may have opposed, sorry),
> then the driver can get neccessary information from regulator
> framework.

OK, so what would be the mechanism to tell these drivers about the
system wide suspend state they are entering if it is not via
platform_suspend_target_state()?

Keep in mind that regulators might be one aspect of what could be
causing the platform to behave specifically in one suspend state vs.
another, but there could be pieces of HW within the SoC that can't be
described with power domains, voltage islands etc. that would still have
inherent suspend states properties (like memory retention, pin/pad
controls etc. etc). We still need some mechanism, possibly centralized

> 
> I don't think it should cause problems with multiplatform kernels.

Just like platform_suspend_target_state() with an enum is not creating
problems either. suspend_ops is already a singleton for a given kernel
image so a given kernel running on a given platform will get to see a
subset of the enum values defined.

In any case, just agree and I will be happy to follow-up with patches.
-- 
Florian
