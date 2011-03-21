From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend() and runtime_suspend()
Date: Mon, 21 Mar 2011 10:28:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1103211024230.1978-100000@iolanthe.rowland.org>
References: <9F3EABD6E3419B4C81F34EAABB4D40188142FF8486@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D40188142FF8486@irsmsx501.ger.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Martin, LoicX" <loicx.martin@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Mar 2011, Martin, LoicX wrote:

> Hi
> 
> I found in the linux kernel documentation :
> In /power/pci.h
> 2.4.1. System Suspend
> 
> PCI device drivers (that don't implement legacy power management callbacks) are
> generally not expected to prepare devices for signaling wakeup or to put them
> into low-power states.  However, if one of the driver's suspend callbacks
> (pm->suspend() or pm->suspend_noirq()) saves the device's standard configuration
> registers, pci_pm_suspend_noirq() will assume that the device has been prepared
> to signal wakeup and put into a low-power state by the driver (the driver is
> then assumed to have used the helper functions provided by the PCI subsystem for
> this purpose).  PCI device drivers are not encouraged to do that, but in some
> rare cases doing that in the driver may be the optimum approach.
> 
> 3.1.2 suspend()
> 
> It is not required (in fact it even is
> not recommended) that a PCI driver's suspend() callback save the standard
> configuration registers of the device, prepare it for waking up the system, or
> put it into a low-power state.  All of these operations can very well be taken
> care of by the PCI subsystem, without the driver's participation.
> 
> 2.3. Runtime Device Power Management
> 
> It is expected that the device driver's pm->runtime_suspend() callback will
> not attempt to prepare the device for signaling wakeup or to put it into a
> low-power state.  The driver ought to leave these tasks to the PCI subsystem
> that has all of the information necessary to perform them.
> 
> 
> So I was wondering why in the kernel sources, most of the PCI drivers were using pci_set_power_state, as well pci_save_state either in suspend() callbacks

Perhaps because those PCI drivers were written before the
documentation, using legacy power management.

>  either in runtime_suspend() callbacks.

There should not be any drivers doing that, because runtime_suspend is 
a relatively recent addition.  Can you provide examples?

> Why should we not use those functions in a driver suspend callback implementation ?

Because it would duplicate code that is already present in the PCI
core.

Alan Stern
