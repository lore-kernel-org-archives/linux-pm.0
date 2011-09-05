From: Tejun Heo <tj@kernel.org>
Subject: Re: [BUG] CPU hotplug,
 freezer: Freezing of tasks failed after 20.00 seconds
Date: Mon, 5 Sep 2011 23:15:12 +0900
Message-ID: <20110905141512.GE9807__1413.90152643925$1315232196$gmane$org@htj.dyndns.org>
References: <1313763382-12341-1-git-send-email-tj@kernel.org>
	<201108192300.55405.rjw@sisk.pl>
	<4E648DDA.8080605@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4E648DDA.8080605@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Pekka Enberg <penberg@kernel.org>, Christoph Lameter <cl@linux-foundation.org>, arnd@arndb.de, linux-kernel@vger.kernel.org, oleg@redhat.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On Mon, Sep 05, 2011 at 02:22:42PM +0530, Srivatsa S. Bhat wrote:
> This could be a CPU hotplug issue too, since a "possible circular locking dependency
> detected" warning was encountered, some time before task freezing failure was hit.

That one seems like a separate issue from the freezing failure.  As
the lockdep warning involves SLAB, I'm cc'ing SLAB maintainers.
Christoph and Pekka, please skip to the lockdep warning.

> Here is a an excerpt of the log:
> 
>  Freezing of tasks failed after 20.01 seconds (2 tasks refusing to freeze, wq_busy=0):
>  invert_cpu_stat D 0000000000000000  5304 20435  17329 0x00000084
>   ffff8801f367bab8 0000000000000046 ffff8801f367bfd8 00000000001d3a00
>   ffff8801f367a010 00000000001d3a00 00000000001d3a00 00000000001d3a00
>   ffff8801f367bfd8 00000000001d3a00 ffff880414cc6840 ffff8801f36783c0
>  Call Trace:
>   [<ffffffff81532de5>] schedule_timeout+0x235/0x320
>   [<ffffffff81532a0b>] wait_for_common+0x11b/0x170
>   [<ffffffff81532b3d>] wait_for_completion+0x1d/0x20
>   [<ffffffff81364486>] _request_firmware+0x156/0x2c0
>   [<ffffffff81364686>] request_firmware+0x16/0x20
>   [<ffffffffa01f0da0>] request_microcode_fw+0x70/0xf0 [microcode]
>   [<ffffffffa01f0390>] microcode_init_cpu+0xc0/0x100 [microcode]
>   [<ffffffffa01f14b4>] mc_cpu_callback+0x7c/0x11f [microcode]
>   [<ffffffff815393a4>] notifier_call_chain+0x94/0xd0
>   [<ffffffff8109770e>] __raw_notifier_call_chain+0xe/0x10
>   [<ffffffff8106d000>] __cpu_notify+0x20/0x40
>   [<ffffffff8152cf5b>] _cpu_up+0xc7/0x10e
>   [<ffffffff8152d07b>] cpu_up+0xd9/0xec
>   [<ffffffff8151e599>] store_online+0x99/0xd0
>   [<ffffffff81355eb0>] sysdev_store+0x20/0x30
>   [<ffffffff811f3096>] sysfs_write_file+0xe6/0x170
>   [<ffffffff8117ee50>] vfs_write+0xd0/0x1a0
>   [<ffffffff8117f024>] sys_write+0x54/0xa0
>   [<ffffffff8153df02>] system_call_fastpath+0x16/0x1b

So, this task is trying to bring a CPU up, which triggers firmware
helper to load microcode.  Firmware class currently sleeps
non-interruptibly to wait for firmware load to complete, which is
performed by another userland task.  Now, the PM freezer doesn't
assume that there will be non-freezable wait dependencies among
userland tasks.  It only knows two levels - userland and kernel tasks
- and assumes that the former group may have non-freezable wait
dependency on the latter but there's no such dependency among each
group itself.  If there's such dependency, PM freezer may fail, which
is what happened here.

ie. the firmware loader userland process got frozen first.
invert_cpu_stat trying to bring up CPU was waiting for the firmware
loader to finish in non-interruptible sleep, so the freezer couldn't
proceed.

>  bash            D 0000000000000000  5784 23638  17550 0x00000084
>   ffff88046068bd88 0000000000000046 ffff88046068bfd8 00000000001d3a00
>   ffff88046068a010 00000000001d3a00 00000000001d3a00 00000000001d3a00
>   ffff88046068bfd8 00000000001d3a00 ffff8801f1592180 ffff88046d59a4c0
>  Call Trace:
>   [<ffffffff81533653>] __mutex_lock_common+0x193/0x3f0
>   [<ffffffff810315f7>] ? cpu_hotplug_driver_lock+0x17/0x20
>   [<ffffffff810315f7>] ? cpu_hotplug_driver_lock+0x17/0x20
>   [<ffffffff815339d7>] mutex_lock_nested+0x37/0x50
>   [<ffffffff810315f7>] cpu_hotplug_driver_lock+0x17/0x20
>   [<ffffffff8151e532>] store_online+0x32/0xd0
>   [<ffffffff81355eb0>] sysdev_store+0x20/0x30
>   [<ffffffff811f3096>] sysfs_write_file+0xe6/0x170
>   [<ffffffff8117ee50>] vfs_write+0xd0/0x1a0
>   [<ffffffff8117f024>] sys_write+0x54/0xa0
>   [<ffffffff8153df02>] system_call_fastpath+0x16/0x1b

