From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH] MAINTAINERS: Fix linux-pm address
Date: Thu, 19 Jan 2012 15:18:02 +0200
Message-ID: <1326979082-4485-1-git-send-email-amiettinen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Current linux-pm mailing list address seems to be
linux-pm@lists.linux-foundation.org.

Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
---
 MAINTAINERS |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56818fe..6038cb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2805,7 +2805,7 @@ F:	fs/freevxfs/
 FREEZER
 M:	Pavel Machek <pavel@ucw.cz>
 M:	"Rafael J. Wysocki" <rjw@sisk.pl>
-L:	linux-pm@vger.kernel.org
+L:	linux-pm@lists.linux-foundation.org
 S:	Supported
 F:	Documentation/power/freezing-of-tasks.txt
 F:	include/linux/freezer.h
@@ -3083,7 +3083,7 @@ F:	drivers/video/hgafb.c
 HIBERNATION (aka Software Suspend, aka swsusp)
 M:	Pavel Machek <pavel@ucw.cz>
 M:	"Rafael J. Wysocki" <rjw@sisk.pl>
-L:	linux-pm@vger.kernel.org
+L:	linux-pm@lists.linux-foundation.org
 S:	Supported
 F:	arch/x86/power/
 F:	drivers/base/power/
@@ -3296,7 +3296,7 @@ F:	drivers/ide/ide-cd*
 
 IDLE-I7300
 M:	Andy Henroid <andrew.d.henroid@intel.com>
-L:	linux-pm@vger.kernel.org
+L:	linux-pm@lists.linux-foundation.org
 S:	Supported
 F:	drivers/idle/i7300_idle.c
 
@@ -3379,7 +3379,7 @@ F:	firmware/isci/
 
 INTEL IDLE DRIVER
 M:	Len Brown <lenb@kernel.org>
-L:	linux-pm@vger.kernel.org
+L:	linux-pm@lists.linux-foundation.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-idle-2.6.git
 S:	Supported
 F:	drivers/idle/intel_idle.c
@@ -3476,7 +3476,7 @@ F:	drivers/net/ethernet/intel/
 
 INTEL MRST PMU DRIVER
 M:	Len Brown <len.brown@intel.com>
-L:	linux-pm@vger.kernel.org
+L:	linux-pm@lists.linux-foundation.org
 S:	Supported
 F:	arch/x86/platform/mrst/pmu.*
 
@@ -6469,7 +6469,7 @@ SUSPEND TO RAM
 M:	Len Brown <len.brown@intel.com>
 M:	Pavel Machek <pavel@ucw.cz>
 M:	"Rafael J. Wysocki" <rjw@sisk.pl>
-L:	linux-pm@vger.kernel.org
+L:	linux-pm@lists.linux-foundation.org
 S:	Supported
 F:	Documentation/power/
 F:	arch/x86/kernel/acpi/
-- 
1.7.4.1
