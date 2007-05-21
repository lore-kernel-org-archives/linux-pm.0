From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-git] pci_choose_state() works,
	does ACPI magic
Date: Mon, 21 May 2007 11:58:34 -0700
Message-ID: <200705211158.34778.david-b__13634.2905265794$1179774016$gmane$org@pacbell.net>
References: <200705091222.29561.david-b@pacbell.net>
	<200705211055.55090.david-b@pacbell.net>
	<200705211221.09439.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705211221.09439.bjorn.helgaas@hp.com>
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
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 21 May 2007, Bjorn Helgaas wrote:
> On Monday 21 May 2007 11:55:54 am David Brownell wrote:
> > On Monday 21 May 2007, Bjorn Helgaas wrote:
> > > We had a bug[1] a while back where e1000 would suspend a device and
> > > call pci_power_state(), which used ACPI to turn off the slot.  The
> > > only problem was that this was a dual-port card and the other port
> > > was still active when the lights went out.
> > 
> > Sounds like an ACPI bug to me:  not properly tracking the users
> > of a given PCI power resource.
> 
> acpi_bus_set_power() takes a "handle", which refers to the slot.

Odd; elsewhere the "handle" refers to a single logical device,
and that's normally been a single function.  And the examples
in the Microsoft doc you mentioned show that structure too.

Of course, I'm not used to seeing ACPI look at devices in slots
either ... usually it just tells me about things on the mainboard.
It seems hotplug PCI needs work yet.

... Regardless, this pre-existing problem wasn't affected by
the $SUBJECT patch.

- Dave


>   http://www.microsoft.com/whdc/system/pnppwr/hotadd/hotplugpci.mspx
> 
> > > [1] https://bugzilla.novell.com/show_bug.cgi?id=162320
> 
