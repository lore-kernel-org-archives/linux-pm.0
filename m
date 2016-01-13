From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 09:51:24 -0800
Message-ID: <20160113095124.186ff487@yairi>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<alpine.DEB.2.11.1601131042590.3575@nanos>
	<20160113082113.3314fa92@icelake>
	<20160113163610.GH12897@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19091 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932130AbcAMRvZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Jan 2016 12:51:25 -0500
In-Reply-To: <20160113163610.GH12897@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, jacob.jun.pan@linux.intel.com

On Wed, 13 Jan 2016 17:36:10 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Jan 13, 2016 at 08:21:13AM -0800, Jacob Pan wrote:
> > Thanks for bring this out. I didn't mean to ignore. I thought my
> > point was stated in the commit message there was no point of going
> > back and forth. Read-Modify-Write is quite common, not just for
> > RAPL could be used by future code. Sorry if I wasn't clear.
> 
> But it also shows that it doesn't suffice for all your needs. So why
> add it?
> 
> You can much better define your own functions which do all the MSR
> handling you require and call them with smp_call_function_*.
> 
yeah, that is what I did in the original patch.
https://lkml.org/lkml/2015/12/7/1090

Then i was suggested to add a rmw msr api for the common good :), I
think it is a good idea since such operation is not limited to RAPL
driver. Other register access APIs such as regmap have more complete
selections.


Jacob
