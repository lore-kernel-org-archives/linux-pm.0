From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 01/10] CPU hotplug: Provide APIs for "light"	atomic
 readers to prevent CPU offline
Date: Fri, 07 Dec 2012 23:03:14 +0530
Message-ID: <50C2285A.60806@linux.vnet.ibm.com>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com> <20121205184258.3750.31879.stgit@srivatsabhat.in.ibm.com> <50BF96DF.3000500@linux.vnet.ibm.com> <50BF979A.50304@linux.vnet.ibm.com> <50BF982D.7090704@linux.vnet.ibm.com> <50BF98F7.3030600@linux.vnet.ibm.com> <50BF999C.6030707@linux.vnet.ibm.com> <50BFAB17.3090603@linux.vnet.ibm.com> <20121206161850.GA6710@redhat.com> <50C0E88E.9050909@linux.vnet.ibm.com> <1354822103.17101.24.camel@gandalf.local.home> <50C0F3CA.7070105@linux.vnet.ibm.com> <1354831350.17101.31.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:59316 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab2LGRey (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Dec 2012 12:34:54 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Sat, 8 Dec 2012 03:30:03 +1000
In-Reply-To: <1354831350.17101.31.camel@gandalf.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Oleg Nesterov <oleg@redhat.com>, tj@kernel.org, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, sbw@mit.edu, amit.kucheria@linaro.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/07/2012 03:32 AM, Steven Rostedt wrote:
> On Fri, 2012-12-07 at 01:06 +0530, Srivatsa S. Bhat wrote:
>> The root-cause of this deadlock is again lock-ordering mismatch right?
>> CPU0 takes locks in order A, B
>> CPU1 takes locks in order B, A
>>
>> And the writer facilitates in actually getting deadlocked.
>>
>> I avoid this in this patchset by always taking the locks in the same
>> order. So we won't be deadlocking like this.
> 
> OK, I haven't looked closely at the patch yet. I'm currently hacking on
> my own problems. But just from the description above, it looked like you
> were using rw_locks() to be able to inverse the order of the locks.
> 

Ah, ok, no problem! I'd be grateful if you could take a look when you
are free :-) I'll post a v3 soon, which has a completely redesigned
synchronization scheme, to address the performance concerns related to
global rwlocks that Tejun raised.

Regards,
Srivatsa S. Bhat

