From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH RESEND 2/4] thermal: remove unnecessary include
Date: Wed, 2 Jan 2013 17:29:40 +0200
Message-ID: <1357140582-8151-3-git-send-email-eduardo.valentin@ti.com>
References: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52784 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab3ABPaj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Jan 2013 10:30:39 -0500
In-Reply-To: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: durgadoss.r@intel.com, linux-pm@lists.linux-foundation.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

No need for spinlocks in this file, then removing its header.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/thermal_sys.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index d85f51f..70ce100 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -32,7 +32,6 @@
 #include <linux/kdev_t.h>
 #include <linux/idr.h>
 #include <linux/thermal.h>
-#include <linux/spinlock.h>
 #include <linux/reboot.h>
 #include <net/netlink.h>
 #include <net/genetlink.h>
-- 
1.7.7.1.488.ge8e1c

