From: Jochen Hein <jochen@jochen.org>
Subject: [PATCH] intel_idle: work around errate VLP52 on Baytrail CPUs
Date: Mon, 19 Dec 2016 19:19:57 +0100
Message-ID: <838trb233m.fsf@echidna.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.dinoex.de ([188.40.204.4]:35618 "EHLO smtp.dinoex.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932679AbcLSSwP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Dec 2016 13:52:15 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Vincent Gerris <vgerris@gmail.com>, linux-pm@vger.kernel.org


There are frequent hangs on Baytrail CPUs according to
https://bugzilla.kernel.org/show_bug.cgi?id=109051.
This patch works around the errata by disabling C6.

According to the discussion in the bug and private mail it might be
useful to include the workaround in mainline.

Signed-off-by: Jochen Hein <jochen@jochen.org>
Cc: stable@vger.kernel.org

--- linux-4.7.5/drivers/idle/intel_idle.c.orig	2016-09-24 10:10:18.000000000 +0200
+++ linux-4.7.5/drivers/idle/intel_idle.c	2016-10-16 07:36:51.142862573 +0200
@@ -1210,6 +1210,34 @@
 
 }
 /*
+ * byt_idle_state_table_update(void)
+ *
+ * On BYT, we have errata VLP52 and disable C6.
+ * https://bugzilla.kernel.org/show_bug.cgi?id=109051A
+ * http://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/pentium-n3520-j2850-celeron-n2920-n2820-n2815-n2806-j1850-j1750-spec-update.pdf
+ * VLP52 EOI Transactions May Not be Sent if Software Enters Core C6 During an Interrupt Service Routine.
+
+Problem:
+If core C6 is entered after the start of an interrupt service routine but before a write
+to the APIC EOI (End of Interrupt) register, and the core is woken up by an event
+other than a fixed interrupt source the core may drop the EOI transaction the next
+time APIC EOI register is written and further interrupts from the same or lower
+priority level will be blocked.
+
+Implication:
+EOI transactions may be lost and interrupts may be blocked when core C6 is used
+during interrupt service routines.
+
+Workaround:
+It is possible for the firmware to contain a workaround for this erratum.
+ */
+static void byt_idle_state_table_update(void)
+{
+	printk(PREFIX "byt_idle_state_table_update reached\n");
+	byt_cstates[1].disabled = 1;	/* C6N-BYT */
+	byt_cstates[2].disabled = 1;	/* C6S-BYT */
+}
+/*
  * sklh_idle_state_table_update(void)
  *
  * On SKL-H (model 0x5e) disable C8 and C9 if:
@@ -1264,6 +1292,10 @@
 	case 0x3e: /* IVT */
 		ivt_idle_state_table_update();
 		break;
+	case 0x37: /* BYT */
+		printk(PREFIX "intel_idle_state_table_update BYT 0x37 reached\n");
+		byt_idle_state_table_update();
+		break;
 	case 0x5c: /* BXT */
 		bxt_idle_state_table_update();
 		break;

-- 
The only problem with troubleshooting is that the trouble shoots back.

