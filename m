From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86: speed cpu_up by quirking cpu_init_udelay
Date: Fri, 8 May 2015 10:32:51 +0200
Message-ID: <20150508083250.GB4137@pd.tnic>
References: <418898b5b9a6d76e7fbbd2af7cc988de1a5a287d.1431066425.git.len.brown@intel.com>
 <170f6f6e9ac4aa4d8ec1ed5000bee95463897337.1431066425.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:44519 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbbEHIcx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 May 2015 04:32:53 -0400
Content-Disposition: inline
In-Reply-To: <170f6f6e9ac4aa4d8ec1ed5000bee95463897337.1431066425.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, May 08, 2015 at 02:37:55AM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Modern processor familes are on a white-list to remove
> the costly cpu_init_udelay 10000.  Unknown processor families
> get the traditional 10ms delay in cpu_up().
> 
> This seemed more efficient than forcing modern processors
> to exhaustively search a black-list having all the old
> processor families that should have a 10ms delay.
> For not only are new processor familes infrequently added,
> the white list also allows a delay other than 0, if needed.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/kernel/smpboot.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)

...

> +static void __init smp_quirk_init_udelay(void)
> +{
> +	const struct x86_cpu_id *id;
> +	unsigned int new_udelay;
> +
> +	id = x86_match_cpu(init_udelay_ids);
> +	if (id == NULL)
> +		return;	/* if no match, keep default */
> +
> +	if (init_udelay != UDELAY_10MS_DEFAULT)
> +		return;	/* if cmdline changed from default, leave it alone */
> +
> +	new_udelay = (unsigned long) id->driver_data;
> +	pr_debug("cpu_init_udelay quirk to %d, was %d", new_udelay, init_udelay);

Can we make this printk(KERN_DEBUG please?

I'd like to be able to slap "debug" on the command line and not
recompile the kernel. And no, dyndbg="file smpboot.c +p" or whatever the
syntax is, simply doesn't scale if I want to see all debug messages from
early boot.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