This one is just blocked on the first process.

I don't know.  Maybe we can improve firmware loader such that it can
handle freezing while waiting for completion
(wait_for_completion_freezable?).

And, here's the lockdep warning.  Christoph, Pekka, any ideas?

>  =======================================================
>  [ INFO: possible circular locking dependency detected ]
>  3.1.0-rc2 #1
>  -------------------------------------------------------
>  invert_cpu_stat/17338 is trying to acquire lock:
>   (alc_key){..-...}, at: [<ffffffff81168fa9>] kmem_cache_free+0x1a9/0x240
>  
>  but task is already holding lock:
>   (&(&parent->list_lock)->rlock){-.-...}, at: [<ffffffff8152e610>] cpuup_canceled+0x82/0x1a3
>  
>  which lock already depends on the new lock.
>  
>  
>  the existing dependency chain (in reverse order) is:
>  
>  -> #1 (&(&parent->list_lock)->rlock){-.-...}:
>         [<ffffffff810ab50c>] validate_chain+0x6cc/0x7d0
>         [<ffffffff810ab914>] __lock_acquire+0x304/0x500
>         [<ffffffff810ac1d2>] lock_acquire+0xa2/0x130
>         [<ffffffff815349b6>] _raw_spin_lock+0x36/0x70
>         [<ffffffff81169294>] __drain_alien_cache+0x64/0xa0
>         [<ffffffff811698cb>] kfree+0x1db/0x2a0
>         [<ffffffff81169a21>] free_alien_cache+0x91/0xa0
>         [<ffffffff8152e9b9>] cpuup_prepare+0x168/0x1a9
>         [<ffffffff8152ea2f>] cpuup_callback+0x35/0xc5
>         [<ffffffff815393a4>] notifier_call_chain+0x94/0xd0
>         [<ffffffff8109770e>] __raw_notifier_call_chain+0xe/0x10
>         [<ffffffff8106d000>] __cpu_notify+0x20/0x40
>         [<ffffffff8152cf02>] _cpu_up+0x6e/0x10e
>         [<ffffffff8152d07b>] cpu_up+0xd9/0xec
>         [<ffffffff81e21bd6>] smp_init+0x41/0x96
>         [<ffffffff81e03791>] kernel_init+0x1ef/0x2a6
>         [<ffffffff81540184>] kernel_thread_helper+0x4/0x10
>  
>  -> #0 (alc_key){..-...}:
>         [<ffffffff810aae18>] check_prev_add+0x528/0x550
>         [<ffffffff810ab50c>] validate_chain+0x6cc/0x7d0
>         [<ffffffff810ab914>] __lock_acquire+0x304/0x500
>         [<ffffffff810ac1d2>] lock_acquire+0xa2/0x130
>         [<ffffffff815349b6>] _raw_spin_lock+0x36/0x70
>         [<ffffffff81168fa9>] kmem_cache_free+0x1a9/0x240
>         [<ffffffff81169094>] slab_destroy+0x54/0x80
>         [<ffffffff8116911d>] free_block+0x5d/0x170
>         [<ffffffff8152e62f>] cpuup_canceled+0xa1/0x1a3
>         [<ffffffff8152ea96>] cpuup_callback+0x9c/0xc5
>         [<ffffffff815393a4>] notifier_call_chain+0x94/0xd0
>         [<ffffffff8109770e>] __raw_notifier_call_chain+0xe/0x10
>         [<ffffffff8106d000>] __cpu_notify+0x20/0x40
>         [<ffffffff8106d035>] cpu_notify_nofail+0x15/0x30
>         [<ffffffff8151beed>] _cpu_down+0x12d/0x2b0
>         [<ffffffff8151c0a6>] cpu_down+0x36/0x50
>         [<ffffffff8151e571>] store_online+0x71/0xd0
>         [<ffffffff81355eb0>] sysdev_store+0x20/0x30
>         [<ffffffff811f3096>] sysfs_write_file+0xe6/0x170
>         [<ffffffff8117ee50>] vfs_write+0xd0/0x1a0
>         [<ffffffff8117f024>] sys_write+0x54/0xa0
>         [<ffffffff8153df02>] system_call_fastpath+0x16/0x1b
>  
>  other info that might help us debug this:
>  
>   Possible unsafe locking scenario:
>  
>         CPU0                    CPU1
>         ----                    ----
>    lock(&(&parent->list_lock)->rlock);
>                                 lock(alc_key);
>                                 lock(&(&parent->list_lock)->rlock);
>    lock(alc_key);

Thanks.

-- 
tejun
