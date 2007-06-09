From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] ehci_hcd causes box to resume
 immediately after suspend to RAM
Date: Sat, 9 Jun 2007 17:26:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706091721270.30086-100000@netrider.rowland.org>
References: <200706092310.16264.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706092310.16264.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Sat, 9 Jun 2007, Rafael J. Wysocki wrote:

> > You can try using the patch below to see what happens when you manually
> > suspend the controller.  It enables PCI devices to respond to the
> > legacy power/state attribute.  You should look at what "lspci -vv" says
> > about the controller's power management signals, both before and after
> > suspending the PCI device entry.
> 
> It works as expected, AFAICS.  That is, after I echo '2' to the 'state' file,
> it shows that the controller is in D3.

At that point, does "lspci -vv" show that the controller is trying to 
signal a wakeup event?  That is, is the PME# signal asserted?

(Not that knowing this will help very much -- I'm not sure what we 
could do with that information, and in any case there are other ways 
besides PME# for on-board devices to report wakeup requests.  I ask 
mainly out of curiousity.)

> I've tried to suspend with the controller in that state, but it's resumed
> immediately, as before.
> 
> > Maybe also see what ACPI reports.
> 
> How can I see that?

I wish I knew.  Maybe you can try asking on the ACPI mailing list.

The simplest workaround should be to disable remote wakeup for that 
controller:

	echo disable >/sys/bus/pci/devices/.../power/wakeup

Alan Stern
