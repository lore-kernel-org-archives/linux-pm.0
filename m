From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory map by md5 value
Date: Wed, 31 Aug 2016 02:27:53 +0200
Message-ID: <4324101.BrknapGkIi@vostro.rjw.lan>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65507 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1750849AbcHaAWF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2016 20:22:05 -0400
In-Reply-To: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Lee@vger.kernel.org, Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>

On Monday, August 29, 2016 12:35:40 AM Chen Yu wrote:
> On some platforms, there is occasional panic triggered when trying to
> resume from hibernation, a typical panic looks like:
> 
> "BUG: unable to handle kernel paging request at ffff880085894000
> IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"
> 
> This is because e820 map has been changed by BIOS across
> hibernation, and one of the page frames from first kernel
> is right located in second kernel's unmapped region, so panic
> comes out when accessing unmapped kernel address.
> 
> In order to expose this issue earlier, the md5 hash of e820 map
> is passed from suspend kernel to resume kernel, and the system will
> trigger panic once it finds the md5 value of previous kernel is not
> the same as current resume kernel.
> 
> Note:
> 1. Without this patch applied, it is possible that BIOS has
>    provided an inconsistent memory map, but the resume kernel is still
>    able to restore the image anyway(e.g.,  E820_RAM region is the subset
>    of the previous one), although the system might be unstable. So this
>    patch tries to treat any inconsistent e820 as illegal.
> 
> 2. Another case is, this patch replies on comparing the e820_saved, but
>    currently the e820_save might not be strictly the same across
>    hibernation, even if BIOS has provided consistent e820 map - In
>    theory mptable might modify the BIOS-provided e820_saved dynamically
>    in early_reserve_e820_mpc_new, which would allocate a buffer from
>    E820_RAM, and marks it from E820_RAM to E820_RESERVED). 
>    This is a potential and rare case we need to deal with in OS in
>    the future.
> 
> Suggested-by: Pavel Machek <pavel@ucw.cz>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Lee, Chun-Yi <jlee@suse.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v8:
>  - Panic the system once the e820 is found to be inconsistent
>    during resume.
>    Fix the md5 hash len from 128 bytes to 16 bytes.
> v7:
>  - Use md5 hash to compare the e820 map.
> v6:
>  - Fix some compiling errors reported by 0day/LKP, adjust
>    Kconfig/variable namings.
> v5:
>  - Rewrite this patch to just warn user of the broken BIOS
>    when panic.
> v4:
>  - Add __attribute__ ((unused)) for swsusp_page_is_valid,
>    to eliminate the warnning of:
>    'swsusp_page_is_valid' defined but not used
>    on non-x86 platforms.
> 
> v3:
>  - Adjust the logic to exclude the end_pfn boundary in pfn_mapped
>    when invoking mark_valid_pages, because the end_pfn is not
>    a mapped page frame, we should not regard it as a valid page.
> 
>    Move the sanity check of valid pages to a early stage in resuming
>    process(moved to mark_unsafe_pages), in this way, we can avoid
>    unnecessarily accessing these invalid pages in later stage(yes,
>    move to the original position Joey once introduced in:
>    Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820
>    reserved regions")
> 
>    With v3 patch applied, I did 30 cycles on my problematic platform,
>    no panic triggered anymore(50% reproducible before patched, by
>    plugging/unplugging memory peripheral during hibernation), and it
>    just warns of invalid pages.
> 
> v2:
>  - According to Ingo's suggestion, rewrite this patch.
> 
>    New version just checks each page frame according to pfn_mapped array.
>    So that we do not need to touch existing code related to
>    E820_RESERVED_KERN. And this method can naturely guarantee
>    that the system before/after hibernation do not need to be of
>    the same memory size on x86_64.
> 
> ---
>  arch/x86/power/hibernate_64.c | 98 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/power/Kconfig          |  9 ++++
>  2 files changed, 107 insertions(+)
> 
> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
> index 9634557..7eb27afd 100644
> --- a/arch/x86/power/hibernate_64.c
> +++ b/arch/x86/power/hibernate_64.c
> @@ -11,6 +11,10 @@
>  #include <linux/gfp.h>
>  #include <linux/smp.h>
>  #include <linux/suspend.h>
> +#include <linux/scatterlist.h>
> +#include <linux/kdebug.h>
> +
> +#include <crypto/hash.h>
>  
>  #include <asm/init.h>
>  #include <asm/proto.h>
> @@ -177,15 +181,100 @@ int pfn_is_nosave(unsigned long pfn)
>  	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
>  }
>  
> +#define MD5_DIGEST_SIZE 16
> +
>  struct restore_data_record {
>  	unsigned long jump_address;
>  	unsigned long jump_address_phys;
>  	unsigned long cr3;
>  	unsigned long magic;
> +	u8 e820_digest[MD5_DIGEST_SIZE];
>  };
>  
>  #define RESTORE_MAGIC	0x123456789ABCDEF0UL

