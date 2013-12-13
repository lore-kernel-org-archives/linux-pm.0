From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] time: Support in tick broadcast framework for archs
 without an external wakeup source
Date: Fri, 13 Dec 2013 10:51:23 +0530
Message-ID: <52AA9953.9090909@linux.vnet.ibm.com>
References: <20131213041901.17199.37383.stgit@preeti.in.ibm.com> <1386911862.15730.81.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:42561 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab3LMFYv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2013 00:24:51 -0500
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 12 Dec 2013 22:24:51 -0700
In-Reply-To: <1386911862.15730.81.camel@pasglop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: peterz@infradead.org, fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org, mingo@kernel.org, shangw@linux.vnet.ibm.com, rafael.j.wysocki@intel.com, paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au, john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org

Hi Ben,

On 12/13/2013 10:47 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2013-12-13 at 09:49 +0530, Preeti U Murthy wrote:
>> On some architectures, in certain CPU deep idle states the local timers stop.
>> An external clock device is used to wakeup these CPUs. The kernel support for the
>> wakeup of these CPUs is provided by the tick broadcast framework by using the
>> external clock device as the wakeup source.
> 
>> However on architectures like PowerPC there is no external clock device. 
> 
> Minor nit ...
> 
> I wouldn't make this an architectural statement. Some PowerPC's do have
> external clock devices (for example the old MPIC interrupt controller
> had timers). In fact, if we really need it, I'm sure we *could* find
> something somewhere in P8 that could act as a timer, probably hijacking
> a bit of the OCC or similar but at this stage, that's not on the radar.
> 
> So make it an implementation statement. "However, not all
> implementations, such as some PowerPC ones, provide such an external
> timer ...".

Thanks for this information. I will update this going ahead.

Regards
Preeti U Murthy

