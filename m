From: Ikhwan Lee <ikhwan.lee@samsung.com>
Subject: Re: sysfs power/state file & dpm_runtime_suspend()
Date: Wed, 16 Aug 2006 16:17:32 +0900
Message-ID: <018801c6c104$0b0ab980$4686190c@dsn.sec.samsung.com>
References: <Pine.LNX.4.44L0.0607271027400.6315-100000@iolanthe.rowland.org>
	<200607270853.54674.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

Thank you for your answers.

> > Proper runtime power management requires drivers to change their
> > devices' power states as needed, with no intervention of the PM
> > core.  Neither power/state nor power.power_state.event is really
> > necessary for this purpose.
>
> That's a key point that I think was not widely understood early on.  The
> driver APIs exist to make sure systems can be cleanly shut down ... not
> to reduce power usage.  At best, that sysfs power/state thing is a big
> distraction from actually trying to make drivers be power-efficient.

Now I understand that the drivers are responsible for making runtime power
management decisions for individual devices. But there are cases that a
device driver does not have enough information to make the most effective
decision. In such a case, we may want to employ a high level power manager
to make decisions for them.

Suppose we have a SoC with an on-chip multimedia codec. The codec can either
be clock-gated or power-gated, and it shares its power domain with a
neighboring IP, say a 3D engine. Clock gating can be done by the driver
since the clock can be controlled separately. However, the codec driver can
never perform power-gating since it does not know if the 3D engine is active
or not. We would prefer a centralized device power manager in this case.
This is a common case for state-of-the-art mobile handsets such as a DMB
phone. As a different example, a system-level power manager may want to put
the codec into a low quality (thus low power) mode regarding the battery
status. Certainly, this kind of decision cannot be made by the driver.

IMO, having support for such use cases in the PM core and exporting
necessary driver APIs would not be a bad idea. Centralized device power
manager can keep track of the system power states and interdependencies
among devices (the device model perfectly suits for this) while device
drivers provide necessary APIs for safe power state transitions.

> See list archives for the "RFC -- updated Documentation/power/devices.txt"
> thread; one of my last posts there has a version of that document with
lots
> of examples of how runtime power saving works; it does NOT need to involve
> any kind of public power state updating.  Things like cpufreq and dynamic
> tick, or power-aware idle tasks, don't need to change externally visible
> state any more than per-device power saving policies do.

I have been following the thread. I especially like the section on runtime
power management, with lots of examples. I am actually working on some of
them, and my claim is that (as stated above) we may need to involve some
kind of public power state updating in a system-wide way.

Regards,

Ikhwan
