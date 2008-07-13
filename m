From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: PCI PM: Fix pci_prepare_to_sleep
Date: Sun, 13 Jul 2008 22:45:06 +0200
Message-ID: <200807132245.07414.rjw__36123.9533326172$1215981874$gmane$org@sisk.pl>
References: <200807012356.26669.rjw@sisk.pl> <200807070330.02849.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807070330.02849.rjw@sisk.pl>
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
Cc: Zhao Yakui <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Jesse,

The recently introduced pci_prepare_to_sleep() needs the following fix,
because there are systems which are not power manageable by ACPI (ie. ACPI
doesn't provide methods to put the device into low power states and back), but
require ACPI hooks to be executed for wake-up to work.

Please apply.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

Fix pci_prepare_to_sleep() to work on systems that are not power
manageable by ACPI (ie. ACPI doesn't provide methods to put the
device into low power states and back into the full power state), but
require ACPI hooks to be executed for wake-up to work.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-next/drivers/pci/pci.c
===================================================================
--- linux-next.orig/drivers/pci/pci.c
+++ linux-next/drivers/pci/pci.c
@@ -1153,7 +1153,6 @@ int pci_prepare_to_sleep(struct pci_dev 
 				break;
 		default:
 			target_state = state;
-			pci_enable_wake(dev, target_state, true);
 		}
 	} else if (device_may_wakeup(&dev->dev)) {
 		/*
@@ -1168,10 +1167,11 @@ int pci_prepare_to_sleep(struct pci_dev 
 			while (target_state
 			      && !(dev->pme_support & (1 << target_state)))
 				target_state--;
-			pci_pme_active(dev, true);
 		}
 	}
 
+	pci_enable_wake(dev, target_state, true);
+
 	error = pci_set_power_state(dev, target_state);
 
 	if (error)
