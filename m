From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] powercap/rapl: reduce ipi calls
Date: Tue, 8 Dec 2015 09:48:45 +0100
Message-ID: <20151208084845.GE6356@twins.programming.kicks-ass.net>
References: <1449529275-14722-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1449530602.3240.130.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:42108 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933124AbbLHIss (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 03:48:48 -0500
Content-Disposition: inline
In-Reply-To: <1449530602.3240.130.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>

On Mon, Dec 07, 2015 at 03:23:22PM -0800, Srinivas Pandruvada wrote:
> On Mon, 2015-12-07 at 15:01 -0800, Jacob Pan wrote:
> > +struct rapl_msr_action {
> > +	u32 msr;
> > +	unsigned long long value;
> > +	int shift;
> > +	u64 mask;
> > +};
> > +
> > +static void rapl_write_data_cpu(void *info)
> > +{
> > +	u64 msr_val;
> > +	struct rapl_msr_action *ra = (struct rapl_msr_action *)info;
> > +
> > +	rdmsrl_safe(ra->msr, &msr_val);
> > +	msr_val &= ~ra->mask;
> > +	msr_val |= ra->value << ra->shift;
> > +	wrmsrl_safe(ra->msr, msr_val);
> What about adding additional common interface
> wrmsrl_safe_update(), so that everyone can use this?
> 

In which case you want a return value. Also, instead of the value,shift
pair I would add another u64.

Something like:

struct msr_action {
	u32 msr;
	int ret;
	u64 mask, bits;
};

static void msr_update_function(void *info)
{
	struct msr_action *ma = info;
	int ret = 0;
	u64 val;

	ret = rdmsrl_safe(ma->msr, &val);
	if (ret)
		goto out;

	val &= ma->mask;
	val |= ma->bits;

	ret = wrmsrl_safe(ma->msr, val);

out:
	ma->ret = ret;
}

int rmwmsrl_safe_on_cpu(u32 msr, int cpu, u64 mask, u64 bits)
{
	struct msr_action ma = {
		.msr = msr,
		.mask = mask,
		.bits = bits,
	};
	int ret;

	ret = smp_call_function_single(cpu, msr_update_func, &ma, 1);
	if (!ret)
		ret = ma.ret;

	return ret;
}

