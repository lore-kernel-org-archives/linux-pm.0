From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 12:41:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204181228380.1149-100000@iolanthe.rowland.org>
References: <20120418152455.GT11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120418152455.GT11484@belkar.wrar.name>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: jrnieder@gmail.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Apr 2012, Andrey Rahmatullin wrote:

> Unbound:
> 
> pci 0000:00:1d.0: wake-up capability enabled by ACPI
> pci 0000:00:1d.0: Refused to change power state, currently in D0
> pci 0000:00:1d.0: cur 5 target 3 error 0
> pci 0000:00:1a.0: wake-up capability enabled by ACPI
> pci 0000:00:1a.0: Refused to change power state, currently in D0
> pci 0000:00:1a.0: cur 5 target 3 error 0
> 
> Bound:
> 
> ehci_hcd 0000:00:1d.0: wake-up capability enabled by ACPI
> ehci_hcd 0000:00:1d.0: cur 0 target 3 error 0
> ehci_hcd 0000:00:1a.0: wake-up capability enabled by ACPI
> ehci_hcd 0000:00:1a.0: cur 0 target 3 error 0

Okay, it sounds like you both got the same result.

Here's the situation.  When the script unbinds ehci-hcd, 
pci_device_remove() sets the current state to PCI_UNKNOWN.  The patch 
to hcd-pci.c does the same thing before the suspend_noirq phase begins, 
i.e., before pci_prepare_to_sleep() is called.

In pci_raw_set_power_state(), there's a "switch" statement that depends
on dev->current_state.  If the current state is PCI_D0 then the new
state in pmcsr is set to PCI_D3; if the current state is PCI_UNKNOWN
then the state in pmcsr is left unchanged.  After that, the value in
pmcsr is written to the controller.

This means that when ehci-hcd is unbound or the patch is installed, the
controller stays in D0.  That's why we see those "Refused to change
power state" messages, since D0 is not what the target state was
supposed to be.  When ehci-hcd remains bound and the patch isn't
installed, the controller is put into D3.

And then finally, the computer crashes during the final stage of 
suspend if either controller is in D3.  Clearly this is a bug in the 
firmware, not in the kernel.

Have you guys checked to see if any BIOS updates are available?

Alan Stern
