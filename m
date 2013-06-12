From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: power-efficient scheduling design
Date: Tue, 11 Jun 2013 18:48:58 -0700
Message-ID: <51B7D38A.7050204@linux.intel.com>
References: <20130530134718.GB32728@e103034-lin> <51B221AF.9070906@linux.vnet.ibm.com> <20130608112801.GA8120@MacBook-Pro.local> <1834293.MlyIaiESPL@vostro.rjw.lan> <51B3F99A.4000101@linux.vnet.ibm.com> <51B5FE02.7040607@linaro.org> <alpine.DEB.2.02.1306111722470.24968@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17493 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757783Ab3FLBtA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 11 Jun 2013 21:49:00 -0400
In-Reply-To: <alpine.DEB.2.02.1306111722470.24968@nftneq.ynat.uz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Lang <david@lang.hm>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@kernel.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "alex.shi@intel.com" <alex.shi@intel.com>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, Mike Galbraith <efault@gmx.de>, "pjt@google.com" <pjt@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, "len.brown@intel.com" <len.brown@intel.com>, "corbet@lwn.net" <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>

On 6/11/2013 5:27 PM, David Lang wrote:
>
> Nobody is saying that this sort of thing should be in the fastpath of the scheduler.
>
> But if the scheduler has a table that tells it the possible states, and the cost to get from the current state to each of these states (and to get back and/or wake up to
> full power), then the scheduler can make the decision on what to do, invoke a routine to make the change (and in the meantime, not be fighting the change by trying to
> schedule processes on a core that's about to be powered off), and then when the change happens, the scheduler will have a new version of the table of possible states and costs
>
> This isn't in the fastpath, it's in the rebalancing logic.

the reality is much more complex unfortunately.
C and P states hang together tightly, and even C state on
one core impacts other cores' performance, just like P state selection
on one core impacts other cores.

(at least for x86, we should really stop talking as if the OS picks the "frequency",
that's just not the case anymore)

