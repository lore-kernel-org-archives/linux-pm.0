From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/5] intel_idle: disable module support
Date: Sun, 15 Aug 2010 01:22:03 -0400
Message-ID: <6ce9cd8669fa1195fdc21643370e34523c7ac988.1281849655.git.len.brown__10811.3304981545$1281849793$gmane$org@intel.com>
References: <1281849725-7379-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1281849725-7379-1-git-send-email-lenb@kernel.org>
In-reply-to: <0394c6676e3fa48587fbe4821390d3264672c530.1281849655.git.len.brown@intel.com>
References: <0394c6676e3fa48587fbe4821390d3264672c530.1281849655.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Right now the module capability is cauing more trouble
than it is worth.  At least one distro built intel_idle as a module
where it lost the init race with ACPI, making it useless.

Make intel_idle bool so that if you select it, you will use it.

We can restore module capability after cpuidle is enhanced
to handle run-time changing of idle drivers.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/idle/Kconfig b/drivers/idle/Kconfig
index fb5c518..82e4e86 100644
--- a/drivers/idle/Kconfig
+++ b/drivers/idle/Kconfig
@@ -1,5 +1,5 @@
 config INTEL_IDLE
-	tristate "Cpuidle Driver for Intel Processors"
+	bool "Cpuidle Driver for Intel Processors"
 	depends on CPU_IDLE
 	depends on X86
 	depends on CPU_SUP_INTEL
-- 
1.7.2.1.95.g3d045
