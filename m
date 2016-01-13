From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 23:16:13 +0100
Message-ID: <20160113221613.GW12897@pd.tnic>
References: <alpine.DEB.2.11.1601131042590.3575@nanos>
 <20160113082113.3314fa92@icelake>
 <20160113163610.GH12897@pd.tnic>
 <20160113095124.186ff487@yairi>
 <20160113180412.GN12897@pd.tnic>
 <20160113102138.4e34e890@yairi>
 <20160113191622.GP12897@pd.tnic>
 <20160113121003.3e9c2108@yairi>
 <20160113212602.GT12897@pd.tnic>
 <1452722083.3092.92.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452722083.3092.92.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 13, 2016 at 01:54:43PM -0800, Srinivas Pandruvada wrote:
> regmap_update_bits(), which is referenced for 346 times.

I'm at a loss as to why people keep talking about regmap.

$ git grep regmap_update_bits arch/x86/
$

> Are you saying that any such calls are not useful?

It seems I have to repeat myself ad absurdum so let me summarize: I
don't have anything against useful APIs. Those are not.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
