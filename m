From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] PM / devfreq: Fix static checker warning in try_then_request_governor
Date: Tue, 16 Oct 2018 12:02:03 +0200
Message-ID: <20181016100203.18624-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The patch 23c7b54ca1cd: "PM / devfreq: Fix devfreq_add_device() when
drivers are built as modules." leads to the following static checker
warning:

    drivers/devfreq/devfreq.c:1043 governor_store()
    warn: 'governor' can also be NULL

The reason is that the try_then_request_governor() function returns both
error pointers and NULL. It should just return error pointers, so fix
this by returning a ERR_PTR to the error intead of returning NULL.

Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 62ead442a872..b10124c7308f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -231,7 +231,7 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
  * if is not found. This can happen when both drivers (the governor driver
  * and the driver that call devfreq_add_device) are built as modules.
  * devfreq_list_lock should be held by the caller. Returns the matched
- * governor's pointer.
+ * governor's pointer or an error pointer.
  */
 static struct devfreq_governor *try_then_request_governor(const char *name)
 {
@@ -257,7 +257,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 		/* Restore previous state before return */
 		mutex_lock(&devfreq_list_lock);
 		if (err)
-			return NULL;
+			return ERR_PTR(err);
 
 		governor = find_devfreq_governor(name);
 	}
-- 
2.19.1
