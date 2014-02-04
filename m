From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] time: Change the return type of clockevents_notify()
 to integer
Date: Tue, 04 Feb 2014 22:44:48 +0530
Message-ID: <52F12008.4040103@linux.vnet.ibm.com>
References: <20140124065501.17564.39363.stgit@preeti.in.ibm.com> <20140124065739.17564.97259.stgit@preeti.in.ibm.com> <alpine.DEB.2.02.1402041100250.24986@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:50214 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbaBDRS3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2014 12:18:29 -0500
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Tue, 4 Feb 2014 22:48:27 +0530
In-Reply-To: <alpine.DEB.2.02.1402041100250.24986@ionos.tec.linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com, galak@kernel.crashing.org, paul.gortmaker@windriver.com, paulus@samba.org, mingo@kernel.org, mikey@neuling.org, shangw@linux.vnet.ibm.com, rafael.j.wysocki@intel.com, agraf@suse.de, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au, john.stultz@linaro.org, anton@samba.org, chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org

On 02/04/2014 03:31 PM, Thomas Gleixner wrote:
> On Fri, 24 Jan 2014, Preeti U Murthy wrote:
>> -extern void tick_broadcast_oneshot_control(unsigned long reason);
>> +extern int tick_broadcast_oneshot_control(unsigned long reason);
> 
>> -static inline void tick_broadcast_oneshot_control(unsigned long reason) { }
>> +static inline int tick_broadcast_oneshot_control(unsigned long reason) { }
> 
>> -static inline void tick_broadcast_oneshot_control(unsigned long reason) { }
>> +static inline int tick_broadcast_oneshot_control(unsigned long reason) { }
> 
> The inline stubs need to return 0.

Oh right! Apologies!
Thanks.
> 
> Thanks,
> 
> 	tglx
> 

Regards
Preeti U Murthy

