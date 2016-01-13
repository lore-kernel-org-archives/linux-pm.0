From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 23:29:35 +0100
Message-ID: <20160113222935.GX12897@pd.tnic>
References: <alpine.DEB.2.11.1601131042590.3575@nanos>
 <20160113082113.3314fa92@icelake>
 <20160113163610.GH12897@pd.tnic>
 <20160113095124.186ff487@yairi>
 <20160113180412.GN12897@pd.tnic>
 <20160113102138.4e34e890@yairi>
 <20160113191622.GP12897@pd.tnic>
 <20160113121003.3e9c2108@yairi>
 <20160113212602.GT12897@pd.tnic>
 <20160113142007.7c99e826@yairi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:47153 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbcAMW3v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Jan 2016 17:29:51 -0500
Content-Disposition: inline
In-Reply-To: <20160113142007.7c99e826@yairi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>

On Wed, Jan 13, 2016 at 02:20:07PM -0800, Jacob Pan wrote:
> To me the caller code became more readable.

Not to me.

> I think you are referring the function name being not readable, which
> is separate of this conversion.

You think wrong.

I typed in the example and commented right under it. The old code is
much more understandable than the new code. The old code shows what bits
get set and cleared, the new code uses masks, sometimes hidden behind
defines, which people have to look up to understand what's going on. And
then look at the function definition to know which arg which is. And so
on and so on...

But I'm going to stop wasting my time with this now. I gave you enough
arguments against.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
