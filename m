From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH 3/5] PM / hibernate: Encrypt snapshot image
Date: Thu,  3 Jan 2019 22:32:25 +0800
Message-ID: <20190103143227.9138-4-jlee@suse.com>
References: <20190103143227.9138-1-jlee@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103143227.9138-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

To protect the secret in memory snapshot image, this patch adds the
logic to encrypt snapshot pages by AES-CTR. Using AES-CTR is because
it's simple, fast and parallelizable. But this patch didn't implement
parallel encryption.

The encrypt key is derived from the snapshot key. And the initialization
vector will be kept in snapshot header for resuming.

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
 kernel/power/hibernate.c |   8 ++-
 kernel/power/power.h     |   6 ++
 kernel/power/snapshot.c  | 154 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 0dda6a9f0af1..5ac2ab6f4a0e 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -275,10 +275,14 @@ static int create_image(int platform_mode)
 	if (error)
 		return error;
 
+	error = snapshot_prepare_crypto(false, true);
+	if (error)
+		goto finish_hash;
+
 	error = dpm_suspend_end(PMSG_FREEZE);
 	if (error) {
 		pr_err("Some devices failed to power down, aborting hibernation\n");
-		goto finish_hash;
+		goto finish_crypto;
 	}
 
 	error = platform_pre_snapshot(platform_mode);
@@ -335,6 +339,8 @@ static int create_image(int platform_mode)
 	dpm_resume_start(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
 
+ finish_crypto:
+	snapshot_finish_crypto();
  finish_hash:
 	snapshot_finish_hash();
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index c614b0a294e3..41263fdd3a54 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -5,6 +5,7 @@
 #include <linux/freezer.h>
 #include <linux/compiler.h>
 #include <crypto/sha.h>
+#include <crypto/aes.h>
 
 /* The max size of encrypted key blob */
 #define KEY_BLOB_BUFF_LEN 512
@@ -24,6 +25,7 @@ struct swsusp_info {
 	unsigned long		pages;
 	unsigned long		size;
 	unsigned long		trampoline_pfn;
+	u8			iv[AES_BLOCK_SIZE];
 	u8			signature[SNAPSHOT_DIGEST_SIZE];
 } __aligned(PAGE_SIZE);
 
@@ -44,6 +46,8 @@ extern void __init hibernate_image_size_init(void);
 #ifdef CONFIG_HIBERNATION_ENC_AUTH
 /* kernel/power/snapshot.c */
 extern int snapshot_image_verify_decrypt(void);
+extern int snapshot_prepare_crypto(bool may_sleep, bool create_iv);
+extern void snapshot_finish_crypto(void);
 extern int snapshot_prepare_hash(bool may_sleep);
 extern void snapshot_finish_hash(void);
 /* kernel/power/snapshot_key.c */
@@ -53,6 +57,8 @@ extern int snapshot_get_auth_key(u8 *auth_key, bool may_sleep);
 extern int snapshot_get_enc_key(u8 *enc_key, bool may_sleep);
 #else
 static inline int snapshot_image_verify_decrypt(void) { return 0; }
+static inline int snapshot_prepare_crypto(bool may_sleep, bool create_iv) { return 0; }
+static inline void snapshot_finish_crypto(void) {}
 static inline int snapshot_prepare_hash(bool may_sleep) { return 0; }
 static inline void snapshot_finish_hash(void) {}
 static inline int snapshot_key_init(void) { return 0; }
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index e817c035f378..cd10ab5e4850 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -41,7 +41,11 @@
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 #ifdef CONFIG_HIBERNATION_ENC_AUTH
+#include <linux/random.h>
+#include <linux/scatterlist.h>
+#include <crypto/aes.h>
 #include <crypto/hash.h>
+#include <crypto/skcipher.h>
 #endif
 
 #include "power.h"
@@ -1413,6 +1417,127 @@ static unsigned int nr_copy_pages;
 static void **h_buf;
 
 #ifdef CONFIG_HIBERNATION_ENC_AUTH
+static struct skcipher_request *sk_req;
+static u8 iv[AES_BLOCK_SIZE];
+static void *c_buffer;
+
+static void init_iv(struct swsusp_info *info)
+{
+	memcpy(info->iv, iv, AES_BLOCK_SIZE);
+}
+
+static void load_iv(struct swsusp_info *info)
+{
+	memcpy(iv, info->iv, AES_BLOCK_SIZE);
+}
+
+int snapshot_prepare_crypto(bool may_sleep, bool create_iv)
+{
+	char enc_key[DERIVED_KEY_SIZE];
+	struct crypto_skcipher *tfm;
+	int ret = 0;
+
+	ret = snapshot_get_enc_key(enc_key, may_sleep);
+	if (ret) {
+		pr_warn_once("enc key is invalid\n");
+		return -EINVAL;
+	}
+
+	c_buffer = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!c_buffer) {
+		pr_err("Allocate crypto buffer page failed\n");
+		return -ENOMEM;
+	}
+
+	tfm = crypto_alloc_skcipher("ctr(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		pr_err("failed to allocate skcipher (%d)\n", ret);
+		goto alloc_fail;
+	}
+
+	ret = crypto_skcipher_setkey(tfm, enc_key, AES_MAX_KEY_SIZE);
+	if (ret) {
+		pr_err("failed to setkey (%d)\n", ret);
+		goto set_fail;
+	}
+
+	sk_req = skcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!sk_req) {
+		pr_err("failed to allocate request\n");
+		ret = -ENOMEM;
+		goto set_fail;
+	}
+	if (may_sleep)
+		skcipher_request_set_callback(sk_req, CRYPTO_TFM_REQ_MAY_SLEEP,
+						NULL, NULL);
+	if (create_iv)
+		get_random_bytes(iv, AES_BLOCK_SIZE);
+
+	return 0;
+
+set_fail:
+	crypto_free_skcipher(tfm);
+alloc_fail:
+	__free_page(c_buffer);
+
+	return ret;
+}
+
+void snapshot_finish_crypto(void)
+{
+	struct crypto_skcipher *tfm;
+ 
+	if (!sk_req)
+		return;
+
+	tfm = crypto_skcipher_reqtfm(sk_req);
+	skcipher_request_zero(sk_req);
+	skcipher_request_free(sk_req);
+	crypto_free_skcipher(tfm);
+	__free_page(c_buffer);
+	sk_req = NULL;
+}
+
+static int encrypt_data_page(void *hash_buffer)
+{
+	struct scatterlist src[1], dst[1];
+	u8 iv_tmp[AES_BLOCK_SIZE];
+	int ret = 0;
+
+	if (!sk_req)
+		return 0;
+
+	memcpy(iv_tmp, iv, sizeof(iv));
+	sg_init_one(src, hash_buffer, PAGE_SIZE);
+	sg_init_one(dst, c_buffer, PAGE_SIZE);
+	skcipher_request_set_crypt(sk_req, src, dst, PAGE_SIZE, iv_tmp);
+	ret = crypto_skcipher_encrypt(sk_req);
+
+	copy_page(hash_buffer, c_buffer);
+	memset(c_buffer, 0, PAGE_SIZE);
+
+	return ret;
+}
+
+static int decrypt_data_page(void *encrypted_page)
+{
+	struct scatterlist src[1], dst[1];
+	u8 iv_tmp[AES_BLOCK_SIZE];
+	int ret = 0;
+
+	memcpy(iv_tmp, iv, sizeof(iv));
+	sg_init_one(src, encrypted_page, PAGE_SIZE);
+	sg_init_one(dst, c_buffer, PAGE_SIZE);
+	skcipher_request_set_crypt(sk_req, src, dst, PAGE_SIZE, iv_tmp);
+	ret = crypto_skcipher_decrypt(sk_req);
+
+	copy_page(encrypted_page, c_buffer);
+	memset(c_buffer, 0, PAGE_SIZE);
+
+	return ret;
+}
+
 /*
  * Signature of snapshot image
  */
