From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] PM: Add arch_suspend_disable_nonboot_cpus
Date: Sun, 21 Feb 2010 16:01:09 -0600
Message-ID: <4B81AD25.5010204@linux.vnet.ibm.com>
References: <201002211631.o1LGVsw8022630@d01av02.pok.ibm.com>
	<20100221191821.GA2198@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100221191821.GA2198@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 02/21/2010 01:18 PM, Pavel Machek wrote:
> On Sun 2010-02-21 10:32:02, Brian King wrote:
>>
>> Rather than calling disable_nonboot_cpus and enable_nonboot_cpus
>> directly, wrapper the calls in a weak arch_suspend_disable_nonboot_cpus
>> and arch_suspend_enable_nonboot_cpus that can be overridden by
>> architectures that require different handling of suspending processors
>> at suspend time than these functions provide. This is needed to enable
>> suspend/resume on IBM Power servers.
> 
> This needs *way* better explanation. Like: why do power servers
> require special handling? What else is disable_nonboot_cpus used for?

disable_nonboot_cpus ends up calling _cpu_down, which is also used in
the CPU hotplug path.

The issue is essentially that on Power servers, the state that a CPU
needs to be in when hotplug removing it is different than the state it
needs to be in for suspend.

Here is the way that suspend works on Power servers. For each CPU, we
must make a call to the hypervisor (H_JOIN). For all but the last CPU,
this call does not return. For the last CPU, it will return with a
response indicating it is the last hardware thread. At that point, we
need to make a different call (ibm,suspend-me) to the hypervisor to
indicate we are suspending the partition. When the partition resumes,
the CPU thread that made the ibm,suspend-me call will wake up. It then
makes a call to the hypevisor (H_PROD) for each other CPU to wake up the
other CPUs.

So, for Power, the arch_suspend_disable_nonboot_cpus implementation will
call H_JOIN for all other CPUs. Then the suspend enter call just calls
ibm,suspend-me to suspend the partition. On resume,
arch_suspend_enable_nonboot_cpus sends the H_PROD to each CPU, waking it up.

Adding these arch hooks seemed like the cleanest way to accomplish all this.

Thanks,

Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
