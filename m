From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/4][v2] PM / hibernate: Check the success of generating md5 digest before hibernation
Date: Wed, 12 Sep 2018 01:20:36 +0800
Message-ID: <afb1c18493fa3fb891a37752161e9f73a46fc2df.1536685746.git.yu.c.chen@intel.com>
References: <cover.1536685746.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536685746.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Rui Zhang <rui.zhang@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Zhimin Gu <kookoo.gu@intel.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

Currently if get_e820_md5() fails, then it will hibernate nevertheless.
Actually the error code should be propagated to upper caller so that
the hibernation could be aware of the result and terminates the process
if md5 digest fails.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_64.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index f8e3b668d20b..dc12dc57889e 100644
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
@@ -306,6 +307,7 @@ static bool hibernation_e820_mismatch(void *buf)
 int arch_hibernation_header_save(void *addr, unsigned int max_size)
 {
 	struct restore_data_record *rdr = addr;
+	int ret = -EINVAL;
 
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
@@ -333,7 +335,9 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 
 	rdr->magic = RESTORE_MAGIC;
 
-	hibernation_e820_save(rdr->e820_digest);
+	ret = hibernation_e820_save(rdr->e820_digest);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.17.1
