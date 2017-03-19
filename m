From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [04/15] power: supply: bq24190_charger: Add no_register_reset
 pdata flag
Date: Sun, 19 Mar 2017 09:22:03 +0100
Message-ID: <f7b3fda0-eeff-b6ab-4908-86c4180bda8a@redhat.com>
References: <20170318071019.4561-1-liam@networkimprov.net>
 <6ad6ecd2-ea0f-b613-8519-66ad424c623a@redhat.com>
 <CAKvHMgQ-hnS_XkL_7Mwkm94hNDc9Q++xHBAOUK1bKmvO=YnSXQ@mail.gmail.com>
 <6a0e54e3-581d-6162-b521-82b7567b6e74@redhat.com>
 <CAKvHMgTYqypPiv0KcoFZqpojq50yUDoU=HL8uiwPyKP7HLTy1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbdCSIWk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 Mar 2017 04:22:40 -0400
In-Reply-To: <CAKvHMgTYqypPiv0KcoFZqpojq50yUDoU=HL8uiwPyKP7HLTy1A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

Hi,

On 19-03-17 01:57, Liam Breck wrote:
> Hi Hans,
>
> I realize you put a ton of work into this patchset. Pls know that I
> want you to end up with a solution that both works for you, and makes
> the charger driver more generally useful. All of my critique is
> offered in good faith, and not meant as rejection. I genuinely regret
> it if you feel otherwise.

While we are being candid I'm a bit surprised about how you're claiming
maintainership / ownership of the bq24190_charger driver and are acting
as if you are *the* authority on it. MAINTAINERS seems to disagree
with you.

You seem to have started contributing to the kernel about 6 months ago
going from git logs. I'm an experienced FOSS developer with 10+ years
of upstream kernel involvement and 2000+ commits on my name.

As such I'm finding it difficult to accept your authority on this and
some of your questions like "Have you looked into patching upower"
certainly do not help here. We can not EVER NEVER change userspace
if an ABI is already in place and widely used. We can extend / add
new ABIs but we cannot just go and change what userspace can expect
of an existing ABI.

Also you do not seem to understand what being a good maintainer
involves. All I see you do is throwing up roadblocks without offering
*workable* alternatives. Being a good maintainer is not just about
saying no, it is far more about thinking with the contributor and
helping them to find a good solution. Being a maintainer is much
more of a role where you help others then where you get to dictate
them what to do.

 > Then consider the pseudo-driver concept. That would be generally
 > useful for any charger/gauge pairing. Both drivers would provide
 > callbacks to it.

So your rejecting a patch which adds 30 lines of code for some
vague generic pseudo-driver concept without offering any design
direction on what such a concept would look like and without taking
into account that so far this seems to be a one-of problem.

Usually the rule in the kernel is that we do not introduce generic
solutions until we've at least 2 or 3 use-cases for it, both so
that we understand the problem better and so that we are sure
this actually is a generic problem which is worth the effort of
writing a generic solution for. Doing a generic solution now,
when we do not even fully understand the problem space seems
like over-engineering to me. Note that this is an in kernel
interface so we can always fix it later if a generic solution
is called for. But right now you are asking me to write something
which I do not even know what it should look like, will likely
be 1000+ lines of code and a lot of work and all that to avoid a
simple 30 line patch, which I will gladly admit is not the prettiest
but really is not that ugly either.

> Pls consider my feedback for a couple days; I put a lot of thought into it.

Try looking at this form my pov, as I wrote your asking me to
write some 1000+ line generic solution for something which might
well be a one-of problem, while we've no idea what such a generic
solution should look like (esp. since we have only one real-world
example of the problem so far) and you're offering 0 design assistance
in the process, all to avoid a not pretty but very serviceable patch
adding 30 lines of code.

Before you reply to this I'm going to ask you the same as you're
asking me. Please let my carefully considered and worded reply sink
in a bit before answering.

>> Assuming the platform_data has sane values like uA that means
>> re-implementing most of the bq24190 driver in the code filling
>> the platform data (to go from register values to uA) that does
>> not seem like a sane approach when a simple do not reset
>> flag suffices. Note also see below for another way to deal
>> with this.
>
> I am suggesting you treat platform_data like a DT node: fill it with
> board-specific params. Don't compute the params, read them manually
> via /sys/class/...-charger/f_* and hard-code them for this board. That
> gives you control over the charger config. You've already found that
> you need that given the high voltage setting.

This is not going to work, I realize this is how things are
done on ARM, but there are likely at least a 100 designs with
this Cherry Trail Whiskey Cove + TI charger combo and on x86 people
expect to be able to just take a generic kernel from a distro and
have it work without first needing to write a dts (or some equivalent)
so we really need to extract the info from the BIOS, which in this
case means reading back the values from the registers since the BIOS
offers no other interface (that we know of) to get those params.

>>> The driver does a register_reset on resume so it has a consistent
>>> state with chip.
>>
>>
>> That assumes someone may be mucking with the chip during
>> suspend which usually is not the case arguably this is a
>> bad idea in general since if the chip is programmed with
>> lower then reset charging limits it may now charge above
>> the limits until the limits are re-applied.
>>
>> I really wonder what the reset is there for at all TBH,
>> are there any cases where this really is necessary ?
>> Maybe it would be best to just drop the reset altogether,
>> or make it opt in rather then opt out.
>
> The reason is to put the driver back into autonomous mode while we're
> asleep. Otherwise we run in host mode.

You do not need to do a reset for that you can just re-enable
the host activity watchdog, that would actually be a better
solution as then you keep the charging settings as is without
needing to re-apply them after the reset. Note that if you
re-apply the settings after reset you are also kicking the
charger back into host mode since any host-activity does
that, the only difference from before the reset is that the
watchdog is now running again, see the statemachine in 8.4.1
of the datasheet. You can get the same effect with a single
i2c write re-enabling the watchdog.

>> Yes I've asked both the manufacturer and the chip vendor (Intel)
>> for docs, but I've not gotten an answer from either.
>
> Maybe someone at Redhat could make a formal request on your behalf?

I've quite good contacts inside Intel myself and I've already
made such a request, but without any result.

>>> I mean record the chip's UEFI-supplied state here.
>>
>>
>> Ok, so a flag get state from chip in platform_data would be
>> an acceptable solution to me as then I can re-use all the
>> code in bq24190_charger.c to go from register values to
>> uA (and uV).
>
> Yes, recording chip state in probe is an alternative to hard-coding
> values in platform_data. But I think you should do the latter, so you
> get a known charger config. Maybe a later version of the board has an
> undesirable value.

As mentioned before there is no such thing as a "board specific config"
in x86, all x86 code is generic and should run on any x86 board.

Regards,

Hans
