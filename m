From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Thu, 5 Jan 2006 17:37:30 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
References: <20060104213405.GC1761@elf.ucw.cz>
	<Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
	<20060105215528.GF2095@elf.ucw.cz>
	<20060105221334.GA925@isilmar.linta.de>
	<20060105222338.GG2095@elf.ucw.cz>
	<20060105222705.GA12242@isilmar.linta.de>
	<20060105230849.GN2095@elf.ucw.cz>
	<20060105234629.GA7298@isilmar.linta.de>
	<20060105235838.GC3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
	<20060106001252.GE3339@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============39093299503535928=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060106001252.GE3339@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

--===============39093299503535928==
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k061bgDZ016879



On Fri, 6 Jan 2006, Pavel Machek wrote:

> On =C4=8Ct 05-01-06 16:04:07, Patrick Mochel wrote:

> > A better point, and one that would actually be useful, would be to re=
move
> > the file altogether. Let Dominik export a power file, with complete
> > control over the values, for each pcmcia device. Then you never have =
to
> > worry about breaking PCMCIA again.
>
> Fine with me.

ACK, you beat me to it.

And, appended is a patch to export PM controls for PCI devices. The file
"pm_possible_states" exports the states a device supports, and "pm_state"
exports the current state (and provides the interface for entering a
state).

Eventually, some drivers will want to fix up those values so that it can
mask of states that it doesn't support, as well as offer possible device-
specific states.

What's interesting is that with this patch, I can see that two more
devices on my system support D1 and D2 -- the cardbus controllers, which
are actually bridges whose PM capabilities aren't exported via lspci.

Thanks,

	Patrick


diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 6707df9..628f3a3 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -36,6 +36,10 @@ obj-$(CONFIG_ACPI)    +=3D pci-acpi.o
 # Cardbus & CompactPCI use setup-bus
 obj-$(CONFIG_HOTPLUG) +=3D setup-bus.o

