From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Regression with suspicious RCU usage splats with cpu_pm change
Date: Mon, 17 Jul 2017 05:39:38 -0700
Message-ID: <20170717123938.GP2393@linux.vnet.ibm.com>
References: <20170713070749.GE16509@atomide.com>
 <c00272dc-cf84-81a2-b2e2-d52cadf7bcc6@linaro.org>
 <CAJZ5v0j15uWyCRAPep4KwqSiC4UD4ZppAG++SUvN3Ok1wzDwNQ@mail.gmail.com>
 <20170713124318.GK2393@linux.vnet.ibm.com>
 <c5c6623b-ea1d-1bbf-ea80-5d93e7e81c6f@linaro.org>
 <20170717060806.GC10026@atomide.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53169 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751335AbdGQMjo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 08:39:44 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6HCccDl133662
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2017 08:39:44 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2brqmnq33s-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2017 08:39:43 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 17 Jul 2017 08:39:42 -0400
Content-Disposition: inline
In-Reply-To: <20170717060806.GC10026@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alex Shi <alex.shi@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>

On Sun, Jul 16, 2017 at 11:08:07PM -0700, Tony Lindgren wrote:
> * Alex Shi <alex.shi@linaro.org> [170716 16:25]:
> > I reused the rcu_irq_enter_irqson() from RCU_NONIDLE to avoid this issue. 
> > It works fine.
> > 
> > Tony, Could you like to give a tested-by if this patch works for you.
> 
> Yeah that keeps things booting for me with no splats so:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>
> 
> In general, it seems we're missing the knowledge in Linux kernel
> of when the entire system is idle. Right now it seems that only
> cpuidle_coupled knows that?
> 
> We could probably simplify things by adding some PM state for
> entire system idle. Then cpuidle code and timer code could use
> that to test when it's safe to do whatever the SoC needs to do
> to enter deeper power states.
> 
> If we already have something like that, please do let me know :)

Well, we used to have CONFIG_NO_HZ_FULL_SYSIDLE, which detected
full-system idle lazily so as to avoid scalability bottlenecks.
https://lwn.net/Articles/558284/

No one was using it, so I removed it last merge window.  The
patch that removed it is at sysidle.2017.05.11a, which can
probably still be reverted cleanly.  Or just use v4.11 or earlier.

						Thanx, Paul
