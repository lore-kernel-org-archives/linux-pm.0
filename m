From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / QoS: Drop redundant declaration of pm_qos_get_value()
Date: Fri, 25 May 2018 12:33:10 +0200
Message-ID: <2434181.mvXUDI8C0e@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The extra forward declaration of pm_qos_get_value() is redundant, so
drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/qos.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/kernel/power/qos.c
===================================================================
--- linux-pm.orig/kernel/power/qos.c
+++ linux-pm/kernel/power/qos.c
@@ -184,7 +184,6 @@ static inline void pm_qos_set_value(stru
 	c->target_value = value;
 }
 
-static inline int pm_qos_get_value(struct pm_qos_constraints *c);
 static int pm_qos_dbg_show_requests(struct seq_file *s, void *unused)
 {
 	struct pm_qos_object *qos = (struct pm_qos_object *)s->private;
