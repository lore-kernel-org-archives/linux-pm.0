From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Random freezing failure with NFS and automount
Date: Tue, 28 Jun 2011 21:20:54 +0530
Message-ID: <20110628155054.GA23242@dirshya.in.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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

Hi,

I have random freezing failures on my laptop running 2.6.39 kernel.
The laptop has NFS client and automount.  Network could have been
disconnected by the time suspend is attempted, hence nfs client should
fail all operations, just freeze and allow laptop to suspend.

I need some help to drill deeper at this log and also suggestions on
config options to try and get more information to help me root cause
this issue.

This happens once in 4-5 suspend/resume cycles, does not succeed on
retry, eventually I have to reboot.

Linux kernel version 2.6.39-2.slh.1-aptosid-amd64 (debian)

[15203.060847] PM: Syncing filesystems ... done.
[15203.224792] Freezing user space processes ... 
[15223.230516] Freezing of tasks failed after 20.00 seconds (1 tasks refusing to freeze, wq_busy=0):
[15223.230551] man             T 0000000000000002     0  6788   6765 0x00800004
[15223.230557]  ffff880037192760 0000000000000086 ffff88011823cc30 ffff88013328bb10
[15223.230562]  ffff88010bd83fd8 ffff88010bd83fd8 ffff88010bd83fd8 ffff880037192760
[15223.230567]  ffff8801332d5ac0 ffffffff8103cd7c ffff880037192760 ffff88012f8d5a88
[15223.230571] Call Trace:
[15223.230581]  [<ffffffff8103cd7c>] ? __wake_up_sync_key+0x4c/0x90
[15223.230588]  [<ffffffff8105b4f9>] ? do_notify_parent_cldstop+0x149/0x1b0
[15223.230596]  [<ffffffff810fb5c9>] ? kmem_cache_free+0x99/0xb0
[15223.230600]  [<ffffffff8105b767>] ? do_signal_stop+0xa7/0x1e0
[15223.230604]  [<ffffffff8105c74d>] ? get_signal_to_deliver+0xfd/0x3f0
[15223.230609]  [<ffffffff8100a114>] ? do_signal+0x84/0x7e0
[15223.230614]  [<ffffffff81033c28>] ? do_page_fault+0x198/0x440
[15223.230619]  [<ffffffff8104fb38>] ? do_wait+0x1d8/0x210
[15223.230623]  [<ffffffff81050dc5>] ? sys_wait4+0xa5/0x100
[15223.230626]  [<ffffffff8100a8f5>] ? do_notify_resume+0x65/0x90
[15223.230630]  [<ffffffff8104eab0>] ? delayed_put_task_struct+0x60/0x60
[15223.230637]  [<ffffffff813b4c60>] ? int_signal+0x12/0x17
[15223.230640] pager           T 0000000000000000     0  6799   6788 0x00800004
[15223.230647]  ffff880037196900 0000000000000086 ffff880037025200 ffff880133326f90
[15223.230649]  ffff88010487bfd8 ffff88010487bfd8 ffff88010487bfd8 ffff880037196900
[15223.230651]  ffff8801303318c0 ffffffff8103cd7c ffff880037196900 ffff8801332d62c8
[15223.230653] Call Trace:
[15223.230655]  [<ffffffff8103cd7c>] ? __wake_up_sync_key+0x4c/0x90
[15223.230657]  [<ffffffff8105b4f9>] ? do_notify_parent_cldstop+0x149/0x1b0
[15223.230659]  [<ffffffff810400d8>] ? check_preempt_wakeup+0x118/0x160
[15223.230661]  [<ffffffff810fb544>] ? kmem_cache_free+0x14/0xb0
[15223.230663]  [<ffffffff8105b767>] ? do_signal_stop+0xa7/0x1e0
[15223.230665]  [<ffffffff8105c74d>] ? get_signal_to_deliver+0xfd/0x3f0
[15223.230667]  [<ffffffff8100a114>] ? do_signal+0x84/0x7e0
[15223.230669]  [<ffffffff8105d312>] ? sys_kill+0x122/0x1d0
[15223.230670]  [<ffffffff8100a8f5>] ? do_notify_resume+0x65/0x90
[15223.230672]  [<ffffffff813b4c60>] ? int_signal+0x12/0x17
[15223.230685] automount       D 0000000000000003     0 15394   2438 0x00800004
[15223.230688]  ffff8800a0a83480 0000000000000082 0000000000000000 ffff8801183dc1a0
[15223.230690]  ffff88009c4e3fd8 ffff88009c4e3fd8 ffff88009c4e3fd8 ffff8800a0a83480
[15223.230692]  ffff88009c4e3ce0 ffff88010bf95001 ffff88009c4e3c5e ffffffff81113547
[15223.230694] Call Trace:
[15223.230697]  [<ffffffff81113547>] ? __follow_mount_rcu.isra.21+0x37/0xe0
[15223.230703]  [<ffffffff812b3b89>] ? kernel_sendmsg+0x39/0x50
[15223.230722]  [<ffffffffa059992a>] ? xs_send_kvec+0x8a/0x90 [sunrpc]
[15223.230727]  [<ffffffffa059c3f0>] ? rpc_queue_empty+0x40/0x40 [sunrpc]
[15223.230732]  [<ffffffffa059c40f>] ? rpc_wait_bit_killable+0x1f/0x40 [sunrpc]
[15223.230734]  [<ffffffff813b253f>] ? __wait_on_bit+0x4f/0x80
[15223.230738]  [<ffffffffa059c3f0>] ? rpc_queue_empty+0x40/0x40 [sunrpc]
[15223.230740]  [<ffffffff813b25ec>] ? out_of_line_wait_on_bit+0x7c/0xa0
[15223.230744]  [<ffffffff81068610>] ? autoremove_wake_function+0x30/0x30
[15223.230748]  [<ffffffffa059d0d4>] ? __rpc_execute+0xe4/0x2f0 [sunrpc]
[15223.230750]  [<ffffffff810682d8>] ? wake_up_bit+0x18/0x40
[15223.230754]  [<ffffffffa0596299>] ? rpc_run_task+0x69/0x90 [sunrpc]
[15223.230757]  [<ffffffffa05963cf>] ? rpc_call_sync+0x3f/0x70 [sunrpc]
[15223.230765]  [<ffffffffa05f089c>] ? nfs3_rpc_wrapper.constprop.15+0x3c/0x60 [nfs]
[15223.230770]  [<ffffffffa05f1c13>] ? nfs3_proc_getattr+0x43/0x90 [nfs]
[15223.230775]  [<ffffffffa05e0d94>] ? __nfs_revalidate_inode+0x94/0x200 [nfs]
[15223.230780]  [<ffffffffa05e1107>] ? nfs_getattr+0x57/0x110 [nfs]
[15223.230782]  [<ffffffff8110c432>] ? vfs_fstatat+0x52/0x70
[15223.230784]  [<ffffffff8110c5c2>] ? sys_newlstat+0x12/0x30
[15223.230787]  [<ffffffff81125026>] ? mntput_no_expire+0x16/0xf0
[15223.230790]  [<ffffffff8110625f>] ? filp_close+0x5f/0x90
[15223.230791]  [<ffffffff8110633d>] ? sys_close+0xad/0x120
[15223.230793]  [<ffffffff813b4992>] ? system_call_fastpath+0x16/0x1b
[15223.230796] 
[15223.230797] Restarting tasks ... done.

Thanks,
Vaidy
