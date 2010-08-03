From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PCI / PCIe/ AER: Introduce
	pci_aer_available()
Date: Tue, 3 Aug 2010 11:28:02 +0200
Message-ID: <201008031128.02437.rjw__15104.2604622946$1280828128$gmane$org@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl> <201008022354.46369.rjw@sisk.pl>
	<4C5766F2.4010605@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C5766F2.4010605@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 03, 2010, Hidetoshi Seto wrote:
> (2010/08/03 6:54), Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Introduce a function allowing the caller to check if PCIe AER should
> > be enabled.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> (snip)
> > Index: linux-2.6/drivers/pci/pcie/aer/aerdrv.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/pci/pcie/aer/aerdrv.c
> > +++ linux-2.6/drivers/pci/pcie/aer/aerdrv.c
> > @@ -72,6 +72,11 @@ void pci_no_aer(void)
> >  	pcie_aer_disable = 1;	/* has priority over 'forceload' */
> >  }
> >  
> > +bool pci_aer_available(void)
> > +{
> > +	return !pcie_aer_disable && pci_msi_enabled();
> > +}
> > +
> >  static int set_device_error_reporting(struct pci_dev *dev, void *data)
> >  {
> >  	bool enable = *((bool *)data);
> > @@ -411,9 +416,7 @@ static void aer_error_resume(struct pci_
> >   */
> >  static int __init aer_service_init(void)
> >  {
> > -	if (pcie_aer_disable)
> > -		return -ENXIO;
> > -	if (!pci_msi_enabled())
> > +	if (pci_aer_available())
> >  		return -ENXIO;
> >  	return pcie_port_service_register(&aerdriver);
> >  }
> 
> Breaking a big lump into small pieces often makes things clear.
> You should return error when AER is _NOT_ available.
> 
> if (!pci_aer_available())
> 	return -ENXIO;
> 
> Be careful...

Yup, sorry.

Thanks,
Rafael
