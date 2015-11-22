From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2] x86: replace RDRAND forced-reseed with simple sanity check
Date: Sun, 22 Nov 2015 17:28:10 -0500
Message-ID: <CAJvTdKkRYAdqwX3PA=iCh4TD=6NE8QJALEipFH+MwU-EZYM1XA@mail.gmail.com>
References: <058618cc56ec6611171427ad7205e37e377aa8d4.1439738240.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34728 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbbKVW2M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2015 17:28:12 -0500
In-Reply-To: <058618cc56ec6611171427ad7205e37e377aa8d4.1439738240.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>

Ingo, PeterA,

ping.

Please let me know if you require a revision to this patch,
or if you would like me to re-send it.

thanks,
-Len


On Sun, Aug 16, 2015 at 11:20 AM, Len Brown <lenb@kernel.org> wrote:
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
>
> This change reduces the cost of x86_init_rdrand() by a factor of 1,000x,
> to O(1us) from O(1,000us).
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> v2: add printk_once() on disabling rdrand, per feedback from Ingo Molnar
> ---
>  arch/x86/kernel/cpu/rdrand.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
> index 136ac74..819d949 100644
> --- a/arch/x86/kernel/cpu/rdrand.c
> +++ b/arch/x86/kernel/cpu/rdrand.c
> @@ -33,28 +33,27 @@ static int __init x86_rdrand_setup(char *s)
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
>         unsigned long tmp;
> -       int i, count, ok;
> +       int i;
>
>         if (!cpu_has(c, X86_FEATURE_RDRAND))
> -               return;         /* Nothing to do */
> +               return;
>
> -       for (count = i = 0; i < RESEED_LOOP; i++) {
> -               ok = rdrand_long(&tmp);
> -               if (ok)
> -                       count++;
> +       for (i = 0; i < SANITY_CHECK_LOOPS; i++) {
> +               if (!rdrand_long(&tmp)) {
> +                       clear_cpu_cap(c, X86_FEATURE_RDRAND);
> +                       printk_once(KERN_WARNING "rdrand: disabled\n");
> +                       return;
> +               }
>         }
> -
> -       if (count != RESEED_LOOP)
> -               clear_cpu_cap(c, X86_FEATURE_RDRAND);
>  #endif
>  }
> --
> 2.5.0.330.g130be8e
>



-- 
Len Brown, Intel Open Source Technology Center
