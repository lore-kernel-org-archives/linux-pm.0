From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpupower tools: Fix error when running cpupower monitor
Date: Tue, 25 Aug 2015 17:29:57 +0530
Message-ID: <55DC58BD.4070108@linux.vnet.ibm.com>
References: <1438582560-13352-1-git-send-email-shreyas@linux.vnet.ibm.com> <9534146.fFc3TD2C5D@skinner> <55D192AF.5000602@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55D192AF.5000602@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Thomas Renninger <trenn@suse.de>, pavsubra@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 08/17/2015 01:22 PM, Shreyas B Prabhu wrote:
> 
> 
> On 08/10/2015 05:58 PM, Thomas Renninger wrote:
>> On Monday, August 03, 2015 11:46:00 AM Shreyas B. Prabhu wrote:
>>> get_cpu_topology() tries to get topology info from all cpus by reading
>>> files in the topology sysfs dir. If a cpu is offlined, since it doesn't
>>> have topology dir, this function fails and returns -1. This causes
>>> functions relying on get_cpu_topology() to fail. For example-
>>>
>>> $ cpupower monitor
>>> Cannot read number of available processors
>>>
>>> Fix this by skipping fetching topology info for offline cpus.
>>
>> Looks fine.
>>
>> Thanks!
>>
>> Acked-by: Thomas Renninger <trenn@suse.de>
>>
> 
> Thanks Thomas!
> Rafael, can you please pick this patch?
> 
> 


Hi Rafael,

If this patch looks good can you please pick this up?


Thanks,
Shreyas
