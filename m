From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/52] ACPI: remove acpi_pad MAINTAINERS entry
Date: Tue, 24 Jul 2012 23:41:24 -0400
Message-ID: <442f24ace6c5991df2a9ab49fe0273b79b145d19.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

As Shaohua is no longer in this neck of the woods,
and thus treat the acpi_pad driver as just another
part of drivers/acpi/

Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14bc707..508a935 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -242,13 +242,6 @@ W:	http://www.lesswatts.org/projects/acpi/
 S:	Supported
 F:	drivers/acpi/fan.c
 
-ACPI PROCESSOR AGGREGATOR DRIVER
-M:	Shaohua Li <shaohua.li@intel.com>
-L:	linux-acpi@vger.kernel.org
-W:	http://www.lesswatts.org/projects/acpi/
-S:	Supported
-F:	drivers/acpi/acpi_pad.c
-
 ACPI THERMAL DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
-- 
1.7.12.rc0
