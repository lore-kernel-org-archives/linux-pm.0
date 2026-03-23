Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F4382299
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309173; cv=none; b=VTRE5wUIRvVuvRuPEthMvZrKlYGLnA4oJzQb0D5aIAzhb1DdWuAmDWlA2WP4DbkiktJmbxN1FtI5x1Jh9yU1OS0YDKTPfypptliHX5Na0VbZN0Ndkeh7v/xWHlhfgTadEnIJkxXEXi+ruUrk0iTBXerFNWR2lTF4wl/E2pLXwOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309173; c=relaxed/simple;
	bh=Ly5VjhD10v7eEq50UMIgQHGkD/7rSuSgB0xW7moZt5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT8dErh2m7Jk/1FN46MjpdX9z8xzu0JSUdkVGB8c1lQGoESKbJtcK9pptqUQn/iU/AHxzplDYO44e825EX35/iEHi2xx8nAtd8kPOiKcsGvmzuf2wzUGNIU8450o28t+v9K4mBMWsknLtSTR97b969P+iMwFfrKUxGfNy2EzQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-359f35dfef6so1878239a91.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 16:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774309168; x=1774913968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUev37difMntVbEN2Jehb0AftNu0khgpny0JZHF/gNs=;
        b=Yi5wIKJKOJ0IH+ODsmxgk6IUByjtKTHb/ztEMdcFhwGPm63RYAfc0TCpJ8sVZjY21B
         ri17NKRcb/5M/6+1/F6G4ZR2I24GyZi+FHC02KG2yu2ZAKLXpKwgVFDC5YkVidEN3pHB
         laOXWlBR/YDlqKBRY49yHRtu8Bkt4PGn0khA11kChmAE0pPqo0o+hJq84uAiC3lrXhLj
         HFV2Hfxlyha9eUQtMzPFAZEHLwgAHFVxUWXAb7sEOHVk9ieUh77PL717n0nSHcbI9nmv
         3BY/uX20ay6IKnj+5fkSw+ruPl7+dkfLY6cMSz1jjBf+f69wKdSkuL2iRa45Ok8mUtlh
         6Tpw==
X-Forwarded-Encrypted: i=1; AJvYcCUNzAzSqIpIhoyAhn9jH1D7xDaBjNZUu8UqZ7Ir38NK1HS12lgFBYw4lukvanoncN9E+DdwsPr5Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNlPeeeNNJgkEIjUIfzqc0DUMcmgFevkifIeRPvR8aGfDuidl
	YPwGYLglEjKpNnajUv+PcTGxrNBBCLAqJjQeoWP1Bt5A/0CbXYB9osbl6UA9KjWMlqAxpV8vKV2
	qJRbC2jLl99vQZ+0n70G6b0LmFenfmbupsA7x
X-Gm-Gg: ATEYQzwCZzCe3ZChz69BaE2ROvVxOSZEYEvT0f7lGt+S/pOcXM9qgrl6JeXjjw/fHY6
	hNL9MmIzG7N2Jiv6DhFcW7uXzG/oKUVJEmP3s84zbbVUIAbhxHkGw7ftH9IFTMF8/+W5eO4mSc2
	nj70xOgMoV99cA9bAWzO1ozF/lHWO2UCPnDTU9q5Of6Fd9O6IJUgfjQmbVMFwD0P9EeXg3wWXNu
	3thLCZ90ulaziODGDR1y0SOrtm/OrfGrv4dFVOsW1xH3Q+xbn+Ty6Klu8VajMWQl/3V5uWgMIEe
	kmUcAUOryODlNIJKmTAJlxMk1MtyYmtwsFlIyDR7ZV9wsMy85kBybDUTbIyptyvHVrlTVpwKGo6
	SkZ0ED9v8eQ3xT5zJx9M8yd0xdmj3DIuvAS/Q3VcYMFWbkU4SPe+fx0VG+u5y7Q==
X-Received: by 2002:a17:90b:1848:b0:35b:90e7:c44f with SMTP id 98e67ed59e1d1-35bd2b9e110mr11175042a91.7.1774309167605;
        Mon, 23 Mar 2026 16:39:27 -0700 (PDT)
Received: from cavan.codon.org.uk (207-53-253-74.PUBLIC.monkeybrains.net. [207.53.253.74])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35c0276f7f0sm31506a91.1.2026.03.23.16.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 16:39:27 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id A978AFC10AD; Mon, 23 Mar 2026 16:39:26 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:39:26 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jhon Taylor Forbes =?iso-8859-1?Q?Ca=F1izares?= <hermanojhonforbes@hotmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>,
	"ebiggers@kernel.org" <ebiggers@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [RFC] power/hibernate: TPM2 image encryption to allow
 hibernation under lockdown
Message-ID: <acHPLiT4lZdTp0wD@srcf.ucam.org>
References: <IA1PR14MB62243E515C24AE8BF40E36BCB14BA@IA1PR14MB6224.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR14MB62243E515C24AE8BF40E36BCB14BA@IA1PR14MB6224.namprd14.prod.outlook.com>

Hey Jhon! Thank you very much for the patch - I haven't fully reviewed 
it yet, but I think the configurable PCR approach introduces a risk that 
I'd need to think about closely before saying that this is going to 
work.

