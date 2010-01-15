From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Memory allocations in .suspend became very unreliable
Date: Fri, 15 Jan 2010 12:34:08 +0200
Message-ID: <1263551648.4581.2.camel@maxim-laptop>
References: <1263549544.3112.10.camel@maxim-laptop> <4B50425B.4050605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B50425B.4050605@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Romit Dasgupta <romit@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-01-15 at 15:54 +0530, Romit Dasgupta wrote: 
> Maxim Levitsky wrote:
> > Hi,
> > 
> > I know that this is very controversial, because here I want to describe
> > a problem in a proprietary driver that happens now in 2.6.33-rc3
> > I am taking about nvidia driver.
> > 
> > Some time ago I did very long hibernate test and found no errors after
> > more that 200 cycles.
> > 
> > Now I update to 2.6.33 and notice that system will hand when nvidia
> > driver allocates memory is their .suspend functions.
> > This could fail in 2.6.32 if I would run many memory hungry
> > applications, but now this happens with most of memory free.
> > 
> > I added some printks to function used to allocate memory in nvidia
> > driver and found out that contrary to my belief, they don't allocate
> > much memory there.
> Hello Maxim,
>                Do you hit the error early if you reduce your memory (by passing
> 'mem=  ' bootargs)? The hibernation routine allocates memory for creating its
> own bitmaps, so I was wondering if it is really a memory issue or bug in the
> nvidia driver.

I know that kmalloc is to blame here, here is the backtrace:

<6>[ 3775.469811] pm-hibernate  D 0000000000000000     0  6890   5630 0x00000000
<4>[ 3775.469811]  ffff880037c7b4f8 0000000000000046 0000000000000000 ffffffff812db456
<4>[ 3775.469811]  ffff880037c7b438 0000000000000000 00000001000525fc ffff880004214e58
<4>[ 3775.469811]  ffff88000420f008 ffff880037c7a000 ffff88006fbec1f8 ffff880037c7bfd8
<4>[ 3775.469811] Call Trace:
<4>[ 3775.469811]  [<ffffffff812db456>] ? scsi_request_fn+0xb6/0x400
<4>[ 3775.469811]  [<ffffffff8122fc69>] ? __up_read+0x99/0xc0
<4>[ 3775.469811]  [<ffffffff810c7790>] ? sync_page+0x0/0x60
<4>[ 3775.469811]  [<ffffffff81400923>] io_schedule+0x73/0xc0
<4>[ 3775.469811]  [<ffffffff810c77d5>] sync_page+0x45/0x60
<4>[ 3775.469811]  [<ffffffff814010bf>] __wait_on_bit+0x5f/0x90
<4>[ 3775.469811]  [<ffffffff810c7a23>] wait_on_page_bit+0x73/0x80
<4>[ 3775.469811]  [<ffffffff81065e10>] ? wake_bit_function+0x0/0x40
<4>[ 3775.469811]  [<ffffffff810d40dc>] shrink_page_list+0x18c/0x600
<4>[ 3775.469811]  [<ffffffff81078c4d>] ? trace_hardirqs_on+0xd/0x10
<4>[ 3775.469811]  [<ffffffff81403c52>] ? _raw_spin_unlock_irqrestore+0x42/0x80
<4>[ 3775.469811]  [<ffffffff81065f67>] ? finish_wait+0x67/0x90
<4>[ 3775.469811]  [<ffffffff810d2d0a>] ? isolate_pages_global+0x15a/0x230
<4>[ 3775.469811]  [<ffffffff810df6fd>] ? congestion_wait+0x7d/0x90
<4>[ 3775.469811]  [<ffffffff81065dd0>] ? autoremove_wake_function+0x0/0x40
<4>[ 3775.469811]  [<ffffffff810d4bd9>] shrink_inactive_list+0x689/0x710
<4>[ 3775.469811]  [<ffffffff8122fbf3>] ? __up_read+0x23/0xc0
<4>[ 3775.469811]  [<ffffffff810d4edf>] shrink_zone+0x27f/0x490
<4>[ 3775.469811]  [<ffffffff810d525a>] ? shrink_slab+0x16a/0x1a0
<4>[ 3775.469811]  [<ffffffff810d5dbf>] do_try_to_free_pages+0x1bf/0x310
<4>[ 3775.469811]  [<ffffffff810d6040>] try_to_free_pages+0x70/0x80
<4>[ 3775.469811]  [<ffffffff810d2bb0>] ? isolate_pages_global+0x0/0x230
<4>[ 3775.469811]  [<ffffffff810ce480>] __alloc_pages_nodemask+0x3e0/0x740
<4>[ 3775.469811]  [<ffffffff810ce7f7>] __get_free_pages+0x17/0x60
<4>[ 3775.469811]  [<ffffffff810ff759>] __kmalloc+0x1d9/0x270
<4>[ 3775.469811]  [<ffffffffa05a1ff0>] os_alloc_mem+0xa0/0xf0 [nvidia]
<4>[ 3775.469811]  [<ffffffffa04b70e4>] _nv005422rm+0x12/0x21 [nvidia]
<4>[ 3775.469811]  [<ffffffffa029bc39>] ? _nv014333rm+0xac8/0xc0a [nvidia]
<4>[ 3775.469811]  [<ffffffffa04f18e6>] ? _nv012492rm+0x12e/0x217 [nvidia]
<4>[ 3775.469811]  [<ffffffffa04b9e0e>] ? _nv003813rm+0x176/0x372 [nvidia]
<4>[ 3775.469811]  [<ffffffffa04bf115>] ? rm_power_management+0x170/0x209 [nvidia]
<4>[ 3775.469811]  [<ffffffffa059bb9c>] ? nv_power_management+0x1fc/0x250 [nvidia]
<4>[ 3775.469811]  [<ffffffffa059bcbc>] ? nv_kern_suspend+0x2c/0xb0 [nvidia]
<4>[ 3775.469811]  [<ffffffff81246856>] ? pci_legacy_suspend+0x46/0xe0
<4>[ 3775.469811]  [<ffffffff812ce526>] ? dpm_suspend_start+0x446/0x4b0
<4>[ 3775.469811]  [<ffffffff8124712d>] ? pci_pm_freeze+0x9d/0xb0
<4>[ 3775.469811]  [<ffffffff812cdf6e>] ? pm_op+0x14e/0x1c0
<4>[ 3775.469811]  [<ffffffff812ce446>] ? dpm_suspend_start+0x366/0x4b0
<4>[ 3775.469811]  [<ffffffff8108bb1f>] ? hibernation_snapshot+0x7f/0x280
<4>[ 3775.469811]  [<ffffffff8108be1d>] ? hibernate+0xfd/0x200
<4>[ 3775.469811]  [<ffffffff8108a70c>] ? state_store+0xec/0x100
<4>[ 3775.469811]  [<ffffffff811710b7>] ? sysfs_get_active_two+0x27/0x60
<4>[ 3775.469811]  [<ffffffff8122ba27>] ? kobj_attr_store+0x17/0x20
<4>[ 3775.469811]  [<ffffffff8116f3c6>] ? sysfs_write_file+0xe6/0x170
<4>[ 3775.469811]  [<ffffffff81107da8>] ? vfs_write+0xb8/0x1a0
<4>[ 3775.469811]  [<ffffffff814030e5>] ? lockdep_sys_exit_thunk+0x35/0x67
<4>[ 3775.469811]  [<ffffffff81107f81>] ? sys_write+0x51/0x90
<4>[ 3775.469811]  [<ffffffff8100305b>] ? system_call_fastpath+0x16/0x1b



Best regards,
Maxim Levitsky
