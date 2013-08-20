From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: Hold acpi_scan_lock over system PM transitions
Date: Tue, 20 Aug 2013 14:24:42 +0200
Message-ID: <4492949.n2Wo36SnUY@vostro.rjw.lan>
References: <2852781.TfChGuuEkJ@vostro.rjw.lan> <20130820110833.GZ4898@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20130820110833.GZ4898@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 20, 2013 02:08:33 PM Mika Westerberg wrote:
> On Tue, Aug 20, 2013 at 01:47:57AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Bad things happen if ACPI hotplug events are handled during system
> > PM transitions, especially if devices are removed as a result.
> > To prevent those bad things from happening, acquire acpi_scan_lock
> > when a transition is started and release it when that transition
> > is complete or has been aborted.
> > 
> > This fixes resume lockup on my test-bed Acer Aspire S5 that happens
> > when Thunderbolt devices are disconnected from the machine while
> > suspended.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> I tested this on Intel DZ77RE-75K and after the patch is applied the
> machine didn't hang anymore once resuming.
> 
> Feel free to add my tested-by.

I will, thanks!

