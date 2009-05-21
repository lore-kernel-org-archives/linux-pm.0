From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: dev->status.power and future of DPM_
Date: Thu, 21 May 2009 17:10:07 +0900
Message-ID: <aec7e5c30905210110p6aa4d162t93fded5d36887511@mail.gmail.com>
References: <aec7e5c30905130329t5610c8d1x925d554b833dedcc@mail.gmail.com>
	<200905141736.56215.rjw@sisk.pl>
	<aec7e5c30905150341y3d81bf0dv325fbf2d60e4bd80@mail.gmail.com>
	<200905151757.10758.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905151757.10758.rjw@sisk.pl>
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

On Sat, May 16, 2009 at 12:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 15 May 2009, Magnus Damm wrote:
>> Right. I guess drivers are not supposed to look at these DPM_ values.
>
> No, they aren't. =A0Why would they need to do that anyway?

No, not exposing that to drivers sounds like a good plan.

>> The current DPM_ values cover one round of
>> device_suspend()+device_power_down() or
>> device_power_up()+device_resume(). In the case of two rounds
>> (suspend-to-disk) then the DPM_ values are interated over again, but
>> the current "big picture" state is not stored anywhere, right? Or is
>> it?
>
> If by "big picture state" you mean "what stage of the transition we curre=
ntly
> are at", then no, it's not. =A0It follows from what code is being execute=
d at the
> moment (ie. if line 233 of kernel/power/disk.c is currently being execute=
d,
> we're going to create a hibernation image and we've just executed the dev=
ice
> drivers' ->freeze_noirq() callbacks).
>
> What would you need such information for?

Avoiding executing dev_pm_ops callbacks more than once. For instance,
if the run-time PM code has called ->freeze() on a certain struct
device and the device is kept like that for a while. During this time
the system is suspended. We don't want the driver to get a second
->freeze() call. This can be filtered on a bus level though.

>> > I agree that it might make sense to introduce the run-time PM flag at =
the core
>> > level so that various bus types don't reinvent the wheel each time the=
y decide
>> > to implement run-time PM.
>>
>> Avoiding re-implementing the wheel _and_ remembering the software
>> state, ie not calling the same bus_type callbacks twice.
>
> That really depends. =A0There may be bus types that won't use the dev_pm_=
ops
> callbacks for run-time PM at all, in which case the dev_pm_ops bus type
> suspend() callback, for example, will need to know that the device has be=
en put
> into a low power state at run time and therefore there's no need to call =
its
> driver's ->suspend() callback (when the system is going to suspend to RAM=
).
> However, this information appears to be bus type-specific.
>
> So, remembering at the core level that the device has been power-managed =
at
> run time is reasonable IMO, but I'm not sure about anything else.

I agree most of this seems to be bus specific.

>> >> Most things seem to be driven from system wide suspend/resume though.
>> >> I'm more interested in performing partial system suspend during
>> >> runtime. From for instance cpuidle.
>> >
>> > That, IMO, may be done by applying the run-time PM handling to each of=
 the
>> > devices in question.
>>
>> Yeah. Our problem is the granularity of various PM parameters. So
>> multiple devices share the same clock or are located in the same power
>> domain. So the devices can't really handle themselves.
>
> In that case it might make sense to introduce a "device" representing the
> control logic of the power domain and make it the parent of the devices
> depending on it.

Yeah, mapping the power domain topology to the bus topology is one
way. We also have clock framework topology, so we may need multiple
views. =3D)

> On a PCI bus the power and clock bus resources are controlled through the
> PM registers of the bridge. =A0Although it principle devices can be power
> managed individually, still to remove the clock and power from the entire
> bus segment you have to power manage the bridge. =A0Even if there are no
> such bridges physically on your system, you can always pretend there is o=
ne
> and represent it as a software device through which you can control the p=
ower
> resources.

Right. So there are somewhat similar dependencies there as well.

>> Also, it's not uncommon that a certain hardware block sits in multiple
>> different SoCs. The driver can be shared, but the power management topol=
ogy
>> needs to be adjusted to each SoC.
>
> Well, that would be a child depending on multiple parents. =A0I don't know
> how to represent that in our device tree. =A0Hmm.
>
> Perhaps I'd introduce a parent "device" consisting of all of the SoCs' po=
wer
> control registers and a add PM support for that. =A0The other devices on =
the
> SoCs may also depend on that one common parent.

We'll figure something out. Thanks for your comments!

/ magnus
