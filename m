From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sun, 25 Mar 2007 14:26:48 +0400
Message-ID: <46064E68.8030302@gmail.com>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>	<200703231057.16539.david-b@pacbell.net>	<200703232139.38721.rjw@sisk.pl>
	<200703241349.19964.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703241349.19964.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, johannes@sipsolutions.net, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Friday 23 March 2007 1:39 pm, Rafael J. Wysocki wrote:
>
>> 	After we have frozen tasks, we need to
>> call something like device_suspend(some_argument) where the argument sho=
uld
>> tell drivers what to do. =

>
> That parameter can't suffice, since the exact details depend on
> system-dependent context.  Example, on one system a given sleep
> state will allow a given device to issue wakeups ... on another,
> it won't.
>
What do you mean? Capability of h/w to be a wakeup source or
design decisions, when wakeup capability of a given device
is disabled intentionally for some reason?

System may have a number of devices that all are able to wakeup
the system from *all* sleep (low power) states the system
supports.Normally, such devices should be marked as "can_wakeup"
to demonstrate the capability, then, user may select these
devices as a wakeup source(s) from a given sleep state.
He(she) sets "should_wakeup" flag for this. For example,
I may want to wakeup the system via USB, MMC and keypad,
but when I put  the system into deeper sleep state I may want
to wakeup it only via keypad and do not bother it via MMC
and USB.


So, it is reasonable idea to permit some devices to be
wakeup sources for one system-wide state but restrict
the wakeup ability for another system-wide state.
But, it seems not quite reasonable to hardcode this
in platform-specific code, unless your platform is
designed for very specific needs. In general,
every wakeup source (which is capable to wakeup
at any system state) should be available via sysfs
(../power/wakeup interface of device)

> You seem to have overlooked the clk_must_disable() patches I
> recently re-sent.  In conjunction with the driver model wakeup
> flags, that can solve the problem on every SOC platform I've
> had a reason to look at ... see how it works for AT91 USB.

As I pointed above, user may want to choose between wakeup
sources and he(she) must be sure the choice won't be ignored,
but your changes for atmel_serial.c and at91_udc.c,
seems restrict user with that.



Thanks,
Dmitry
