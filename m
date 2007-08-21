From: Adam Belay <abelay@novell.com>
Subject: [PATCH 4/6] CPUIDLE: max_cstate fix
Date: Tue, 21 Aug 2007 18:25:58 -0400
Message-ID: <1187735158.7199.52.camel__43486.1413007185$1187740250$gmane$org@callisto.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brown@smtp2.linux-foundation.org, Len <len.brown@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Currently max_cstate is limited to 0, resulting in no idle processor
power management on ACPI platforms.  This patch restores the value to
the array size.

Please Apply,
Adam

Change Summary:
 processor_idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---

diff -urN a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c	2007-08-14 15:53:48.000000000 -0400
+++ b/drivers/acpi/processor_idle.c	2007-08-14 16:00:48.000000000 -0400
@@ -67,7 +67,7 @@
 #define C2_OVERHEAD			1	/* 1us */
 #define C3_OVERHEAD			1	/* 1us */
 
-static unsigned int max_cstate __read_mostly;
+static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
 module_param(max_cstate, uint, 0000);
 static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);
