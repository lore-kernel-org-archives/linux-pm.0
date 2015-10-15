From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Runtime PM causes oops on next-20151015
Date: Thu, 15 Oct 2015 21:04:54 +1100
Message-ID: <1444903494.8464.5.camel@ellerman.id.au>
References: <20151015092213.GA26614@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20151015092213.GA26614@ulmo.nvidia.com>
Sender: linux-next-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wonhong Kwon <wonhong.kwon@lge.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-next@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2015-10-15 at 11:22 +0200, Thierry Reding wrote:
> Hi Rafael, Wonhong,
> 
> Todays linux-next breaks rather spectacularly for drivers using runtime
> PM. The culprit seems to be this commit:
> 
> 	commit 7d24068e144adc03b805806645d732cf79488717
> 	Author: Wonhong Kwon <wonhongkwon@gmail.com>
> 	Date:   Tue Oct 6 10:10:20 2015 +0900
> 
> 	    PM / hibernate: Move pm_init/pm_disk_init to late_initcall_sync
> 
> 	    pm_init is being invoked by core_initcall and hibernate_image_size_init
> 	    calculates preferred image size (image_size) based on total pages
> 	    (totalram_pages). This totalram_pages can be modified during various
> 	    initcall-s phase and this can cause miscalculated image_size.
> 
> 	    For example, when CMA is being used, init_cma_reserved_pageblock tries
> 	    to change the totalram_pages and this job is done during core_initcall.
> 	    In order words, the totalram_pages doesn't take CMA reserved pages into
> 	    account when image_size is calculated and it can be too small.
> 
> 	    Move pm_init and pm_disk_init to late_initcall_sync so that it happens
> 	    after all other initcall-s change the totalram_pages.
> 
> 	    Reported-by: Sangseok Lee <sangseok.lee@lge.com>
> 	    Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>
> 	    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 

I'm seeing one too on powerpc:

Unable to handle kernel paging request for data at address 0x00000030
Faulting instruction address: 0xc0000000002e4094
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2048 NUMA pSeries
Modules linked in:
CPU: 5 PID: 1 Comm: swapper/0 Not tainted 4.3.0-rc5-next-20151015-50217-ge2be40d-dirty #37
task: c0000001fefc0000 ti: c0000001fb000000 task.ti: c0000001fb000000
NIP: c0000000002e4094 LR: c000000000c79dd4 CTR: c000000000c79d90
REGS: c0000001fb003900 TRAP: 0300   Not tainted  (4.3.0-rc5-next-20151015-50217-ge2be40d-dirty)
MSR: 8000000100009032 <SF,EE,ME,IR,DR,RI>  CR: 28000882  XER: 20000000
CFAR: c0000000000d117c DAR: 0000000000000030 DSISR: 40000000 SOFTE: 1 
GPR00: c00000000000b074 c0000001fb003b80 c000000000e93800 0000000000000000 
GPR04: c000000000d15c80 0000000000000000 00000001ff150000 0000000000000026 
GPR08: c000000000d0f748 c000000000f41a10 c000000000d0f8e8 c000000000abc59d 
GPR12: c000000000b42400 c00000000fdc1680 c00000000000b960 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: 0000000000000000 c000000000de0360 c000000000c45d28 0000000000000000 
GPR28: c000000000deca80 c000000000d103c0 c0000001fbc905c0 c000000000d103c0 
NIP [c0000000002e4094] .sysfs_create_file_ns+0x4/0x50
LR [c000000000c79dd4] .__machine_initcall_pseries_apo_pm_init+0x44/0x60
Call Trace:
[c0000001fb003b80] [c0000000004852cc] .kasprintf+0x2c/0x40 (unreliable)
[c0000001fb003bf0] [c00000000000b074] .do_one_initcall+0xc4/0x250
[c0000001fb003ce0] [c000000000c64560] .kernel_init_freeable+0x268/0x348
[c0000001fb003db0] [c00000000000b97c] .kernel_init+0x1c/0x140
[c0000001fb003e30] [c0000000000095ac] .ret_from_kernel_thread+0x58/0xac
Instruction dump:
419e001c 3ce2ffa8 38e7be60 4bfffea4 3ce2ffa8 38e7bea8 4bfffe9c 3ce2ffa8 
38e7bea8 4bfffe8c 60000000 2c230000 <e8630030> 41820028 2fa30000 419e0020 
---[ end trace d2a742ce359651dd ]---

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b


Which starts at:

  static int __init apo_pm_init(void)
  {
  	return (sysfs_create_file(power_kobj, &auto_poweron_attr.attr));
  }
  machine_device_initcall(pseries, apo_pm_init);

And seems to be caused by power_kobj being NULL:

  0:mon> d $power_kobj
  c000000000f41a10 0000000000000000 0000000000000000  |................|


cheers
