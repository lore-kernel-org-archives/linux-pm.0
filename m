From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] x86/msr: add on cpu read/modify/write function
Date: Sun, 20 Dec 2015 14:28:48 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1512201421300.28591@nanos>
References: <1449873637-24300-1-git-send-email-jacob.jun.pan@linux.intel.com> <1449873637-24300-2-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45297 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbbLTN3o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Dec 2015 08:29:44 -0500
In-Reply-To: <1449873637-24300-2-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>

Jacob,

On Fri, 11 Dec 2015, Jacob Pan wrote:
> +static inline int rmwmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 mask, u64 bits)
> +{
> +	int err;
> +	u64 val;
> +
> +	err = rdmsrl_safe(msr_no, &val);
> +	if (err)
> +		goto out;
> +
> +	val &= ~mask;
> +	val |= bits;
> +
> +	err = wrmsrl_safe(msr_no, val);
> +out:
> +	return err;
> +}

....

> +static void __rmwmsrl_safe(void *info)
> +{
> +	int err;
> +	struct msr_action *ma = info;
> +	u64 val;
> +
> +	err = rdmsrl_safe(ma->msr_no, &val);
> +	if (err)
> +		goto out;
> +
> +	val &= ~ma->mask;
> +	val |= ma->bits;
> +
> +	err = wrmsrl_safe(ma->msr_no, val);
> +
> +out:
> +	ma->err = err;

So this is a copy of the above !SMP inline. What's wrong with providing:

 int rmwmsrl_safe(msr_no, clear_mask, set_mask)

in x86/lib/msr.c and make the !SMP variant of rdmsrl_safe_on_cpu() and that
variant for the SMP case a simple wrapper around it?

static void remote_rmwmsrl_safe(void *info)
{
	struct msr_action *ma = info;

	return rmwmsrl_safe(ma->msr, ma->clear_mask, ma->set_mask);
}

No gotos, no pointless code duplication. Just simple.

Thanks,

	tglx
