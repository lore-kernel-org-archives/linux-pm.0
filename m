From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/3] PCI PM: Introduce
	platform_pci_power_manageable
Date: Tue, 17 Jun 2008 15:11:26 +0200
Message-ID: <200806171511.26717.rjw__14665.929930243$1213708439$gmane$org@sisk.pl>
References: <200806170206.26616.rjw@sisk.pl>
	<1213665980.11712.120.camel@localhost.localdomain>
	<200806171347.20575.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806171347.20575.rjw@sisk.pl>
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 17 of June 2008, Rafael J. Wysocki wrote:
> On Tuesday, 17 of June 2008, Matt Helsley wrote:
> > 
> > On Tue, 2008-06-17 at 02:14 +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Introduce function pointer platform_pci_power_manageable to be used
> > > by the platform-related code to point to a function allowing us to
> > > check if given device is power manageable by the platform.
> > > 
> > > Introduce acpi_pci_power_manageable() playing that role for ACPI.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  drivers/pci/pci-acpi.c |   11 +++++++++++
> > >  drivers/pci/pci.c      |    1 +
> > >  drivers/pci/pci.h      |    1 +
> > >  3 files changed, 13 insertions(+)
> > > 
> > > Index: linux-2.6/drivers/pci/pci-acpi.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/pci/pci-acpi.c
> > > +++ linux-2.6/drivers/pci/pci-acpi.c
> > > @@ -315,6 +315,16 @@ static pci_power_t acpi_pci_choose_state
> > >  }
> > >  #endif
> > > 
> > > +static bool acpi_pci_power_manageable(struct pci_dev *dev)
> > > +{
> > > +	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
> > > +
> > > +	if (!handle)
> > > +		return -ENODEV;
> > 
> > Seems like a bad idea to pass non-true/false values using a bool.
> > Wouldn't an int return type be more appropriate here?
> 
> That's a bug actually.  It should be 'false'.

Updated patch follows.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce function pointer platform_pci_power_manageable to be used
by the platform-related code to point to a function allowing us to
check if given device is power manageable by the platform.

Introduce acpi_pci_power_manageable() playing that role for ACPI.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |    8 ++++++++
 drivers/pci/pci.c      |    1 +
 drivers/pci/pci.h      |    1 +
 3 files changed, 10 insertions(+)

Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -315,6 +315,13 @@ static pci_power_t acpi_pci_choose_state
 }
 #endif
 
+static bool acpi_pci_power_manageable(struct pci_dev *dev)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+
+	return handle ? acpi_bus_power_manageable(handle) : false;
+}
+
 static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
@@ -398,6 +405,7 @@ static int __init acpi_pci_init(void)
 #ifdef	CONFIG_ACPI_SLEEP
 	platform_pci_choose_state = acpi_pci_choose_state;
 #endif
+	platform_pci_power_manageable = acpi_pci_power_manageable;
 	platform_pci_set_power_state = acpi_pci_set_power_state;
 	return 0;
 }
Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -378,6 +378,7 @@ pci_restore_bars(struct pci_dev *dev)
 		pci_update_resource(dev, &dev->resource[i], i);
 }
 
+bool (*platform_pci_power_manageable)(struct pci_dev *dev);
 int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t t);
 
 /**
Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -6,6 +6,7 @@ extern void pci_remove_sysfs_dev_files(s
 extern void pci_cleanup_rom(struct pci_dev *dev);
 
 /* Firmware callbacks */
+extern bool (*platform_pci_power_manageable)(struct pci_dev *dev);
 extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
 extern int (*platform_pci_set_power_state)(struct pci_dev *dev,
 						pci_power_t state);
