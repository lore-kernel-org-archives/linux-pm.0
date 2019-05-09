From: Ido Schimmel <idosch@idosch.org>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
 interface
Date: Thu, 9 May 2019 13:23:15 +0300
Message-ID: <20190509102315.GA31824@splinter>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1762575.ER2xjzr9E1@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1762575.ER2xjzr9E1@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 21, 2019 at 11:20:17PM +0100, Rafael J. Wysocki wrote:
> +static struct attribute *intel_epb_attrs[] = {
> +	&dev_attr_energy_perf_bias.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group intel_epb_attr_group = {
> +	.name = power_group_name,
> +	.attrs =  intel_epb_attrs
> +};
> +
>  static int intel_epb_online(unsigned int cpu)
>  {
> +	struct device *cpu_dev = get_cpu_device(cpu);
> +
>  	intel_epb_restore();
> +	if (!cpuhp_tasks_frozen)
> +		sysfs_merge_group(&cpu_dev->kobj, &intel_epb_attr_group);
> +
>  	return 0;
>  }
>  
>  static int intel_epb_offline(unsigned int cpu)
>  {
> -	return intel_epb_save();
> +	struct device *cpu_dev = get_cpu_device(cpu);
> +
> +	if (!cpuhp_tasks_frozen)
> +		sysfs_unmerge_group(&cpu_dev->kobj, &intel_epb_attr_group);
> +
> +	intel_epb_save();
> +	return 0;
>  }

Hi,

I just booted net-next and got the following NULL pointer dereference
[1] during boot. I believe it is caused by this patch.

CONFIG_PM is disabled in my config which means 'power_group_name' is
defined as NULL. When I enable CONFIG_PM the issue is not reproduced.

Thanks

[1]
[    1.230241] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.231043] #PF: supervisor read access in kernel mode
[    1.231043] #PF: error_code(0x0000) - not-present page
[    1.231043] PGD 0 P4D 0
[    1.231043] Oops: 0000 [#1] SMP
[    1.231043] CPU: 0 PID: 12 Comm: cpuhp/0 Not tainted 5.1.0-custom-07273-g80f232121b69 #1392
[    1.231043] Hardware name: Mellanox Technologies Ltd. MSN2100-CB2FO/SA001017, BIOS 5.6.5 06/07/2016
[    1.231043] RIP: 0010:strlen+0x0/0x20
[    1.231043] Code: b5 20 75 eb c6 42 01 00 0f b6 10 f6 82 40 bf 4d b5 20 74 14 48 c7 c1 40 bf 4d b5 48 83 c0 01 0f b6 10 f6 04 11 20 75 f3 c3 90 <80> 3f 00 74 10 48 89 f8
48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
[    1.231043] RSP: 0000:ffffb587c0cd3dc8 EFLAGS: 00010246
[    1.231043] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000100
[    1.231043] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    1.231043] RBP: 0000000000000000 R08: ffff8e6137a160c8 R09: 0000000000000000
[    1.231043] R10: 0000000000000000 R11: ffff8e613652ec80 R12: 0000000000000000
[    1.231043] R13: 0000000000000000 R14: ffff8e6137a160c8 R15: ffffffffb4690120
[    1.231043] FS:  0000000000000000(0000) GS:ffff8e6137a00000(0000) knlGS:0000000000000000
[    1.231043] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.231043] CR2: 0000000000000000 CR3: 0000000200409000 CR4: 00000000001006f0
[    1.231043] Call Trace:
[    1.231043]  kernfs_name_hash+0xd/0x80
[    1.231043]  kernfs_find_ns+0x30/0xc0
[    1.231043]  kernfs_find_and_get_ns+0x27/0x50
[    1.231043]  sysfs_merge_group+0x2e/0x100
[    1.231043]  ? __switch_to_asm+0x40/0x70
[    1.231043]  intel_epb_online+0x2a/0x30
[    1.231043]  cpuhp_invoke_callback+0x8f/0x550
[    1.231043]  ? sort_range+0x20/0x20
[    1.231043]  cpuhp_thread_fun+0x9b/0x100
[    1.231043]  smpboot_thread_fn+0xc0/0x160
[    1.231043]  kthread+0x10d/0x130
[    1.231043]  ? __kthread_create_on_node+0x180/0x180
[    1.231043]  ret_from_fork+0x35/0x40
[    1.231043] CR2: 0000000000000000
[    1.231043] ---[ end trace c8ea60276791261c ]---
[    1.231043] RIP: 0010:strlen+0x0/0x20
[    1.231043] Code: b5 20 75 eb c6 42 01 00 0f b6 10 f6 82 40 bf 4d b5 20 74 14 48 c7 c1 40 bf 4d b5 48 83 c0 01 0f b6 10 f6 04 11 20 75 f3 c3 90 <80> 3f 00 74 10 48 89 f8
48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
[    1.231043] RSP: 0000:ffffb587c0cd3dc8 EFLAGS: 00010246
[    1.231043] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000100
[    1.231043] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    1.231043] RBP: 0000000000000000 R08: ffff8e6137a160c8 R09: 0000000000000000
[    1.231043] R10: 0000000000000000 R11: ffff8e613652ec80 R12: 0000000000000000
[    1.231043] R13: 0000000000000000 R14: ffff8e6137a160c8 R15: ffffffffb4690120
[    1.231043] FS:  0000000000000000(0000) GS:ffff8e6137a00000(0000) knlGS:0000000000000000
[    1.231043] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.231043] CR2: 0000000000000000 CR3: 0000000200409000 CR4: 00000000001006f0
