From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] MAINTAINERS: Add myself as driver core changes reviewer
Date: Thu, 05 Jul 2018 12:27:53 +0200
Message-ID: <69592383.djb3pJg15x@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael@kernel.org>

I really need to look at driver core changes before they are applied
due to PM dependencies and they sometimes get lost in the LKML
traffic, so add myself as an official driver core reviewer.

Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -4460,6 +4460,7 @@ F:	Documentation/blockdev/drbd/
 
 DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+R:	"Rafael J. Wysocki" <rafael@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 S:	Supported
 F:	Documentation/kobject.txt
