From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.19] deprecate PM_LEGACY, default it to N
Date: Tue, 5 Dec 2006 03:07:38 -0800
Message-ID: <200612050307.39157.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Deprecate the old "legacy" PM API, and more importantly default it to "n".
Virtually nothing in-tree uses it any more.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: at91/kernel/power/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/kernel/power/Kconfig	2006-09-30 19:16:37.000000000 -0700
+++ at91/kernel/power/Kconfig	2006-12-04 05:13:59.000000000 -0800
@@ -20,13 +20,14 @@ config PM
 	  sending the processor to sleep and saving power.
 =

 config PM_LEGACY
-	bool "Legacy Power Management API"
+	bool "Legacy Power Management API (DEPRECATED)"
 	depends on PM
-	default y
+	default n
 	---help---
-	   Support for pm_register() and friends.
+	   Support for pm_register() and friends.  This old API is obsoleted
+	   by the driver model.
 =

-	   If unsure, say Y.
+	   If unsure, say N.
 =

 config PM_DEBUG
 	bool "Power Management Debug Support"
