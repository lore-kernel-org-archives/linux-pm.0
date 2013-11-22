From: Eliezer Tamir <eliezer.tamir@linux.intel.com>
Subject: Re: [PATCH 6/7] sched: Clean up preempt_enable_no_resched() abuse
Date: Fri, 22 Nov 2013 08:56:00 +0200
Message-ID: <528F0000.7000505@linux.intel.com>
References: <20131120160450.072555619@infradead.org> <20131120162736.691879744@infradead.org> <528CF94E.8020300@linux.intel.com> <20131121101018.GX10022@twins.programming.kicks-ass.net> <528E09F9.9030501@linux.intel.com> <20131121133936.GF10022@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58193 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab3KVG4Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Nov 2013 01:56:24 -0500
In-Reply-To: <20131121133936.GF10022@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, Chris Leech <christopher.leech@intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 21/11/2013 15:39, Peter Zijlstra wrote:
> On Thu, Nov 21, 2013 at 03:26:17PM +0200, Eliezer Tamir wrote:

>> We don't override any limit the user has put on the system call.
> 
> You are in fact, note how the normal select @endtime argument is only
> set up _after_ you're done polling. So if the syscall had a timeout of 5
> seconds, you just blew it by 55.
> 

That's a bug, we will fix it.

Cheers,
Eliezer
