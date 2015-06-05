From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] cpufreq: governor: Fix potential races
Date: Fri, 05 Jun 2015 08:34:53 +0530
Message-ID: <557111D5.6030709@linux.vnet.ibm.com>
References: <cover.1433326032.git.viresh.kumar@linaro.org> <556FDEA8.6090801@linux.vnet.ibm.com> <20150605030028.GB13999@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:34512 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbbFEDFD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 23:05:03 -0400
Received: from /spool/local
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 23:05:03 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5F1BD38C804A
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 23:05:01 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t553515V59048060
	for <linux-pm@vger.kernel.org>; Fri, 5 Jun 2015 03:05:01 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5534xNE020899
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 23:05:00 -0400
In-Reply-To: <20150605030028.GB13999@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/05/2015 08:30 AM, Viresh Kumar wrote:
> On 04-06-15, 10:44, Preeti U Murthy wrote:
>> On 06/03/2015 03:57 PM, Viresh Kumar wrote:
>>> Preeti recently highlighted [1] some issues in cpufreq core locking with
>>> respect to governors. I wanted to solve them after we have simplified
>>> the hotplug paths in cpufreq core with my latest patches, but now that
>>> she has poked me, I have done some work in that area.
>>>
>>> I am trying to solve only a part of the bigger problem (in a way that I
>>> feel is the right way ahead). The first patches restructures code to
>>> make it more readable and the last patch does all the major changes. The
>>> logs in that one should be good enough to explain why and what I am
>>> doing.
>>>
>>> The first two shouldn't bring any functional change and so can be
>>> applied early if you are confident about them.
>>>
>>> @Preeti: I would like you to test these patches. These should get rid of
>>> the crashes you were facing but may generate a WARN() from line 447 of
>>> cpufreq_governor.c, if the sequence is wrong. That has to be fixed
>>> separately.
>>>
>>> Line 447: WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT))
> 
> Hi Preeti,
> 
> Thanks for giving your RBY tags for all the patches, would you also
> like to give Tested-by's if you have done any testing on these.
> 
> That is just to confirm it hasn't broken things any further and that
> we haven't seen any crashes in races between
> INIT/EXIT/START/STOP/LIMITS.
> 

Let me run a fair bit of tests today and confirm this.

Regards
Preeti U Murthy

