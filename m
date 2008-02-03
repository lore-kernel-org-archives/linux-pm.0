From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] Documentation: Feature removal: Add
	deprecation of some hibernation ioctls
Date: Sun, 3 Feb 2008 22:59:03 +0100
Message-ID: <200802032259.04260.rjw__1572.51969581029$1202076264$gmane$org@sisk.pl>
References: <200802032252.04852.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802032252.04852.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Harvey Harrison <harvey.harrison@gmail.com>

Let this appear as deprecated in 2.6.25, remove after three
releases (2.6.28).

[rjw: Say that I will be removing the features and give the
reason for the SNAPSHOT_SET_SWAP_FILE ioctl deprecation.]

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/feature-removal-schedule.txt |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Index: linux-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6/Documentation/feature-removal-schedule.txt
@@ -338,3 +338,28 @@ Why:	The support code for the old firmwa
 	and slightly hurts runtime performance. Bugfixes for the old firmware
 	are not provided by Broadcom anymore.
 Who:	Michael Buesch <mb@bu3sch.de>
+
+---------------------------
+
+What:	SNAPSHOT_PMOPS ioctl
+When:	2.6.28
+Why:	Badly designed interface, obsoleted by SNAPSHOT_PLATFORM_SUPPORT and
+	SNAPSHOT_POWER_OFF.
+Who:	Rafael J. Wysocki <rjw@sisk.pl>
+
+---------------------------
+
+What:	SNAPSHOT_SET_SWAP_FILE ioctl
+When:	2.6.28
+Why:	Obsoleted by SNAPSHOT_SET_SWAP_AREA which is more flexible.
+Who:	Rafael J. Wysocki <rjw@sisk.pl>
+
+---------------------------
+
+What:	SNAPSHOT_ATOMIC_SNAPSHOT, SNAPSHOT_AVAIL_SWAP, SNAPSHOT_GET_SWAP_PAGE ioctls
+When:	2.6.28
+Why:	Defined in a non-portable manner, new numbers introduced, old numbers
+	deprecated.
+Who:	Rafael J. Wysocki <rjw@sisk.pl>
+
+---------------------------
