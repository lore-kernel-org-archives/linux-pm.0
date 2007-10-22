From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: lockdep report in hibernate code
Date: Tue, 23 Oct 2007 00:39:29 +0200
Message-ID: <200710230039.30224.rjw@sisk.pl>
References: <1193062264.9793.11.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1193062264.9793.11.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 22 October 2007 16:11, Johannes Berg wrote:
> I just got this on my quad powermac which then failed to hibernate
> (separate mail coming soon):
> 
> Oct 22 15:37:59 quad kernel: [  362.782679] [ INFO: possible circular locking dependency detected ]
> Oct 22 15:37:59 quad kernel: [  362.782687] 2.6.23-g55b70a03-dirty #268
> Oct 22 15:37:59 quad kernel: [  362.782696] -------------------------------------------------------
> Oct 22 15:37:59 quad kernel: [  362.782704] pm-hibernate/4231 is trying to acquire lock:
> Oct 22 15:37:59 quad kernel: [  362.782710]  (pm_mutex){--..}, at: [<c00000000008ae28>] .disk_store+0x70/0x17c
> Oct 22 15:37:59 quad kernel: [  362.782742] 
> Oct 22 15:37:59 quad kernel: [  362.782744] but task is already holding lock:
> Oct 22 15:37:59 quad kernel: [  362.782751]  (&buffer->mutex){--..}, at: [<c00000000013a620>] .sysfs_write_file+0x58/0x19c
> Oct 22 15:37:59 quad kernel: [  362.782771] 
> Oct 22 15:37:59 quad kernel: [  362.782773] which lock already depends on the new lock.

That's strange and almost certainly not true.

