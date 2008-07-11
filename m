From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 8/8] PCI: Simplify PCI device PM code (rev. 4)
Date: Fri, 11 Jul 2008 22:37:30 +0200
Message-ID: <20080711203730.GD6843__22915.801642421$1215808808$gmane$org@elf.ucw.cz>
References: <200807012356.26669.rjw@sisk.pl> <200807070330.02849.rjw@sisk.pl>
	<200807070336.25004.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807070336.25004.rjw@sisk.pl>
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
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Zhao Yakui <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCI: Simplify PCI device PM code (rev. 4)
> 
> If the offset of PCI device's PM capability in its configuration
> space, the mask of states that the device supports PME# from and the
> D1 and D2 support bits are cached in the corresponding
> struct pci_dev, the PCI device PM code can be simplified quite a bit.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pci.c        |  118 ++++++++++++++++++++---------------------------
>  include/linux/pci.h      |    8 ++-
>  include/linux/pci_regs.h |    1 
>  3 files changed, 60 insertions(+), 67 deletions(-)
> 
> Index: linux-pci/include/linux/pci.h
> ===================================================================
> --- linux-pci.orig/include/linux/pci.h
> +++ linux-pci/include/linux/pci.h
> @@ -177,6 +177,13 @@ struct pci_dev {
>  	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
>  					   this is D0-D3, D0 being fully functional,
>  					   and D3 being off. */
> +	int		pm_cap;		/* PM capability offset in the
> +					   configuration space */
> +	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
> +					   can be generated */
> +	unsigned int	d1_support:1;	/* Low power state D1 is supported */
> +	unsigned int	d2_support:1;	/* Low power state D2 is supported */
> +	unsigned int	no_d1d2:1;	/* Only allow D0 and D3 */

Uh, "D1", "D2", then "no D1D2" ?

>  	}
>  
> -	if (pmc & PCI_PM_CAP_PME_MASK) {
> +	dev->pm_cap = pm;
> +
> +	dev->d1_support = false;
> +	dev->d2_support = false;

I thought d1_support is unsigned int, not bool?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
