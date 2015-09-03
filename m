From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpupower tools: Fix error when running cpupower monitor
Date: Thu, 03 Sep 2015 11:51:22 +0530
Message-ID: <55E7E6E2.3090900@linux.vnet.ibm.com>
References: <1438582560-13352-1-git-send-email-shreyas@linux.vnet.ibm.com> <9534146.fFc3TD2C5D@skinner> <55D192AF.5000602@linux.vnet.ibm.com> <55DC58BD.4070108@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:59006 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbbICGWS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 02:22:18 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Thu, 3 Sep 2015 16:22:16 +1000
In-Reply-To: <55DC58BD.4070108@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Thomas Renninger <trenn@suse.de>, pavsubra@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org



On 08/25/2015 05:29 PM, Shreyas B Prabhu wrote:
> 
> 
> On 08/17/2015 01:22 PM, Shreyas B Prabhu wrote:
>>
>>
>> On 08/10/2015 05:58 PM, Thomas Renninger wrote:
>>> On Monday, August 03, 2015 11:46:00 AM Shreyas B. Prabhu wrote:
>>>> get_cpu_topology() tries to get topology info from all cpus by reading
>>>> files in the topology sysfs dir. If a cpu is offlined, since it doesn't
>>>> have topology dir, this function fails and returns -1. This causes
>>>> functions relying on get_cpu_topology() to fail. For example-
>>>>
>>>> $ cpupower monitor
>>>> Cannot read number of available processors
>>>>
>>>> Fix this by skipping fetching topology info for offline cpus.
>>>
>>> Looks fine.
>>>
>>> Thanks!
>>>
>>> Acked-by: Thomas Renninger <trenn@suse.de>
>>>
>>
>> Thanks Thomas!
>> Rafael, can you please pick this patch?
>>
>>
> 
> 
> Hi Rafael,
> 
> If this patch looks good can you please pick this up?
> 
> 
> Thanks,
> Shreyas
> 

Hi Rafael,

If this patch looks good can you please pick this up?


Thanks,
Shreyas

