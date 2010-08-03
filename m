From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PCI / PCIe/ AER: Introduce
	pci_aer_available()
Date: Tue, 3 Aug 2010 22:59:28 +0200
Message-ID: <201008032259.28967.rjw__30587.7978833907$1280869492$gmane$org@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl> <4C5766F2.4010605@jp.fujitsu.com>
	<201008031128.02437.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008031128.02437.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-pci@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 03, 2010, Rafael J. Wysocki wrote:
> On Tuesday, August 03, 2010, Hidetoshi Seto wrote:
> > (2010/08/03 6:54), Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Introduce a function allowing the caller to check if PCIe AER should
> > > be enabled.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > (snip)
> > > Index: linux-2.6/drivers/pci/pcie/aer/aerdrv.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/pci/pcie/aer/aerdrv.c
> > > +++ linux-2.6/drivers/pci/pcie/aer/aerdrv.c
> > > @@ -72,6 +72,11 @@ void pci_no_aer(void)
> > >  	pcie_aer_disable = 1;	/* has priority over 'forceload' */
> > >  }
> > >  
> > > +bool pci_aer_available(void)
> > > +{
> > > +	return !pcie_aer_disable && pci_msi_enabled();
> > > +}
> > > +
> > >  static int set_device_error_reporting(struct pci_dev *dev, void *data)
> > >  {
> > >  	bool enable = *((bool *)data);
> > > @@ -411,9 +416,7 @@ static void aer_error_resume(struct pci_
> > >   */
> > >  static int __init aer_service_init(void)
> > >  {
> > > -	if (pcie_aer_disable)
> > > -		return -ENXIO;
> > > -	if (!pci_msi_enabled())
> > > +	if (pci_aer_available())
> > >  		return -ENXIO;
> > >  	return pcie_port_service_register(&aerdriver);
> > >  }
> > 
> > Breaking a big lump into small pieces often makes things clear.
> > You should return error when AER is _NOT_ available.
> > 
> > if (!pci_aer_available())
> > 	return -ENXIO;
> > 
> > Be careful...
> 
> Yup, sorry.

Corrected patch is appended.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PCI / PCIe/ AER: Introduce pci_aer_available()

Introduce a function allowing the caller to check whether to try to
enable PCIe AER.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.h             |    2 ++
 drivers/pci/pcie/aer/aerdrv.c |    9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -131,8 +131,10 @@ static inline void pci_msi_init_pci_dev(
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+bool pci_aer_available(void);
 #else
 static inline void pci_no_aer(void) { }
+static inline bool pci_aer_available(void) { return false; }
 #endif
 
 static inline int pci_no_d1d2(struct pci_dev *dev)
Index: linux-2.6/drivers/pci/pcie/aer/aerdrv.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/aer/aerdrv.c
+++ linux-2.6/drivers/pci/pcie/aer/aerdrv.c
@@ -72,6 +72,11 @@ void pci_no_aer(void)
 	pcie_aer_disable = 1;	/* has priority over 'forceload' */
 }
 
+bool pci_aer_available(void)
+{
+	return !pcie_aer_disable && pci_msi_enabled();
+}
+
 static int set_device_error_reporting(struct pci_dev *dev, void *data)
 {
 	bool enable = *((bool *)data);
@@ -411,9 +416,7 @@ static void aer_error_resume(struct pci_
  */
 static int __init aer_service_init(void)
 {
-	if (pcie_aer_disable)
-		return -ENXIO;
-	if (!pci_msi_enabled())
+	if (!pci_aer_available())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
