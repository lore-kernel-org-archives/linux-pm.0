From: "Potenza, Leonardo" <leonardo.potenza@intel.com>
Subject: [PATCH] PM: export hibernation_set_ops
Date: Tue, 19 Nov 2013 12:27:41 +0000
Message-ID: <A03916A9EAE8D346B5F2093CCA95C34346489DC7@IRSMSX101.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Verplanke, Edwin" <edwin.verplanke@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Leonardo Potenza <leonardo.potenza@intel.com>

To support the ability to implement PM hibernation code as modules
the hibernation_set_ops function requires to be exported.

Similar solution already available for suspend_set_ops
(please refer to commit a5e4fd8783a2bec861ecf1138cdc042269ff59aa).

Signed-off-by: Leonardo Potenza <leonardo.potenza@intel.com>
Signed-off-by: Edwin Verplanke <edwin.verplanke@intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
Index: linux/kernel/power/hibernate.c
===================================================================
--- linux.orig/kernel/power/hibernate.c
+++ linux/kernel/power/hibernate.c
@@ -82,6 +82,7 @@ void hibernation_set_ops(const struct pl
 
 	unlock_system_sleep();
 }
+EXPORT_SYMBOL_GPL(hibernation_set_ops);
 
 static bool entering_platform_hibernation;

--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). Any review or distribution by others is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.
