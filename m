From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] cpufreq: governor: Fix potential races
Date: Thu, 04 Jun 2015 12:57:05 +0530
Message-ID: <556FFDC9.6040906@linux.vnet.ibm.com>
References: <cover.1433326032.git.viresh.kumar@linaro.org> <556FDEA8.6090801@linux.vnet.ibm.com> <556FEB4B.1010601@linux.vnet.ibm.com> <20150604061128.GF11325@linux> <556FF201.8080100@linux.vnet.ibm.com> <20150604064202.GI11325@linux> <556FF893.3070007@linux.vnet.ibm.com> <20150604071359.GA743@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:44730 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbFDH1Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 03:27:24 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 01:27:24 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C373738C8039
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 03:27:20 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t547RKHV53477420
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 07:27:20 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t547RJ9K005034
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 03:27:20 -0400
In-Reply-To: <20150604071359.GA743@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/04/2015 12:43 PM, Viresh Kumar wrote:
> On 04-06-15, 12:34, Preeti U Murthy wrote:
>> My point is do we really need to treat them as separate problems ?
> 
> Yes.
> 
>> Will not serializing sequence of events help solve both issues ?
> 
> That's not the point. Even if it solves the problem, it may not be the
> right approach. There are two problems here:
> - One lies in cpufreq.c or in policies domain.
> - Other one is about governor. Governor code shouldn't rely of
>   cpufreq.c locking to guarantee that access to its structures isn't
>   racy.
> 
> And the way you proposed to solve it (yes the original idea was from
> one of my earlier patches) is not the right way to do it.
> 
> For example, cpufreq_set_policy() shouldn't care about how the
> governor code is placed. It should just do enough to get rid of racy
> code belonging to that policy.
> 
> But with our other approach, we are trying to stop the governor to be
> used by anyone else in the kernel. Who the hell is that 'policy' to
> decide who can access the governor ?
> 
> That's why I divided it up, so that we don't come to it again. I
> haven't learnt these things earlier, and wrote messy locking code
> earlier. But after looking/working on core code like timers etc, I
> understood the importance of right design and proper partitioning of
> responsibilities.

Ok, fair enough.

Regards
Preeti U Murthy

