From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/2] x86/msr: add on cpu read/modify/write function
Date: Tue, 12 Jan 2016 17:14:26 -0800
Message-ID: <20160112171426.20062fa8@yairi>
References: <1449873637-24300-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1449873637-24300-2-git-send-email-jacob.jun.pan@linux.intel.com>
	<alpine.DEB.2.11.1512201421300.28591@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5889 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbcAMBQu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 Jan 2016 20:16:50 -0500
In-Reply-To: <alpine.DEB.2.11.1512201421300.28591@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, jacob.jun.pan@linux.intel.com

On Sun, 20 Dec 2015 14:28:48 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> So this is a copy of the above !SMP inline. What's wrong with
> providing:
> 
>  int rmwmsrl_safe(msr_no, clear_mask, set_mask)
> 
> in x86/lib/msr.c and make the !SMP variant of rdmsrl_safe_on_cpu()
> and that variant for the SMP case a simple wrapper around it?
> 
> static void remote_rmwmsrl_safe(void *info)
> {
> 	struct msr_action *ma = info;
> 
> 	return rmwmsrl_safe(ma->msr, ma->clear_mask, ma->set_mask);
> }
> 
> No gotos, no pointless code duplication. Just simple.
much better, just sent new code in v2. Sorry for the delay.

Thanks
