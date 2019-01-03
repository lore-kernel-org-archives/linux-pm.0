From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 4/5 v2] PM / hibernate: Erase the snapshot master key in snapshot pages
Date: Thu,  3 Jan 2019 22:32:26 +0800
Message-ID: <20190103143227.9138-5-jlee@suse.com>
References: <20190103143227.9138-1-jlee@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103143227.9138-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

If the encryption key be guessed then the snapshot master key can
also be grabbed from snapshot image. Which means that the authentication
key can also be calculated. So kernel erases master key in snapshot
pages.

Because the master key in image kernel be erased, kernel uses the
trampoline page to forward snapshot master key to image kernel.

v2:
- Add memory barrier after cleaning key initialized flag.

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
 kernel/power/power.h        |  6 ++++
 kernel/power/snapshot.c     |  5 ++++
 kernel/power/snapshot_key.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index 41263fdd3a54..d2fc73b2e200 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -36,6 +36,7 @@ struct swsusp_info {
 struct trampoline {
 	bool snapshot_key_valid;
 	int sig_verify_ret;
+	u8 snapshot_key[SNAPSHOT_KEY_SIZE];
 } __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_HIBERNATION
@@ -55,6 +56,9 @@ extern int snapshot_key_init(void);
 extern bool snapshot_key_initialized(void);
 extern int snapshot_get_auth_key(u8 *auth_key, bool may_sleep);
 extern int snapshot_get_enc_key(u8 *enc_key, bool may_sleep);
+extern void snapshot_key_page_erase(unsigned long pfn, void *buff_addr);
+extern void snapshot_key_trampoline_backup(struct trampoline *t);
+extern void snapshot_key_trampoline_restore(struct trampoline *t);
 #else
 static inline int snapshot_image_verify_decrypt(void) { return 0; }
 static inline int snapshot_prepare_crypto(bool may_sleep, bool create_iv) { return 0; }
@@ -62,6 +66,8 @@ static inline void snapshot_finish_crypto(void) {}
 static inline int snapshot_prepare_hash(bool may_sleep) { return 0; }
 static inline void snapshot_finish_hash(void) {}
 static inline int snapshot_key_init(void) { return 0; }
+static inline void snapshot_key_trampoline_backup(struct trampoline *t) {}
+static inline void snapshot_key_trampoline_restore(struct trampoline *t) {}
 #endif	/* !CONFIG_HIBERNATION_ENC_AUTH */
 
 #ifdef CONFIG_ARCH_HIBERNATION_HEADER
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index cd10ab5e4850..80ed8e7c5ed8 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1697,6 +1697,9 @@ __copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
 			crypto_buffer = page_address(d_page);
 		}
 
+		/* Erase key data in snapshot */
+		snapshot_key_page_erase(pfn, crypto_buffer);
+
 		/* Encrypt hashed page */
 		encrypt_data_page(crypto_buffer);
 
@@ -2482,6 +2485,7 @@ void snapshot_init_trampoline(void)
 	t = (struct trampoline *)trampoline_buff;
 
 	init_sig_verify(t);
+	snapshot_key_trampoline_backup(t);
 
 	pr_info("Hibernation trampoline page prepared\n");
 }
@@ -2505,6 +2509,7 @@ void snapshot_restore_trampoline(void)
 	t = (struct trampoline *)trampoline_virt;
 
 	handle_sig_verify(t);
+	snapshot_key_trampoline_restore(t);
 	snapshot_free_trampoline();
 }
 
diff --git a/kernel/power/snapshot_key.c b/kernel/power/snapshot_key.c
index 3a569b505d8d..9d478c27d6b9 100644
--- a/kernel/power/snapshot_key.c
+++ b/kernel/power/snapshot_key.c
@@ -29,11 +29,27 @@ static struct snapshot_key {
 	const char *key_name;
 	bool initialized;
 	unsigned int key_len;
+	unsigned long pfn;			/* pfn of keyblob */
+	unsigned long addr_offset;		/* offset in page for keyblob */
 	u8 key[SNAPSHOT_KEY_SIZE];
+	u8 fingerprint[SHA512_DIGEST_SIZE];	/* fingerprint of keyblob */
 } skey = {
 	.key_name = "swsusp-kmk",
 };
 
+static void snapshot_key_clean(void)
+{
+	crypto_free_shash(hash_tfm);
+	hash_tfm = NULL;
+	skey.initialized = false;
+	barrier();
+	skey.pfn = 0;
+	skey.key_len = 0;
+	skey.addr_offset = 0;
+	memzero_explicit(skey.key, SNAPSHOT_KEY_SIZE);
+	memzero_explicit(skey.fingerprint, SHA512_DIGEST_SIZE);
+}
+
 static int calc_hash(u8 *digest, const u8 *buf, unsigned int buflen,
 		     bool may_sleep)
 {
@@ -81,6 +97,53 @@ static int calc_key_hash(u8 *key, unsigned int key_len, const char *salt,
 	return ret;
 }
 
+static int get_key_fingerprint(u8 *fingerprint, u8 *key, unsigned int key_len,
+				bool may_sleep)
+{
+	return calc_key_hash(key, key_len, "FINGERPRINT", fingerprint, may_sleep);
+}
+
+void snapshot_key_page_erase(unsigned long pfn, void *buff_addr)
+{
+	if (!skey.initialized || pfn != skey.pfn)
+		return;
+
+	/* erase key data from snapshot buffer page */
+	if (!memcmp(skey.key, buff_addr + skey.addr_offset, skey.key_len)) {
+		memzero_explicit(buff_addr + skey.addr_offset, skey.key_len);
+		pr_info("Erased swsusp key in snapshot pages.\n");
+	}
+}
+
+/* this function may sleeps because snapshot_key_init() */
+void snapshot_key_trampoline_backup(struct trampoline *t)
+{
+	if (!t || snapshot_key_init())
+		return;
+
+	memcpy(t->snapshot_key, skey.key, skey.key_len);
+}
+
+/* Be called after snapshot image restored success */
+void snapshot_key_trampoline_restore(struct trampoline *t)
+{
+	u8 fingerprint[SHA512_DIGEST_SIZE];
+
+	if (!skey.initialized || !t)
+		return;
+
+	/* check key fingerprint before restore */
+	get_key_fingerprint(fingerprint, t->snapshot_key, skey.key_len, true);
+	if (memcmp(skey.fingerprint, fingerprint, SHA512_DIGEST_SIZE)) {
+		pr_warn("Restored swsusp key failed, fingerprint mismatch.\n");
+		snapshot_key_clean();
+		return;
+	}
+
+	memcpy(skey.key, t->snapshot_key, skey.key_len);
+	memzero_explicit(t->snapshot_key, SNAPSHOT_KEY_SIZE);
+}
+
 /* Derive authentication/encryption key */
 static int get_derived_key(u8 *derived_key, const char *derived_type_str,
 			   bool may_sleep)
@@ -230,10 +293,14 @@ int snapshot_key_init(void)
 	if (err)
 		goto key_fail;
 
+	skey.pfn = page_to_pfn(virt_to_page(skey.key));
+	skey.addr_offset = (unsigned long) skey.key & ~PAGE_MASK;
+	get_key_fingerprint(skey.fingerprint, skey.key, skey.key_len, true);
 	barrier();
 	skey.initialized = true;
 
 	pr_info("Snapshot key is initialled.\n");
+	pr_debug("Fingerprint %*phN\n", SHA512_DIGEST_SIZE, skey.fingerprint);
 
 	return 0;
 
-- 
2.13.6
