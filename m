From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hibernation hangs with ATA errors (lockup_detector
	bug)
Date: Tue, 01 Jun 2010 16:51:22 +0200
Message-ID: <4C051E6A.20102__33063.0366145217$1275403981$gmane$org@gmail.com>
References: <4C03C608.1040600@gmail.com> <20100601135004.GP15159@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100601135004.GP15159@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Don Zickus <dzickus@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/01/2010 03:50 PM, Don Zickus wrote:
> I'll need your whole boot up log to see how the lockup detector
> initialized itself.

Ah, plus hung tasks:

INFO: task s2disk:3218 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
s2disk        D ffff88003c61cd40     0  3218   3184 0x00000000
 ffff88003c639af8 0000000000000082 0000000000011f00 0000000000011f00
 ffff88003c639fd8 ffff88003c639fd8 ffff88003c61cd40 0000000000011f00
 ffff88003c639fd8 0000000000011f00 ffffffff8180d020 ffff88003c61cd40
Call Trace:
 [<ffffffff8157ba75>] schedule_timeout+0x1b5/0x220
 [<ffffffff8157b113>] ? schedule+0x263/0x5a0
 [<ffffffff8157b655>] wait_for_common+0xc5/0x150
 [<ffffffff8105d7b0>] ? default_wake_function+0x0/0x10
 [<ffffffff8157b778>] wait_for_completion+0x18/0x20
 [<ffffffff8107772e>] flush_cpu_workqueue+0xce/0x110
 [<ffffffff81077170>] ? wq_barrier_func+0x0/0x10
 [<ffffffff81077788>] cleanup_workqueue_thread+0x18/0x30
 [<ffffffff81568f3b>] workqueue_cpu_callback+0xc3/0x117
 [<ffffffff81080acc>] notifier_call_chain+0x4c/0x70
 [<ffffffff81080ba9>] __raw_notifier_call_chain+0x9/0x10
 [<ffffffff8156768b>] __cpu_notify+0x1b/0x30
 [<ffffffff81064550>] cpu_notify+0x10/0x20
 [<ffffffff81064569>] cpu_notify_nofail+0x9/0x20
 [<ffffffff81567a48>] _cpu_down+0x218/0x290
 [<ffffffff8106482e>] disable_nonboot_cpus+0x7e/0xf0
 [<ffffffff8109651d>] hibernation_platform_enter+0xbd/0x100
 [<ffffffff8109a0b7>] snapshot_ioctl+0x3e7/0x670
 [<ffffffff811042ac>] vfs_ioctl+0x3c/0xd0
 [<ffffffff81104a5d>] do_vfs_ioctl+0x7d/0x3d0
 [<ffffffff81104dfa>] sys_ioctl+0x4a/0x80
 [<ffffffff81029deb>] system_call_fastpath+0x16/0x1b
INFO: task events/1:3246 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
events/1      D 0000000000000000     0  3246      2 0x00000000
 ffff88003b205ee0 0000000000000046 0000000000011f00 0000000000011f00
 ffff88003b205fd8 ffff88003b205fd8 ffff88003195e090 0000000000011f00
 ffff88003b205fd8 0000000000011f00 ffff88003c61cd40 ffff88003195e090
Call Trace:
 [<ffffffff81076f10>] ? worker_thread+0x0/0x100
 [<ffffffff8107b2f2>] kthread+0x72/0xa0
 [<ffffffff8102ab14>] kernel_thread_helper+0x4/0x10
 [<ffffffff8107b280>] ? kthread+0x0/0xa0
 [<ffffffff8102ab10>] ? kernel_thread_helper+0x0/0x10

-- 
js
