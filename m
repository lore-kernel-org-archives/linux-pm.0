From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 2.6.21-git] pci_choose_state() works,
	does ACPI magic
Date: Mon, 21 May 2007 12:21:09 -0600
Message-ID: <200705211221.09439.bjorn.helgaas__26744.4257312038$1179771764$gmane$org@hp.com>
References: <200705091222.29561.david-b@pacbell.net>
	<200705211134.36578.bjorn.helgaas@hp.com>
	<200705211055.55090.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705211055.55090.david-b@pacbell.net>
Content-Disposition: inline
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 21 May 2007 11:55:54 am David Brownell wrote:
> On Monday 21 May 2007, Bjorn Helgaas wrote:
> > We had a bug[1] a while back where e1000 would suspend a device and
> > call pci_power_state(), which used ACPI to turn off the slot.  The
> > only problem was that this was a dual-port card and the other port
> > was still active when the lights went out.
> 
> Sounds like an ACPI bug to me:  not properly tracking the users
> of a given PCI power resource.

acpi_bus_set_power() takes a "handle", which refers to the slot.  I
don't know where the refcounting should occur, and I don't know
whether your patch affects this path.  Just something to be aware
of in this area.

> I can't see that bug without 
> getting a Novell login -- you might want post the report rather
> than its URL.

Yeah, that's irritating.  It likely was protected just by default,
but I don't feel empowered to change that.

The synopsis is that e1000_suspend() called pci_set_power_state(),
which called platform_pci_set_power_state(), which evaluated the
SxFy _PS3 method, which turned off the power to slot "x".

Unfortunately, slot "x" contained a dual-port NIC, so suspending
one port turned off the power to *both* ports.  The e1000 driver
didn't expect that, so it tried to do something with the other
port and blew up.

It was non-intuitive to me that a SxFy\_PS3 method would turn
off the slot, affecting all functions, not just "Fy", but I
guess that's the standard behavior:

  http://www.microsoft.com/whdc/system/pnppwr/hotadd/hotplugpci.mspx

> > [1] https://bugzilla.novell.com/show_bug.cgi?id=162320
