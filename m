From: Steven Price <steven.price@arm.com>
Subject: [PATCH] PM / devfreq: return PTR_ERR not NULL in try_then_request_governor()
Date: Wed,  3 Apr 2019 16:26:02 +0100
Message-ID: <20190403152602.10019-1-steven.price@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Steven Price <steven.price@arm.com>
List-Id: linux-pm@vger.kernel.org

The callers of try_then_request_governor() only test for a PTR_ERR using
IS_ERR(). However in the case that request_module() fails then NULL is
currently returned which will cause a NULL-pointer dereference in the
caller.

Instead convert the error we already have to a valid PTR_ERR and return
it.

Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b..d29f66f0e52a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 		/* Restore previous state before return */
 		mutex_lock(&devfreq_list_lock);
 		if (err)
-			return NULL;
+			return ERR_PTR(err);
 
 		governor = find_devfreq_governor(name);
 	}
-- 
2.20.1
