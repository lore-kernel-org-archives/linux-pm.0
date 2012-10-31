From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/5] ACPI / ia64: Export acpi_[un]register_gsi()
Date: Wed, 31 Oct 2012 10:35:03 +0100
Message-ID: <4658357.W5N4FrsF71@vostro.rjw.lan>
References: <1421417.rIOjExM5Pt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:48193 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753056Ab2JaJe7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 31 Oct 2012 05:34:59 -0400
In-Reply-To: <1421417.rIOjExM5Pt@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lv Zheng <lv.zheng@intel.com>, Huang Ying <ying.huang@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86 list <x86@kernel.org>, Tony Luck <tony.luck@intel.com>

From: Mika Westerberg <mika.westerberg@linux.intel.com>

These functions might be called from modules as well so make sure
they are exported.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/ia64/kernel/acpi.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux/arch/ia64/kernel/acpi.c
===================================================================
--- linux.orig/arch/ia64/kernel/acpi.c
+++ linux/arch/ia64/kernel/acpi.c
@@ -633,6 +633,7 @@ int acpi_register_gsi(struct device *dev
 				      ACPI_EDGE_SENSITIVE) ? IOSAPIC_EDGE :
 				     IOSAPIC_LEVEL);
 }
+EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
 void acpi_unregister_gsi(u32 gsi)
 {
@@ -644,6 +645,7 @@ void acpi_unregister_gsi(u32 gsi)
 
 	iosapic_unregister_intr(gsi);
 }
+EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
 
 static int __init acpi_parse_fadt(struct acpi_table_header *table)
 {

