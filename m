From: "Miles Lane" <miles.lane@gmail.com>
Subject: 2.6.24-rc5-mm1 -- WARNING: at
	arch/x86/kernel/smp_32.c:561 native_smp_call_function_mask()
Date: Wed, 19 Dec 2007 08:17:20 -0500
Message-ID: <a44ae5cd0712190517t7c80e15bv759fa5486dfca234@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Is this warning about something that needs attention?

Dec 19 08:05:42 syntropy kernel: [  126.422685] PM: Creating hibernation image:
Dec 19 08:05:42 syntropy kernel: [  126.422689] WARNING: at
arch/x86/kernel/smp_32.c:561 native_smp_call_function_mask()
Dec 19 08:05:42 syntropy kernel: [  126.422693] Pid: 5504, comm:
pm-hibernate Not tainted 2.6.24-rc5-mm1 #8
Dec 19 08:05:42 syntropy kernel: [  126.422695]
[show_trace_log_lvl+0x12/0x25] show_trace_log_lvl+0x12/0x25
Dec 19 08:05:42 syntropy kernel: [  126.422704]  [show_trace+0xd/0x10]
show_trace+0xd/0x10
Dec 19 08:05:42 syntropy kernel: [  126.422708]
[sbp2:dump_stack+0x57/0x1734] dump_stack+0x57/0x5f
Dec 19 08:05:42 syntropy kernel: [  126.422712]
[native_smp_call_function_mask+0x41/0x126]
native_smp_call_function_mask+0x41/0x126
Dec 19 08:05:42 syntropy kernel: [  126.422717]
[smp_call_function+0x18/0x1f] smp_call_function+0x18/0x1f
Dec 19 08:05:42 syntropy kernel: [  126.422722]
[on_each_cpu+0x12/0x40] on_each_cpu+0x12/0x40
Dec 19 08:05:42 syntropy kernel: [  126.422728]
[drain_all_pages+0x13/0x16] drain_all_pages+0x13/0x16
Dec 19 08:05:42 syntropy kernel: [  126.422733]
[swsusp_save+0x18/0x46b] swsusp_save+0x18/0x46b
Dec 19 08:05:42 syntropy kernel: [  126.422738]
[swsusp_arch_suspend+0x2a/0x2c] swsusp_arch_suspend+0x2a/0x2c
Dec 19 08:05:42 syntropy kernel: [  126.422743]
[hibernate+0xba/0x16e] hibernate+0xba/0x16e
Dec 19 08:05:42 syntropy kernel: [  126.422747]
[state_store+0x45/0xac] state_store+0x45/0xac
Dec 19 08:05:42 syntropy kernel: [  126.422750]
[kobj_attr_store+0x1a/0x22] kobj_attr_store+0x1a/0x22
Dec 19 08:05:42 syntropy kernel: [  126.422755]
[sysfs_write_file+0xb8/0xe3] sysfs_write_file+0xb8/0xe3
Dec 19 08:05:42 syntropy kernel: [  126.422759]
[vfs_write+0xa4/0x120] vfs_write+0xa4/0x120
Dec 19 08:05:42 syntropy kernel: [  126.422764]  [sys_write+0x3b/0x60]
sys_write+0x3b/0x60
Dec 19 08:05:42 syntropy kernel: [  126.422767]
[sysenter_past_esp+0x6b/0xc1] sysenter_past_esp+0x6b/0xc1
Dec 19 08:05:42 syntropy kernel: [  126.422771]  =======================
Dec 19 08:05:42 syntropy kernel: [  126.512956] PM: Need to copy 123427 pages
Dec 19 08:05:42 syntropy kernel: [  126.512960] PM: Normal pages
needed: 47288 + 1024 + 40, available pages: 181983
