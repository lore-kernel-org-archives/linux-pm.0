From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/5] acpi_idle: add missing \n to printk
Date: Tue, 28 Sep 2010 23:53:07 -0400
Message-ID: <e9a64ed4994db04c9963495b03d8a86538e3ad55.1285732130.git.len.brown@intel.com>
References: <1285732387-18629-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1285732387-18629-1-git-send-email-lenb@kernel.org>
In-reply-to: <4731fdcf6f7bdab3e369a3f844d4ea4d4017284d.1285732130.git.len.brown@intel.com>
References: <4731fdcf6f7bdab3e369a3f844d4ea4d4017284d.1285732130.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

otherwise, these two lines print as one:

ACPI: acpi_idle yielding to intel_idle
ACPI: SSDT 3f5d8741 00203 (v02 PmRef  Cpu0Ist 00003000 INTL 20050624)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_driver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 1560218..347eb21 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -850,7 +850,7 @@ static int __init acpi_processor_init(void)
 		printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
 			acpi_idle_driver.name);
 	} else {
-		printk(KERN_DEBUG "ACPI: acpi_idle yielding to %s",
+		printk(KERN_DEBUG "ACPI: acpi_idle yielding to %s\n",
 			cpuidle_get_driver()->name);
 	}
 
-- 
1.7.3.2.g9027fa
