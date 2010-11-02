From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] intel_idle: Do not load if user overrides idle
	function via idle= boot param
Date: Tue, 2 Nov 2010 14:41:08 +0100
Message-ID: <201011021441.09258.trenn__31708.4984657869$1288705457$gmane$org@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Len,

I found that by review, it's compile tested only.
Could you give this a review and apply if appropriate.

Thanks,

     Thomas

----

if idle= boot param is passed, cpuidle drivers should not register
and only arch specific idle routines should get active.

Ideally cpuidle subsystem would be made aware of this.
But acpi parses sleep state tables before registering for cpuidle
which should not happen if idle= is passed.

-> Check for boot_option_idle_override in cpuidle drivers, not
cpuidle subsystem.

Compare with:
arch/x86/kernel/process.c
and
drivers/acpi/processor_idle.c

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: lenb@kernel.org
CC: linux-acpi@vger.kernel.org
CC: stable@kernel.org
CC: linux-pm@lists.linux-foundation.org                                                                                                                               
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 41665d2..e50389b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -410,6 +410,9 @@ static int __init intel_idle_init(void)
 {
 	int retval;
 
+	if (boot_option_idle_override)
+		return -ENODEV;
+
 	retval = intel_idle_probe();
 	if (retval)
 		return retval;
