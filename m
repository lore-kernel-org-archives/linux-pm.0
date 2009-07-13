From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RFC][PATCH] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 8)
Date: Mon, 13 Jul 2009 10:42:31 +0900
Message-ID: <aec7e5c30907121842p57a6fe3cud3d601a15c67df4f@mail.gmail.com>
References: <aec7e5c30907081952t4b88f1ccjeec6ab11b1d913b8@mail.gmail.com>
	<Pine.LNX.4.44L0.0907090937530.5823-100000@iolanthe.rowland.org>
	<aec7e5c30907090831y180b0972o6dcb961dd292a3c0@mail.gmail.com>
	<175E0F9A9EFCEA46A65F5552BB057298BB5F3EA2@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <175E0F9A9EFCEA46A65F5552BB057298BB5F3EA2@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 10, 2009 at 6:56 AM, Mahalingam,
Nithish<nithish.mahalingam@intel.com> wrote:
> On Thu, Jul 9, 2009 at 10:48 PM, Alan Stern<stern@rowland.harvard.edu> wr=
ote:
>>> On Thu, 9 Jul 2009, Magnus Damm wrote:
>>>
>>>> Clocks should be stopped as soon as possible without any delay. The
>>>> clock stopping is very cheap performance wise. Also, the clock
>>> stopping is done on bus level without invoking any driver callbacks.
>>>> Delaying the clock stopping does not make any sense to me.
>>>
>>> In that case the device driver or bus subsystem should manage the
>>> device's clock directly. =A0There's no need to tie it in with the runti=
me
>>> PM framework. =A0Simply start the clock before each I/O operation and
>>> stop it afterward.
>
>> It's not that easy. The clock needs to be enabled to let the hardware
>> device perform device specific stuff. For instance, the clock for the
>> LCD controller needs to be on to redraw the screen. When the driver
>> knows that it's done with the clock it can notify the bus using
>> Runtime PM.
>
> Is there any plan to look into the "Clock Framework" that was developed a=
s part of OMAP and extending this to make it generic for all platforms?

Do you mean vendor specific extensions to the clock framework? I'm
quite sure a bunch of architectures already support the clock
framework. Some architectures probably have extensions that would be
nice if they could be made more generic. Do you have any special
extensions in mind? =3D)

As for Runtime PM, clock stopping is only one part of the problem. On
SuperH we manage clock stopping through the clock framework and I'm
pretty sure other embedded architectures do that as well. That problem
is more or less already solved in my opinion.

For efficient power management on embedded systems we need more than
just clock stopping. We also want to save and restore device context
so we can turn off power to power domains during runtime. This is
somewhat tied together with clock stopping because we want to disable
clocks as soon as possible when the device gets idle but in the case
of domain power off we also need to start the clock before we can call
the ->runtime_suspend() callback provided by the driver. All this can
of course be handled by the device driver, but that would just be
duplicating too much code - I'd rather let the Runtime PM bus code
manage that.

Many runtime power management aware device drivers use clk_enable()
and clk_disable() stop and start clocks. But the clk_disable()
function is actually often used to signal that the device is idle.
Allowing device drivers to replace clk_enable()/clk_disable() with
Runtime PM callbacks to add support for context save and restore is a
logical next step from my point of view.

For SuperH we will most likely allow clock stopping through the clock
framework _or_ using Runtime PM in parallel, at least until all
drivers are converted to make use of Runtime PM.

Cheers,

/ magnus
