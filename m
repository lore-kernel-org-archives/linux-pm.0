From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Memory allocations in .suspend became very unreliable
Date: Sat, 16 Jan 2010 01:56:47 +0200
Message-ID: <1263599807.3407.2.camel@maxim-laptop>
References: <1263549544.3112.10.camel@maxim-laptop>
	<201001152303.39885.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001152303.39885.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-01-15 at 23:03 +0100, Rafael J. Wysocki wrote: 
> On Friday 15 January 2010, Maxim Levitsky wrote:
> > Hi,
> 
> Hi,
> 
> > I know that this is very controversial, because here I want to describe
> > a problem in a proprietary driver that happens now in 2.6.33-rc3
> > I am taking about nvidia driver.
> > 
> > Some time ago I did very long hibernate test and found no errors after
> > more that 200 cycles.
> > 
> > Now I update to 2.6.33 and notice that system will hand when nvidia
> > driver allocates memory is their .suspend functions. 
> 
> They shouldn't do that, there's no guarantee that's going to work at all.
> 
> > This could fail in 2.6.32 if I would run many memory hungry
> > applications, but now this happens with most of memory free.
> 
> This sounds a little strange.  What's the requested size of the image?
Don't know, but system has to be very tight on memory.


Here is the same problem, now happens within non-propertary path:

<6>[  961.740712] ata_piix 0000:00:1f.1: PCI INT A disabled
<6>[  961.740867] HDA Intel 0000:00:1b.0: PCI INT A disabled
<6>[  961.760386] PM: freeze of devices complete after 335.113 msecs
<6>[  961.761952] PM: late freeze of devices complete after 1.465 msecs
<6>[  961.762296] ACPI: Preparing to enter system sleep state S4 
<6>[  961.771997] PM: Saving platform NVS memory
<3>[ 1201.052518] INFO: task kthreadd:2 blocked for more than 120 seconds.
<3>[ 1201.052619] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
<6>[ 1201.052724] kthreadd      D 0000000000000000     0     2      0 0x00000000
<4>[ 1201.052979]  ffff88006f8a55e0 0000000000000046 0000000000000000 ffffffff812db476
<4>[ 1201.053385]  ffff88006f8a5520 0000000000000000 0000000100010281 ffff880004214e58
<4>[ 1201.053790]  ffff88000420f008 ffff88006f8a4000 ffff88006f899288 ffff88006f8a5fd8
<4>[ 1201.054196] Call Trace:
<4>[ 1201.054296]  [<ffffffff812db476>] ? scsi_request_fn+0xb6/0x400
<4>[ 1201.054406]  [<ffffffff8122fc89>] ? __up_read+0x99/0xc0
<4>[ 1201.054511]  [<ffffffff810c77b0>] ? sync_page+0x0/0x60
<4>[ 1201.054617]  [<ffffffff81400943>] io_schedule+0x73/0xc0
<4>[ 1201.054720]  [<ffffffff810c77f5>] sync_page+0x45/0x60
<4>[ 1201.054824]  [<ffffffff814010df>] __wait_on_bit+0x5f/0x90
<4>[ 1201.054929]  [<ffffffff810c7a43>] wait_on_page_bit+0x73/0x80
<4>[ 1201.055037]  [<ffffffff81065e30>] ? wake_bit_function+0x0/0x40
<4>[ 1201.055145]  [<ffffffff810d3939>] pageout+0x209/0x280
<4>[ 1201.055249]  [<ffffffff810edc3b>] ? page_unlock_anon_vma+0x2b/0x30
<4>[ 1201.055358]  [<ffffffff810d41ef>] shrink_page_list+0x27f/0x600
<4>[ 1201.055467]  [<ffffffff81078c6d>] ? trace_hardirqs_on+0xd/0x10
<4>[ 1201.055575]  [<ffffffff81403c72>] ? _raw_spin_unlock_irqrestore+0x42/0x80
<4>[ 1201.055688]  [<ffffffff81065f87>] ? finish_wait+0x67/0x90
<4>[ 1201.055795]  [<ffffffff810df71d>] ? congestion_wait+0x7d/0x90
<4>[ 1201.055902]  [<ffffffff81065df0>] ? autoremove_wake_function+0x0/0x40
<4>[ 1201.056012]  [<ffffffff810d4bf9>] shrink_inactive_list+0x689/0x710
<4>[ 1201.056121]  [<ffffffff8122fc13>] ? __up_read+0x23/0xc0
<4>[ 1201.056227]  [<ffffffff810d4eff>] shrink_zone+0x27f/0x490
<4>[ 1201.056333]  [<ffffffff810d527a>] ? shrink_slab+0x16a/0x1a0
<4>[ 1201.056440]  [<ffffffff810d5ddf>] do_try_to_free_pages+0x1bf/0x310
<4>[ 1201.056549]  [<ffffffff810d6060>] try_to_free_pages+0x70/0x80
<4>[ 1201.056657]  [<ffffffff810d2bd0>] ? isolate_pages_global+0x0/0x230
<4>[ 1201.056767]  [<ffffffff810ce4a0>] __alloc_pages_nodemask+0x3e0/0x740
<4>[ 1201.056878]  [<ffffffff81041ce9>] ? copy_process+0xb9/0x15a0
<4>[ 1201.056985]  [<ffffffff810ce817>] __get_free_pages+0x17/0x60
<4>[ 1201.057091]  [<ffffffff81041d04>] copy_process+0xd4/0x15a0
<4>[ 1201.057196]  [<ffffffff8103ef5a>] ? wake_up_new_task+0x9a/0x110
<4>[ 1201.057303]  [<ffffffff81062470>] ? __task_pid_nr_ns+0x0/0x100
<4>[ 1201.057409]  [<ffffffff81043267>] do_fork+0x97/0x480
<4>[ 1201.057514]  [<ffffffff81403bfb>] ? _raw_spin_unlock_irq+0x3b/0x70
<4>[ 1201.057623]  [<ffffffff8103966f>] ? finish_task_switch+0x7f/0xe0
<4>[ 1201.057730]  [<ffffffff810395f0>] ? finish_task_switch+0x0/0xe0
<4>[ 1201.057840]  [<ffffffff8100c7f9>] kernel_thread+0x69/0x70
<4>[ 1201.057946]  [<ffffffff810657e0>] ? kthread+0x0/0xb0
<4>[ 1201.058050]  [<ffffffff81003e10>] ? kernel_thread_helper+0x0/0x10
<4>[ 1201.058159]  [<ffffffff81065968>] kthreadd+0xd8/0x110
<4>[ 1201.058263]  [<ffffffff81078c15>] ? trace_hardirqs_on_caller+0x145/0x190
<4>[ 1201.058374]  [<ffffffff81003e14>] kernel_thread_helper+0x4/0x10
<4>[ 1201.058480]  [<ffffffff81404240>] ? restore_args+0x0/0x30
<4>[ 1201.058586]  [<ffffffff81065890>] ? kthreadd+0x0/0x110
<4>[ 1201.058690]  [<ffffffff81003e10>] ? kernel_thread_helper+0x0/0x10
<4>[ 1201.058797] INFO: lockdep is turned off.


Best regards,
	Maxim Levitsky
