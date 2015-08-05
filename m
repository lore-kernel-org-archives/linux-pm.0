From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/1] x86: replace RDRAND forced-reseed with simple sanity
 check
Date: Wed, 5 Aug 2015 12:07:28 +0200
Message-ID: <20150805100728.GA572@gmail.com>
References: <001e354e9435443b1720838a111620c4eec12a61.1438356386.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34844 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbHEKHd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 06:07:33 -0400
Content-Disposition: inline
In-Reply-To: <001e354e9435443b1720838a111620c4eec12a61.1438356386.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>


* Len Brown <lenb@kernel.org> wrote:

>  void x86_init_rdrand(struct cpuinfo_x86 *c)
>  {
>  #ifdef CONFIG_ARCH_RANDOM
>  	unsigned long tmp;
> -	int i, count, ok;
> +	int i;
>  
>  	if (!cpu_has(c, X86_FEATURE_RDRAND))
> -		return;		/* Nothing to do */
> +		return;
>  
> -	for (count = i = 0; i < RESEED_LOOP; i++) {
> -		ok = rdrand_long(&tmp);
> -		if (ok)
> -			count++;
> +	for (i = 0; i < SANITY_CHECK_LOOPS; i++) {
> +		if (!rdrand_long(&tmp)) {
> +			clear_cpu_cap(c, X86_FEATURE_RDRAND);
> +			return;

So here we should emit a printk_once() warning that something's fishy, instead of 
silently disabling a CPU feature.

Thanks,

	Ingo
