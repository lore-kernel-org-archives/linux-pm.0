From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/5] powernv,cpufreq:Add per-core locking to serialize
 frequency transitions
Date: Fri, 21 Mar 2014 15:26:13 +0530
Message-ID: <532C0CBD.1060904@linux.vnet.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com> <1395317460-14811-3-git-send-email-ego@linux.vnet.ibm.com> <CAOh2x==Lzeatp=7BoxuSH4PfxXqWqpHJ_KcwWdXXsFAftxTMCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:44311 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbaCUJ4f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 05:56:35 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 21 Mar 2014 19:56:32 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 690642BB0054
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 20:56:29 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2L9aGse41222278
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 20:36:16 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2L9uSrq026493
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 20:56:28 +1100
In-Reply-To: <CAOh2x==Lzeatp=7BoxuSH4PfxXqWqpHJ_KcwWdXXsFAftxTMCQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com

On 03/21/2014 02:12 PM, Viresh Kumar wrote:
> On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
>> From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
>>
>> On POWER systems, the CPU frequency is controlled at a core-level and
>> hence we need to serialize so that only one of the threads in the core
>> switches the core's frequency at a time.
> 
> Probably you don't need this anymore.
> 
> https://lkml.org/lkml/2014/3/21/23
> 

Agreed.

Regards,
Srivatsa S. Bhat

