From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: deadlock between mmc_pm_notify() and mmcqd
Date: Tue, 29 Mar 2011 18:11:14 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1103291755190.2328@localhost6.localdomain6>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi linux-pm'ers,


I'm encountering the following deadlock:


First, an "echo disk >/sys/power/state":

[<c03bad2c>] (schedule+0x48c/0x50c) from [<c01a5ca4>] (log_wait_commit+0xb8/0x110)
[<c01a5ca4>] (log_wait_commit+0xb8/0x110) from [<c0193254>] (ext3_sync_fs+0x3c/0x44)
[<c0193254>] (ext3_sync_fs+0x3c/0x44) from [<c015d7a0>] (__sync_filesystem+0x50/0x60)
[<c015d7a0>] (__sync_filesystem+0x50/0x60) from [<c01663ac>] (fsync_bdev+0x18/0x38)
[<c01663ac>] (fsync_bdev+0x18/0x38) from [<c01d4ef8>] (invalidate_partition+0x18/0x34)
[<c01d4ef8>] (invalidate_partition+0x18/0x34) from [<c0182260>] (del_gendisk+0x24/0xc0)
[<c0182260>] (del_gendisk+0x24/0xc0) from [<c02f7f48>] (mmc_blk_remove+0x20/0x40)
[<c02f7f48>] (mmc_blk_remove+0x20/0x40) from [<c02f233c>] (mmc_bus_remove+0x18/0x20)
[<c02f233c>] (mmc_bus_remove+0x18/0x20) from [<c024649c>] (__device_release_driver+0x64/0xa4)
[<c024649c>] (__device_release_driver+0x64/0xa4) from [<c02465a4>] (device_release_driver+0x1c/0x28)
[<c02465a4>] (device_release_driver+0x1c/0x28) from [<c0245ae0>] (bus_remove_device+0x6c/0x7c)
[<c0245ae0>] (bus_remove_device+0x6c/0x7c) from [<c0244178>] (device_del+0x118/0x170)
[<c0244178>] (device_del+0x118/0x170) from [<c02f23f4>] (mmc_remove_card+0x50/0x64)
[<c02f23f4>] (mmc_remove_card+0x50/0x64) from [<c02f3ed4>] (mmc_sd_remove+0x24/0x30)
[<c02f3ed4>] (mmc_sd_remove+0x24/0x30) from [<c02f1c0c>] (mmc_pm_notify+0x88/0xd8)
[<c02f1c0c>] (mmc_pm_notify+0x88/0xd8) from [<c00d6780>] (notifier_call_chain+0x2c/0x70)
[<c00d6780>] (notifier_call_chain+0x2c/0x70) from [<c00d6998>] (__blocking_notifier_call_chain+0x48/0x5c)
[<c00d6998>] (__blocking_notifier_call_chain+0x48/0x5c) from [<c00d69c0>] (blocking_notifier_call_chain+0x14/0x18)
[<c00d69c0>] (blocking_notifier_call_chain+0x14/0x18) from [<c00ebc70>] (pm_notifier_call_chain+0x14/0x2c)
[<c00ebc70>] (pm_notifier_call_chain+0x14/0x2c) from [<c00ed630>] (hibernate+0x1a8/0x1d8)
[<c00ed630>] (hibernate+0x1a8/0x1d8) from [<c00ebbc4>] (state_store+0x4c/0xe4)
[<c00ebbc4>] (state_store+0x4c/0xe4) from [<c01d9d34>] (kobj_attr_store+0x18/0x1c)
[<c01d9d34>] (kobj_attr_store+0x18/0x1c) from [<c0183bf8>] (sysfs_write_file+0x10c/0x140)
[<c0183bf8>] (sysfs_write_file+0x10c/0x140) from [<c013d8bc>] (vfs_write+0xac/0x154)
[<c013d8bc>] (vfs_write+0xac/0x154) from [<c013da10>] (sys_write+0x3c/0x68)
[<c013da10>] (sys_write+0x3c/0x68) from [<c007d700>] (ret_fast_syscall+0x0/0x2c)

This waits for I/O. Which would be processed by mmcqd:

mmcqd D c03bad2c 0 516 2 0x00000000
[<c03bad2c>] (schedule+0x48c/0x50c) from [<c02f1ae8>] (__mmc_claim_host+0xbc/0x158)
[<c02f1ae8>] (__mmc_claim_host+0xbc/0x158) from [<c02f8378>] (mmc_blk_issue_rq+0x2c/0x728)
[<c02f8378>] (mmc_blk_issue_rq+0x2c/0x728) from [<c02f9184>] (mmc_queue_thread+0xd8/0xdc)
[<c02f9184>] (mmc_queue_thread+0xd8/0xdc) from [<c00d199c>] (kthread+0x80/0x88)
[<c00d199c>] (kthread+0x80/0x88) from [<c007e0e4>] (kernel_thread_exit+0x0/0x8)

and that's waiting to claim the MMC host.

Which will never happen - mmc_pm_notify(), by the point above, holds that 
host ransom already, the code does the mmc_claim_host() directly before 
calling into bus_ops->suspend().


I wonder if this is a known problem. We're running a customized 2.6.32 
kernel, so admittedly not the latest; mmc_pm_notify, on the other hand, is 
already newer than that, introduced via:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e;hp=7310ece86ad7da027f85a37a0638164118a5d12f

in 2.6.35, and in itself not changed since.

I've found https://lkml.org/lkml/2010/10/21/494 which talks about a 
regression from said change, but nothing came out of that, and the 
codepaths mentioned is mmc_suspend_host not mmc_sd_remove.

The device I'm testing this on is an OMAP3 box that boots via MMC, hence 
the root filesystem is on there and it'd be expected dirty.

Removing the abovementioned commit will of course prevent this from 
happening, but then I wonder ?


FrankH.
