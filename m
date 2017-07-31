From: Kevin Brodsky <kevin.brodsky@arm.com>
Subject: Re: [PATCH] psci: add CPU_IDLE dependency
Date: Mon, 31 Jul 2017 17:22:03 +0100
Message-ID: <c64a27d9-a645-f5d1-a7bf-9eaa2368c120@arm.com>
References: <20170731085523.320244-1-arnd@arndb.de>
 <e8580a81-5cca-462c-24c1-30232e19462e@arm.com>
 <20170731161458.08c34088@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54818 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751951AbdGaQWI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Jul 2017 12:22:08 -0400
In-Reply-To: <20170731161458.08c34088@endymion>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <treding@nvidia.com>, Carlo Caione <carlo@endlessm.com>, Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 31/07/17 15:14, Jean Delvare wrote:
> Hi Kevin,
>
> On Mon, 31 Jul 2017 11:19:39 +0100, Kevin Brodsky wrote:
>> On 31/07/17 09:55, Arnd Bergmann wrote:
>>> I ran into a build error for the psci_checker:
>>>
>>> drivers/firmware/psci_checker.o: In function `psci_checker':
>>> psci_checker.c:(.init.text+0x528): undefined reference to `cpuidle_devices'
>>>
>>> As far as I can tell, this is simply a very rare combination of options,
>>> but the problem has existed since the code was initially added.
>>> Adding a Kconfig dependency makes it build properly.
>> Good catch! For some reason I missed this config option when figuring out the
>> dependencies... I wonder though, shouldn't cpuidle.h declare cpuidle_devices
>> conditionally on CONFIG_CPU_IDLE?
> Such conditional declarations only make sense if there is a legitimate
> use of the disabled case and if they make the disabled case fully
> transparent to the users. This is typically done by replacing function
> declarations by inline stubs doing nothing in the right way when the
> feature is disabled. It avoids having to put the condition checks on the
> side of all users.
>
> In this case however, you can't stub out cpuidle_devices alone. If you
> omit the declaration when CONFIG_CPU_IDLE isn't set, all you'll get is a
> failure at compilation time, instead of at linkage time. This barely
> helps. For it to be useful, you would additionally have to provide
> wrappers around
> 	this_cpu_read(cpuidle_devices)
> and
> 	per_cpu(cpuidle_devices, cpu)
> and stub out these wrappers when CONFIG_CPU_IDLE is disabled (so you
> don't refer to cpuidle_devices at all when it isn't available.)
>
> But then again this would only make sense if the psci_checker still
> serves a purpose when CONFIG_CPU_IDLE isn't set. Not my area, but after
> a quick look at the code I strongly suspect this is not the case.

I see your point: unlike functions, you can't provide empty stubs for variables, and 
therefore you can't make their absence transparent for the users. That wasn't my 
intention. My point was simply that a variable that's not defined should not be 
declared either in the header (if possible), and I do think that a compilation error 
is preferable to a linkage error. As far as I can tell, other headers also apply this 
principle to per-cpu variables: bpf_prog_active is conditional on CONFIG_BPF_SYSCALL 
in linux/bpf.h, vm_event_states is conditional on CONFIG_VM_EVENT_COUNTERS in 
linux/vmstat.h, etc.

Kevin

>
>>> Fixes: ea8b1c4a6019 ("drivers: psci: PSCI checker module")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
