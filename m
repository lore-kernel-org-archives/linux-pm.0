From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 1/9] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
Date: Tue, 11 Dec 2012 19:32:13 +0530
Message-ID: <50C73CE5.1080201@linux.vnet.ibm.com>
References: <20121207173702.27305.1486.stgit@srivatsabhat.in.ibm.com> <20121207173759.27305.84316.stgit@srivatsabhat.in.ibm.com> <20121209191437.GA2816@redhat.com> <50C4EB79.5050203@linux.vnet.ibm.com> <20121209202234.GA5793@redhat.com> <50C564ED.9090803@linux.vnet.ibm.com> <20121210172410.GA28479@redhat.com> <50C73192.9010905@linux.vnet.ibm.com> <20121211134758.GA7084@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:47136 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383Ab2LKODr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Dec 2012 09:03:47 -0500
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 11 Dec 2012 19:33:22 +0530
In-Reply-To: <20121211134758.GA7084@htj.dyndns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/11/2012 07:17 PM, Tejun Heo wrote:
> Hello, Srivatsa.
> 
> On Tue, Dec 11, 2012 at 06:43:54PM +0530, Srivatsa S. Bhat wrote:
>> This approach (of using synchronize_sched()) also looks good. It is simple,
>> yet effective, but unfortunately inefficient at the writer side (because
>> he'll have to wait for a full synchronize_sched()).
> 
> While synchornize_sched() is heavier on the writer side than the
> originally posted version, it doesn't stall the whole machine and
> wouldn't introduce latencies to others.  Shouldn't that be enough?
> 

Short answer: Yes. But we can do better, with almost comparable code
complexity. So I'm tempted to try that out.

Long answer:
Even in the synchronize_sched() approach, we still have to identify the
readers who need to be converted to use the new get/put_online_cpus_atomic()
APIs and convert them. Then, if we can come up with a scheme such that
the writer has to wait only for those readers to complete, then why not?

If such a scheme ends up becoming too complicated, then I agree, we
can use synchronize_sched() itself. (That's what I meant by saying that
we'll use this as a fallback).

But even in this scheme which uses synchronize_sched(), we are
already half-way through (we already use 2 types of sync schemes -
counters and rwlocks). Just a little more logic can get rid of the
unnecessary full-wait too.. So why not give it a shot?

Regards,
Srivatsa S. Bhat

