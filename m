From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v4 1/9] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
Date: Wed, 12 Dec 2012 23:41:21 +0530
Message-ID: <50C8C8C9.2070605@linux.vnet.ibm.com>
References: <20121211140314.23621.64088.stgit@srivatsabhat.in.ibm.com> <20121211140358.23621.97011.stgit@srivatsabhat.in.ibm.com> <20121212171720.GA22289@redhat.com> <20121212172431.GA23328@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:46875 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab2LLSNF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Dec 2012 13:13:05 -0500
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Wed, 12 Dec 2012 23:42:37 +0530
In-Reply-To: <20121212172431.GA23328@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/12/2012 10:54 PM, Oleg Nesterov wrote:
> On 12/12, Oleg Nesterov wrote:
>>
>> On 12/11, Srivatsa S. Bhat wrote:
>>>
>>> IOW, the hotplug readers just increment/decrement their per-cpu refcounts
>>> when no writer is active.
>>
>> plus cli/sti ;) and increment/decrement are atomic.
>                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> OOPS, sorry I was going to say "adds mb()".
> 

Ok, got it :)

> And when I look at get_online_cpus_atomic() again it uses rmb(). This
> doesn't look correct, we need the full barrier between this_cpu_inc()
> and writer_active().
> 

Hmm..

> At the same time reader_nested_percpu() can be checked before mb().
> 

I thought that since the increment and the check (reader_nested_percpu)
act on the same memory location, they will naturally be run in the given
order, without any need for barriers. Am I wrong?

(I referred Documentation/memory-barriers.txt again to verify this, and
the second point under the "Guarantees" section looked like it said the
same thing : "Overlapping loads and stores within a particular CPU will
appear to be ordered within that CPU").

Regards,
Srivatsa S. Bhat

