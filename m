From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 4/4] PCI/ACPI PM: Propagate wake-up
	enable for devices w/o ACPI support
Date: Sat, 5 Sep 2009 00:00:32 +0200
Message-ID: <200909050000.32288.rjw__44302.7615467601$1252102033$gmane$org@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200909041639.46289.rjw@sisk.pl>
	<20090904145638.GA23091@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090904145638.GA23091@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ykzhao <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 04 September 2009, Matthew Garrett wrote:
> On Fri, Sep 04, 2009 at 04:39:46PM +0200, Rafael J. Wysocki wrote:
> 
> > Quite frankly, I'm not sure of that.  It really depends on how PME# is routed
> > in given system.  The spec permits routing it directly to the chipset as well
> > as routing it through bridges and I don't know if we can assume that the
> > first upstream device capable of generating wake-up events will handle it.
> 
> The GPE block is going to be in the chipset, so unless the vendors have 
> explicitly hooked up a link between the PME line from a bridge and the 
> EC, we're presumably always going to get it from the chipset if at all.
> 
> > That said, I think we can try returning from
> > acpi_pci_propagate_wakeup_enable() as soon as
> > acpi_pm_device_sleep_wake() returns 0 for current device.  On the test systems
> > I have it won't make any difference, because the GPE is shared among the
> > root bridge and the first upstream bridge of the device in question.
> 
> Yes, it's presumably the case that the PME event in the bridge is just 
> tied to the root bridge in the chipset. Do we know what chipset this 
> hardware is? For Intel, at least, GPE behaviour is defined in the 
> chipset docs.

One box is Intel, the other one is based on an ATI (pre-AMD) chipset, but
the design is similar in that respect.

Thanks,
Rafael
