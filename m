From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: WARNING: at drivers/base/sys.c:353
	__sysdev_resume+0x54/0xca()
Date: Mon, 26 Oct 2009 19:04:35 +0100
Message-ID: <200910261904.35765.rjw__24987.8484909006$1256580266$gmane$org@sisk.pl>
References: <dd18b0c30910251258qde2e54csc07d726e916004f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <dd18b0c30910251258qde2e54csc07d726e916004f9@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 25 October 2009, Justin Mattock wrote:
> echo mem > /sys/power/state
> produces this:
> 
> [   75.908109] ------------[ cut here ]------------
> [   75.908114] WARNING: at drivers/base/sys.c:353 __sysdev_resume+0x54/0xca()
> [   75.908116] Hardware name: iMac9,1
> [   75.908118] Interrupts enabled after irqrouter_resume+0x0/0x4b
> [   75.908119] Modules linked in: authenc esp4 ah4
> xfrm4_mode_transport ctr twofish twofish_common camellia serpent
> blowfish cast5 des_generic cbc xcbc rmd160 sha256_generic crypto_null
> xt_tcpudp iptable_nat nf_nat ipt_LOG xt_state nf_conntrack_ftp
> nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 iptable_filter ip_tables
> x_tables snd_hda_codec_realtek firewire_ohci firewire_core uvcvideo
> nvidia(P) ohci1394 snd_hda_intel wl(P) evdev agpgart ieee1394
> snd_hda_codec snd_hwdep snd_pcm snd_timer snd_page_alloc thermal
> button uhci_hcd ehci_hcd hci_uart rfcomm btusb hidp l2cap bluetooth
> coretemp acpi_cpufreq processor appletouch applesmc
> [   75.908152] Pid: 1691, comm: bash Tainted: P
> 2.6.32-rc3-00053-g0ba4675 #2
> [   75.908153] Call Trace:
> [   75.908157]  [<ffffffff81060e3e>] warn_slowpath_common+0x77/0x8f
> [   75.908160]  [<ffffffff81060ea3>] warn_slowpath_fmt+0x3c/0x3e
> [   75.908162]  [<ffffffff8120fd5f>] ? irqrouter_resume+0x0/0x4b
> [   75.908164]  [<ffffffff81265fdd>] __sysdev_resume+0x54/0xca
> [   75.908166]  [<ffffffff812660bb>] sysdev_resume+0x68/0xa9
> [   75.908170]  [<ffffffff81090781>] suspend_devices_and_enter+0xf1/0x168
> [   75.908172]  [<ffffffff810908a8>] enter_state+0xb0/0xcd
> [   75.908175]  [<ffffffff81090125>] state_store+0xb1/0xce
> [   75.908178]  [<ffffffff811d61e7>] kobj_attr_store+0x17/0x19
> [   75.908181]  [<ffffffff811303c2>] sysfs_write_file+0xf2/0x12e
> [   75.908184]  [<ffffffff810ed177>] vfs_write+0xad/0x14e
> [   75.908187]  [<ffffffff8109cdd1>] ? audit_syscall_entry+0x1ba/0x1e6
> [   75.908189]  [<ffffffff810ed2d1>] sys_write+0x45/0x6c
> [   75.908192]  [<ffffffff8102cc42>] system_call_fastpath+0x16/0x1b
> [   75.908194] ---[ end trace f5d0cba363054d63 ]---
> 
> 
> The machine does have to proprietary modules(unfortunately)
> nvidia and wl(hopefully soon I wont needs these).

I've seen this warning on a system without any proprietary drivers, no idea
why and how it triggers.

Best,
Rafael
