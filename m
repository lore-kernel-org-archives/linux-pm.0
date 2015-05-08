From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86: speed cpu_up by quirking cpu_init_udelay
Date: Fri, 8 May 2015 10:23:20 +0200
Message-ID: <20150508082319.GA4137@pd.tnic>
References: <418898b5b9a6d76e7fbbd2af7cc988de1a5a287d.1431066425.git.len.brown@intel.com>
 <170f6f6e9ac4aa4d8ec1ed5000bee95463897337.1431066425.git.len.brown@intel.com>
 <20150508075111.GA5403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:52181 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbbEHIXW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 May 2015 04:23:22 -0400
Content-Disposition: inline
In-Reply-To: <20150508075111.GA5403@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, May 08, 2015 at 09:51:11AM +0200, Ingo Molnar wrote:
> > +static const struct x86_cpu_id init_udelay_ids[] = {
> > +	{ X86_VENDOR_INTEL, 0x6, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> > +	{ X86_VENDOR_AMD, 0x16, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> > +	{ X86_VENDOR_AMD, 0x15, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> > +	{ X86_VENDOR_AMD, 0x14, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> > +	{ X86_VENDOR_AMD, 0x12, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> > +	{ X86_VENDOR_AMD, 0x11, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> > +	{ X86_VENDOR_AMD, 0x10, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> > +	{ X86_VENDOR_AMD, 0xF, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
> > +	{}
> > +};
> 
> So since especially AMD likes to iterate the family upwards, why not 
> make this a simple open ended check:
> 
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
> 	    boot_cpu_data.x86 >= 6 ||
> 	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> 	    boot_cpu_data.x86 >= 15) {
> 
> 		... 0 delay ...
> 	}
> 
> ... which is much smaller and more future proof?

I was about to say that...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
