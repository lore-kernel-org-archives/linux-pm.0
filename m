From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: dev->status.power and future of DPM_
Date: Fri, 15 May 2009 19:41:55 +0900
Message-ID: <aec7e5c30905150341y3d81bf0dv325fbf2d60e4bd80@mail.gmail.com>
References: <aec7e5c30905130329t5610c8d1x925d554b833dedcc@mail.gmail.com>
	<200905131522.31882.rjw@sisk.pl>
	<aec7e5c30905132118m265245f4u9d9581b3fde788f6@mail.gmail.com>
	<200905141736.56215.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905141736.56215.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Thanks for your comments.

On Fri, May 15, 2009 at 12:36 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday 14 May 2009, Magnus Damm wrote:
>> 2009/5/13 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Wednesday 13 May 2009, Magnus Damm wrote:
>> >> I'm a bit interested in modifying dev->status.power to reflect the
>> >> current device power state. Basically getting rid of DPM_PREPARING,
>> >> DPM_RESUMING, DPM_SUSPENDING and DPM_OFF_NOIRQ (they seem to be fairly
>> >> unused anyway),
>> >
>> > Please read drivers/base/power/main.c once again _carefully_ and rethi=
nk
>> > your observation above.
>>
>> Sorry about typos above, it shold be dev->power.status and DPM_OFF_IRQ.
>
> Ah. =A0That still doesn't sound good, though. =A0The reason is, on error =
in
> dpm_power_down() the devices that had their callbacks executed go to
> OFF_IRQ, while the others stay at OFF, so when device_power_up() is called
> to clean up things, it won't touch them.

Right, sorry if I didn't cover that area. I have no intention of
breaking things, just curios how the DPM_ values are used and if it's
possible to extend them.

>> So I read through the code again. How about this matrix:
>>
>> (function, in-function-change-DPM_, after-DPM_ [error-DPM_])
>>
>> device_suspend(), PREPARING/SUSPENDING/OFF/ON, OFF [ON]
>
> You can transition from PREPARING to either SUSPENDING or ON, depending on
> whether or not there's an error. =A0Next, you can either go from SUSPENDI=
NG to
> OFF, or stay at SUSPENDING (on error), So, the after-DPM is always OFF I'=
d say.
> =A0Also, the error DPM may be ON or SUSPENDING.

Yes, this looks correct.

>> device_power_down(), OFF_IRQ/OFF, OFF_IRQ, [OFF/unchanged]
>
> Here we go from OFF to OFF_IRQ (you have the other way around).

Correct. Sorry abot the swapping. CONFIG_ENDIAN is not setup correctly. =3D)

>> device_power_up(), OFF, OFF/unchanged
>
> Here we go from OFF_IRQ to OFF or stay at whatever was set before.

Yep.

>> device_resume(), RESUMING/ON, ON/unchanged
>
> This is more complicated, depending on the situation it is called in. =A0=
If that
> is during resume, we go from OFF (or OFF_IRQ) to RESUMING and next to ON.
> In turn, if that is during _suspend_ on error condition, we go from SUSPE=
NDING
> to RESUMING and then to ON. =A0The final state is always ON.

Right. I guess drivers are not supposed to look at these DPM_ values.
If they should then it may make sense to have a DPM_COMPLETING value
as well.

>> Basically, dev->power.status seems to represent the soon to be state
>> of each device. For instance, before calling prepare() PREPARING is
>> set. Have a look at the JPG that I attached in the previous email.
>
> The meaning of the DPM_ constants is explained in a comment in
> include/linux/pm.h . =A0They are related to device driver callbacks rathe=
r than
> to the core functions above.
>
>> Am I misunderstanding?
>
> Well, I tried to explain that in detail above. :-)

I think we're on the same page. Thanks for explaining.

The current DPM_ values cover one round of
device_suspend()+device_power_down() or
device_power_up()+device_resume(). In the case of two rounds
(suspend-to-disk) then the DPM_ values are interated over again, but
the current "big picture" state is not stored anywhere, right? Or is
it?

>> Entering deeper sleep modes will result in that parts of the SoC get
>> powered off. This is true for SuperH Mobile and SoCs from other
>> vendors as well. Before turning off power to a certain part of the SoC
>> we have to save the state of all the devices located there. And after
>> powering up we need to restore the state of each device.
>> dev_pm_ops->freeze() and ->restore() seem like good candidates for
>> doing that.
>
> OK there, but you need to take the bus type level into consideration. =A0=
Namely,
> on suspend we have, for example:
>
> dpm_suspend(PMSG_FREEZE) -> bus type freeze() -> driver freeze()
>
> Now, the bus type freeze() need not be suitable for your run-time PM, so =
you'd
> probably call the driver freeze() directly. =A0However, the DPM_* flags t=
ell the
> core which _bus_ _type_ callback has been called last, so I don't think y=
ou can
> generally reuse them for the run-time case. =A0Thus I think there should =
be a
> separate flag for the run-time PM.

That makes sense. We can probably filter stuff on a bus level to begin with.

> Of course, there's the question how to make the run-time PM and
> suspend/hibernation play well together and I think it may be done by teac=
hing
> the bus type freeze() and friends about the runtime PM flag.

As a first step that sounds good.

> I agree that it might make sense to introduce the run-time PM flag at the=
 core
> level so that various bus types don't reinvent the wheel each time they d=
ecide
> to implement run-time PM.

Avoiding re-implementing the wheel _and_ remembering the software
state, ie not calling the same bus_type callbacks twice.

>> Most things seem to be driven from system wide suspend/resume though.
>> I'm more interested in performing partial system suspend during
>> runtime. From for instance cpuidle.
>
> That, IMO, may be done by applying the run-time PM handling to each of the
> devices in question.

Yeah. Our problem is the granularity of various PM parameters. So
multiple devices share the same clock or are located in the same power
domain. So the devices can't really handle themselves. Also, it's not
uncommon that a certain hardware block sits in multiple different
SoCs. The driver can be shared, but the power management topology
needs to be adjusted to each SoC.

>> > USB, where run-time power management has already been
>> > implemented, is a good example too.
>>
>> That's great, but it doesn't help us entering deep sleep states on our S=
oCs. =3D)
>
> Well, you still can have a look at it and see how it's done. :-)

Will do. Thank you!

/ magnus
