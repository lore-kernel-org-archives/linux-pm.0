From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 5/5 v2] PM / hibernate: An option to request that snapshot image must be authenticated
Date: Thu,  3 Jan 2019 22:32:27 +0800
Message-ID: <20190103143227.9138-6-jlee@suse.com>
References: <20190103143227.9138-1-jlee@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103143227.9138-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

This kernel option is similar to the option for kernel module signature
verification. When this option is unselected, kernel will be tainted by
restored from a snapshot image without (valid) signature.

When the option is selected, kernel will refuse the system to be restored
from a unauthenticated image. The hibernation resume process will be stopped
, the snapshot image will be discarded and system just boots as normal.

The hibernation can be triggered without snapshot master key when this
option is unselected. But kernel will be tainted after hibernation resume.

v2:
- Fixed wording in Kconfig

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++
 include/linux/kernel.h                          |  3 +-
 kernel/panic.c                                  |  1 +
 kernel/power/Kconfig                            | 11 +++++++
 kernel/power/hibernate.c                        |  8 +++--
 kernel/power/power.h                            |  5 ++++
 kernel/power/snapshot.c                         | 40 +++++++++++++++++++++++--
 kernel/power/user.c                             |  2 +-
 8 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 37e235be1d35..f103b5d4676f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3991,6 +3991,12 @@
 		protect_image	Turn on image protection during restoration
 				(that will set all pages holding image data
 				during restoration read-only).
+		enforce_auth	When HIBERNATION_ENC_AUTH is set, this means
+				that snapshot image without (valid) signature
+				will fail to restore.
+				Note that if HIBERNATION_ENC_AUTH_FORCE is
+				set, that is always true, so this option does
+				nothing.
 
 	retain_initrd	[RAM] Keep initrd memory after extraction
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75b51ba..61714489cb57 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -598,7 +598,8 @@ extern enum system_states {
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_UNSAFE_HIBERNATE		18
+#define TAINT_FLAGS_COUNT		19
 
 struct taint_flag {
 	char c_true;	/* character printed when tainted */
diff --git a/kernel/panic.c b/kernel/panic.c
index d10c340c43b0..7179c6d8d38f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -335,6 +335,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[ TAINT_UNSAFE_HIBERNATE ]	= { 'H', ' ', true },
 };
 
 /**
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 506a3c5a7a0d..cf1896c32014 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -90,6 +90,17 @@ config HIBERNATION_ENC_AUTH
 	  as the master key of hibernation. The TPM trusted key depends on TPM.
 	  The security of user defined key relies on user space.
 
+config HIBERNATION_ENC_AUTH_FORCE
+	bool "Require hibernate snapshot image to be validly signed"
+	depends on HIBERNATION_ENC_AUTH
+	help
+	  This option will prevent that a snapshot image without (valid)
+	  signature be restored. Without this option, an unauthenticated
+	  snapshot image can be restored but the restored kernel will be
+	  tainted, which also means that the hibernation can be triggered
+	  without snapshot key but kernel will be tainted without this
+	  option.
+
 config ARCH_SAVE_PAGE_KEYS
 	bool
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 5ac2ab6f4a0e..9515bad0897e 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -272,11 +272,11 @@ static int create_image(int platform_mode)
 	int error;
 
 	error = snapshot_prepare_hash(false);
-	if (error)
+	if (error && snapshot_is_enforce_auth())
 		return error;
 
 	error = snapshot_prepare_crypto(false, true);
-	if (error)
+	if (error && snapshot_is_enforce_auth())
 		goto finish_hash;
 
 	error = dpm_suspend_end(PMSG_FREEZE);
@@ -708,7 +708,7 @@ int hibernate(void)
 	}
 
 	error = snapshot_key_init();
-	if (error)
+	if (error && snapshot_is_enforce_auth())
 		return error;
 
 	error = snapshot_create_trampoline();
@@ -1248,6 +1248,8 @@ static int __init hibernate_setup(char *str)
 	} else if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)
 		   && !strncmp(str, "protect_image", 13)) {
 		enable_restore_image_protection();
+	} else if (!strncmp(str, "enforce_auth", 10)) {
+		snapshot_set_enforce_auth();
 	}
 	return 1;
 }
diff --git a/kernel/power/power.h b/kernel/power/power.h
index d2fc73b2e200..edb63991bcdc 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -36,6 +36,7 @@ struct swsusp_info {
 struct trampoline {
 	bool snapshot_key_valid;
 	int sig_verify_ret;
+	bool enforce_auth;
 	u8 snapshot_key[SNAPSHOT_KEY_SIZE];
 } __aligned(PAGE_SIZE);
 
@@ -51,6 +52,8 @@ extern int snapshot_prepare_crypto(bool may_sleep, bool create_iv);
 extern void snapshot_finish_crypto(void);
 extern int snapshot_prepare_hash(bool may_sleep);
 extern void snapshot_finish_hash(void);
+extern void snapshot_set_enforce_auth(void);
+extern int snapshot_is_enforce_auth(void);
 /* kernel/power/snapshot_key.c */
 extern int snapshot_key_init(void);
 extern bool snapshot_key_initialized(void);
@@ -65,6 +68,8 @@ static inline int snapshot_prepare_crypto(bool may_sleep, bool create_iv) { retu
 static inline void snapshot_finish_crypto(void) {}
 static inline int snapshot_prepare_hash(bool may_sleep) { return 0; }
 static inline void snapshot_finish_hash(void) {}
+static inline void snapshot_set_enforce_auth(void) {}
+static inline int snapshot_is_enforce_auth(void) { return 0; }
 static inline int snapshot_key_init(void) { return 0; }
 static inline void snapshot_key_trampoline_backup(struct trampoline *t) {}
 static inline void snapshot_key_trampoline_restore(struct trampoline *t) {}
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 80ed8e7c5ed8..03a76c474ab7 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1538,6 +1538,23 @@ static int decrypt_data_page(void *encrypted_page)
 	return ret;
 }
 
+/* enforce the snapshot to be signed */
+#ifdef CONFIG_HIBERNATION_ENC_AUTH_FORCE
+static bool enforce_auth = true;
+#else
+static bool enforce_auth;
+#endif
+
+void snapshot_set_enforce_auth(void)
+{
+	enforce_auth = true;
+}
+
+int snapshot_is_enforce_auth(void)
+{
+	return enforce_auth;
+}
+
 /*
  * Signature of snapshot image
  */
@@ -1604,6 +1621,8 @@ int snapshot_prepare_hash(bool may_sleep)
 	crypto_free_shash(tfm);
 	s4_verify_digest = NULL;
 	s4_verify_desc = NULL;
+	if (!enforce_auth)
+		ret = 0;
 	return ret;
 }
 