You're changing the image header format, so RESTORE_MAGIC needs to be updated
too.

>  
> +#ifdef CONFIG_HIBERNATION_CHECK_E820
> +
> +/**
> + *	get_e820_md5 - calculate md5 according to e820 map
> + *
> + *	@map: the e820 map to be calculated
> + *	@buf: the md5 result to be stored to
> + */

Please use spaces instead of tabs in the kerneldoc (note to self: the existing
ones need to be fixed too).

> +static int get_e820_md5(struct e820map *map, void *buf)
> +{
> +	struct scatterlist sg;
> +	struct crypto_ahash *tfm;
> +	struct ahash_request *req;
> +	int ret = 0;
> +
> +	tfm = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);

You need to ensure that crypto_alloc_ahash() and friends are built in.

> +	if (IS_ERR(tfm))
> +		return -ENOMEM;
> +
> +	req = ahash_request_alloc(tfm, GFP_KERNEL);
> +	if (!req) {
> +		ret = -ENOMEM;
> +		goto free_ahash;
> +	}
> +
> +	sg_init_one(&sg, (u8 *)map, sizeof(struct e820map));
> +	ahash_request_set_callback(req, 0, NULL, NULL);
> +	ahash_request_set_crypt(req, &sg, buf, sizeof(struct e820map));
> +
> +	if (crypto_ahash_digest(req))
> +		ret = -EINVAL;
> +
> +	ahash_request_free(req);
> + free_ahash:
> +	crypto_free_ahash(tfm);
> +
> +	return ret;
> +}
> +
> +static int hibernation_e820_save(void *buf)
> +{
> +	int ret;
> +	u8 result[MD5_DIGEST_SIZE] = {0};
> +
> +	ret = get_e820_md5(&e820_saved, result);

Why can't you do it on buf directly without the intermediate buffer on the
stack?

> +	if (ret)
> +		return ret;
> +
> +	memcpy(buf, result, MD5_DIGEST_SIZE);
> +
> +	return 0;

Plus the only caller of this doesn't check the return value of it, so
why is it not void?

> +}
> +
> +static int hibernation_e820_check(void *buf)
> +{
> +	int ret;
> +	u8 result[MD5_DIGEST_SIZE] = {0};
> +
> +	ret = get_e820_md5(&e820_saved, result);
> +	if (ret)
> +		return ret;
> +
> +	if (memcmp(result, buf, MD5_DIGEST_SIZE)) {
> +		pr_err("PM: e820 map conflict detected.\n");
> +		panic("BIOS is playing funny tricks with us.\n");

As I said to Pavel, this doesn't serve any useful purpose.

Make this one a bool function, call it hibernate_e820_mismatch() and then
you can do ->

> +	}
> +
> +	return 0;
> +}
> +
> +#else
> +static int hibernation_e820_save(void *buf)
> +{
> +	return 0;
> +}
> +
> +static int hibernation_e820_check(void *buf)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /**
>   *	arch_hibernation_header_save - populate the architecture specific part
>   *		of a hibernation image header
> @@ -201,6 +290,9 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>  	rdr->jump_address_phys = __pa_symbol(&restore_registers);
>  	rdr->cr3 = restore_cr3;
>  	rdr->magic = RESTORE_MAGIC;
> +
> +	hibernation_e820_save(rdr->e820_digest);
> +
>  	return 0;
>  }
>  
> @@ -216,5 +308,11 @@ int arch_hibernation_header_restore(void *addr)
>  	restore_jump_address = rdr->jump_address;
>  	jump_address_phys = rdr->jump_address_phys;
>  	restore_cr3 = rdr->cr3;
> +
> +	/*
> +	 * Check if suspend e820 map is the same with the resume e820 map.
> +	 */
> +	hibernation_e820_check(rdr->e820_digest);

->
	if (hibernate_e820_mismatch(rdr->e820_digest))
		return -ENODEV;

for example.

> +
>  	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
>  }
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 68d3ebc..f0ba5e7 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -76,6 +76,15 @@ config HIBERNATION
>  
>  	  For more information take a look at <file:Documentation/power/swsusp.txt>.
>  
> +config HIBERNATION_CHECK_E820

That is a bit clumsy.

First off, ARM64 uses ARCH_HIBERNATION_HEADER, so depending on this one alone
is not enough.  Moreover, it depends on the hash to be available, so that needs
to be taken into account as well.

Second, I'm not sure if making it user-selectable adds any value.

> +	bool "Check the consistence of e820 map across hibernation"
> +	depends on ARCH_HIBERNATION_HEADER
> +	---help---
> +	  Check if the resume kernel has the same BIOS-provided
> +	  e820 memory map as the one in suspend kernel(requested
> +	  by ACPI spec), by comparing the md5 digest of the two e820
> +	  regions.
> +
>  config ARCH_SAVE_PAGE_KEYS
>  	bool

Thanks,
Rafael