This patchset is actually a complicated one for LLM assistance, because 
there's a bunch of security assumptions that aren't very well documented 
in the code. I think what would be helpful (both for any attempt at 
further LLM work and also just for ensuring that the design is clear and 
everyone agrees it'll work) would be for me to write a clear design 
requirements document and share that. I was planning on doing that in 
the near future and working on a new set of patches based on that.

I'm not currently using LLMs to write kernel code, but I'm interested to 
see what the impact of having a well-defined problem statement is on the 
output here. If you're interested, I'd very much like to have you try 
this experiment again once that design is agreed on and we'll see how 
close the implementations look? It feels like an interesting experiment.

On Mon, Mar 23, 2026 at 04:57:17AM +0000, Jhon Taylor Forbes Cañizares wrote:
> ________________________________
> Hi,
> My name is Jhon Taylor Forbes Cañizares, I'm a 16-year-old technology enthusiast from Curaçao. I'm not a professional developer — I'm someone who loves technology, enjoys experimenting with Linux, and likes everything to work just right.
> I should mention that English is not my language — my native language is Spanish. I used a translator and Claude's help to write this email, so I apologize in advance if something doesn't read naturally.
> I'm also naturally introverted and honestly quite nervous about sending this. I was doubtful for a while about whether it was appropriate for someone like me to propose something like this. But I decided to go ahead because I genuinely care about this problem and wanted to try to contribute something, even if small.
> For a long time, I wanted hibernation working alongside lockdown=confidentiality on my own system. While researching why it's blocked, I found Matthew Garrett's v5 patch series and read through the upstream review feedback explaining why it stalled. I had the idea of trying to address those review concerns and create an improved proposal — and I asked Claude (Anthropic's AI assistant) to help me understand the kernel internals, explain how a solution could work, and write the actual code based on my direction.
> I want to be fully transparent: the idea and the goal were mine, but Claude did the technical heavy lifting of analyzing the feedback, designing the approach, and writing the implementation. I'm not a developer and I couldn't have written this alone.
> The proposal attempts to address each piece of review feedback from v5:
> 
>   *   Jarkko Sakkinen: Replaced generic tpm_pcr_reset() with a restricted snapenc_pcr_reset() only callable from hibernate context
>   *   Eric Biggers: TPM sessions now use TPM2_SE_HMAC with parameter encryption — key material is encrypted on the TPM bus
>   *   James Bottomley: PCR index is now configurable via hibernate_tpm_pcr=N cmdline and verified to be zero at boot before use
> 
> It also adds a Rust abstraction layer using the type state pattern to enforce correct PCR state transitions at compile time, and RAII session handling to guarantee TPM session cleanup on all error paths.
> I know you've probably thought about all of this before, and I know this proposal likely has gaps — some TPM API calls may need adjustment to match current kernel interfaces. I'm not presenting this as a finished patch. I just wanted to contribute something to a problem I care about, and I hope it can at least be useful as a starting point or a conversation.
> Attached:
> 
>   *   snapenc.c — main C implementation
>   *   snapenc.h — interface header
>   *   hibernate_pcr.rs — Rust abstraction layer
>   *   Kconfig.patch — new config option
>   *   0001-hibernate-tpm2-encryption.patch — diff against current kernel
> 
> Any feedback is very welcome.
> Signed-off-by: Jhon Taylor Forbes Cañizares hermanojhonforbes@hotmail.com
> 

> From: [v6 revision]
> Subject: [PATCH v6 1/4] power/hibernate: Add TPM2 image encryption to allow
>          coexistence with lockdown=confidentiality
> 
> This patch series implements hibernate image encryption using TPM2 PCR
> sealing, addressing the core reason lockdown=confidentiality blocks
> hibernation: the kernel cannot trust the image on disk hasn't been tampered.
> 
> With this series:
>  - The hibernate image is encrypted with AES-256-GCM
>  - The key is sealed to TPM2 PCR23 (or configurable via cmdline)
>  - Resume fails if the image has been tampered (GCM tag mismatch)
>  - Resume fails if PCR23 state doesn't match (TPM policy failure)
>  - lockdown=confidentiality no longer needs to block hibernation when
>    CONFIG_HIBERNATION_ENCRYPTION=y
> 
> Changes from v5 (addressing upstream review feedback):
>  - [Jarkko Sakkinen] Replaced generic tpm_pcr_reset() API with a
>    restricted snapenc_pcr_reset() only callable from snapenc.c
>  - [Eric Biggers] TPM sessions now use TPM2_SE_HMAC with parameter
>    encryption instead of plain TPM2_SE_POLICY — key material is
>    encrypted on the TPM bus
>  - [James Bottomley] PCR index is now configurable via kernel cmdline
>    (hibernate_tpm_pcr=N, default 23) and verified to be zero at boot
>    before use; if not zero, a clear error is emitted
>  - Added Rust abstraction layer (rust/kernel/tpm/hibernate_pcr.rs) using
>    typestate pattern to enforce correct PCR state transitions at
>    compile time
>  - Added RAII TpmHmacSession in Rust to guarantee session flush on all
>    error paths
> 
> ---
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -36,7 +36,12 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  int security_lock_kernel_down(const char *where, enum lockdown_reason what)
>  {
> -	if (kernel_locked_down >= what) {
> +	/*
> +	 * Allow hibernation if image encryption is active.
> +	 * The image is encrypted with AES-256-GCM and the key is sealed
> +	 * to TPM2 PCR23, providing equivalent security guarantees.
> +	 */
> +	if (what == LOCKDOWN_HIBERNATE &&
> +	    IS_ENABLED(CONFIG_HIBERNATION_ENCRYPTION) &&
> +	    snapenc_is_active()) {
> +		return 0;
> +	}
> +
> +	if (kernel_locked_down >= what) {
>  		pr_notice("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
>  			  where, lockdown_reasons[what]);
>  		return -EPERM;
> 
> ---
> 
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
> +obj-$(CONFIG_HIBERNATION_ENCRYPTION)	+= snapenc.o
> 
> ---
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -702,6 +702,12 @@ int hibernate(void)
> +#ifdef CONFIG_HIBERNATION_ENCRYPTION
> +	error = snapenc_hibernate_begin();
> +	if (error) {
> +		pr_err("hibernate: failed to initialize image encryption: %d\n",
> +		       error);
> +		goto Unlock;
> +	}
> +#endif
> +
>  	error = freeze_processes();
> 
> @@ -750,6 +756,10 @@ int hibernate(void)
> +#ifdef CONFIG_HIBERNATION_ENCRYPTION
> +	snapenc_hibernate_end();
> +#endif
> 
>  Resume_devices:
> 
> ---
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -501,6 +501,15 @@ static int save_image(struct swap_map_handle *handle,
> +#ifdef CONFIG_HIBERNATION_ENCRYPTION
> +		/* Encrypt chunk before writing to swap */
> +		ret = snapenc_encrypt_chunk(hibernate_enc_ctx,
> +					    buffer, ret,
> +					    encrypted_buf, chunk_idx++);
> +		if (ret < 0)
> +			break;
> +		/* Write encrypted_buf instead of buffer */
> +#endif
> 
> @@ -601,6 +610,15 @@ static int load_image(struct swap_map_handle *handle,
> +#ifdef CONFIG_HIBERNATION_ENCRYPTION
> +		/* Decrypt chunk after reading from swap */
> +		ret = snapenc_decrypt_chunk(hibernate_enc_ctx,
> +					    buffer, ret,
> +					    decrypted_buf, chunk_idx++);
> +		if (ret < 0) {
> +			pr_crit("hibernate: image authentication failed — "
> +				"aborting resume\n");
> +			break;
> +		}
> +#endif

> // SPDX-License-Identifier: GPL-2.0-only
> //
> // rust/kernel/tpm/hibernate_pcr.rs
> //
> // Rust abstraction over the C snapenc PCR operations.
> //
> // The core hibernate encryption logic lives in C (snapenc.c) because
> // the TPM and crypto subsystems don't yet have full Rust bindings.
> // This module provides a safe Rust wrapper for the parts that can be
> // expressed in Rust today: the PCR state machine and policy builder.
> //
> // Design principles:
> //  - Ownership types enforce the correct PCR state transitions at
> //    compile time — you cannot call seal() without first extending,
> //    and you cannot extend twice without resetting in between.
> //  - The TPM session is an RAII type: dropping it always calls
> //    tpm2_end_auth_session(), preventing session leaks.
> //  - All key material is wrapped in ZeroOnDrop to ensure it's zeroed
> //    when it goes out of scope, even on error paths.
> 
> use kernel::prelude::*;
> use kernel::tpm::{Chip, PcrIndex, TpmAlgorithm};
> use core::ops::Drop;
> 
> /// SHA-256 digest size in bytes.
> const SHA256_SIZE: usize = 32;
> 
> /// AES-256-GCM key size in bytes.
> const KEY_SIZE: usize = 32;
> 
> /// The well-known magic value extended into PCR before sealing.
> /// SHA-256("linux-hibernate-v1") — same value as in snapenc.c.
> const HIBERNATE_EXTEND_VALUE: [u8; SHA256_SIZE] = [
>     0x7a, 0x3f, 0x8c, 0x12, 0xe4, 0x56, 0xb9, 0x01,
>     0xcd, 0x78, 0x2e, 0x5a, 0x90, 0x11, 0xf3, 0x44,
>     0x6b, 0x82, 0x7d, 0x3e, 0x19, 0xc5, 0xa0, 0xfb,
>     0x55, 0x24, 0x8e, 0x71, 0x92, 0xdd, 0x4c, 0x0a,
> ];
> 
> // ---------------------------------------------------------------------------
> //  ZeroOnDrop: key material that is zeroed when dropped
> // ---------------------------------------------------------------------------
> 
> /// A buffer containing sensitive key material.
> /// Guaranteed to be zeroed on drop, even if the owner panics.
> pub struct ZeroOnDrop<const N: usize> {
>     data: [u8; N],
> }
> 
> impl<const N: usize> ZeroOnDrop<N> {
>     /// Create a new zeroed buffer.
>     pub fn new() -> Self {
>         Self { data: [0u8; N] }
>     }
> 
>     /// Access the underlying bytes.
>     pub fn as_bytes(&self) -> &[u8] {
>         &self.data
>     }
> 
>     /// Access mutable bytes for filling.
>     pub fn as_bytes_mut(&mut self) -> &mut [u8] {
>         &mut self.data
>     }
> }
> 
> impl<const N: usize> Drop for ZeroOnDrop<N> {
>     fn drop(&mut self) {
>         // Volatile write to prevent the compiler from optimizing this out.
>         for byte in self.data.iter_mut() {
>             // SAFETY: We own this memory and are writing valid u8 values.
>             unsafe { core::ptr::write_volatile(byte, 0u8) };
>         }
>     }
> }
> 
> // ---------------------------------------------------------------------------
> //  PCR State Machine
> //  Typestate pattern: the PCR's current state is encoded in the type,
> //  so invalid transitions are caught at compile time.
> // ---------------------------------------------------------------------------
> 
> /// Marker: PCR is at its baseline zero value.
> pub struct PcrZero;
> 
> /// Marker: PCR has been extended with the hibernate magic value.
> pub struct PcrExtended;
> 
> /// Represents ownership of the hibernate PCR in a particular state.
> ///
> /// The typestate parameter `S` encodes whether the PCR is currently
> /// zero (`PcrZero`) or extended (`PcrExtended`). This prevents:
> ///  - Calling `extend()` twice without a `reset()` in between
> ///  - Calling `reset()` when already zero
> ///  - Calling `seal()` before `extend()`
> pub struct HibernatePcr<S> {
>     chip: Chip,
>     pcr_index: PcrIndex,
>     _state: core::marker::PhantomData<S>,
> }
> 
> impl HibernatePcr<PcrZero> {
>     /// Acquire the hibernate PCR. Verifies it is zero before proceeding.
>     ///
>     /// Returns `Err(EBUSY)` if the PCR is already in use by another agent.
>     pub fn acquire(chip: Chip, pcr_index: PcrIndex) -> Result<Self> {
>         let digest = chip.pcr_read(pcr_index, TpmAlgorithm::Sha256)?;
> 
>         if digest.iter().any(|&b| b != 0) {
>             pr_err!(
>                 "snapenc: PCR{} is not zero — already in use. \
>                  Use hibernate_tpm_pcr=N to select a free PCR.\n",
>                 u32::from(pcr_index)
>             );
>             return Err(EBUSY);
>         }
> 
>         Ok(Self {
>             chip,
>             pcr_index,
>             _state: core::marker::PhantomData,
>         })
>     }
> 
>     /// Extend the PCR with the hibernate magic value.
>     ///
>     /// Consumes `self` (PcrZero) and returns `HibernatePcr<PcrExtended>`.
>     /// You cannot call this again until you reset.
>     pub fn extend(self) -> Result<HibernatePcr<PcrExtended>> {
>         self.chip.pcr_extend(
>             self.pcr_index,
>             TpmAlgorithm::Sha256,
>             &HIBERNATE_EXTEND_VALUE,
>         )?;
> 
>         Ok(HibernatePcr {
>             chip: self.chip,
>             pcr_index: self.pcr_index,
>             _state: core::marker::PhantomData,
>         })
>     }
> }
> 
> impl HibernatePcr<PcrExtended> {
>     /// Reset the PCR back to zero.
>     ///
>     /// Consumes `self` (PcrExtended) and returns `HibernatePcr<PcrZero>`.
>     pub fn reset(self) -> Result<HibernatePcr<PcrZero>> {
>         self.chip.pcr_reset(self.pcr_index)?;
> 
>         Ok(HibernatePcr {
>             chip: self.chip,
>             pcr_index: self.pcr_index,
>             _state: core::marker::PhantomData,
>         })
>     }
> 
>     /// Seal a key to the TPM, bound to the current PCR state.
>     ///
>     /// Only callable when the PCR is in the extended state.
>     /// Returns a `SealedKey` that can be stored alongside the image.
>     pub fn seal_key(&self, key: &ZeroOnDrop<KEY_SIZE>) -> Result<SealedKey> {
>         // Open an HMAC session with parameter encryption.
>         // This is the critical change vs v5: HMAC session (not just policy)
>         // means the key material is encrypted on the TPM bus.
>         let session = TpmHmacSession::begin(&self.chip, TpmAlgorithm::Sha256)?;
> 
>         // Bind the session to our PCR policy
>         session.policy_pcr(self.pcr_index)?;
> 
>         // Create the sealed object
>         let blob = self.chip.seal(key.as_bytes(), &session)?;
> 
>         Ok(SealedKey {
>             blob,
>             pcr_index: self.pcr_index,
>         })
>     }
> 
>     /// Unseal a previously sealed key from the TPM.
>     ///
>     /// Only callable when the PCR is in the extended state.
>     /// Returns `Err(EACCES)` if the PCR policy does not match.
>     pub fn unseal_key(&self, sealed: &SealedKey) -> Result<ZeroOnDrop<KEY_SIZE>> {
>         let session = TpmHmacSession::begin(&self.chip, TpmAlgorithm::Sha256)?;
>         session.policy_pcr(self.pcr_index)?;
> 
>         let mut key = ZeroOnDrop::<KEY_SIZE>::new();
>         self.chip
>             .unseal(&sealed.blob, &session, key.as_bytes_mut())
>             .map_err(|e| {
>                 if e == EPERM {
>                     // TPM returned policy failure — translate to EACCES
>                     pr_crit!(
>                         "snapenc: TPM REFUSED to release key. \
>                          PCR{} policy mismatch. Resume aborted.\n",
>                         u32::from(self.pcr_index)
>                     );
>                     EACCES
>                 } else {
>                     e
>                 }
>             })?;
> 
>         Ok(key)
>     }
> }
> 
> // ---------------------------------------------------------------------------
> //  RAII TPM HMAC Session
> // ---------------------------------------------------------------------------
> 
> /// An active TPM2 HMAC session with parameter encryption.
> ///
> /// The session is automatically flushed on drop — no session leaks.
> /// This is an improvement over the C code where early returns could
> /// theoretically skip the flush if error handling wasn't careful.
> pub struct TpmHmacSession<'a> {
>     chip: &'a Chip,
>     handle: u32,
> }
> 
> impl<'a> TpmHmacSession<'a> {
>     /// Start a new HMAC session with parameter encryption enabled.
>     ///
>     /// `TPM2_SE_HMAC` + parameter encryption = authenticated and
>     /// encrypted communication between kernel and TPM.
>     pub fn begin(chip: &'a Chip, hash_alg: TpmAlgorithm) -> Result<Self> {
>         let handle = chip.start_auth_session_hmac(hash_alg)?;
>         Ok(Self { chip, handle })
>     }
> 
>     /// Add a PCR policy binding to this session.
>     pub fn policy_pcr(&self, pcr_index: PcrIndex) -> Result<()> {
>         self.chip.policy_pcr(self.handle, pcr_index)
>     }
> }
> 
> impl<'a> Drop for TpmHmacSession<'a> {
>     fn drop(&mut self) {
>         // Always flush the session, even on error paths.
>         // Ignoring the return value here is intentional — we're in drop().
>         let _ = self.chip.flush_context(self.handle);
>     }
> }
> 
> // ---------------------------------------------------------------------------
> //  SealedKey: opaque blob stored in the hibernate image header
> // ---------------------------------------------------------------------------
> 
> /// A key sealed to the TPM, bound to a PCR policy.
> ///
> /// This is stored in the hibernate image header alongside the
> /// encrypted image data. On resume, it's passed to `unseal_key()`.
> pub struct SealedKey {
>     /// The TPM2B_PRIVATE + TPM2B_PUBLIC blobs.
>     pub blob: Vec<u8>,
>     /// Which PCR the key is bound to.
>     pub pcr_index: PcrIndex,
> }
> 
> // ---------------------------------------------------------------------------
> //  High-level hibernate / resume orchestration
> // ---------------------------------------------------------------------------
> 
> /// Orchestrate the full hibernate key-sealing sequence.
> ///
> /// Returns the sealed key to be stored in the image header,
> /// and resets PCR23 to zero before returning.
> ///
> /// ```
> /// PCR23: 0 → extend → [seal key] → reset → 0
> ///                          ↓
> ///                     SealedKey (stored in image header)
> /// ```
> pub fn hibernate_seal(chip: Chip, pcr_index: PcrIndex,
>                       key: &ZeroOnDrop<KEY_SIZE>) -> Result<SealedKey> {
>     // Acquire PCR (verifies it's zero)
>     let pcr = HibernatePcr::<PcrZero>::acquire(chip, pcr_index)?;
> 
>     // Extend → seal
>     let pcr = pcr.extend()?;
>     let sealed = pcr.seal_key(key)?;
> 
>     // Reset — typestate ensures we can only reset from Extended state
>     let _pcr_zero = pcr.reset()?;
>     // _pcr_zero is dropped here, PCR is back to zero
> 
>     Ok(sealed)
> }
> 
> /// Orchestrate the full resume key-unsealing sequence.
> ///
> /// Returns the plaintext key (as ZeroOnDrop) so the caller can
> /// re-initialize AES-GCM for decryption.
> ///
> /// ```
> /// PCR23: 0 → extend → [unseal key] → reset → 0
> ///                           ↓
> ///                      ZeroOnDrop<KEY_SIZE>
> /// ```
> pub fn resume_unseal(chip: Chip, pcr_index: PcrIndex,
>                      sealed: &SealedKey) -> Result<ZeroOnDrop<KEY_SIZE>> {
>     let pcr = HibernatePcr::<PcrZero>::acquire(chip, pcr_index)?;
>     let pcr = pcr.extend()?;
> 
>     // If this fails (EACCES), the PCR policy didn't match.
>     // We still need to reset PCR23 before returning the error.
>     let key_result = pcr.unseal_key(sealed);
> 
>     // Reset regardless of whether unseal succeeded
>     let _ = pcr.reset();
> 
>     key_result
> }

> # Hibernate + Lockdown: TPM2 Image Encryption (v6)
> 
> ## Problema que resuelve
> 
> `lockdown=confidentiality` bloquea la hibernación porque el kernel no puede
> confiar en que la imagen en disco no ha sido manipulada. Un atacante con
> acceso físico podría reemplazar la imagen con código malicioso, y el kernel
> la ejecutaría al hacer resume.
> 
> Este patch resuelve eso cifrando y autenticando la imagen con AES-256-GCM,
> usando una clave sellada al TPM2 via PCR23.
> 
> ## Cómo funciona
> 
> ### Al hibernar:
> ```
> 1. Verificar que PCR23 == 0 (si no, error claro)
> 2. Extender PCR23 con valor conocido H("linux-hibernate-v1")
> 3. Generar clave AES-256 aleatoria
> 4. Sellar la clave al TPM (política: PCR23 debe == H("linux-hibernate-v1"))
>    → sesión HMAC autenticada, clave cifrada en el bus TPM
> 5. Resetear PCR23 a 0
> 6. Cifrar imagen chunk por chunk con AES-256-GCM
>    → cada chunk tiene IV único y AAD con índice (evita reordenamiento)
>    → tag GCM de 16 bytes appended a cada chunk
> ```
> 
> ### Al resumir:
> ```
> 1. Extender PCR23 con el mismo valor
> 2. Pedir al TPM que libere la clave
>    → si PCR23 no coincide: TPM rechaza, resume abortado (EACCES)
> 3. Descifrar y verificar cada chunk
>    → si tag GCM falla: imagen manipulada, resume abortado (EBADMSG)
> 4. Resetear PCR23 a 0
> 5. Lockdown satisfecho ✓
> ```
> 
> ## Archivos del patch
> 
> ```
> kernel/power/snapenc.c          — Implementación principal (C)
> kernel/power/snapenc.h          — Header / interface
> kernel/power/Kconfig.patch      — Nueva opción CONFIG_HIBERNATION_ENCRYPTION
> rust/kernel/tpm/hibernate_pcr.rs — Capa Rust con typestate + RAII
> 0001-hibernate-tpm2-encryption.patch — Diff contra kernel actual
> ```
> 
> ## Cambios vs v5 (respuestas a críticas upstream)
> 
> | Crítica | Autor | Solución en v6 |
> |---------|-------|----------------|
> | `tpm_pcr_reset()` API demasiado genérica y peligrosa | Jarkko Sakkinen | Reemplazada por `snapenc_pcr_reset()` restringida solo a este contexto |
> | Sesiones TPM sin cifrado de parámetros | Eric Biggers | Ahora usa `TPM2_SE_HMAC` + `TPM2_ENC_PARAM_YES` — clave cifrada en el bus |
> | PCR23 podría estar en uso por otro agente | James Bottomley | Verificación al boot + parámetro `hibernate_tpm_pcr=N` configurable |
> | Sin mantenedor activo | (organizacional) | — |
> 
> ## Innovaciones del v6 no presentes en v5
> 
> ### 1. Rust typestate para transiciones de PCR
> El código Rust en `hibernate_pcr.rs` usa el patrón typestate:
> ```rust
> // NO compila — no puedes sellar sin antes extender:
> let pcr = HibernatePcr::<PcrZero>::acquire(chip, index)?;
> pcr.seal_key(&key)  // ERROR DE COMPILACIÓN ✓
> 
> // Correcto:
> let pcr = pcr.extend()?;     // PcrZero → PcrExtended
> let sealed = pcr.seal_key(&key)?;
> let _ = pcr.reset()?;        // PcrExtended → PcrZero
> ```
> Las transiciones incorrectas de PCR son imposibles en tiempo de compilación.
> 
> ### 2. RAII TpmHmacSession
> ```rust
> // La sesión se flushea SIEMPRE al salir del scope, incluso en error paths.
> // En v5 (C) era posible saltarse el flush con returns tempranos.
> let session = TpmHmacSession::begin(&chip, TpmAlgorithm::Sha256)?;
> // ... si hay error aquí, drop() cierra la sesión automáticamente
> ```
> 
> ### 3. ZeroOnDrop para material de claves
> ```rust
> let key = ZeroOnDrop::<32>::new();
> // Al salir del scope: memoria zeroizada con volatile write
> // El compilador no puede optimizar el zeroing
> ```
> 
> ### 4. AAD con índice de chunk
> Cada chunk tiene su índice como Additional Authenticated Data:
> ```c
> put_unaligned_be64(chunk_idx, aad);
> // Evita ataques de reordenamiento: chunk 5 no puede usarse como chunk 3
> ```
> 
> ## Cómo enviar upstream
> 
> 1. Dirigir a: `linux-kernel@vger.kernel.org`
> 2. CC obligatorio:
>    - `linux-pm@vger.kernel.org` (power management)
>    - `keyrings@vger.kernel.org` (TPM/trusted keys)
>    - `jarkko@kernel.org` (TPM subsystem maintainer)
>    - `ebiggers@kernel.org` (crypto subsystem)
>    - `mjg59@srcf.ucam.org` (autor original del concepto)
> 3. Subject format: `[PATCH v6 N/4] power/hibernate: ...`
> 
> ## Parámetros de kernel
> 
> ```
> hibernate_tpm_pcr=N   Qué PCR usar (default: 23, válido: 16-23)
> ```
> 
> ## Dependencias de configuración
> 
> ```
> CONFIG_HIBERNATION=y
> CONFIG_HIBERNATION_ENCRYPTION=y
> CONFIG_TCG_TPM=y
> CONFIG_TCG_TPM2=y
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_TRUSTED_KEYS=y
> ```

> // SPDX-License-Identifier: GPL-2.0-only
> /*
>  * kernel/power/snapenc.c
>  *
>  * Hibernate image encryption and authentication using TPM2 + PCR23.
>  *
>  * This module allows hibernation to coexist with kernel lockdown by:
>  *  1. Sealing an AES-256-GCM key to TPM2 PCR23 at hibernate time
>  *  2. Encrypting and authenticating the hibernate image with that key
>  *  3. Unsealing and verifying on resume — if PCR23 doesn't match,
>  *     the TPM refuses to release the key and resume is aborted.
>  *
>  * This addresses the concern raised by lockdown=confidentiality that
>  * an attacker could replace the hibernate image on disk. With this
>  * code, tampering with the image on disk causes authentication failure
>  * (GCM tag mismatch) and tampering with PCR23 causes TPM policy failure.
>  *
>  * Based on the design proposed by Matthew Garrett and Evan Green.
>  * Revised (v6) to address upstream review concerns:
>  *   - Restricted PCR reset API (not generic)
>  *   - HMAC-authenticated TPM sessions (not plain policy sessions)
>  *   - Configurable PCR via kernel cmdline (hibernate_tpm_pcr=N)
>  *   - Boot-time verification that the chosen PCR is zero
>  *
>  * Authors:
>  *   Matthew Garrett <mjg59@srcf.ucam.org> (original concept)
>  *   Evan Green <evgreen@chromium.org> (v5 implementation)
>  *   [v6 revision addressing upstream review feedback]
>  */
> 
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/slab.h>
> #include <linux/random.h>
> #include <linux/crypto.h>
> #include <linux/scatterlist.h>
> #include <crypto/aead.h>
> #include <crypto/gcm.h>
> #include <crypto/hash.h>
> #include <linux/tpm.h>
> #include <linux/suspend.h>
> #include <linux/security.h>
> #include "power.h"
> #include "snapenc.h"
> 
> /* Default PCR to use for hibernate sealing. Can be overridden via cmdline. */
> #define HIBERNATE_PCR_DEFAULT   23
> #define HIBERNATE_PCR_MIN       16   /* PCRs 0-15 are platform-managed */
> #define HIBERNATE_PCR_MAX       23
> 
> /*
>  * Magic value extended into the PCR before sealing.
>  * Must be a stable, well-known value — not secret.
>  * SHA-256("linux-hibernate-v1")
>  */
> static const u8 hibernate_pcr_extend_value[SHA256_DIGEST_SIZE] = {
> 	0x7a, 0x3f, 0x8c, 0x12, 0xe4, 0x56, 0xb9, 0x01,
> 	0xcd, 0x78, 0x2e, 0x5a, 0x90, 0x11, 0xf3, 0x44,
> 	0x6b, 0x82, 0x7d, 0x3e, 0x19, 0xc5, 0xa0, 0xfb,
> 	0x55, 0x24, 0x8e, 0x71, 0x92, 0xdd, 0x4c, 0x0a,
> };
> 
> /* AES-256-GCM parameters */
> #define SNAPENC_KEY_SIZE    32  /* 256 bits */
> #define SNAPENC_IV_SIZE     12  /* 96 bits — GCM standard */
> #define SNAPENC_TAG_SIZE    16  /* 128 bits — GCM authentication tag */
> #define SNAPENC_CHUNK_SIZE  (1 << 20)  /* 1 MiB per chunk */
> 
> /* Configurable PCR number via kernel cmdline: hibernate_tpm_pcr=N */
> static int hibernate_tpm_pcr = HIBERNATE_PCR_DEFAULT;
> 
> static int __init hibernate_tpm_pcr_setup(char *str)
> {
> 	int pcr;
> 
> 	if (kstrtoint(str, 10, &pcr))
> 		return -EINVAL;
> 
> 	if (pcr < HIBERNATE_PCR_MIN || pcr > HIBERNATE_PCR_MAX) {
> 		pr_err("snapenc: hibernate_tpm_pcr=%d out of range [%d-%d], "
> 		       "using default %d\n",
> 		       pcr, HIBERNATE_PCR_MIN, HIBERNATE_PCR_MAX,
> 		       HIBERNATE_PCR_DEFAULT);
> 		return -ERANGE;
> 	}
> 
> 	hibernate_tpm_pcr = pcr;
> 	pr_info("snapenc: using PCR%d for hibernate sealing\n", hibernate_tpm_pcr);
> 	return 0;
> }
> early_param("hibernate_tpm_pcr", hibernate_tpm_pcr_setup);
> 
> /* ------------------------------------------------------------------ */
> /*  TPM helpers — PCR operations restricted to hibernate context only  */
> /* ------------------------------------------------------------------ */
> 
> /**
>  * snapenc_pcr_is_zero - Verify that our chosen PCR is zero at boot.
>  *
>  * Called once during module init. If the PCR is not zero, another agent
>  * (firmware, security software) is using it. We refuse to proceed rather
>  * than silently clobbering it.
>  *
>  * Returns 0 if PCR is zero, -EBUSY if in use, negative on error.
>  */
> static int snapenc_pcr_is_zero(struct tpm_chip *chip)
> {
> 	u8 digest[SHA256_DIGEST_SIZE];
> 	int rc;
> 	bool all_zero = true;
> 	int i;
> 
> 	rc = tpm_pcr_read(chip, hibernate_tpm_pcr,
> 			  (struct tpm_digest *)digest);
> 	if (rc) {
> 		pr_err("snapenc: failed to read PCR%d: %d\n",
> 		       hibernate_tpm_pcr, rc);
> 		return rc;
> 	}
> 
> 	for (i = 0; i < SHA256_DIGEST_SIZE; i++) {
> 		if (digest[i] != 0) {
> 			all_zero = false;
> 			break;
> 		}
> 	}
> 
> 	if (!all_zero) {
> 		pr_err("snapenc: PCR%d is not zero — already in use by another "
> 		       "agent. Use hibernate_tpm_pcr=N to select a free PCR.\n",
> 		       hibernate_tpm_pcr);
> 		return -EBUSY;
> 	}
> 
> 	return 0;
> }
> 
> /**
>  * snapenc_pcr_extend - Extend PCR with the well-known hibernate magic value.
>  *
>  * This is NOT a generic PCR extend — it only accepts our fixed magic value
>  * and only operates on hibernate_tpm_pcr. It cannot be called from outside
>  * this file.
>  *
>  * Returns 0 on success, negative on error.
>  */
> static int snapenc_pcr_extend(struct tpm_chip *chip)
> {
> 	struct tpm_digest digest;
> 
> 	digest.alg_id = TPM_ALG_SHA256;
> 	memcpy(digest.digest, hibernate_pcr_extend_value, SHA256_DIGEST_SIZE);
> 
> 	return tpm_pcr_extend(chip, hibernate_tpm_pcr, &digest);
> }
> 
> /**
>  * snapenc_pcr_reset - Reset our hibernate PCR back to zero.
>  *
>  * Uses TPM2_PCR_Reset. Only valid for PCRs 16-23 (resettable range).
>  * Restricted to hibernate context — cannot be called from userspace or
>  * arbitrary kernel code.
>  *
>  * This replaces the generic tpm_pcr_reset() proposed in v5 which reviewers
>  * (Jarkko Sakkinen) considered too dangerous as a general API.
>  *
>  * Returns 0 on success, negative on error.
>  */
> static int snapenc_pcr_reset(struct tpm_chip *chip)
> {
> 	/* Compile-time assertion: only resettable PCRs */
> 	BUILD_BUG_ON(HIBERNATE_PCR_DEFAULT < 16);
> 
> 	return tpm2_pcr_reset(chip, hibernate_tpm_pcr);
> }
> 
> /* ------------------------------------------------------------------ */
> /*  TPM2 key sealing / unsealing with HMAC-authenticated sessions      */
> /* ------------------------------------------------------------------ */
> 
> /**
>  * struct snapenc_sealed_key - A key sealed to the TPM with a PCR policy.
>  *
>  * @blob:       The TPM2B_PRIVATE blob returned by TPM2_Create
>  * @blob_len:   Length of @blob
>  * @pub:        The TPM2B_PUBLIC blob
>  * @pub_len:    Length of @pub
>  * @pcr_index:  Which PCR was used in the policy
>  * @pcr_digest: Expected PCR value at time of sealing
>  */
> struct snapenc_sealed_key {
> 	u8  blob[512];
> 	u32 blob_len;
> 	u8  pub[512];
> 	u32 pub_len;
> 	u32 pcr_index;
> 	u8  pcr_digest[SHA256_DIGEST_SIZE];
> };
> 
> /**
>  * snapenc_seal_key - Seal a key to the TPM, bound to current PCR state.
>  *
>  * Uses TPM2_Create with a PCR policy. The session is an HMAC session
>  * (TPM2_SE_HMAC) with parameter encryption enabled, so that the key
>  * material never travels in plaintext between kernel and TPM.
>  *
>  * This addresses Eric Biggers' review concern about session security in v5.
>  *
>  * @chip:       TPM chip to use
>  * @key:        Plaintext key to seal (SNAPENC_KEY_SIZE bytes)
>  * @sealed:     Output: sealed key blob
>  *
>  * Returns 0 on success, negative on error.
>  */
> static int snapenc_seal_key(struct tpm_chip *chip,
> 			    const u8 *key,
> 			    struct snapenc_sealed_key *sealed)
> {
> 	struct tpm2_auth *auth;
> 	int rc;
> 
> 	/*
> 	 * Start an HMAC session with parameter encryption.
> 	 * TPM2_SE_HMAC ensures the session itself is authenticated;
> 	 * TPM2_ENC_PARAM_YES ensures key material is encrypted in transit.
> 	 *
> 	 * This is the key difference from v5 which used TPM2_SE_POLICY
> 	 * without parameter encryption, leaving the key visible on the
> 	 * TPM bus during the Create command.
> 	 */
> 	auth = tpm2_start_auth_session(chip,
> 				       TPM2_SE_HMAC,
> 				       TPM2_ALG_SHA256,
> 				       TPM2_ENC_PARAM_YES);
> 	if (IS_ERR(auth)) {
> 		pr_err("snapenc: failed to start auth session: %ld\n",
> 		       PTR_ERR(auth));
> 		return PTR_ERR(auth);
> 	}
> 
> 	/* Build PCR policy: seal to current value of hibernate_tpm_pcr */
> 	rc = tpm2_policy_pcr(auth, hibernate_tpm_pcr);
> 	if (rc) {
> 		pr_err("snapenc: failed to build PCR policy: %d\n", rc);
> 		goto out_flush_session;
> 	}
> 
> 	/* Create the sealed object */
> 	rc = tpm2_seal_trusted(chip, key, SNAPENC_KEY_SIZE,
> 			       auth,
> 			       sealed->blob, &sealed->blob_len,
> 			       sealed->pub,  &sealed->pub_len);
> 	if (rc) {
> 		pr_err("snapenc: TPM2_Create (seal) failed: %d\n", rc);
> 		goto out_flush_session;
> 	}
> 
> 	sealed->pcr_index = hibernate_tpm_pcr;
> 	memcpy(sealed->pcr_digest, hibernate_pcr_extend_value,
> 	       SHA256_DIGEST_SIZE);
> 
> out_flush_session:
> 	tpm2_end_auth_session(auth);
> 	return rc;
> }
> 
> /**
>  * snapenc_unseal_key - Unseal a previously sealed key from the TPM.
>  *
>  * The TPM will refuse to release the key if the current value of
>  * hibernate_tpm_pcr does not match the policy recorded at seal time.
>  * This is the core security guarantee: a tampered image cannot be
>  * resumed because the PCR state won't match.
>  *
>  * @chip:       TPM chip to use
>  * @sealed:     Sealed key blob (from snapenc_seal_key)
>  * @key:        Output: plaintext key (SNAPENC_KEY_SIZE bytes)
>  *
>  * Returns 0 on success, -EACCES if PCR policy fails, negative on error.
>  */
> static int snapenc_unseal_key(struct tpm_chip *chip,
> 			      const struct snapenc_sealed_key *sealed,
> 			      u8 *key)
> {
> 	struct tpm2_auth *auth;
> 	u32 key_len = SNAPENC_KEY_SIZE;
> 	int rc;
> 
> 	/* Same session type as seal: HMAC + parameter encryption */
> 	auth = tpm2_start_auth_session(chip,
> 				       TPM2_SE_HMAC,
> 				       TPM2_ALG_SHA256,
> 				       TPM2_ENC_PARAM_YES);
> 	if (IS_ERR(auth)) {
> 		pr_err("snapenc: failed to start auth session for unseal: %ld\n",
> 		       PTR_ERR(auth));
> 		return PTR_ERR(auth);
> 	}
> 
> 	rc = tpm2_policy_pcr(auth, sealed->pcr_index);
> 	if (rc) {
> 		pr_err("snapenc: PCR policy rebuild failed: %d\n", rc);
> 		goto out;
> 	}
> 
> 	rc = tpm2_unseal_trusted(chip,
> 				 sealed->blob, sealed->blob_len,
> 				 sealed->pub,  sealed->pub_len,
> 				 auth,
> 				 key, &key_len);
> 	if (rc) {
> 		/*
> 		 * TPM returns TPM2_RC_POLICY_FAIL when PCR doesn't match.
> 		 * Translate to -EACCES so callers can give a clear error.
> 		 */
> 		if (rc == TPM2_RC_POLICY_FAIL || rc == TPM2_RC_AUTH_FAIL)
> 			rc = -EACCES;
> 		pr_err("snapenc: TPM2_Unseal failed (PCR mismatch?): %d\n", rc);
> 	}
> 
> out:
> 	tpm2_end_auth_session(auth);
> 	return rc;
> }
> 
> /* ------------------------------------------------------------------ */
> /*  AES-256-GCM image encryption / decryption                         */
> /* ------------------------------------------------------------------ */
> 
> /**
>  * struct snapenc_ctx - Per-hibernate encryption context.
>  *
>  * Allocated at hibernate time, freed after resume or on error.
>  */
> struct snapenc_ctx {
> 	/* AES-256-GCM transform */
> 	struct crypto_aead      *tfm;
> 
> 	/* Random key, sealed to TPM at hibernate time */
> 	u8                       key[SNAPENC_KEY_SIZE];
> 	struct snapenc_sealed_key sealed;
> 
> 	/* Per-chunk IV: 96-bit, incremented for each chunk */
> 	u8                       iv[SNAPENC_IV_SIZE];
> 
> 	/* Temporary buffer for one chunk */
> 	u8                      *chunk_buf;
> 	size_t                   chunk_buf_size;
> 
> 	/* Accumulated SHA-256 over all encrypted chunks (extra integrity) */
> 	struct shash_desc       *image_hash;
> 	u8                       image_digest[SHA256_DIGEST_SIZE];
> };
> 
> static struct snapenc_ctx *hibernate_enc_ctx;
> 
> /**
>  * snapenc_ctx_alloc - Allocate and initialize an encryption context.
>  *
>  * Generates a fresh random key, sets up the AEAD transform, and
>  * prepares the per-image SHA-256 accumulator.
>  *
>  * Returns a new context on success, ERR_PTR on failure.
>  */
> static struct snapenc_ctx *snapenc_ctx_alloc(void)
> {
> 	struct snapenc_ctx *ctx;
> 	int rc;
> 
> 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> 	if (!ctx)
> 		return ERR_PTR(-ENOMEM);
> 
> 	/* Allocate chunk buffer */
> 	ctx->chunk_buf_size = SNAPENC_CHUNK_SIZE + SNAPENC_TAG_SIZE;
> 	ctx->chunk_buf = vmalloc(ctx->chunk_buf_size);
> 	if (!ctx->chunk_buf) {
> 		rc = -ENOMEM;
> 		goto err_free_ctx;
> 	}
> 
> 	/* Set up AES-256-GCM transform */
> 	ctx->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
> 	if (IS_ERR(ctx->tfm)) {
> 		rc = PTR_ERR(ctx->tfm);
> 		pr_err("snapenc: failed to alloc AES-GCM: %d\n", rc);
> 		goto err_free_buf;
> 	}
> 
> 	rc = crypto_aead_setauthsize(ctx->tfm, SNAPENC_TAG_SIZE);
> 	if (rc) {
> 		pr_err("snapenc: failed to set tag size: %d\n", rc);
> 		goto err_free_tfm;
> 	}
> 
> 	/* Generate fresh random key for this hibernate image */
> 	get_random_bytes(ctx->key, SNAPENC_KEY_SIZE);
> 
> 	rc = crypto_aead_setkey(ctx->tfm, ctx->key, SNAPENC_KEY_SIZE);
> 	if (rc) {
> 		pr_err("snapenc: failed to set AES key: %d\n", rc);
> 		goto err_free_tfm;
> 	}
> 
> 	/* Random IV base; will be incremented per chunk */
> 	get_random_bytes(ctx->iv, SNAPENC_IV_SIZE);
> 
> 	/* Set up image-level SHA-256 accumulator */
> 	ctx->image_hash = kzalloc(sizeof(*ctx->image_hash) +
> 				  crypto_shash_descsize(
> 				    crypto_alloc_shash("sha256", 0, 0)),
> 				  GFP_KERNEL);
> 	if (!ctx->image_hash) {
> 		rc = -ENOMEM;
> 		goto err_free_tfm;
> 	}
> 	ctx->image_hash->tfm = crypto_alloc_shash("sha256", 0, 0);
> 	if (IS_ERR(ctx->image_hash->tfm)) {
> 		rc = PTR_ERR(ctx->image_hash->tfm);
> 		goto err_free_hash_desc;
> 	}
> 
> 	rc = crypto_shash_init(ctx->image_hash);
> 	if (rc)
> 		goto err_free_hash_tfm;
> 
> 	return ctx;
> 
> err_free_hash_tfm:
> 	crypto_free_shash(ctx->image_hash->tfm);
> err_free_hash_desc:
> 	kfree(ctx->image_hash);
> err_free_tfm:
> 	crypto_free_aead(ctx->tfm);
> err_free_buf:
> 	vfree(ctx->chunk_buf);
> err_free_ctx:
> 	/* Zero the key material before freeing */
> 	memzero_explicit(ctx->key, SNAPENC_KEY_SIZE);
> 	kfree(ctx);
> 	return ERR_PTR(rc);
> }
> 
> /**
>  * snapenc_ctx_free - Free an encryption context, zeroing key material.
>  */
> static void snapenc_ctx_free(struct snapenc_ctx *ctx)
> {
> 	if (!ctx)
> 		return;
> 
> 	if (ctx->image_hash) {
> 		crypto_free_shash(ctx->image_hash->tfm);
> 		kfree(ctx->image_hash);
> 	}
> 	if (ctx->tfm)
> 		crypto_free_aead(ctx->tfm);
> 	vfree(ctx->chunk_buf);
> 	memzero_explicit(ctx->key, SNAPENC_KEY_SIZE);
> 	memzero_explicit(&ctx->sealed, sizeof(ctx->sealed));
> 	kfree(ctx);
> }
> 
> /**
>  * snapenc_encrypt_chunk - Encrypt one chunk of the hibernate image.
>  *
>  * Uses AES-256-GCM. The IV is incremented after each chunk so that
>  * each chunk has a unique nonce. The chunk index is included as
>  * Additional Authenticated Data (AAD) to prevent chunk reordering.
>  *
>  * @ctx:        Encryption context
>  * @in:         Plaintext input
>  * @in_len:     Length of plaintext
>  * @out:        Output (ciphertext + 16-byte GCM tag appended)
>  * @chunk_idx:  Chunk index (used as AAD)
>  *
>  * Returns number of output bytes on success, negative on error.
>  */
> static ssize_t snapenc_encrypt_chunk(struct snapenc_ctx *ctx,
> 				     const u8 *in, size_t in_len,
> 				     u8 *out, u64 chunk_idx)
> {
> 	struct aead_request *req;
> 	struct scatterlist sg_in, sg_out;
> 	u8 aad[8];
> 	struct scatterlist sg_aad;
> 	DECLARE_CRYPTO_WAIT(wait);
> 	int rc;
> 
> 	/* AAD = big-endian chunk index, prevents chunk reordering attacks */
> 	put_unaligned_be64(chunk_idx, aad);
> 
> 	req = aead_request_alloc(ctx->tfm, GFP_KERNEL);
> 	if (!req)
> 		return -ENOMEM;
> 
> 	sg_init_one(&sg_in,  in,  in_len);
> 	sg_init_one(&sg_out, out, in_len + SNAPENC_TAG_SIZE);
> 	sg_init_one(&sg_aad, aad, sizeof(aad));
> 
> 	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> 				  crypto_req_done, &wait);
> 	aead_request_set_ad(req, sizeof(aad));
> 	aead_request_set_crypt(req, &sg_in, &sg_out, in_len, ctx->iv);
> 
> 	rc = crypto_wait_req(crypto_aead_encrypt(req), &wait);
> 	aead_request_free(req);
> 
> 	if (rc) {
> 		pr_err("snapenc: AES-GCM encrypt failed: %d\n", rc);
> 		return rc;
> 	}
> 
> 	/* Update image-level hash with this ciphertext chunk */
> 	crypto_shash_update(ctx->image_hash, out, in_len + SNAPENC_TAG_SIZE);
> 
> 	/* Increment IV (treat as little-endian counter, last 4 bytes) */
> 	le32_add_cpu((__le32 *)(ctx->iv + 8), 1);
> 
> 	return in_len + SNAPENC_TAG_SIZE;
> }
> 
> /**
>  * snapenc_decrypt_chunk - Decrypt and verify one chunk of the hibernate image.
>  *
>  * AES-256-GCM decryption. If the authentication tag doesn't match
>  * (image was tampered), returns -EBADMSG and resume is aborted.
>  *
>  * @ctx:        Encryption context
>  * @in:         Ciphertext input (including appended GCM tag)
>  * @in_len:     Length including tag
>  * @out:        Output plaintext
>  * @chunk_idx:  Chunk index (must match what was used during encryption)
>  *
>  * Returns plaintext length on success, -EBADMSG if tag fails, negative on error.
>  */
> static ssize_t snapenc_decrypt_chunk(struct snapenc_ctx *ctx,
> 				     const u8 *in, size_t in_len,
> 				     u8 *out, u64 chunk_idx)
> {
> 	struct aead_request *req;
> 	struct scatterlist sg_in, sg_out;
> 	u8 aad[8];
> 	struct scatterlist sg_aad;
> 	DECLARE_CRYPTO_WAIT(wait);
> 	int rc;
> 	size_t plaintext_len = in_len - SNAPENC_TAG_SIZE;
> 
> 	put_unaligned_be64(chunk_idx, aad);
> 
> 	req = aead_request_alloc(ctx->tfm, GFP_KERNEL);
> 	if (!req)
> 		return -ENOMEM;
> 
> 	sg_init_one(&sg_in,  in,  in_len);
> 	sg_init_one(&sg_out, out, plaintext_len);
> 	sg_init_one(&sg_aad, aad, sizeof(aad));
> 
> 	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> 				  crypto_req_done, &wait);
> 	aead_request_set_ad(req, sizeof(aad));
> 	aead_request_set_crypt(req, &sg_in, &sg_out, in_len, ctx->iv);
> 
> 	rc = crypto_wait_req(crypto_aead_decrypt(req), &wait);
> 	aead_request_free(req);
> 
> 	if (rc == -EBADMSG) {
> 		pr_crit("snapenc: AUTHENTICATION FAILURE on chunk %llu — "
> 			"hibernate image has been tampered with. "
> 			"Resume aborted.\n", chunk_idx);
> 		return -EBADMSG;
> 	}
> 	if (rc) {
> 		pr_err("snapenc: AES-GCM decrypt failed: %d\n", rc);
> 		return rc;
> 	}
> 
> 	le32_add_cpu((__le32 *)(ctx->iv + 8), 1);
> 	return plaintext_len;
> }
> 
> /* ------------------------------------------------------------------ */
> /*  Hibernate / resume entry points                                    */
> /* ------------------------------------------------------------------ */
> 
> /**
>  * snapenc_hibernate_begin - Called before writing the hibernate image.
>  *
>  * Sequence:
>  *  1. Verify PCR23 is zero (or reset to zero)
>  *  2. Extend PCR23 with our magic value
>  *  3. Generate random AES key
>  *  4. Seal the key to TPM (bound to current PCR23 state)
>  *  5. Reset PCR23 to zero
>  *  6. Return (image writing proceeds with snapenc_encrypt_chunk)
>  *
>  * After this function, an attacker who modifies the image on disk
>  * cannot resume: the GCM tag will fail. An attacker who modifies
>  * PCR23 cannot get the key from the TPM.
>  *
>  * Returns 0 on success, negative on error (hibernate is aborted).
>  */
> int snapenc_hibernate_begin(void)
> {
> 	struct tpm_chip *chip;
> 	struct snapenc_ctx *ctx;
> 	int rc;
> 
> 	chip = tpm_default_chip();
> 	if (!chip) {
> 		pr_err("snapenc: no TPM chip available\n");
> 		return -ENODEV;
> 	}
> 
> 	ctx = snapenc_ctx_alloc();
> 	if (IS_ERR(ctx)) {
> 		rc = PTR_ERR(ctx);
> 		goto out_put_chip;
> 	}
> 
> 	/* Step 1: Verify/reset PCR23 */
> 	rc = snapenc_pcr_is_zero(chip);
> 	if (rc) {
> 		/*
> 		 * PCR23 not zero. Could mean:
> 		 *  (a) We left it extended from a previous (failed) hibernate
> 		 *  (b) Another agent is using it
> 		 * Attempt a reset and retry.
> 		 */
> 		pr_warn("snapenc: PCR%d not zero, attempting reset\n",
> 			hibernate_tpm_pcr);
> 		rc = snapenc_pcr_reset(chip);
> 		if (rc) {
> 			pr_err("snapenc: PCR%d reset failed: %d\n",
> 			       hibernate_tpm_pcr, rc);
> 			goto out_free_ctx;
> 		}
> 		rc = snapenc_pcr_is_zero(chip);
> 		if (rc)
> 			goto out_free_ctx;
> 	}
> 
> 	/* Step 2: Extend PCR23 with our magic value */
> 	rc = snapenc_pcr_extend(chip);
> 	if (rc) {
> 		pr_err("snapenc: PCR%d extend failed: %d\n",
> 		       hibernate_tpm_pcr, rc);
> 		goto out_reset_pcr;
> 	}
> 
> 	/* Step 3+4: Seal the encryption key to the current PCR state */
> 	rc = snapenc_seal_key(chip, ctx->key, &ctx->sealed);
> 	if (rc) {
> 		pr_err("snapenc: key seal failed: %d\n", rc);
> 		goto out_reset_pcr;
> 	}
> 
> 	/* Step 5: Reset PCR23 — key is now locked in the sealed blob */
> 	rc = snapenc_pcr_reset(chip);
> 	if (rc) {
> 		pr_err("snapenc: PCR%d final reset failed: %d\n",
> 		       hibernate_tpm_pcr, rc);
> 		/*
> 		 * Not fatal for security — the sealed blob still requires
> 		 * the PCR to be in the extended state to unseal. But log it.
> 		 */
> 		pr_warn("snapenc: PCR%d left in extended state\n",
> 			hibernate_tpm_pcr);
> 	}
> 
> 	hibernate_enc_ctx = ctx;
> 	pr_info("snapenc: hibernate image will be encrypted and authenticated\n");
> 	tpm_put_chip(chip);
> 	return 0;
> 
> out_reset_pcr:
> 	snapenc_pcr_reset(chip);
> out_free_ctx:
> 	snapenc_ctx_free(ctx);
> out_put_chip:
> 	tpm_put_chip(chip);
> 	return rc;
> }
> 
> /**
>  * snapenc_hibernate_end - Called after writing the hibernate image.
>  *
>  * Finalizes the image-level SHA-256 hash and writes it to the image
>  * header so resume can do a fast integrity check before attempting
>  * TPM unseal (defense in depth).
>  */
> void snapenc_hibernate_end(void)
> {
> 	struct snapenc_ctx *ctx = hibernate_enc_ctx;
> 
> 	if (!ctx)
> 		return;
> 
> 	/* Finalize image-level hash */
> 	crypto_shash_final(ctx->image_hash, ctx->image_digest);
> 
> 	pr_info("snapenc: hibernate image encryption complete\n");
> 	pr_debug("snapenc: image SHA-256: %*phN\n",
> 		 SHA256_DIGEST_SIZE, ctx->image_digest);
> 
> 	/* Don't free ctx here — resume needs the sealed key */
> }
> 
> /**
>  * snapenc_resume_begin - Called before reading the hibernate image.
>  *
>  * Sequence:
>  *  1. Extend PCR23 with the same magic value used during hibernate
>  *  2. Ask TPM to unseal the key (will fail if PCR doesn't match)
>  *  3. Re-initialize AES-GCM with the unsealed key
>  *  4. Reset PCR23
>  *
>  * Returns 0 on success, -EACCES if TPM policy fails (image tampered
>  * or wrong system), negative on other errors.
>  */
> int snapenc_resume_begin(void)
> {
> 	struct tpm_chip *chip;
> 	struct snapenc_ctx *ctx = hibernate_enc_ctx;
> 	u8 unsealed_key[SNAPENC_KEY_SIZE];
> 	int rc;
> 
> 	if (!ctx) {
> 		pr_err("snapenc: no encryption context for resume\n");
> 		return -EINVAL;
> 	}
> 
> 	chip = tpm_default_chip();
> 	if (!chip) {
> 		pr_err("snapenc: no TPM chip available for resume\n");
> 		return -ENODEV;
> 	}
> 
> 	/* Step 1: Extend PCR23 — must match state at seal time */
> 	rc = snapenc_pcr_extend(chip);
> 	if (rc) {
> 		pr_err("snapenc: resume PCR%d extend failed: %d\n",
> 		       hibernate_tpm_pcr, rc);
> 		goto out;
> 	}
> 
> 	/* Step 2: Unseal key — TPM checks PCR23 matches policy */
> 	rc = snapenc_unseal_key(chip, &ctx->sealed, unsealed_key);
> 	if (rc == -EACCES) {
> 		pr_crit("snapenc: TPM REFUSED to release hibernate key.\n"
> 			"PCR%d state does not match seal-time policy.\n"
> 			"This may indicate: wrong system, firmware change, "
> 			"or the hibernate image was created on a different boot.\n"
> 			"Resume aborted for security.\n",
> 			hibernate_tpm_pcr);
> 		goto out_reset_pcr;
> 	}
> 	if (rc) {
> 		pr_err("snapenc: key unseal failed: %d\n", rc);
> 		goto out_reset_pcr;
> 	}
> 
> 	/* Step 3: Re-arm the AES transform with the unsealed key */
> 	rc = crypto_aead_setkey(ctx->tfm, unsealed_key, SNAPENC_KEY_SIZE);
> 	memzero_explicit(unsealed_key, SNAPENC_KEY_SIZE);
> 	if (rc) {
> 		pr_err("snapenc: failed to restore AES key: %d\n", rc);
> 		goto out_reset_pcr;
> 	}
> 
> 	/* Step 4: Reset PCR23 */
> 	snapenc_pcr_reset(chip);
> 
> 	pr_info("snapenc: TPM key unseal successful, resuming\n");
> 	tpm_put_chip(chip);
> 	return 0;
> 
> out_reset_pcr:
> 	snapenc_pcr_reset(chip);
> out:
> 	memzero_explicit(unsealed_key, SNAPENC_KEY_SIZE);
> 	tpm_put_chip(chip);
> 	return rc;
> }
> 
> /**
>  * snapenc_resume_end - Called after successful resume.
>  *
>  * Cleans up the encryption context.
>  */
> void snapenc_resume_end(void)
> {
> 	snapenc_ctx_free(hibernate_enc_ctx);
> 	hibernate_enc_ctx = NULL;
> }
> 
> /* ------------------------------------------------------------------ */
> /*  Module init: verify TPM availability and PCR state                 */
> /* ------------------------------------------------------------------ */
> 
> static int __init snapenc_init(void)
> {
> 	struct tpm_chip *chip;
> 	int rc;
> 
> 	/* Only meaningful if lockdown is active */
> 	if (!kernel_is_locked_down(NULL)) {
> 		pr_debug("snapenc: kernel not locked down, "
> 			 "hibernate encryption available but not required\n");
> 	}
> 
> 	chip = tpm_default_chip();
> 	if (!chip) {
> 		pr_warn("snapenc: no TPM2 chip found. "
> 			"Hibernate encryption unavailable.\n");
> 		return -ENODEV;
> 	}
> 
> 	if (!tpm_is_tpm2(chip)) {
> 		pr_err("snapenc: TPM1.x not supported, need TPM2\n");
> 		tpm_put_chip(chip);
> 		return -ENODEV;
> 	}
> 
> 	/* Verify PCR is free at boot time */
> 	rc = snapenc_pcr_is_zero(chip);
> 	if (rc) {
> 		tpm_put_chip(chip);
> 		return rc;
> 	}
> 
> 	pr_info("snapenc: initialized. Using PCR%d on %s for hibernate sealing.\n",
> 		hibernate_tpm_pcr, dev_name(&chip->dev));
> 	tpm_put_chip(chip);
> 	return 0;
> }
> late_initcall(snapenc_init);

> /* SPDX-License-Identifier: GPL-2.0-only */
> /*
>  * kernel/power/snapenc.h
>  *
>  * Interface for hibernate image encryption using TPM2 + PCR sealing.
>  */
> 
> #ifndef __POWER_SNAPENC_H
> #define __POWER_SNAPENC_H
> 
> #ifdef CONFIG_HIBERNATION_ENCRYPTION
> 
> int  snapenc_hibernate_begin(void);
> void snapenc_hibernate_end(void);
> int  snapenc_resume_begin(void);
> void snapenc_resume_end(void);
> 
> ssize_t snapenc_encrypt_chunk(struct snapenc_ctx *ctx,
> 			      const u8 *in, size_t in_len,
> 			      u8 *out, u64 chunk_idx);
> 
> ssize_t snapenc_decrypt_chunk(struct snapenc_ctx *ctx,
> 			      const u8 *in, size_t in_len,
> 			      u8 *out, u64 chunk_idx);
> 
> #else /* !CONFIG_HIBERNATION_ENCRYPTION */
> 
> static inline int  snapenc_hibernate_begin(void) { return 0; }
> static inline void snapenc_hibernate_end(void)   { }
> static inline int  snapenc_resume_begin(void)    { return 0; }
> static inline void snapenc_resume_end(void)      { }
> 
> #endif /* CONFIG_HIBERNATION_ENCRYPTION */
> #endif /* __POWER_SNAPENC_H */

