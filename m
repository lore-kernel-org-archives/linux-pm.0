From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH] feature-removal: Document suspend/hibernate
	deprecations
Date: Thu, 31 Jan 2008 21:48:34 -0800
Message-ID: <1201844914.23523.84.camel__9247.11340708218$1201881037$gmane$org@brick>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Let this appear as deprecated in 2.6.25, remove after three
releases (2.6.28).

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
Something like this should be included if you are deprecating
userspace functionality.  I tried to come up with a useful
reason from your changelogs, but you should fill this in.

 Documentation/feature-removal-schedule.txt |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 181bff0..cb005de 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -354,3 +354,28 @@ Why:	The support code for the old firmware hurts code readability/maintainabilit
 	and slightly hurts runtime performance. Bugfixes for the old firmware
 	are not provided by Broadcom anymore.
 Who:	Michael Buesch <mb@bu3sch.de>
+
+---------------------------
+
+What:	SNAPSHOT_PMOPS ioctl
+When:	2.6.28
+Why:	Badly designed interface, obsoleted by SNAPSHOT_PLATFORM_SUPPORT and
+	SNAPSHOT_POWER_OFF
+Who:	Len Brown <len.brown@intel.com>
+
+---------------------------
+
+What:	SNAPSHOT_SET_SWAP_FILE ioctl
+When:	2.6.28
+Why:	Insert reason here
+Who:	Len Brown <len.brown@intel.com>
+
+---------------------------
+
+What:	SNAPSHOT_ATOMIC_SNAPSHOT, SNAPSHOT_AVAIL_SWAP, SNAPSHOT_GET_SWAP_PAGE ioctls
+When:	2.6.28
+Why:	Defined in a non-portable manner, new numbers introduced, old numbers
+	deprecated.
+Who:	Len Brown <len.brown@intel.com>
+
+---------------------------
-- 
1.5.4.rc4.1142.gf5a97
