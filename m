From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 02/12][RFC v3] PM / hibernate: Check the success of generating md5 digest before hibernation
Date: Wed, 19 Sep 2018 15:38:17 +0800
Message-ID: <f50baa939e550d4c6e09fd15ed2c0ddb0b23b023.1537275915.git.yu.c.chen@intel.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Yu Chen <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

Currently if get_e820_md5() fails, then it will hibernate nevertheless.
Actually the error code should be propagated to upper caller so that
the hibernation could be aware of the result and terminates the process
if md5 digest fails.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_64.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index f8e3b668d20b..e0de959ad02d 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -265,9 +265,9 @@ static int get_e820_md5(struct e820_table *table, void *buf)
 	return ret;
 }
 
-static void hibernation_e820_save(void *buf)
+static int hibernation_e820_save(void *buf)
 {
-	get_e820_md5(e820_table_firmware, buf);
+	return get_e820_md5(e820_table_firmware, buf);
 }
 
 static bool hibernation_e820_mismatch(void *buf)
@@ -287,8 +287,9 @@ static bool hibernation_e820_mismatch(void *buf)
 	return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
 }
 #else
-static void hibernation_e820_save(void *buf)
+static int hibernation_e820_save(void *buf)
 {
+	return 0;
 }
 
 static bool hibernation_e820_mismatch(void *buf)
@@ -333,9 +334,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 
 	rdr->magic = RESTORE_MAGIC;
 
-	hibernation_e820_save(rdr->e820_digest);
-
-	return 0;
+	return hibernation_e820_save(rdr->e820_digest);
 }
 
 /**
-- 
2.17.1
