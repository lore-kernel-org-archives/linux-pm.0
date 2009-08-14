From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] PCI: Runtime power management
Date: Fri, 14 Aug 2009 21:15:25 +0200
Message-ID: <200908142115.25946.rjw__16195.954118348$1250277360$gmane$org@sisk.pl>
References: <200908081625.57333.rjw@sisk.pl>
	<20090813002925.GA2532@srcf.ucam.org>
	<20090814103719.79e99d91@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090814103719.79e99d91@jbarnes-g45>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 14 August 2009, Jesse Barnes wrote:
> On Thu, 13 Aug 2009 01:29:25 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> > I got a fixed BIOS from Dell and have been able to get this working
> > now. It seems entirely happy with USB, but I'd like some sanity
> > checks on whether I'm doing this correctly. There's certainly a
> > couple of quirks related to setting the ACPI GPE type that would need
> > a little bit of work in the ACPI layer, and it breaks ACPI-mediated
> > PCI hotplug though that's easy enough to fix by just calling into the
> > hotplug code from the core notifier.
> > 
> > This patch builds on top of Rafael's work on systemwide runtime power
> > management. It supports suspending and resuming PCI devices at
> > runtime, enabling platform wakeup events that allow the devices to
> > automatically resume when appropriate. It currently requires platform
> > support, but PCIe setups could be supported natively once native PCIe
> > PME code has been added to the kernel.
> 
> PCI bits look pretty good to me, though Rafael should take a look too.

I'm going to do that shortly.

> Card readers and firewire could benefit from similar treatment,

As well us network adapters.

> maybe that would get us to .5W territory on some machines.

Hopefully. :-)

Thanks,
Rafael
