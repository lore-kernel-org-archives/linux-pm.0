From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Mon, 22 Jun 2015 19:01:32 -0500
Message-ID: <CAL_JsqKAWs2McpAP-47UwDMtuBoR+0xkJYvu8+-7yOQwiUfvpw@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+EWLEJhRudTGAwYsOg4tX2-pGhygeQGHae9RL8rBpMiA@mail.gmail.com> <CAAObsKCdv_X+YPFacO7NjbRMnvuDisAmiQOWE-Xb3xFFrn6Qog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAAObsKCdv_X+YPFacO7NjbRMnvuDisAmiQOWE-Xb3xFFrn6Qog@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <stephane.marchesin@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Holler <holler@ahsoftware.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dan Williams <dan.j.williams@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dmaengine@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, linux-clk@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.or>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 22, 2015 at 10:23 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> On 28 May 2015 at 06:33, Rob Herring <robherring2@gmail.com> wrote:
>> On Mon, May 25, 2015 at 9:53 AM, Tomeu Vizoso
>> <tomeu.vizoso@collabora.com> wrote:
>>> Hello,
>>>
>>> I have a problem with the panel on my Tegra Chromebook taking longe=
r than
>>> expected to be ready during boot (St=C3=A9phane Marchesin reported =
what is
>>> basically the same issue in [0]), and have looked into ordered prob=
ing as a
>>> better way of solving this than moving nodes around in the DT or pl=
aying with
>>> initcall levels.
>>>
>>> While reading the thread [1] that Alexander Holler started with his=
 series to
>>> make probing order deterministic, it occurred to me that it should =
be possible
>>> to achieve the same by registering devices as they are referenced b=
y other
>>> devices.
>>
>> I like the concept and novel approach.
>>
>>> This basically reuses the information that is already implicit in t=
he probe()
>>> implementations, saving us from refactoring existing drivers or add=
ing
>>> information to DTBs.
>>>
>>> Something I'm not completely happy with is that I have had to move =
the call to
>>> of_platform_populate after all platform drivers have been registere=
d.
>>> Otherwise I don't see how I could register drivers on demand as we =
don't have
>>> yet each driver's compatible strings.
>>
>> Yeah, this is the opposite of what we'd really like.
>
> Can you elaborate on the reasons why we would like to have devices
> registered before built-in drivers finish registering, even if we
> don't probe them yet?

My main thought was for modules we will almost always have devices
appearing first. More generally, we can have devices and drivers
coming or going at any point in time and should not put restrictions
on ordering.

Also, I think all the probe ordering and dependency tracking should be
done within the driver core (i.e. dependencies are a list of struct
devices). At some level it has to become firmware specific, but we
want to minimize that part. I could be convinced otherwise and you
have put more thought into this problem than I have.

>> Ideally, we would
>> have a solution that works for modules too. However, we're no worse
>> off. We pretty much build-in dependencies to avoid module ordering
>> problems.
>
> Nod, I haven't looked yet at requesting modules on-demand, but I gues=
s
> it should be doable. Modules that have dependencies described in the
> firmware should get them probed automatically already though.
>
>> Perhaps we need to make the probing on-demand rather than simply on
>> device<->driver match occurring.
>
> I'm afraid that too much old code depends on that. For example, Rafae=
l
> pointed out to the PNP subsystem, which registers a driver that will
> probe devices with the EISA ID PNP0c02 to reserve memory regions for
> devices that will be probed later.
>
> http://lxr.free-electrons.com/source/drivers/pnp/system.c
>
> My understanding is that probing of PNP0c02 devices must happen befor=
e
> the actual devices that depend on those regions are probed, so if we
> decoupled the probing from the driver/device registration, we would b=
e
> breaking that assumption.

That shouldn't matter as PNP matching is PNP specific. We already have
different ways of matching with device/driver name or of_match_table
for example. Changing how and when OF matching occurs would not affect
PNP matching. We do matching on device and driver add currently. For
the "when" part, we would need to add what I'll call async matching or
deferred matching which in addition to matching on the of_match_table
also matches on the dependency list having probed. Your last series
essentially does this, but the difference is yours is not OF specific
and I think it needs to be. I mean it is OF specific only in the
aspect that matching already is. From a driver and subsystem
standpoint, it should not be OF specific much like deferred probe is
not OF specific, but in reality only occurs (currently) on OF probed
drivers.

>>> For machs that don't move of_platform_populate() to a later point, =
these
>>> patches shouldn't cause any problems but it's not guaranteed that w=
e'll avoid
>>> all the deferred probes as some drivers may not be registered yet.
>>
>> Ideally, of_platform_populate is not explicitly called by each
>> platform. So I think we need to make this work for the default case.
>
> The problem is that some platforms will need fixing because some
> initcalls assume that some devices will have been registered already,
> or even probed. I think removing those assumptions shouldn't be
> problematic because I haven't had much trouble with this on the four
> platforms I have tested with, but I cannot test every board that is
> supported upstream.
>
> I can ask though the KernelCI folks to boot my branch in all their
> boards and make sure that those work when of_platform_populate is
> called in late_initcall.

I'd imagine Kevin would be happy to. That is still a subset of h/w, so
we'd need a way to disable any solution.

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
