From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Regression with suspicious RCU usage splats with cpu_pm change
Date: Thu, 13 Jul 2017 05:43:18 -0700
Message-ID: <20170713124318.GK2393@linux.vnet.ibm.com>
References: <20170713070749.GE16509@atomide.com>
 <c00272dc-cf84-81a2-b2e2-d52cadf7bcc6@linaro.org>
 <CAJZ5v0j15uWyCRAPep4KwqSiC4UD4ZppAG++SUvN3Ok1wzDwNQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53289 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751157AbdGMMnY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 08:43:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6DCd8sN048891
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2017 08:43:23 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bnt3pphjm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2017 08:43:23 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 13 Jul 2017 08:43:23 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j15uWyCRAPep4KwqSiC4UD4ZppAG++SUvN3Ok1wzDwNQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Shi <alex.shi@linaro.org>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>

On Thu, Jul 13, 2017 at 01:50:26PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 13, 2017 at 11:43 AM, Alex Shi <alex.shi@linaro.org> wrote:
> >
> > On 07/13/2017 03:07 PM, Tony Lindgren wrote:
> >> Hi,
> >>
> >> Looks like next-20170713 gives me a bunch of "suspicious RCU usage"
> >> splats with cpuidle_coupled on duovero, see below. I bisected it down
> >> to commit 2f027e003d05 ("cpu_pm: replace raw_notifier with
> >> atomic_notifier").
> 
> OK, so I'm dropping this commit.

You can surround idle-loop RCU-reading code with RCU_NONIDLE().
This will tell RCU to pay attention even though the CPU is otherwise
idle.

							Thanx, Paul
