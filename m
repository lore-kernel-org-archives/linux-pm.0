From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: 50 Watt idle power regression bisected to Linux-3.10
Date: Wed, 11 Dec 2013 17:44:03 +0100
Message-ID: <20131211164403.GB2480@laptop.programming.kicks-ass.net>
References: <1386652637.5374.72.camel@marge.simpson.net>
 <alpine.DEB.2.02.1312101458040.28330@ionos.tec.linutronix.de>
 <alpine.DEB.2.02.1312110030330.28330@ionos.tec.linutronix.de>
 <1386732093.5964.6.camel@marge.simpson.net>
 <alpine.DEB.2.02.1312111206200.28330@ionos.tec.linutronix.de>
 <20131211113839.GF21683@pd.tnic>
 <20131211115239.GA21999@twins.programming.kicks-ass.net>
 <1386764955.12005.60.camel@marge.simpson.net>
 <20131211124352.GB21999@twins.programming.kicks-ass.net>
 <20131211144238.GA4510@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:35155 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab3LKQoO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2013 11:44:14 -0500
Content-Disposition: inline
In-Reply-To: <20131211144238.GA4510@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Mike Galbraith <bitbucket@online.de>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Eder <jeder@redhat.com>, x86@kernel.org

On Wed, Dec 11, 2013 at 03:42:38PM +0100, Ingo Molnar wrote:
> Another thing that is required I think is to issue a write barrier 
> before CLFLUSH instruction. By my (possibly incorrect ...) reading of 
> the documentation CLFLUSH does not appear to be ordered (at all), so 
> it might execute before the modification to the affected memory?
> 
> 
> So something like:
> 
> 		if (this_cpu_has(X86_FEATURE_CLFLUSH_MONITOR)) {
> 			smp_wmb(); /* order CLFLUSH */
> 			clflush(&current_thread_info()->flags);
> 		}

smp_wmb() is a NO-OP on x86 remember :-)

Also, a wmb doesn't actually need to flush the store buffers.
