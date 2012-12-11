From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 1/9] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
Date: Tue, 11 Dec 2012 18:34:11 +0530
Message-ID: <50C72F4B.9090805@linux.vnet.ibm.com>
References: <20121207173702.27305.1486.stgit@srivatsabhat.in.ibm.com> <20121207173759.27305.84316.stgit@srivatsabhat.in.ibm.com> <20121209205733.GA7038@redhat.com> <50C570F9.2020801@linux.vnet.ibm.com> <20121210181521.GA30684@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:50712 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab2LKNFt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Dec 2012 08:05:49 -0500
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 11 Dec 2012 18:35:26 +0530
In-Reply-To: <20121210181521.GA30684@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/10/2012 11:45 PM, Oleg Nesterov wrote:
> On 12/10, Srivatsa S. Bhat wrote:
>>
>> On 12/10/2012 02:27 AM, Oleg Nesterov wrote:
>>> However. If this is true, then compared to preempt_disable/stop_machine
>>> livelock is possible. Probably this is fine, we have the same problem with
>>> get_online_cpus(). But if we can accept this fact I feel we can simmplify
>>> this somehow... Can't prove, only feel ;)
>>
>> Not sure I follow..
> 
> I meant that write_lock_irqsave(&hotplug_rwlock) in take_cpu_down()
> can spin "forever".
> 
> Suppose that reader_acked() == T on every CPU, so that
> get_online_cpus_atomic() always takes read_lock(&hotplug_rwlock).
> 
> It is possible that this lock will be never released by readers,
> 
> 	CPU_0				CPU_1
> 
> 	get_online_cpus_atomic()
> 					get_online_cpus_atomic()
> 	put_online_cpus_atomic()
> 
> 	get_online_cpus_atomic()
> 					put_online_cpus_atomic()
> 
> 					get_online_cpus_atomic()
> 	put_online_cpus_atomic()
> 
> and so on.
> 

Right, and we can't do anything about it :(
Regards,
Srivatsa S. Bhat

