From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [patch 2/2] cpuidle: update the last_state acpi cpuidle
	reflecting actual state entered
Date: Mon, 29 Sep 2008 15:24:28 -0700
Message-ID: <20080929222752.788171000@intel.com>
References: <20080929222426.914988000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=acpi_cpuidle_driver_set_last_state.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: lenb@kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

reflect the actual state entered in dev->last_state, when actaul state entered
is different from intended one.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

---
 drivers/acpi/processor_idle.c |    1 +
 1 file changed, 1 insertion(+)

Index: tip/drivers/acpi/processor_idle.c
===================================================================
--- tip.orig/drivers/acpi/processor_idle.c	2008-09-23 11:40:50.000000000 -0700
+++ tip/drivers/acpi/processor_idle.c	2008-09-23 14:22:48.000000000 -0700
@@ -1587,6 +1587,7 @@ static int acpi_idle_enter_bm(struct cpu
 
 	if (acpi_idle_bm_check()) {
 		if (dev->safe_state) {
+			dev->last_state = dev->safe_state;
 			return dev->safe_state->enter(dev, dev->safe_state);
 		} else {
 			local_irq_disable();

-- 
