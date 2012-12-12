From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v4 1/9] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
Date: Thu, 13 Dec 2012 01:13:55 +0530
Message-ID: <50C8DE7B.8080708@linux.vnet.ibm.com>
References: <20121211140314.23621.64088.stgit@srivatsabhat.in.ibm.com> <20121211140358.23621.97011.stgit@srivatsabhat.in.ibm.com> <20121212171720.GA22289@redhat.com> <50C8C4A5.4080104@linux.vnet.ibm.com> <20121212180248.GA24882@redhat.com> <20121212193646.GA29395@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:59179 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab2LLTp3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Dec 2012 14:45:29 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 13 Dec 2012 01:14:56 +0530
In-Reply-To: <20121212193646.GA29395@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/13/2012 01:06 AM, Oleg Nesterov wrote:
> On 12/12, Oleg Nesterov wrote:
>>
>> On 12/12, Srivatsa S. Bhat wrote:
>>>
>>> On 12/12/2012 10:47 PM, Oleg Nesterov wrote:
>>>>
>>>> Why it needs to be per-cpu? It can be global and __read_mostly to avoid
>>>> the false-sharing. OK, perhaps to put reader_percpu_refcnt/writer_signal
>>>> into a single cacheline...
>>>
>>> Even I realized this (that we could use a global) after posting out the
>>> series.. But do you think that it would be better to retain the per-cpu
>>> variant itself, due to the cache effects?
>>
>> I don't really know, up to you. This was the question ;)
> 
> But perhaps there is another reason to make it per-cpu...
> 
> It seems we can avoid cpu_hotplug.active_writer == current check in
> get/put.
> 
> take_cpu_down() can clear this_cpu(writer_signal) right after it takes
> hotplug_rwlock for writing. It runs with irqs and preemption disabled,
> nobody else will ever look at writer_signal on its CPU.
> 

Hmm.. And then the get/put_ on that CPU will increment/decrement the per-cpu
refcount, but we don't care.. because we only need to ensure that they don't
deadlock by taking the rwlock for read.

This sounds great!

Regards,
Srivatsa S. Bhat

