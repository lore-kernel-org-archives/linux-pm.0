From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Question regarding completion signal in S3 flow
Date: Thu, 26 Jan 2012 11:49:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1201261130000.1386-100000@iolanthe.rowland.org>
References: <810586B7581CC8469141DADEBC371912057F41@BGSMSX102.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <810586B7581CC8469141DADEBC371912057F41@BGSMSX102.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Mansoor, Illyas" <illyas.mansoor@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 26 Jan 2012, Mansoor, Illyas wrote:

> > > I have question related to suspend flow and completion signal:
> > >
> > > Is it possible that a completion signal could be missed in S3 flow
> > > after processes are frozen?
> > 
> > What do you mean by "completion signal"?
> 
> In our case we have an interrupt that signals completion of the interrupt using
> complete()
> For a waiting thread.

It sounds like you're saying you have an interrupt handler that calls 
complete(), and the target thread is stuck in wait_for_completion().

> Our interrupt is configured with IRQ_NO_SUSPEND so we expect interrupts during 
> Suspend also.

IRQ_NO_SUSPEND no longer exists.  Regardless, you can't receive
interrupts while the system is in suspend, because by definition the
CPU isn't running at that time.

> So here is what I'm seeing in the panic logs:
> 
> <4>[ 7960.661939] Call Trace:
> <4>[ 7960.661953]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
> <4>[ 7960.661965]  [<c12735b5>] refrigerator+0xa5/0x160
> <4>[ 7960.661977]  [<c125f64d>] get_signal_to_deliver+0x9ad/0xdc0
> <4>[ 7960.661991]  [<c120257b>] do_signal+0x6b/0xa20
> <4>[ 7960.662003]  [<c186ffbd>] ? schedule_hrtimeout_range+0x1cd/0x220
> <4>[ 7960.662018]  [<c122d4a4>] ? pmu_sc_irq+0x364/0x3d0 <==============This is
> where in the interrupt we signal completion using complete()

That is irrelevant.  The '?' means this is merely a random value on the
stack, not the return address of a function call.

> <4>[ 7960.662030]  [<c18715f3>] ? _raw_spin_unlock_irqrestore+0x23/0x50
> <4>[ 7960.662043]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
> <4>[ 7960.662056]  [<c134c162>] ? sys_epoll_wait+0x72/0x300
> <4>[ 7960.662069]  [<c1242c40>] ? default_wake_function+0x0/0x20
> <4>[ 7960.662082]  [<c1202f85>] do_notify_resume+0x55/0x90
> <4>[ 7960.662094]  [<c1871e99>] work_notifysig+0x9/0x1

This stack trace appears to show that some thread attempted to send a 
signal and got frozen while waiting.

