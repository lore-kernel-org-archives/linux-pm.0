From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v4 1/9] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
Date: Thu, 13 Dec 2012 00:12:43 +0530
Message-ID: <50C8D023.2000908@linux.vnet.ibm.com>
References: <20121211140314.23621.64088.stgit@srivatsabhat.in.ibm.com> <20121211140358.23621.97011.stgit@srivatsabhat.in.ibm.com> <20121212171720.GA22289@redhat.com> <20121212172431.GA23328@redhat.com> <50C8C8C9.2070605@linux.vnet.ibm.com> <20121212182308.GA26094@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:37952 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843Ab2LLSoV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Dec 2012 13:44:21 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 13 Dec 2012 04:39:26 +1000
In-Reply-To: <20121212182308.GA26094@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/12/2012 11:53 PM, Oleg Nesterov wrote:
> On 12/12, Srivatsa S. Bhat wrote:
>>
>> On 12/12/2012 10:54 PM, Oleg Nesterov wrote:
>>
>>> And when I look at get_online_cpus_atomic() again it uses rmb(). This
>>> doesn't look correct, we need the full barrier between this_cpu_inc()
>>> and writer_active().
>>
>> Hmm..
>>
>>> At the same time reader_nested_percpu() can be checked before mb().
>>
>> I thought that since the increment and the check (reader_nested_percpu)
>> act on the same memory location, they will naturally be run in the given
>> order, without any need for barriers. Am I wrong?
> 
> And this is what I meant, you do not need a barrier before
> reader_nested_percpu().
> 

Ah, ok!

> But you need to ensure that WRITE(reader_percpu_refcnt) and READ(writer_signal)
> can't be reordered, so you need mb() in between. rmb() can serialize LOADs and
> STOREs.
> 

OK, got it. (I know you meant s/can/can't).

I'm trying to see if we can somehow exploit the fact that the writer can
potentially tolerate if a reader ignores his signal (to switch to rwlocks)
for a while... and use this to get rid of barriers in the reader path (without
using synchronize_sched() at the writer, of course). And perhaps also take advantage
of the fact that the read_lock() acts as a one-way barrier..

I don't know, maybe its not possible after all.. :-/
 
Regards,
Srivatsa S. Bhat

