From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] x86: replace RDRAND forced-reseed with simple sanity
 check
Date: Sun, 2 Aug 2015 18:03:32 +0200
Message-ID: <20150802160332.GB28860@amd>
References: <001e354e9435443b1720838a111620c4eec12a61.1438356386.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55128 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbHBQDe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2015 12:03:34 -0400
Content-Disposition: inline
In-Reply-To: <001e354e9435443b1720838a111620c4eec12a61.1438356386.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri 2015-07-31 11:27:39, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> x86_init_rdrand() was added with 2 goals:
> 
> 1. Sanity check that the built-in-self-test circuit on the Digital
>    Random Number Generator (DRNG) is not complaining.  As RDRAND
>    HW self-checks on every invocation, this goal is achieved
>    by simply invoking RDRAND and checking its return code.
> 
> 2. Force a full re-seed of the random number generator.
>    This was done out of paranoia to benefit the most un-sophisticated
>    DRNG implementation conceivable in the architecture,
>    an implementation that does not exist, and unlikely ever will.
>    This worst-case full-re-seed is achieved by invoking
>    a 64-bit RDRAND 8192 times.
> 
> Unfortunately, this worst-case re-seed costs O(1,000us).
> Magnifying this cost, it is done from identify_cpu(), which is the
> synchronous critical path to bring a processor on-line -- repeated
> for every logical processor in the system at boot and resume from S3.
> 
> As it is very expensive, and of highly dubious value,
> we delete the worst-case re-seed from the kernel.
> 
> We keep the 1st goal -- sanity check the hardware,
> and mark it absent if it complains.

If we trust built-in-self-test... why do we need to do this at all? We
should check the return value at every call, anyway...

									Pavel

> This change reduces the cost of x86_init_rdrand() by a factor of 1,000x,
> to O(1us) from O(1,000us).
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/kernel/cpu/rdrand.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
> index 136ac74..b86817e 100644
> --- a/arch/x86/kernel/cpu/rdrand.c
> +++ b/arch/x86/kernel/cpu/rdrand.c
> @@ -33,28 +33,26 @@ static int __init x86_rdrand_setup(char *s)
>  __setup("nordrand", x86_rdrand_setup);
>  
>  /*
> - * Force a reseed cycle; we are architecturally guaranteed a reseed
> - * after no more than 512 128-bit chunks of random data.  This also
> - * acts as a test of the CPU capability.
> + * RDRAND has Built-In-Self-Test (BIST) that runs on every invocation.
> + * Run the instruction a few times as a sanity check.
> + * If it fails, it is simple to disable RDRAND here.
>   */
> -#define RESEED_LOOP ((512*128)/sizeof(unsigned long))
> +#define SANITY_CHECK_LOOPS 8
>  
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
> +		}
>  	}
> -
> -	if (count != RESEED_LOOP)
> -		clear_cpu_cap(c, X86_FEATURE_RDRAND);
>  #endif
>  }

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
