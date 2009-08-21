From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 4/5]PCIe native PME support
Date: Fri, 21 Aug 2009 15:01:12 +0800
Message-ID: <20090821070112.GC16694__29493.0757409476$1250838232$gmane$org@sli10-desk.sh.intel.com>
References: <1250666659.23178.119.camel@sli10-desk.sh.intel.com>
	<200908202322.02588.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908202322.02588.rjw@sisk.pl>
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
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 21, 2009 at 05:22:02AM +0800, Rafael J. Wysocki wrote:
> On Wednesday 19 August 2009, Shaohua Li wrote:
> > 
> > PCIe defines a native PME detection mechanism. When a PCIe endpoint
> > invokes PME, PCIe root port has a set of regisets to detect the
> > endpoint's bus/device/function number and root port will send out
> > interrupt when PME is received. After getting interrupt, OS can identify
> > which device invokes PME according to such information. See PCIe
> > spec for detail. This patch implements this feature.
> > 
> > ---
> >  drivers/pci/pcie/Kconfig  |    7 +
> >  drivers/pci/pcie/Makefile |    2 
> >  drivers/pci/pcie/npme.c   |  300 ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci_regs.h  |    1 
> >  4 files changed, 310 insertions(+)
> > 
> > Index: linux/drivers/pci/pcie/Kconfig
> > ===================================================================
> > --- linux.orig/drivers/pci/pcie/Kconfig	2009-08-19 13:43:18.000000000 +0800
> > +++ linux/drivers/pci/pcie/Kconfig	2009-08-19 14:34:00.000000000 +0800
> > @@ -46,3 +46,10 @@ config PCIEASPM_DEBUG
> >  	help
> >  	  This enables PCI Express ASPM debug support. It will add per-device
> >  	  interface to control ASPM.
> > +
> > +config PCIENPME
> > +	bool "PCIE Native PME support(Experimental)"
> > +	depends on PCIEPORTBUS && EXPERIMENTAL
> > +	help
> > +	  This enables PCI Express Native PME Reporting.
> 
> I don't really think we need that.  Or maybe.  But I'd prefer to call it
> PCIE_PME.
It definitely is required if you ever looked at PCIe spec.
In my test machine, the e1000 card can send such event, and the root port can
collect it.

I'm going to fix some issues you pointed out.
