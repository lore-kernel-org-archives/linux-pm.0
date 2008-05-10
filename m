From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Sat, 10 May 2008 20:28:45 +0200
Message-ID: <200805102028.46508.rjw__25718.970996286$1210444288$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0805071139020.3701-100000@iolanthe.rowland.org>
	<200805091513.04194.jbarnes@virtuousgeek.org>
	<200805100057.01656.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805100057.01656.rjw@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 10 of May 2008, Rafael J. Wysocki wrote:
> On Saturday, 10 of May 2008, Jesse Barnes wrote:
> > On Friday, May 09, 2008 2:44 pm Rafael J. Wysocki wrote:
> > > Okay, what about this:
> > >
> > > ---
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > >
> > > The new suspend and hibernation callbacks introduced with
> > > 'struct pm_ops' and 'struct pm_ext_ops' do not take a
> > > pm_message_t argument, so the drivers using them will not be able
> > > to use pci_choose_state() in its present form.  For this reason,
> > > introduce a new function, pci_choose_and_set_state(), playing the
> > > role of pci_choose_state() combined with pci_set_power_state() and
> > > allowing the driver to put the device into a power state chosen by
> > > the platform.
> > 
> > Yeah, that looks pretty good.  The name is long but I can't think of a better 
> > one offhand.  Can you also update Documentation/power/pci.txt with the latest 
> > best practices?
> 
> I'm going to do that, eventually, but rather in a separate patch, when
> everything is ready for the new framework, while at the moment we still have
> some design work to do.
> 
> For example, some drivers may want to call pci_enable_wake() for the
> target state and that must be done before pci_set_power_state() in case the
> target state is D3cold.  To allow them to do that, we'll need a variant of
> pci_choose_and_set_state() with a 'wake_enabled' argument.

Below is how I think that may look like.  Please tell me what you think.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

The new suspend and hibernation callbacks introduced with
'struct pm_ops' and 'struct pm_ext_ops' do not take a
pm_message_t argument, so the drivers using them will not be able
to use pci_choose_state() in its present form.  For this reason,
introduce a new function, raw_pci_change_state(), playing the
role of pci_choose_state() combined with pci_enable_wake() and
pci_set_power_state() and allowing the driver to put the device
into a power state chosen by the platform, optionally configuring
the device as a source of wakeup events.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c   |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h |   11 +++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -509,7 +509,67 @@ pci_set_power_state(struct pci_dev *dev,
 }
 
 pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
- 
+
+/**
+ * raw_pci_change_state - Choose the power state of a PCI device and put the
+ *                        device into that state.
+ * @dev: PCI device to be put into a low power state
+ * @state: State to put the device into by default
+ * @enable_wake: If set, attempt to enable device to generate wakeup events
+ * @fail_no_wake: If set, return error code if the attempt to enable device
+ *                to generate wakeup events fails
+ *
+ * Use the platform driver to choose the preferred PCI power state of given
+ * device and put the device into that state.  If the target power state of
+ * the device cannot be chosen using the platform driver, the driver-provided
+ * @state is used.  If @enable_wake is set, try to enable the device to
+ * generate wakeup events.
+ *
+ * RETURN VALUE:
+ * -EINVAL if trying to enter a lower state than we're already in.
+ * 0 if we're already in the requested state.
+ * -EIO if device does not support PCI PM.
+ * 0 if we can successfully change the power state.
+ *
+ * If both @enable_wake and @fail_no_wake are set, additionally:
+ * -EIO if the device can't ever be a wakeup event source.
+ * -EINVAL if the device can't generate wakeup events from given state.
+ */
+
+int raw_pci_change_state(struct pci_dev *dev, pci_power_t state,
+                         bool enable_wake, bool fail_no_wake)
+{
+	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
+		return -EIO;
+
+	if (platform_pci_choose_state) {
+		pci_power_t ret = platform_pci_choose_state(dev);
+
+		switch (ret) {
+		case PCI_POWER_ERROR:
+		case PCI_UNKNOWN:
+			break;
+		case PCI_D1:
+		case PCI_D2:
+			if (pci_no_d1d2(dev))
+				break;
+		default:
+			state = ret;
+		}
+	}
+
+	if (enable_wake) {
+		int error = pci_enable_wake(dev, state, true);
+
+		if (error && fail_no_wake)
+			return error;
+	}
+
+	return pci_set_power_state(dev, state);
+}
+
+EXPORT_SYMBOL(raw_pci_change_state);
+
 /**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -615,6 +615,17 @@ size_t pci_get_rom_size(void __iomem *ro
 int pci_save_state(struct pci_dev *dev);
 int pci_restore_state(struct pci_dev *dev);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+int raw_pci_change_state(struct pci_dev *dev, pci_power_t state,
+                         bool enable_wake, bool fail_no_wake);
+static inline int pci_change_state(struct pci_dev *dev, pci_power_t state)
+{
+	return raw_pci_change_state(dev, state, false, false);
+}
+static inline int pci_change_state_wake(struct pci_dev *dev,
+                                          pci_power_t state)
+{
+	return raw_pci_change_state(dev, state, true, false);
+}
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
 
