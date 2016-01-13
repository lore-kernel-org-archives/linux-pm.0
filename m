From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 08:21:13 -0800
Message-ID: <20160113082113.3314fa92@icelake>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<alpine.DEB.2.11.1601131042590.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59658 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846AbcAMQW2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Jan 2016 11:22:28 -0500
In-Reply-To: <alpine.DEB.2.11.1601131042590.3575@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, jacob.jun.pan@linux.intel.com, Borislav Petkov <bp@alien8.de>

On Wed, 13 Jan 2016 10:47:26 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> So here you actually use that new (misnomed) function, but for 
> 
> > +static void power_limit_irq_save_cpu(void *info)  
> 
> and
> 
> > +static void power_limit_irq_restore_cpu(void *info)  
> 
> you use a bog standard smp function call. What's the benefit of
> adding that rmw function over a bog standard smp function call if you
> can only use it for one instance of the same pattern?
> 
> Boris asked you the same question here
> 
>       https://lkml.kernel.org/r/20151220152749.GA29805@pd.tnic
> 
> but you decided to ignore it.
+Borislav,

Thanks for bring this out. I didn't mean to ignore. I thought my point
was stated in the commit message there was no point of going back and
forth. Read-Modify-Write is quite common, not just for RAPL could be
used by future code. Sorry if I wasn't clear.

Jacob
