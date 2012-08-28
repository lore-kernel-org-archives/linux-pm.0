From: Apostolos Bartziokas <barz621@gmail.com>
Subject: firewire_ohci resume failure on intel HW
Date: Tue, 28 Aug 2012 16:08:15 +0300
Message-ID: <503CC2BF.2010901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello

I am trying to get rid of SUSPEND_MODULES from my system and 
firewire_ohci prevents the system from resuming when i suspend.
If i remove the modules file i end up wit a blinking cursor on a blank 
screen.

This was also the case with kernels 3.3 and 3.4.

lspci
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core 
processor DRAM Controller (rev 09)
00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core 
processor PCI Express Root Port (rev 09)
00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset 
Family USB xHCI Host Controller (rev 04)
00:16.0 Communication controller: Intel Corporation 7 Series/C210 Series 
Chipset Family MEI Controller #1 (rev 04)
00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network 
Connection (rev 04)
00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset 
Family USB Enhanced Host Controller #2 (rev 04)
00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset 
Family High Definition Audio Controller (rev 04)
00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset 
Family PCI Express Root Port 1 (rev c4)
00:1c.2 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset 
Family PCI Express Root Port 3 (rev c4)
00:1c.4 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset 
Family PCI Express Root Port 5 (rev c4)
00:1c.7 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset 
Family PCI Express Root Port 8 (rev c4)
00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset 
Family USB Enhanced Host Controller #1 (rev 04)
00:1f.0 ISA bridge: Intel Corporation Z77 Express Chipset LPC Controller 
(rev 04)
00:1f.2 SATA controller: Intel Corporation 7 Series/C210 Series Chipset 
Family 6-port SATA Controller [AHCI mode] (rev 04)
00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family 
SMBus Controller (rev 04)
01:00.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI 
Barts PRO [Radeon HD 6800 Series]
01:00.1 Audio device: Advanced Micro Devices [AMD] nee ATI Barts HDMI 
Audio [Radeon HD 6800 Series]
03:00.0 PCI bridge: Integrated Technology Express, Inc. Device 8892 (rev 30)
04:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22A 
IEEE-1394a-2000 Controller (PHY/Link) [iOHCI-Lynx]
05:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host 
Controller (rev 04)
06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 
6Gb/s Controller (rev 11)

uname -a
Linux mainland 3.5.3-1-ARCH #1 SMP PREEMPT Sun Aug 26 09:14:51 CEST 2012 
x86_64 GNU/Linux

I also see this error on my logs but i don't know if it is related to this.

  Pid: 0, comm: swapper/0 Not tainted 3.5.3-1-ARCH #1
[    3.143506] Call Trace:
[    3.143507]  <IRQ>  [<ffffffff810d4d3d>] __report_bad_irq+0x3d/0xe0
[    3.143513]  [<ffffffff810d5033>] note_interrupt+0x1a3/0x1f0
[    3.143515]  [<ffffffff810d292f>] handle_irq_event_percpu+0xbf/0x260
[    3.143516]  [<ffffffff810d2b18>] handle_irq_event+0x48/0x70
[    3.143518]  [<ffffffff810d5b4a>] handle_fasteoi_irq+0x5a/0x100
[    3.143520]  [<ffffffff810160c2>] handle_irq+0x22/0x40
[    3.143522]  [<ffffffff81484cea>] do_IRQ+0x5a/0xe0
[    3.143524]  [<ffffffff8147c12a>] common_interrupt+0x6a/0x6a
[    3.143524]  <EOI>  [<ffffffffa02b3f01>] ? 
acpi_idle_enter_c1+0xda/0x104 [processor]
[    3.143537]  [<ffffffffa02b3edc>] ? acpi_idle_enter_c1+0xb5/0x104 
[processor]
[    3.143541]  [<ffffffff8134f159>] cpuidle_enter+0x19/0x20
[    3.143542]  [<ffffffff8134f7a6>] cpuidle_idle_call+0xa6/0x330
[    3.143544]  [<ffffffff8101daaf>] cpu_idle+0xbf/0x130
[    3.143546]  [<ffffffff81456fbc>] rest_init+0x80/0x84
[    3.143548]  [<ffffffff818bbc35>] start_kernel+0x3c1/0x3ce
[    3.143550]  [<ffffffff818bb673>] ? repair_env_string+0x5e/0x5e
[    3.143551]  [<ffffffff818bb356>] x86_64_start_reservations+0x131/0x135
[    3.143553]  [<ffffffff818bb45a>] x86_64_start_kernel+0x100/0x10f

Thanks in advance.
