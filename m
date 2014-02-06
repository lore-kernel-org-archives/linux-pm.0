From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 38/51] intel-idle: Fix CPU hotplug callback registration
Date: Thu, 06 Feb 2014 21:34:00 +0530
Message-ID: <52F3B270.20005@linux.vnet.ibm.com>
References: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com> <20140205221122.19080.64763.stgit@srivatsabhat.in.ibm.com> <87012016.ZnbTpcb5sN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:50834 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbaBFQJ0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2014 11:09:26 -0500
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 7 Feb 2014 02:09:24 +1000
In-Reply-To: <87012016.ZnbTpcb5sN@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, paulus@samba.org, oleg@redhat.com, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, mingo@kernel.org, paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 02/06/2014 06:13 PM, Rafael J. Wysocki wrote:
> On Thursday, February 06, 2014 03:41:23 AM Srivatsa S. Bhat wrote:
>> Subsystems that want to register CPU hotplug callbacks, as well as perform
>> initialization for the CPUs that are already online, often do it as shown
>> below:
>>
>> 	get_online_cpus();
>>
>> 	for_each_online_cpu(cpu)
>> 		init_cpu(cpu);
>>
>> 	register_cpu_notifier(&foobar_cpu_notifier);
>>
>> 	put_online_cpus();
>>
>> This is wrong, since it is prone to ABBA deadlocks involving the
>> cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
>> with CPU hotplug operations).
>>
>> Instead, the correct and race-free way of performing the callback
>> registration is:
>>
>> 	cpu_maps_update_begin();
>>
>> 	for_each_online_cpu(cpu)
>> 		init_cpu(cpu);
>>
>> 	/* Note the use of the double underscored version of the API */
>> 	__register_cpu_notifier(&foobar_cpu_notifier);
>>
>> 	cpu_maps_update_done();
>>
>>
>> Fix the intel-idle code by using this latter form of callback registration.
>>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> 
> This looks good to me.  Len, what do you think?
> 

Thanks a lot Rafael!

> Srivatsa, how does it depend on the rest of your series?
> 

It depends only on the first patch in the series:
http://article.gmane.org/gmane.linux.kernel/1641640

But don't take this patch yet, we are discussing a possible rename
of the function cpu_maps_update_begin()/done(). So I'll post a v2
after the name is finalized.

Thank you!

Regards,
Srivatsa S. Bhat





