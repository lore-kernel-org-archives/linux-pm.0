From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] x86: speed cpu_up by quirking cpu_init_udelay
Date: Fri, 8 May 2015 09:51:11 +0200
Message-ID: <20150508075111.GA5403@gmail.com>
References: <418898b5b9a6d76e7fbbd2af7cc988de1a5a287d.1431066425.git.len.brown@intel.com>
 <170f6f6e9ac4aa4d8ec1ed5000bee95463897337.1431066425.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38752 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbbEHHvR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 03:51:17 -0400
Content-Disposition: inline
In-Reply-To: <170f6f6e9ac4aa4d8ec1ed5000bee95463897337.1431066425.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@alien8.de>


* Len Brown <lenb@kernel.org> wrote:

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

>  static unsigned int init_udelay = UDELAY_10MS_DEFAULT;
>  
> +static const struct x86_cpu_id init_udelay_ids[] = {
> +	{ X86_VENDOR_INTEL, 0x6, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> +	{ X86_VENDOR_AMD, 0x16, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> +	{ X86_VENDOR_AMD, 0x15, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> +	{ X86_VENDOR_AMD, 0x14, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> +	{ X86_VENDOR_AMD, 0x12, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> +	{ X86_VENDOR_AMD, 0x11, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> +	{ X86_VENDOR_AMD, 0x10, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> +	{ X86_VENDOR_AMD, 0xF, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> +	{}
> +};

So since especially AMD likes to iterate the family upwards, why not 
make this a simple open ended check:

	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
	    boot_cpu_data.x86 >= 6 ||
	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
	    boot_cpu_data.x86 >= 15) {

		... 0 delay ...
	}

... which is much smaller and more future proof?

Thanks,

	Ingo
