From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 14:39:07 -0800
Message-ID: <1452724747.3092.96.camel@linux.intel.com>
References: <alpine.DEB.2.11.1601131042590.3575@nanos>
	 <20160113082113.3314fa92@icelake> <20160113163610.GH12897@pd.tnic>
	 <20160113095124.186ff487@yairi> <20160113180412.GN12897@pd.tnic>
	 <20160113102138.4e34e890@yairi> <20160113191622.GP12897@pd.tnic>
	 <20160113121003.3e9c2108@yairi> <20160113212602.GT12897@pd.tnic>
	 <1452722083.3092.92.camel@linux.intel.com> <20160113221613.GW12897@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53041 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077AbcAMWkc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Jan 2016 17:40:32 -0500
In-Reply-To: <20160113221613.GW12897@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Wed, 2016-01-13 at 23:16 +0100, Borislav Petkov wrote:
> On Wed, Jan 13, 2016 at 01:54:43PM -0800, Srinivas Pandruvada wrote:
> > regmap_update_bits(), which is referenced for 346 times.
> 
> I'm at a loss as to why people keep talking about regmap.

Thomas Gleixner, understood the context and he gave a satisfactory
reply.

Thanks,
Srinivas

