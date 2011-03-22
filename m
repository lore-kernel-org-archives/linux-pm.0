From: "Martin, LoicX" <loicx.martin@intel.com>
Subject: Re: suspend() and runtime_suspend()
Date: Tue, 22 Mar 2011 15:50:22 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188142FF8E0D@irsmsx501.ger.corp.intel.com>
References: <9F3EABD6E3419B4C81F34EAABB4D40188142FF8486@irsmsx501.ger.corp.intel.com>
	<Pine.LNX.4.44L0.1103211024230.1978-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1103211024230.1978-100000@iolanthe.rowland.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi =


I found those drivers:

drivers/dma/intel_mid_dma.c
drivers/i2c/busses/i2c-intel-mid.c
drivers/staging/gma500/psb_drv.c
drivers/staging/gma500/psb_powermgmt.c
drivers/staging/intel_sst/intel_sst.c

We are currently working on this purpose (runtime suspend/resume implementa=
tion), and our first understanding was not perfectly clear.
That's why I was asking about the correct implementation of those callback.

Thanks

I have one more question about this part of the documentation:
>>However, the driver should not call the pm_runtime_allow() helper functio=
n unblocking
>>the runtime PM of the device. Instead, it should allow user space or some
>>platform-specific code to do that

Is there any reason concerning the system stability or something else to do=
 it that way instead of doing it in the driver during the probe ?


Lo=EFc

-----Original Message-----
From: Alan Stern [mailto:stern@rowland.harvard.edu] =

Sent: Monday, March 21, 2011 3:28 PM
To: Martin, LoicX
Cc: linux-pm@lists.linux-foundation.org
Subject: Re: [linux-pm] suspend() and runtime_suspend()

On Mon, 21 Mar 2011, Martin, LoicX wrote:

> Hi
> =

> I found in the linux kernel documentation :
> In /power/pci.h
> 2.4.1. System Suspend
> =

> PCI device drivers (that don't implement legacy power management callback=
s) are
> generally not expected to prepare devices for signaling wakeup or to put =
them
> into low-power states.  However, if one of the driver's suspend callbacks
> (pm->suspend() or pm->suspend_noirq()) saves the device's standard config=
uration
> registers, pci_pm_suspend_noirq() will assume that the device has been pr=
epared
> to signal wakeup and put into a low-power state by the driver (the driver=
 is
> then assumed to have used the helper functions provided by the PCI subsys=
tem for
> this purpose).  PCI device drivers are not encouraged to do that, but in =
some
> rare cases doing that in the driver may be the optimum approach.
> =

> 3.1.2 suspend()
> =

> It is not required (in fact it even is
> not recommended) that a PCI driver's suspend() callback save the standard
> configuration registers of the device, prepare it for waking up the syste=
m, or
> put it into a low-power state.  All of these operations can very well be =
taken
> care of by the PCI subsystem, without the driver's participation.
> =

> 2.3. Runtime Device Power Management
> =

> It is expected that the device driver's pm->runtime_suspend() callback wi=
ll
> not attempt to prepare the device for signaling wakeup or to put it into a
> low-power state.  The driver ought to leave these tasks to the PCI subsys=
tem
> that has all of the information necessary to perform them.
> =

> =

> So I was wondering why in the kernel sources, most of the PCI drivers wer=
e using pci_set_power_state, as well pci_save_state either in suspend() cal=
lbacks

Perhaps because those PCI drivers were written before the
documentation, using legacy power management.

>  either in runtime_suspend() callbacks.

There should not be any drivers doing that, because runtime_suspend is =

a relatively recent addition.  Can you provide examples?

> Why should we not use those functions in a driver suspend callback implem=
entation ?

Because it would duplicate code that is already present in the PCI
core.

Alan Stern

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
