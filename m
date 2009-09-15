From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1] PCI PM: PCIe PME root port service
	driver	(was: Re: [PATCH 2/2] PCIe native PME support)
Date: Tue, 15 Sep 2009 13:32:30 +0200
Message-ID: <20090915113230.GA1328__6954.90601142428$1253014528$gmane$org@ucw.cz>
References: <1251101495.22288.54.camel@sli10-desk.sh.intel.com>
	<200908292248.01079.rjw@sisk.pl>
	<20090901023549.GB3695@sli10-desk.sh.intel.com>
	<200909061434.24870.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909061434.24870.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-pci <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Updated patch.
> 
> I looked at it and thought I would do it differently in many places, so
> below is my version.

> Index: linux-2.6/drivers/pci/pcie/Kconfig
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pcie/Kconfig
> +++ linux-2.6/drivers/pci/pcie/Kconfig
> @@ -46,3 +46,7 @@ config PCIEASPM_DEBUG
>  	help
>  	  This enables PCI Express ASPM debug support. It will add per-device
>  	  interface to control ASPM.
> +
> +config PCIE_PME
> +	def_bool y
> +	depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL

This is evil. Now config_EXPERIMENTAL controls if this option is
enabled or not.

If the feature is so experimental that it needs this kind of markup,
it should probably be user-selectable, too...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