@@ -1665,6 +1684,8 @@ int snapshot_image_verify_decrypt(void)
 		pr_warn("Signature verification failed: %d\n", ret);
  error:
 	sig_verify_ret = ret;
+	if (!enforce_auth)
+		ret = 0;
 	return ret;
 }
 
@@ -1752,6 +1773,7 @@ static void load_signature(struct swsusp_info *info)
 
 static void init_sig_verify(struct trampoline *t)
 {
+	t->enforce_auth = enforce_auth;
 	t->sig_verify_ret = sig_verify_ret;
 	t->snapshot_key_valid = snapshot_key_valid;
 	sig_verify_ret = 0;
@@ -1760,11 +1782,25 @@ static void init_sig_verify(struct trampoline *t)
 
 static void handle_sig_verify(struct trampoline *t)
 {
-	if (t->sig_verify_ret)
+	enforce_auth = t->enforce_auth;
+	if (enforce_auth)
+		pr_info("Enforce the snapshot to be validly signed\n");
+
+	if (t->sig_verify_ret) {
 		pr_warn("Signature verification failed: %d\n",
 			t->sig_verify_ret);
-	else if (t->snapshot_key_valid)
+		if (t->snapshot_key_valid)
+			pr_warn("Did not find valid snapshot key.\n");
+		/* taint kernel */
+		if (!enforce_auth) {
+			pr_warn("System resumed from unsafe snapshot - "
+				"tainting kernel\n");
+			add_taint(TAINT_UNSAFE_HIBERNATE, LOCKDEP_STILL_OK);
+			pr_info("%s\n", print_tainted());
+		}
+	} else if (t->snapshot_key_valid) {
 		pr_info("Signature verification passed.\n");
+	}
 }
 #else
 static int
diff --git a/kernel/power/user.c b/kernel/power/user.c
index d5c8f777e8d8..9597f48f01d0 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -261,7 +261,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			break;
 		}
 		error = snapshot_key_init();
-		if (error)
+		if (error && snapshot_is_enforce_auth())
 			return error;
 		error = snapshot_create_trampoline();
 		if (error)
-- 
2.13.6
