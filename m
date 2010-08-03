From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control
	bits returned by a query (v2)
Date: Tue, 3 Aug 2010 23:02:33 +0200
Message-ID: <201008032302.33778.rjw__45433.6428236731$1280869902$gmane$org@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl> <4C57C182.7060407@jp.fujitsu.com>
	<201008031133.37471.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008031133.37471.rjw@sisk.pl>
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
> > (2010/08/03 13:52), Kenji Kaneshige wrote:
> > > (2010/08/03 6:59), Rafael J. Wysocki wrote:
> > >> @@ -434,19 +432,6 @@ acpi_status acpi_pci_osc_control_set(acp
> > >>       if ((root->osc_control_set&  control_req) == control_req)
> > >>           goto out;
> > >>
> > >> -    /* Need to query controls first before requesting them */
> > >> -    if (!root->osc_queried) {
> > >> -        status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
> > >> -        if (ACPI_FAILURE(status))
> > >> -            goto out;
> > >> -    }
> > >> -    if ((root->osc_control_qry&  control_req) != control_req) {
> > >> -        printk(KERN_DEBUG
> > >> -               "Firmware did not grant requested _OSC control\n");
> > >> -        status = AE_SUPPORT;
> > >> -        goto out;
> > >> -    }
> > > 
> > > I think acpi_pci_osc_control_set() still need to query before commit
> > > to ensure all the requested controls are granted to OS.
> > > 
> > > So the code needs to be
> > > 
> > >     status = acpi_pci_query_osc(root, root->osc_support_set, &control_req);
> > >     if (ACPI_FAILURE(status))
> > >         goto out;
> > 
> > Hum, since acpi_status acpi_pci_osc_control_set() is an exported
> > function, we cannot be too careful here. 
> > 
> > OTOH, I think this second query should be done in caller too,
> > i.e. pcie_port_acpi_setup() in patch [4/8].
> > 
> > Now:
> >   pcie_port_acpi_setup()
> >   {
> >     flags = A|B|C|D;
> >     acpi_pci_osc_control_query(handle, &flags);
> >     /* note: flags might be changed after query */
> >     acpi_pci_osc_control_set(handle, flags);
> >   }
> > 
> > Strictly, it could be like:
> > 
> > New:
> >   pcie_port_acpi_setup()
> >   {
> >     flags = A|B|C|D;
> >     do {
> >       pre_flags = flags;
> >       acpi_pci_osc_control_query(handle, &flags);
> >     } while (flags && pre_flags != flags);
> >     if (flags)
> >       acpi_pci_osc_control_set(handle, flags);
> >   }
> > 
> > IMHO these checks are kind of preventive guard for corner cases,
> > and I suppose it can be implemented by an incremental patch later.
> 
> OK
> 
> The assumption here is that the BIOS would only mask the bits it's not
> going to grant control of and will do it in a consistent way.  So, I guess the
> purpose of the change above would be to protect us from buggy BIOSes.

What about the appended patch (on top of 4/8)?

Rafael


---
 drivers/pci/pcie/portdrv_acpi.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/pci/pcie/portdrv_acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_acpi.c
+++ linux-2.6/drivers/pci/pcie/portdrv_acpi.c
@@ -35,7 +35,7 @@ int pcie_port_acpi_setup(struct pci_dev 
 {
 	acpi_status status;
 	acpi_handle handle;
-	u32 flags;
+	u32 flags, prev_flags = 0;
 
 	if (acpi_pci_disabled)
 		return 0;
@@ -55,11 +55,14 @@ int pcie_port_acpi_setup(struct pci_dev 
 			flags |= OSC_PCI_EXPRESS_AER_CONTROL;
 	}
 
-	status = acpi_pci_osc_control_query(handle, &flags);
-	if (ACPI_FAILURE(status)) {
-		dev_dbg(&port->dev, "ACPI _OSC query failed (code %d)\n",
-			status);
-		return -ENODEV;
+	while (flags != prev_flags) {
+		prev_flags = flags;
+		status = acpi_pci_osc_control_query(handle, &flags);
+		if (ACPI_FAILURE(status)) {
+			dev_dbg(&port->dev,
+				"ACPI _OSC query failed (code %d)\n", status);
+			return -ENODEV;
+		}
 	}
 
 	if (!(flags & OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)) {