> Oct 22 15:37:59 quad kernel: [  362.782776] 
> Oct 22 15:37:59 quad kernel: [  362.782782] 
> Oct 22 15:37:59 quad kernel: [  362.782783] the existing dependency chain (in reverse order) is:
> Oct 22 15:37:59 quad kernel: [  362.782795] 
> Oct 22 15:37:59 quad kernel: [  362.782797] -> #1 (&buffer->mutex){--..}:
> Oct 22 15:37:59 quad kernel: [  362.782831]        [<c00000000007d190>] .__lock_acquire+0xcf0/0xf60
> Oct 22 15:37:59 quad kernel: [  362.782910]        [<c00000000007d4d0>] .lock_acquire+0xd0/0x11c
> Oct 22 15:37:59 quad kernel: [  362.782982]        [<c0000000003e0ed8>] .mutex_lock_nested+0x150/0x3e8
> Oct 22 15:37:59 quad kernel: [  362.783061]        [<c00000000013a7bc>] .sysfs_read_file+0x58/0x1a0
> Oct 22 15:37:59 quad kernel: [  362.783137]        [<c0000000000dd130>] .vfs_read+0xd8/0x1b0
> Oct 22 15:37:59 quad kernel: [  362.783211]        [<c0000000000dd960>] .sys_read+0x5c/0xac
> Oct 22 15:37:59 quad kernel: [  362.783285]        [<c000000000008014>] .try_name+0x88/0x260
> Oct 22 15:37:59 quad kernel: [  362.783362]        [<c000000000008430>] .name_to_dev_t+0x244/0x2e8
> Oct 22 15:37:59 quad kernel: [  362.783439]        [<c00000000008b33c>] .software_resume+0x7c/0x200
> Oct 22 15:37:59 quad kernel: [  362.783516]        [<c00000000054e8f8>] .kernel_init+0x214/0x3e8
> Oct 22 15:37:59 quad kernel: [  362.783588]        [<c000000000024cdc>] .kernel_thread+0x4c/0x68
> Oct 22 15:37:59 quad kernel: [  362.783623] 
> Oct 22 15:37:59 quad kernel: [  362.783625] -> #0 (pm_mutex){--..}:
> Oct 22 15:37:59 quad kernel: [  362.783659]        [<c00000000007d088>] .__lock_acquire+0xbe8/0xf60
> Oct 22 15:37:59 quad kernel: [  362.783733]        [<c00000000007d4d0>] .lock_acquire+0xd0/0x11c
> Oct 22 15:37:59 quad kernel: [  362.783810]        [<c0000000003e0ed8>] .mutex_lock_nested+0x150/0x3e8
> Oct 22 15:37:59 quad kernel: [  362.783884]        [<c00000000008ae28>] .disk_store+0x70/0x17c
> Oct 22 15:37:59 quad kernel: [  362.783960]        [<c00000000013a160>] .subsys_attr_store+0x58/0x70
> Oct 22 15:37:59 quad kernel: [  362.784033]        [<c00000000013a6f4>] .sysfs_write_file+0x12c/0x19c
> Oct 22 15:37:59 quad kernel: [  362.784104]        [<c0000000000dcf80>] .vfs_write+0xd8/0x1b0
> Oct 22 15:37:59 quad kernel: [  362.784179]        [<c0000000000dda0c>] .sys_write+0x5c/0xac
> Oct 22 15:37:59 quad kernel: [  362.784255]        [<c000000000007550>] syscall_exit+0x0/0x40
> Oct 22 15:37:59 quad kernel: [  362.784331] 
> Oct 22 15:37:59 quad kernel: [  362.784333] other info that might help us debug this:
> Oct 22 15:37:59 quad kernel: [  362.784336] 
> Oct 22 15:37:59 quad kernel: [  362.784349] 1 lock held by pm-hibernate/4231:
> Oct 22 15:37:59 quad kernel: [  362.784360]  #0:  (&buffer->mutex){--..}, at: [<c00000000013a620>] .sysfs_write_file+0x58/0x19c
> Oct 22 15:37:59 quad kernel: [  362.784411] 
> Oct 22 15:37:59 quad kernel: [  362.784413] stack backtrace:
> Oct 22 15:37:59 quad kernel: [  362.784423] Call Trace:
> Oct 22 15:37:59 quad kernel: [  362.784434] [c000000010783650] [c00000000000e758] .show_stack+0x78/0x1a4 (unreliable)
> Oct 22 15:37:59 quad kernel: [  362.784473] [c000000010783700] [c00000000000e8a4] .dump_stack+0x20/0x34
> Oct 22 15:37:59 quad kernel: [  362.784503] [c000000010783780] [c00000000007a74c] .print_circular_bug_tail+0x88/0xac
> Oct 22 15:37:59 quad kernel: [  362.784535] [c000000010783850] [c00000000007d088] .__lock_acquire+0xbe8/0xf60
> Oct 22 15:37:59 quad kernel: [  362.784567] [c000000010783940] [c00000000007d4d0] .lock_acquire+0xd0/0x11c
> Oct 22 15:37:59 quad kernel: [  362.784599] [c000000010783a00] [c0000000003e0ed8] .mutex_lock_nested+0x150/0x3e8
> Oct 22 15:37:59 quad kernel: [  362.784619] [c000000010783af0] [c00000000008ae28] .disk_store+0x70/0x17c
> Oct 22 15:37:59 quad kernel: [  362.784650] [c000000010783ba0] [c00000000013a160] .subsys_attr_store+0x58/0x70
> Oct 22 15:37:59 quad kernel: [  362.784680] [c000000010783c20] [c00000000013a6f4] .sysfs_write_file+0x12c/0x19c
> Oct 22 15:37:59 quad kernel: [  362.784712] [c000000010783ce0] [c0000000000dcf80] .vfs_write+0xd8/0x1b0
> Oct 22 15:37:59 quad kernel: [  362.784742] [c000000010783d80] [c0000000000dda0c] .sys_write+0x5c/0xac
> Oct 22 15:37:59 quad kernel: [  362.784772] [c000000010783e30] [c000000000007550] syscall_exit+0x0/0x40
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
