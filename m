From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: dev->status.power and future of DPM_
Date: Thu, 14 May 2009 13:18:26 +0900
Message-ID: <aec7e5c30905132118m265245f4u9d9581b3fde788f6@mail.gmail.com>
References: <aec7e5c30905130329t5610c8d1x925d554b833dedcc@mail.gmail.com>
	<200905131522.31882.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905131522.31882.rjw@sisk.pl>
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

2009/5/13 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday 13 May 2009, Magnus Damm wrote:
>> I'm a bit interested in modifying dev->status.power to reflect the
>> current device power state. Basically getting rid of DPM_PREPARING,
>> DPM_RESUMING, DPM_SUSPENDING and DPM_OFF_NOIRQ (they seem to be fairly
>> unused anyway),
>
> Please read drivers/base/power/main.c once again _carefully_ and rethink
> your observation above.

Sorry about typos above, it shold be dev->power.status and DPM_OFF_IRQ.

So I read through the code again. How about this matrix:

(function, in-function-change-DPM_, after-DPM_ [error-DPM_])

device_suspend(), PREPARING/SUSPENDING/OFF/ON, OFF [ON]
device_power_down(), OFF_IRQ/OFF, OFF_IRQ, [OFF/unchanged]
device_power_up(), OFF, OFF/unchanged
device_resume(), RESUMING/ON, ON/unchanged

Basically, dev->power.status seems to represent the soon to be state
of each device. For instance, before calling prepare() PREPARING is
set. Have a look at the JPG that I attached in the previous email.

Am I misunderstanding?

I'd like to keep the state of each device somewhere.

>> and instead using the following states:
>>
>> DPM_ON - default operational state
>> DPM_FROZEN - set after PMSG_FREEZE
>> DPM_OFF - set after PMSG_HIBERNATE
>> DPM_SUSPENDED - set after PMSG_SUSPEND
>
> The PMSG_* things are only used to pass information between the
> suspend/hibernation core and the functions in drivers/base/power/main.c .
> They are also used by the legacy suspend callbacks of device drivers, but
> drivers are encouraged to use struct dev_pm_ops objects instead.
> And struct dev_pm_ops contains also =A0the .prepare()/.complete() callbac=
ks that
> you don't seem to be taking into consideration.

Thanks for your explanation. I think I understand the PMSG_ stuff. I'm
aware of dev_pm_ops, they are used in sme of my upstream drivers. As
for prepare()/complete() - I am taking them into consideration. Please
check the JPG again.

> What exactly is the purpose of the changes you're suggesting?

Earlier this year I've focused on adding power management to the
SuperH architecture. So in upstream 2.6.30 we now have suspend to disk
and suspend to ram working for most sleep modes. Currently I'm
focusing on run time power management (cpu idle, clock framework) and
deeper sleep modes. This is all upstream activity.

Entering deeper sleep modes will result in that parts of the SoC get
powered off. This is true for SuperH Mobile and SoCs from other
vendors as well. Before turning off power to a certain part of the SoC
we have to save the state of all the devices located there. And after
powering up we need to restore the state of each device.
dev_pm_ops->freeze() and ->restore() seem like good candidates for
doing that.

So I'd like to be able to freeze individual devices independently of
each other. And then there's lots of architecture specific work that
needs to be done. =3D)

>> On top of this I'd like to allow device drivers to mark devices as
>> idle. And if a device is marked idle then I'd like to allow power
>> management code to perform freeze() on a single device. After that
>> marking the device frozen using DPM_FROZEN. poweroff() may also be
>> called to perform some partial system suspend. It gets more
>> complicated of course, but I guess we need a way to know the state of
>> each device regardless.
>
> We have discussed that for several times already IIRC and the conclusion =
has
> always been that such things should better be done at the bus type level,=
 not
> at the core level.

Doing things at the bus type level sounds fine with me. I'm mainly
interested in platform devices.

> If you look at the PCI power management code, you'll notice that the driv=
ers'
> PM callbacks are not called directly by the core, but they are called by =
the
> PCI bus type PM callbacks which in turn carry out some bus-specific opera=
tions
> before or after executing the drivers' callbacks. =A0However, these bus-s=
pecific
> operations generally need not be suitable for run-time power management of
> devices (they are designed with system-wide power transitions in mind).
> Also, such things as PM events signalling (eg. a device has been suspended
> at run time, but there's activity on the device which causes it to notify=
 the
> kernel and the device signals the event somehow) tend to be bus-specific =
or
> platform-specific.

Right. Seems like a good design to me.

Most things seem to be driven from system wide suspend/resume though.
I'm more interested in performing partial system suspend during
runtime. From for instance cpuidle.

> USB, where run-time power management has already been
> implemented, is a good example too.

That's great, but it doesn't help us entering deep sleep states on our SoCs=
. =3D)

Thanks for your comments!

/ magnus
