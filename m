From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] PowerCap: Fix an error code in powercap_register_zone()
Date: Wed, 10 May 2017 22:40:06 +0300
Message-ID: <20170510194006.vsr5r5eyvjry4cka@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In the current code we accidentally return the successful result from
idr_alloc() instead of a negative error pointer.  The caller is looking
for an error pointer and so it treats the returned value as a valid
pointer.

This one might be a bit serious because if it lets people get around the
kernel's protection for remapping NULL.  I'm not sure.

Fixes: 75d2364ea0ca ("PowerCap: Add class driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 14bde0db8c24..5b10b50f8686 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -538,6 +538,7 @@ struct powercap_zone *powercap_register_zone(
 
 	power_zone->id = result;
 	idr_init(&power_zone->idr);
+	result = -ENOMEM;
 	power_zone->name = kstrdup(name, GFP_KERNEL);
 	if (!power_zone->name)
 		goto err_name_alloc;
