From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 03/04] PM: Add platform bus runtime dev_pm_ops
Date: Tue, 2 Jun 2009 22:37:41 +0900
Message-ID: <aec7e5c30906020637i3fc67d10w23e21b035620798f__31560.0154492587$1243949943$gmane$org@mail.gmail.com>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<20090527100650.29671.82139.sendpatchset@rx1.opensource.se>
	<200905300123.18367.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905300123.18367.rjw@sisk.pl>
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
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Thanks for your feedback!

2009/5/30 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday 27 May 2009, Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> Wrap the platform device bus dev_pm_ops to allow runtime
>> pm and regular suspend and resume to coexist.
>>
>> Platform device data is extended with flags that allow
>> us to keep track of which dev_pm_ops that has been called.
>>
>> Basically, if a device has been frozen by the runtime pm
>> code, don't call ->freeze() again when hibernating.
>>
>> Architecture code can use platform_runtime_dev_pm_ops to
>> call driver dev_pm_ops associated with a certain device.
>>
>> Enable with CONFIG_HAVE_PLATFORM_DEVICE_RUNTIME_PM.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> ---
>>
>> =A0This is a bit of a hack, any better way to wrap dev_pm_ops?
>
> I'm not really sure you need to wrap them at all.

I realize that I didn't explain very well why I decided to wrap
dev_pm_ops. Sorry about that. Basically there are two reasons:
1) Wrap to always have the runtime dev_pm_ops functions regardless of kconf=
ig.
2) Wrap to make sure runtime and system-wide dev_pm_ops can coexist.

> There are a few choices:
>
> (1) You can use the platform_pm_* functions directly for run-time PM, but
> in that case you'll need to make sure that the "suspend" ones return 0
> immediately when called during system-wide suspend or hibernation (there'=
s the
> question whether the "resume" ones should still put the device into the f=
ull
> power state in that case). =A0For this purpose you can add a single flag =
to
> struct platform_device and set it for devices that have already been
> "suspended" (this flag, when set, will make all of the "suspend" callbacks
> return 0 without doing anything until the device is "resumed").

I have to make sure that the right Kconfig bits are enabled though,
otherwise some platform_pm_* functions will be missing. So one merit
for the wrapped functions is in this patch is that they are always
there regardless of CONFIG_SUSPEND and CONFIG_HIBERNATION.

Is one flag really enough? Isn't it a bit strange from the driver
point of view to always get their ->prepare() callback executed, but
->suspend() gets filtered?

The bitmap in this patch is more fine-grained, so struct
platform_device remember which of each dev_pm_ops callback that have
been called. It may be overly complex though. Also, please note that
both runtime dev_pm_ops and system-wide dev_pm_ops go through the same
dev_pm_ops that keep track of which callbacks that have been called.

Using some kind of flag(s) for coexisting with system-wide
suspend-to-ram/disk sounds good.

> (2) You can add separate platform callbacks for run-time PM that will exe=
cute
> the drivers' dev_pm_ops callbacks and presumably do something else (I don=
't
> know what that may be for platform devices, though). =A0In that case, aga=
in,
> adding a flag to struct platform_device and making platform_pm_* check it
> should be sufficient to prevent devices from being suspended twice in a r=
ow.

We may need to do other things as well - not sure - but regardless we
still need flag(s) to avoid double suspend.

> (3) You can add separate platform callbacks for run-time PM for both the
> bus type and the drivers, in which dev_pm_ops will be totally separate fr=
om
> these new callbacks, although of course you'll need provide some kind of
> synchronization bettween them all. =A0That also may be done through a flag
> in struct platform_device IMO.

Yeah, that's also one way. I wonder if that helps us though, I feel
that we already have a pretty wide range of callbacks in dev_pm_ops.
I'm not sure if they cover all cases we need though, I guess future
experiments will tell.

> Now, since other bus types will most probably also need a flag in their
> _device structures, it may be worth putting it into struct device (we've
> discsussed that already).

Yeah, I wonder if a single flag is enough though? Aren't we coexisting
with CONFIG_SUSPEND, CONFIG_HIBERNATION and CONFIG_KEXEC_JUMP?

> I'm not sure which of (1) - (3) are the most suitable for the platform bus
> type. =A0For PCI I'd probably choose (2), because the current PCI bus typ=
e's
> dev_pm_ops callbacks are tailored to system-wide power transitions.
> Moreover, PCI devices can generally be put first into D1, then into D2 and
> finally into D3, which only makes sense at run time, and some of them may
> have to be put back into the full power state before a system-wide transi=
tion
> (apparently, we'll need a separate flag to mark such devices).

If I understand (1)-(3) correctly, then I think (1) is probably the
best choice for our platform devices. I guess (2) is not very far from
(1), so if we go with (1) to begin with then we can deal with SoC
specific things in our arch code to come closer to (2) over time if
needed.

> Of course, if you decide to add separate run-time PM callbacks for the
> platform bus type, you won't need to wrap its dev_pm_ops callbacks any mo=
re,
> but you'll need to modify them to check the appropriate flag(s). =A0For e=
xample,
> you may choose to use a two-bit pm_suspend_level field such that
>
> * if pm_suspend_level =3D 1, platform_pm_prepare() will return immediately
> * if pm_suspend_level =3D 2, platform_pm_prepare() and platform_pm_suspen=
d()
> =A0will return immediately
> * if pm_suspend_level =3D 3, platform_pm_prepare(), platform_pm_suspend()
> =A0and platform_pm_suspend_noirq() will return immediately
>
> (and analogously for the hibernation callbacks) and make your run-time PM
> callbacks set this field appropriately.

That is true, but this checking is not needed for systems where
runtime PM is disabled. Or am I misunderstanding?

Maybe it's worth to discuss how to integrate this. I suspect that this
will only affect some selected architectures to begin with, and the
rest of the code base should be unaffected by this change as long as
the runtime kconfig is disabled.

So I decided to wrap dev_pm_ops to make the impact for non runtime PM
systems as small as possible. This while giving the runtime PM case
access to all dev_pm_ops regardless of suspend/hibernation kconfig.

Does it make sense?

Thank you!

/ magnus
