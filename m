From: "Marty Leisner" <linux@rochester.rr.com>
Subject: problem going into hibernate on thinkpad x61
Date: Tue, 07 Apr 2009 05:12:11 +0000
Message-ID: <200904070512.n375CBVN010610@dell2.home>
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
Cc: martyleisner@yahoo.com
List-Id: linux-pm@vger.kernel.org


This has been happening for several months (with 2.6.27-29).

Its sporadic -- I can't find a sequence that's guaranteed to work...
Sometimes try again and it works -- other times I have to shutdown...


Apr  6 00:51:52 thinkpad kernel: [38795.129504] iwl3945 0000:03:00.0: PCI INT 
A disabled
Apr  6 00:51:53 thinkpad kernel: [38795.991938] PM: Hibernation mode set to 
'platform'
Apr  6 00:51:53 thinkpad kernel: [38795.992012] PM: Marking nosave pages: 
000000000009d000 - 0000000000100000
Apr  6 00:51:53 thinkpad kernel: [38795.992018] PM: Basic memory bitmaps 
created
Apr  6 00:52:13 thinkpad kernel: [38795.992020] PM: Syncing filesystems ... d>
] kthread+0x40/0x66
Apr  6 00:52:13 thinkpad kernel: [38816.019934]  [<c023650e>] ? 
kthread+0x0/0x66
Apr  6 00:52:13 thinkpad kernel: [38816.019937]  [<c020404b>] 
kernel_thread_helper+0x7/0x10
Apr  6 00:52:13 thinkpad kernel: [38816.019939] kondemand/1   S f1655c00     0 
 9811      2
Apr  6 00:52:13 thinkpad kernel: [38816.019943]  c38bffa8 00000046 c38bff38 
f1655c00 00000001 c0635a54 c0639040 c0639040
Apr  6 00:52:13 thinkpad kernel: [38816.019949]  c0639040 eec48000 eec48168 
c1814040 00000001 00000000 011db000 00000001
Apr  6 00:52:13 thinkpad kernel: [38816.019956]  c18145d0 00000014 000138b2 
00000002 00000002 c0476c44 00000002 c0476b1b
Apr  6 00:52:13 thinkpad kernel: [38816.019962] Call Trace:
Apr  6 00:52:13 thinkpad kernel: [38816.019966]  [<c0476c44>] ? 
_spin_lock_irqsave+0x27/0x37
Apr  6 00:52:13 thinkpad kernel: [38816.019969]  [<c0476b1b>] ? 
_spin_unlock_irqrestore+0x2e/0x3d
Apr  6 00:52:13 thinkpad kernel: [38816.019973]  [<c02369ea>] ? 
prepare_to_wait+0x48/0x4d
Apr  6 00:52:13 thinkpad kernel: [38816.019976]  [<c023362e>] 
worker_thread+0x8d/0xc7
Apr  6 00:52:13 thinkpad kernel: [38816.019979]  [<c023680d>] ? 
autoremove_wake_function+0x0/0x38
Apr  6 00:52:13 thinkpad kernel: [38816.019982]  [<c02335a1>] ? 
worker_thread+0x0/0xc7
Apr  6 00:52:13 thinkpad kernel: [38816.019985]  [<c023654e>] kthread+0x40/0x66
Apr  6 00:52:13 thinkpad kernel: [38816.019988]  [<c023650e>] ? 
kthread+0x0/0x66
Apr  6 00:52:13 thinkpad kernel: [38816.019991]  [<c020404b>] 
kernel_thread_helper+0x7/0x10
Apr  6 00:52:13 thinkpad kernel: [38816.019993] iwl3945/1     S f63b1880     0 
 9812      2
Apr  6 00:52:13 thinkpad kernel: [38816.019996]  c38ddfa8 00000046 c068751c 
f63b1880 00000001 c0635a54 c0639040 c0639040
Apr  6 00:52:13 thinkpad kernel: [38816.020009]  c0639040 eec49220 eec49388 
c1814040 00000001 00000000 f6368dc0 00000000
Apr  6 00:52:13 thinkpad kernel: [38816.020016]  c38ddf80 c38ddf8c c38ddf8c 
00000002 00000002 c0476c44 00000002 c0476b1b
Apr  6 00:52:13 thinkpad kernel: [38816.020023] Call Trace:
Apr  6 00:52:13 thinkpad kernel: [38816.020027]  [<c0476c44>] ? 
_spin_lock_irqsave+0x27/0x37
:

and it goes on and on for each task...
When its done:

Apr  6 00:52:13 thinkpad kernel: [38816.027869]  [<c02867a6>] ? 
vfs_write+0x8f/0x109
Apr  6 00:52:13 thinkpad kernel: [38816.027872]  [<c02868c3>] ? 
sys_write+0x40/0x65
Apr  6 00:52:13 thinkpad kernel: [38816.027876]  [<c02037a3>] ? 
sysenter_do_call+0x12/0x38
Apr  6 00:52:13 thinkpad kernel: [38816.027897]  automount
Apr  6 00:52:13 thinkpad kernel: [38816.027968]  collectd
Apr  6 00:52:13 thinkpad kernel: [38816.028052]
Apr  6 00:52:13 thinkpad kernel: [38816.028053] Restarting tasks ... done.
Apr  6 00:52:13 thinkpad kernel: [38816.033409] PM: Basic memory bitmaps freed
Apr  6 00:52:14 thinkpad kernel: [38816.985298] iwl3945 0000:03:00.0: PCI INT 
A -> GSI 17 (level, low) -> IRQ 17
Apr  6 00:52:14 thinkpad kernel: [38816.985448] iwl3945 0000:03:00.0: 
restoring config space at offset 0x1 (was 0x100102, wr
iting 0x100106) thinkpad kernel: [38816.985630] iwl3945 0000:03:00.0: irq 25 
for MSI/MSI-X
Apr  6 00:52:14 thinkpad kernel: [38817.062645] Registered led device: 
iwl-phy0:radio
Apr  6 00:52:14 thinkpad kernel: [38817.062669] Registered led device: 
iwl-phy0:assoc

Any insight into what I should look at?

marty
