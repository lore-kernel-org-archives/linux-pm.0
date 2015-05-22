From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 2/2] turbostat, add set_base_cpu()
Date: Fri, 22 May 2015 17:44:05 -0400
Message-ID: <555FA325.3000403@redhat.com>
References: <1432296063-22185-1-git-send-email-prarit@redhat.com> <1432296063-22185-3-git-send-email-prarit@redhat.com> <1A7043D5F58CCB44A599DFD55ED4C9484688E5F2@fmsmsx115.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C9484688E5F2@fmsmsx115.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Semin, Andrey" <andrey.semin@intel.com>
List-Id: linux-pm@vger.kernel.org



On 05/22/2015 11:55 AM, Brown, Len wrote:
>> +void set_base_cpu(void)
>> +{
>> +	int cpu;
>> +
>> +	for (cpu = 0; cpu <= topo.max_cpu_num; ++cpu) {
>> +		if (cpu_is_not_present(cpu))
>> +			continue;
>> +		base_cpu = cpu;
>> +		break;
>> +	}
>> +
>> +	if (base_cpu == -1)
>> +		err(-ENODEV, "No valid cpus found");
>> +}
> 
> 
> cpu0 hard-coding is indeed arbitrary.
> However, so is this proposed replacement, base_cpu.
> Either may not match where turbostat is currently running,
> and thus could provoke unnecessary cross-calls to get there.
> 
> I think it would be better to ask getcpu(2) where we are already running,
> and simply use that one.  I think we can call it once and cache it,
> as you proposed, rather than multiple system calls.
> 

Okay, will do that in a v2.

P.

> thanks,
> -Len
> 
> ps. patches to turbostat should go to linux-pm@vger.kernel.org

Oh -- I ran get_maintainer.pl on this patchset and linux-pm didn't show up.
I'll send a patch to fix that...

P.

> 
> 
