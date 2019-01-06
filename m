From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 2/5] PM / hibernate: Generate and verify signature for snapshot image
Date: Sun, 06 Jan 2019 09:09:27 +0100
Message-ID: <1703775.N7MsT5WVgv@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <20190103143227.9138-3-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103143227.9138-3-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 3. Januar 2019, 15:32:24 CET schrieb Lee, Chun-Yi:

Hi Chun,

> +int snapshot_image_verify_decrypt(void)
> +{
> +	int ret, i;
> +
> +	if (!h_buf) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	ret = snapshot_key_init();
> +	if (ret)
> +		goto error_prep;
> +
> +	ret = snapshot_prepare_hash(true);
> +	if (ret || !s4_verify_desc)
> +		goto error_prep;
> +
> +	for (i = 0; i < nr_copy_pages; i++) {
> +		ret = crypto_shash_update(s4_verify_desc, *(h_buf + i), PAGE_SIZE);
> +		if (ret)
> +			goto error_shash;
> +	}
> +
> +	ret = crypto_shash_final(s4_verify_desc, s4_verify_digest);
> +	if (ret)
> +		goto error_shash;
> +
> +	pr_debug("Signature %*phN\n", SNAPSHOT_DIGEST_SIZE, signature);
> +	pr_debug("Digest    %*phN\n", SNAPSHOT_DIGEST_SIZE, s4_verify_digest);
> +	if (memcmp(signature, s4_verify_digest, SNAPSHOT_DIGEST_SIZE))
> +		ret = -EKEYREJECTED;
> +
> + error_shash:
> +	snapshot_finish_hash();
> +
> + error_prep:
> +	vfree(h_buf);
> +	if (ret)
> +		pr_warn("Signature verification failed: %d\n", ret);
> + error:
> +	sig_verify_ret = ret;
> +	return ret;
> +}

May I ask why the authentication part is done manually here? Why not using an 
AEAD cipher like the authenc() ciphers, or CCM (I would not recommend GCM 
though)? In this case, the encryption/decryption operation would automatically 
perform the creation of the hash and the verification of the hash. I.e. 
decryption can return EBADMSG which indicates an authentication failure.

> +
> +static int
> +__copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap
> *orig_bm) +{
> +	unsigned long pfn, dst_pfn;
> +	struct page *d_page;
> +	void *crypto_buffer = NULL;
> +	int ret = 0;
> +
> +	memory_bm_position_reset(orig_bm);
> +	memory_bm_position_reset(copy_bm);
> +	for (;;) {
> +		pfn = memory_bm_next_pfn(orig_bm);
> +		if (unlikely(pfn == BM_END_OF_MAP))
> +			break;
> +		dst_pfn = memory_bm_next_pfn(copy_bm);
> +		copy_data_page(dst_pfn, pfn);
> +
> +		/* Setup buffer */
> +		d_page = pfn_to_page(dst_pfn);
> +		if (PageHighMem(d_page)) {
> +			void *kaddr = kmap_atomic(d_page);
> +
> +			copy_page(buffer, kaddr);
> +			kunmap_atomic(kaddr);
> +			crypto_buffer = buffer;
> +		} else {
> +			crypto_buffer = page_address(d_page);
> +		}
> +
> +		/* Generate digest */
> +		if (!s4_verify_desc)
> +			continue;
> +		ret = crypto_shash_update(s4_verify_desc, crypto_buffer,
> +					  PAGE_SIZE);

Same here, the creation of the hash would be implicit during the encryption.

Ciao
Stephan