+
+# Power Management functionality
+obj-$(CONFIG_PM)	+=3D pm.o
+
 ifndef CONFIG_X86
 obj-y +=3D syscall.o
 endif
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index eed67d9..83045d9 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -85,6 +85,8 @@ void __devinit pci_bus_add_device(struct
 	list_add_tail(&dev->global_list, &pci_devices);
 	spin_unlock(&pci_bus_lock);

+	pci_pm_init(dev);
+
 	pci_proc_attach_device(dev);
 	pci_create_sysfs_dev_files(dev);
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6527b36..6d7afbc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -63,6 +63,23 @@ extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
 extern struct class_device_attribute class_device_attr_cpuaffinity;

+
+#ifdef CONFIG_PM
+extern int pci_pm_init(struct pci_dev *);
+extern void pci_pm_exit(struct pci_dev *);
+#else /* CONFIG_PM */
+static inline int pci_pm_init(struct pci_dev *)
+{
+	return 0;
+}
+
+static inline void pci_pm_exit(struct pci_dev *)
+{
+
+}
+
+#endif
+
 /**
  * pci_match_one_device - Tell if a PCI device structure has a matching
  *                        PCI device id structure
diff --git a/drivers/pci/pm.c b/drivers/pci/pm.c
new file mode 100644
index 0000000..ce476e4
--- /dev/null
+++ b/drivers/pci/pm.c
@@ -0,0 +1,138 @@
+/*
+ * drivers/pci/pm.c - Power management support for PCI devices
+ */
+
+#include <linux/pci.h>
+
+
+static ssize_t pm_possible_states_show(struct device * d,
+				       struct device_attribute * a,
+				       char * buffer)
+{
+	struct pci_dev * dev =3D to_pci_dev(d);
+	char * s =3D buffer;
+
+	s +=3D sprintf(s, "d0");
+	if (dev->poss_states[PCI_D1])
+		s +=3D sprintf(s, " d1");
+	if (dev->poss_states[PCI_D2])
+		s +=3D sprintf(s, " d2");
+	if (dev->poss_states[PCI_D3hot])
+		s +=3D sprintf(s, " d3");
+	s +=3D sprintf(s, "\n");
+	return (s - buffer);
+}
+
+static DEVICE_ATTR(pm_possible_states, 0444, pm_possible_states_show, NU=
LL);
+
+
+static ssize_t pm_state_show(struct device * d, struct device_attribute =
* a,
+			     char * buffer)
+{
+	struct pci_dev * dev =3D to_pci_dev(d);
+	const char * str;
+
+	switch (dev->current_state) {
+	case PCI_D0:
+		str =3D "d0";
+		break;
+	case PCI_D1:
+		str =3D "d1";
+		break;
+	case PCI_D2:
+		str =3D "d2";
+		break;
+	case PCI_D3hot:
+		str =3D "d3";
+		break;
+	default:
+		str =3D "d?";
+		break;
+	}
+
+	return sprintf(buffer, "%s\n", str);
+}
+
+
+static ssize_t pm_state_store(struct device * d, struct device_attribute=
 * a,
+			      const char * buffer, size_t len)
+{
+	struct pci_dev * dev =3D to_pci_dev(d);
+	pci_power_t state;
+	int ret;
+
+	if (!strnicmp(buffer, "d0", len))
+		state =3D PCI_D0;
+	else if (!strnicmp(buffer, "d1", len))
+		state =3D PCI_D1;
+	else if (!strnicmp(buffer, "d2", len))
+		state =3D PCI_D2;
+	else if (!strnicmp(buffer, "d3", len))
+		state =3D PCI_D3hot;
+	else
+		return -EINVAL;
+
+	if (state =3D=3D dev->current_state)
+		return 0;
+
+	if (dev->poss_states[state])
+		ret =3D pci_set_power_state(dev, state);
+	else
+		ret =3D -EINVAL;
+
+	return ret =3D=3D 0 ? len : ret;
+}
+
+static DEVICE_ATTR(pm_state, 0644, pm_state_show, pm_state_store);
+
+
+static int find_states(struct pci_dev * dev)
+{
+	int cap;
+	u16 pmc;
+
+
+	/*
+	 * Every device supports D0
+	 */
+	dev->poss_states[PCI_D0] =3D 1;
+
+	/*
+	 * Check if the device has PM capabilties in the config space
+	 */
+	cap =3D pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!cap)
+		return -EIO;
+
+	/*
+	 * If it supports PM capabilities, it will support D3
+	 */
+	dev->poss_states[PCI_D3hot] =3D 1;
+
+	/*
+	 * Check D1 and D2 support
+	 */
+	pci_read_config_word(dev, cap + PCI_PM_PMC, &pmc);
+	if (pmc & PCI_PM_CAP_D1)
+		dev->poss_states[PCI_D1] =3D 1;
+	if (pmc & PCI_PM_CAP_D2)
+		dev->poss_states[PCI_D2] =3D 1;
+	return 0;
+}
+
+
+int pci_pm_init(struct pci_dev * dev)
+{
+	if (find_states(dev))
+		return 0;
+
+	device_create_file(&dev->dev, &dev_attr_pm_possible_states);
+	return device_create_file(&dev->dev, &dev_attr_pm_state);
+}
+
+void pci_pm_exit(struct pci_dev * dev)
+{
+	device_remove_file(&dev->dev, &dev_attr_pm_state);
+	device_remove_file(&dev->dev, &dev_attr_pm_possible_states);
+}
+
diff --git a/include/linux/pci.h b/include/linux/pci.h
index de690ca..2600119 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -106,6 +106,7 @@ struct pci_dev {
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */

+	u32		poss_states[4];
 	pci_power_t     current_state;  /* Current operating state. In ACPI-spe=
ak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */


--===============39093299503535928==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============39093299503535928==--
