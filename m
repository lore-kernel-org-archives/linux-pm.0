From: "Rafael J. Wysocki" <rjw@novell.com>
Subject: Re: failure to freeze with nfs
Date: Fri, 8 Oct 2010 22:39:18 +0200
Message-ID: <201010082239.19043.rjw@novell.com>
References: <201010081238.04590.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010081238.04590.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Miklos Szeredi <mszeredi@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, October 08, 2010, Oliver Neukum wrote:
> Hi,
> 
> my kernel refused to freeze tasks due to nfs. Can something be done?

The issue has been there for a long time and it would require some VFS
changes to really fix it.

Miklos said he would look into it some time ago, but I guess he didn't have
the time ...

> Oct  8 12:32:24 vanamonde kernel: [ 7023.362569] PM: Syncing filesystems ... done.
> Oct  8 12:32:24 vanamonde kernel: [ 7024.823085] PM: Preparing system for mem sleep
> Oct  8 12:32:24 vanamonde kernel: [ 7024.823451] Freezing user space processes ... 
> Oct  8 12:32:24 vanamonde kernel: [ 7044.833119] Freezing of tasks failed after 20.00 seconds (1 tasks refusing to freeze, wq_busy=0):
> Oct  8 12:32:24 vanamonde kernel: [ 7044.833186] cp            D 0000000000000082     0  3340   3291 0x00800004
> Oct  8 12:32:24 vanamonde kernel: [ 7044.833192]  ffff88004ec2daf8 0000000000000082 ffff88004ec2da48 ffffffff81378f7c
> Oct  8 12:32:24 vanamonde kernel: [ 7044.833201]  00000000000137c0 ffff88004ec2dfd8 ffff88004ec2dfd8 ffff88005ec3c540
> Oct  8 12:32:24 vanamonde kernel: [ 7044.833209]  ffff88004ec2dfd8 00000000000137c0 ffff88004ec2dfd8 ffff88005ec3c8e0
> Oct  8 12:32:24 vanamonde kernel: [ 7044.833218] Call Trace:
> Oct  8 12:32:24 vanamonde kernel: [ 7044.833228]  [<ffffffff81378f7c>] ? kernel_sendmsg+0x3c/0x50
> Oct  8 12:32:24 vanamonde kernel: [ 7044.833251]  [<ffffffffa057ab20>] ? rpc_wait_bit_killable+0x0/0x40 [sunrpc]
> Oct  8 12:32:24 vanamonde kernel: [ 7044.833268]  [<ffffffffa057ab3f>] rpc_wait_bit_killable+0x1f/0x40 [sunrpc]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833274]  [<ffffffff8146fc67>] __wait_on_bit+0x57/0x80
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833283]  [<ffffffffa05754e1>] ? xprt_release_xprt+0x81/0x90 [sunrpc]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833292]  [<ffffffffa057ab20>] ? rpc_wait_bit_killable+0x0/0x40 [sunrpc]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833297]  [<ffffffff8146fd03>] out_of_line_wait_on_bit+0x73/0x90
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833302]  [<ffffffff81074b50>] ? wake_bit_function+0x0/0x40
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833311]  [<ffffffffa057309a>] ? call_transmit+0x1ea/0x2b0 [sunrpc]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833320]  [<ffffffffa057b2c5>] __rpc_execute+0xe5/0x220 [sunrpc]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833330]  [<ffffffffa057ba3e>] rpc_execute+0x3e/0x50 [sunrpc]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833338]  [<ffffffffa0574320>] rpc_run_task+0xe0/0x130 [sunrpc]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833347]  [<ffffffffa057445e>] rpc_call_sync+0x3e/0x70 [sunrpc]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833359]  [<ffffffffa06a5ee3>] nfs3_rpc_wrapper.clone.0+0x43/0x70 [nfs]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833369]  [<ffffffffa06a71b2>] nfs3_proc_getattr+0x42/0x80 [nfs]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833378]  [<ffffffffa069602a>] __nfs_revalidate_inode+0xca/0x200 [nfs]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833386]  [<ffffffffa06961ad>] nfs_revalidate_mapping+0x4d/0x130 [nfs]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833394]  [<ffffffffa069312f>] nfs_file_read+0x6f/0x100 [nfs]
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833399]  [<ffffffff81124cb2>] do_sync_read+0xd2/0x110
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833404]  [<ffffffff811dbad4>] ? security_file_permission+0x74/0x90
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833409]  [<ffffffff81125463>] vfs_read+0xc3/0x180
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833412]  [<ffffffff8112556c>] sys_read+0x4c/0x80
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833417]  [<ffffffff81002f02>] system_call_fastpath+0x16/0x1b
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833423] 
> Oct  8 12:32:25 vanamonde kernel: [ 7044.833425] Restarting tasks ... done.
> 

Rafael