> <6>[ 7960.380768] suspend         R running      0    19      2 0x00000000
> <4>[ 7960.380780]  f78e3c94 00000000 c1204760 f78e3c8c c12047eb f78e3c94
> 00000000 f78e3c04
> <4>[ 7960.380800]  00000004 00000000 00030002 c1852942 00000001 00000001
> 00000282 f78e3c5c
> <4>[ 7960.380820]  f78e3c30 c12384a5 00000282 f78e3c3c c18715f3 f7868000
> f78e3c84 c186eebc
> <4>[ 7960.380840] Call Trace:
> <4>[ 7960.380850]  [<c1204760>] ? do_invalid_op+0x0/0xb0
> <4>[ 7960.380862]  [<c12047eb>] ? do_invalid_op+0x8b/0xb0
> <4>[ 7960.380875]  [<c1852942>] ? pmu_pci_set_power_state+0x322/0x6e0 <==== here
> is where wait_for_completion_timeout call BUG() after timeout.
> <4>[ 7960.380888]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
> <4>[ 7960.380901]  [<c18715f3>] ? _raw_spin_unlock_irqrestore+0x23/0x50
> <4>[ 7960.380913]  [<c186eebc>] ? schedule_timeout+0x1dc/0x430
> <4>[ 7960.380926]  [<c1204760>] ? do_invalid_op+0x0/0xb0
> <4>[ 7960.380937]  [<c14b916c>] ? trace_hardirqs_off_thunk+0xc/0x10
> <4>[ 7960.380950]  [<c187244b>] ? error_code+0x6b/0x70
> <4>[ 7960.380961]  [<c186dd96>] ? wait_for_common+0x96/0x120
> <4>[ 7960.380973]  [<c1204760>] ? do_invalid_op+0x0/0xb0
> <4>[ 7960.380985]  [<c1852942>] ? pmu_pci_set_power_state+0x322/0x6e0
> <4>[ 7960.380998]  [<c14b502a>] ? put_dec+0x2a/0xa0
> <4>[ 7960.381011]  [<c14b502a>] ? put_dec+0x2a/0xa0
> <4>[ 7960.381025]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
> <4>[ 7960.381038]  [<c14cee6e>] ? pci_platform_power_transition+0x3e/0xa0
> <4>[ 7960.381051]  [<c18715f3>] ? _raw_spin_unlock_irqrestore+0x23/0x50
> <4>[ 7960.381064]  [<c14cf5df>] ? pci_set_power_state+0x3f/0x2c0
> <4>[ 7960.381077]  [<c14ced7c>] ? pci_update_current_state+0x3c/0x50
> <4>[ 7960.381090]  [<c14d180e>] ? pci_pm_runtime_resume+0x5e/0xa0
> <4>[ 7960.381102]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
> <4>[ 7960.381114]  [<c14d17b0>] ? pci_pm_runtime_resume+0x0/0xa0
> <4>[ 7960.381126]  [<c1554d7b>] ? rpm_callback+0x3b/0x70
> <4>[ 7960.381137]  [<c155577c>] ? rpm_resume+0x37c/0x5c0
> <4>[ 7960.381150]  [<c124923b>] ? release_console_sem+0x37b/0x3c0
> <4>[ 7960.381164]  [<c1238593>] ? add_preempt_count+0xb3/0xf0
> <4>[ 7960.381176]  [<c1556609>] ? __pm_runtime_resume+0x49/0xc0
> <4>[ 7960.381189]  [<c14d1b71>] ? pci_pm_prepare+0x21/0x60
> <4>[ 7960.381200]  [<c1553947>] ? dpm_suspend_start+0x137/0x7d0
> <4>[ 7960.381213]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
> <4>[ 7960.381225]  [<c18715f3>] ? _raw_spin_unlock_irqrestore+0x23/0x50
> <4>[ 7960.381237]  [<c126f548>] ? up+0x28/0x40
> <4>[ 7960.381250]  [<c1288f13>] ? suspend_devices_and_enter+0x73/0x1d0
> <4>[ 7960.381262]  [<c1289196>] ? enter_state+0x126/0x1e0
> <4>[ 7960.381273]  [<c1289277>] ? pm_suspend+0x27/0x70
> <4>[ 7960.381285]  [<c128acba>] ? suspend+0x8a/0x160
> <4>[ 7960.381296]  [<c186e445>] ? schedule+0x545/0x9e0
> <4>[ 7960.381310]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
> <4>[ 7960.381322]  [<c1265833>] ? worker_thread+0x123/0x2c0
> <4>[ 7960.381333]  [<c186e445>] ? schedule+0x545/0x9e0
> <4>[ 7960.381346]  [<c128ac30>] ? suspend+0x0/0x160
> <4>[ 7960.381357]  [<c12690d0>] ? autoremove_wake_function+0x0/0x50
> <4>[ 7960.381369]  [<c1265710>] ? worker_thread+0x0/0x2c0
> <4>[ 7960.381381]  [<c1268c34>] ? kthread+0x74/0x80
> <4>[ 7960.381393]  [<c1268bc0>] ? kthread+0x0/0x80
> <4>[ 7960.381405]  [<c120357a>] ? kernel_thread_helper+0x6/0x1

This is very difficult to understand.  You should add some printk 
statements to your code, so that you will know what is going on.

> So my question, is it possible that the complete() called in interrupt context
> can be missed
> During S3?

I don't know what you mean by "missed".  The complete() call will work,
but the target thread might not return from wait_for_completion()  
until after the system returns to S0.

Alan Stern
