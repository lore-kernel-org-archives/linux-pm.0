From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 10/10] arm64: kernel: Add support for
 hibernate/suspend-to-disk.
Date: Tue, 15 Dec 2015 17:42:32 +0000
Message-ID: <20151215174231.GC24286@e104818-lin.cambridge.arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-11-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50910 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932211AbbLORmh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Dec 2015 12:42:37 -0500
Content-Disposition: inline
In-Reply-To: <1448559168-8363-11-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Geoff Levand <geoff@infradead.org>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Pavel Machek <pavel@ucw.cz>, Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, wangfei <w.f@huawei.com>, Kevin Kang <kkang@intrinsyc.com>

On Thu, Nov 26, 2015 at 05:32:48PM +0000, James Morse wrote:
> +static int copy_page_tables(pgd_t *new_pgd, unsigned long start_addr)
> +{
> +	int i;
> +	int rc = 0;
> +	pud_t *new_pud;
> +	pgd_t *old_pgd = pgd_offset_k(start_addr);
> +
> +	new_pgd += pgd_index(start_addr);
> +
> +	for (i = pgd_index(start_addr); i < PTRS_PER_PGD;
> +	     i++, start_addr += PGDIR_SIZE, old_pgd++, new_pgd++) {
> +		if (!pgd_val(*old_pgd))
> +			continue;
> +
> +		if (PTRS_PER_PUD != 1) {
> +			new_pud = (pud_t *)get_safe_page(GFP_ATOMIC);
> +			if (!new_pud) {
> +				rc = -ENOMEM;
> +				break;
> +			}
> +
> +			set_pgd(new_pgd, __pgd(virt_to_phys(new_pud)
> +					       | PUD_TYPE_TABLE));
> +		}
> +
> +		rc = copy_pud(new_pgd, old_pgd, &start_addr);
> +		if (rc)
> +			break;
> +
> +		start_addr &= PGDIR_MASK;
> +	}
> +
> +	return rc;
> +}

I think you could implement the above with fewer lines if you followed a
common pattern for page table walking based on do...while(),
pgd_addr_end() etc. See copy_page_range() as a (more complex) example.

-- 
Catalin
