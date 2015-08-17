From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpupower tools: Fix error when running cpupower monitor
Date: Mon, 17 Aug 2015 13:22:15 +0530
Message-ID: <55D192AF.5000602@linux.vnet.ibm.com>
References: <1438582560-13352-1-git-send-email-shreyas@linux.vnet.ibm.com> <9534146.fFc3TD2C5D@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9534146.fFc3TD2C5D@skinner>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: rjw@rjwysocki.net, pavsubra@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 08/10/2015 05:58 PM, Thomas Renninger wrote:
> On Monday, August 03, 2015 11:46:00 AM Shreyas B. Prabhu wrote:
>> get_cpu_topology() tries to get topology info from all cpus by reading
>> files in the topology sysfs dir. If a cpu is offlined, since it doesn't
>> have topology dir, this function fails and returns -1. This causes
>> functions relying on get_cpu_topology() to fail. For example-
>>
>> $ cpupower monitor
>> Cannot read number of available processors
>>
>> Fix this by skipping fetching topology info for offline cpus.
> 
> Looks fine.
> 
> Thanks!
> 
> Acked-by: Thomas Renninger <trenn@suse.de>
> 

Thanks Thomas!
Rafael, can you please pick this patch?


Thanks,
Shreyas