@@ -1508,22 +1633,30 @@ int snapshot_image_verify_decrypt(void)
 	if (ret || !s4_verify_desc)
 		goto error_prep;
 
+	ret = snapshot_prepare_crypto(true, false);
+	if (ret)
+		goto error_prep;
+
 	for (i = 0; i < nr_copy_pages; i++) {
 		ret = crypto_shash_update(s4_verify_desc, *(h_buf + i), PAGE_SIZE);
 		if (ret)
-			goto error_shash;
+			goto error_shash_crypto;
+		ret = decrypt_data_page(*(h_buf + i));
+		if (ret)
+			goto error_shash_crypto;
 	}
 
 	ret = crypto_shash_final(s4_verify_desc, s4_verify_digest);
 	if (ret)
-		goto error_shash;
+		goto error_shash_crypto;
 
 	pr_debug("Signature %*phN\n", SNAPSHOT_DIGEST_SIZE, signature);
 	pr_debug("Digest    %*phN\n", SNAPSHOT_DIGEST_SIZE, s4_verify_digest);
 	if (memcmp(signature, s4_verify_digest, SNAPSHOT_DIGEST_SIZE))
 		ret = -EKEYREJECTED;
 
- error_shash:
+ error_shash_crypto:
+	snapshot_finish_crypto();
 	snapshot_finish_hash();
 
  error_prep:
@@ -1564,6 +1697,17 @@ __copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
 			crypto_buffer = page_address(d_page);
 		}
 
+		/* Encrypt hashed page */
+		encrypt_data_page(crypto_buffer);
+
+		/* Copy encrypted buffer to destination page in high memory */
+		if (PageHighMem(d_page)) {
+			void *kaddr = kmap_atomic(d_page);
+
+			copy_page(kaddr, crypto_buffer);
+			kunmap_atomic(kaddr);
+		}
+
 		/* Generate digest */
 		if (!s4_verify_desc)
 			continue;
@@ -1638,6 +1782,8 @@ __copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
 }
 
 static inline void alloc_h_buf(void) {}
+static inline void init_iv(struct swsusp_info *info) {}
+static inline void load_iv(struct swsusp_info *info) {}
 static inline void init_signature(struct swsusp_info *info) {}
 static inline void load_signature(struct swsusp_info *info) {}
 static inline void init_sig_verify(struct trampoline *t) {}
@@ -2286,6 +2432,7 @@ static int init_header(struct swsusp_info *info)
 	info->size = info->pages;
 	info->size <<= PAGE_SHIFT;
 	info->trampoline_pfn = page_to_pfn(virt_to_page(trampoline_virt));
+	init_iv(info);
 	init_signature(info);
 	return init_header_complete(info);
 }
@@ -2524,6 +2671,7 @@ static int load_header(struct swsusp_info *info)
 		nr_copy_pages = info->image_pages;
 		nr_meta_pages = info->pages - info->image_pages - 1;
 		trampoline_pfn = info->trampoline_pfn;
+		load_iv(info);
 		load_signature(info);
 	}
 	return error;
-- 
2.13.6
