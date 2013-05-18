From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: Performance issue since 3.2.6
Date: Sat, 18 May 2013 10:34:57 +0530
Message-ID: <51970BF9.7070602@linux.vnet.ibm.com>
References: <CAPPqfY1-sYT8rcPoJ6BD0axq=oczq+xbGFSQj=uth4wc_cvkGw@mail.gmail.com> <CAPPqfY2ba5M27omZBwe0h26Eutyd+2KkLXht6uLN5VdjEKT_Ug@mail.gmail.com> <519689F2.5070207@linux.vnet.ibm.com> <1426477.y1e3fnLN2J@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:35319 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab3ERFH7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 May 2013 01:07:59 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Sat, 18 May 2013 10:31:28 +0530
In-Reply-To: <1426477.y1e3fnLN2J@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Olivier Doucet <webmaster@ajeux.com>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>

On 05/18/2013 05:21 AM, Rafael J. Wysocki wrote:
> On Saturday, May 18, 2013 01:20:10 AM Srivatsa S. Bhat wrote:
>> On 05/17/2013 11:47 PM, Olivier Doucet wrote:
>>> Hello,
>>>
>>> This performance penalty is still present in kernel 3.9.2. And
>>> CONFIG_PM cannot be deactivated anymore.
>>>
>>> I was able to make a working 3.9.2 (meaning with no penalty)  with
>>> following config and patch :
>>> CONFIG_PM=y
>>> CONFIG_PM_SLEEP=y
>>> CONFIG_PM_SLEEP_SMP=y
>>> CONFIG_CPU_IDLE=y
>>> CONFIG_ACPI=y
>>> CONFIG_ACPI_PROCESSOR=y
>>>
>>> Patch : https://gist.github.com/odoucet/5600630
>>>
[...]
>> So, to summarize my thoughts:
>>  - IMHO there is no regression here, you just depended on a bug included
>>    in 3.2.0 (which made it behave like idle=poll with CONFIG_PM=n) and
>>    started your comparisons from there. The later kernels (3.2.6+) got
>>    that bug fixed which is why you saw "performance drops".
>>
>>  - As much as we would like to do it, we can't set the value of
>>    PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE to 0 when CONFIG_PM=n, because
>>    CONFIG_PM doesn't encompass all power-management features (which is
>>    a pity). Doing that would need a big overhaul of all the relevant
>>    Kconfigs, which might or might not be worth the effort. (Because, who
>>    says that CONFIG_PM=n kernels are supposed to eat power like crazy??)
> 
> I think it *is* worth the effort.  We could drop some CONFIG_PM* options in the
> process which would simplify things quite a bit too.
>

Ah, ok..
 
>> So here is my suggestion - use the interfaces provided by the kernel to
>> fix your problem:
>>    - you can give idle=poll in the kernel command line,
>>    - OR you can echo 0 > /dev/cpu_dma_latency
>>
>> Irrespective of your kernel configuration options (CONFIG_PM=y/n), the
>> CPUs will not enter deep idle states, giving you the performance
>> improvement that you are looking for.
> 
> Thanks a lot for the very clear explanation of this!
> 

No problem! :-)

Regards,
Srivatsa S. Bhat

