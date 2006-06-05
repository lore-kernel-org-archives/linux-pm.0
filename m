From: David Brownell <david-b@pacbell.net>
Subject: [patch/rft 2.6.17-rc5-git 3/6] PM_EVENT_PRETHAW,
	handle in IDE and PCI
Date: Mon, 5 Jun 2006 09:38:23 -0700
Message-ID: <200606050938.23356.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<20060527163837.GE4242@ucw.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/3FhEqrd372CAQu"
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_/3FhEqrd372CAQu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Convert some framework code to handle the new PRETHAW message.

  - IDE just treats it like a FREEZE.

  - The pci_choose_state() thingie still doesn't use PCI_D0 when it gets a
    FREEZE (and now PRETHAW) event, which seems rather buglike but wasn't
    something to change with this patch.

Of course PCI drivers don't need to use pci_choose_state().
---
 drivers/ide/ide.c |    6 ++++--
 drivers/pci/pci.c |    4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)


--Boundary-00=_/3FhEqrd372CAQu
Content-Type: text/x-diff;
  charset="us-ascii";
  name="prethaw-fw.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="prethaw-fw.patch"

Convert some framework code to handle the new PRETHAW message.

  - IDE just treats it like a FREEZE.

  - The pci_choose_state() thingie still doesn't use PCI_D0 when it gets a
    FREEZE (and now PRETHAW) event, which seems rather buglike but wasn't
    something to change with this patch.

---
 drivers/ide/ide.c |    6 ++++--
 drivers/pci/pci.c |    4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

Index: g26/drivers/ide/ide.c
===================================================================
--- g26.orig/drivers/ide/ide.c	2006-06-02 18:08:30.000000000 -0700
+++ g26/drivers/ide/ide.c	2006-06-02 18:11:27.000000000 -0700
@@ -1213,7 +1213,7 @@ int system_bus_clock (void)
 
 EXPORT_SYMBOL(system_bus_clock);
 
-static int generic_ide_suspend(struct device *dev, pm_message_t state)
+static int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 {
 	ide_drive_t *drive = dev->driver_data;
 	struct request rq;
@@ -1227,7 +1227,9 @@ static int generic_ide_suspend(struct de
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
-	rqpm.pm_state = state.event;
+	if (mesg.event == PM_EVENT_PRETHAW)
+		mesg.event = PM_EVENT_FREEZE;
+	rqpm.pm_state = mesg.event;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
Index: g26/drivers/pci/pci.c
===================================================================
--- g26.orig/drivers/pci/pci.c	2006-06-02 18:11:20.000000000 -0700
+++ g26/drivers/pci/pci.c	2006-06-02 18:11:27.000000000 -0700
@@ -424,10 +424,12 @@ pci_power_t pci_choose_state(struct pci_
 	case PM_EVENT_ON:
 		return PCI_D0;
 	case PM_EVENT_FREEZE:
+	case PM_EVENT_PRETHAW:
+		/* REVISIT both freeze and pre-thaw "should" use D0 */
 	case PM_EVENT_SUSPEND:
 		return PCI_D3hot;
 	default:
-		printk("They asked me for state %d\n", state.event);
+		printk("Unrecognized suspend event %d\n", state.event);
 		BUG();
 	}
 	return PCI_D0;

--Boundary-00=_/3FhEqrd372CAQu
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_/3FhEqrd372CAQu--
