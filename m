From: Len Brown <lenb@kernel.org>
Subject: [PATCH 51/76] cpuidle: remove unused 'governor_data' field
Date: Fri, 30 Mar 2012 06:13:54 -0400
Message-ID: <e07510585a88c0f6c6c728e2e006aa913496d4ae.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

As far as I can see, this field is never used in the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/cpuidle.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index f7f1d90..f3ebbba 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -98,7 +98,6 @@ struct cpuidle_device {
 	struct list_head 	device_list;
 	struct kobject		kobj;
 	struct completion	kobj_unregister;
-	void			*governor_data;
 };
 
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
-- 
1.7.10.rc2.19.gfae9d

