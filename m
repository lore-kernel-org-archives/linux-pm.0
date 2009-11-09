From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GPF in
 run_workqueue()/list_del_init(cwq->worklist.next) on resume (was: Re: Help
 needed: Resume problems in 2.6.32-rc,
 perhaps related to preempt_count leakage in keventd)
Date: Mon, 9 Nov 2009 13:42:53 -0800 (PST)
Message-ID: <alpine.LFD.2.01.0911091339290.31845@localhost.localdomain>
References: <200911091250.31626.rjw@sisk.pl>
	<alpine.LFD.2.00.0911091949500.2725@localhost.localdomain>
	<200911092100.58187.rjw@sisk.pl> <200911092145.27485.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911092145.27485.rjw@sisk.pl>
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
Cc: Mike Galbraith <efault@gmx.de>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 9 Nov 2009, Rafael J. Wysocki wrote:
>
> [   52.013018] general protection fault: 0000 [#1] PREEMPT SMP 

It'sa GP fault only because it's an invalid pointer - it's the same as a 
NULL pointer page fault, except pointing into the invalid hole in between 
low virtual memory and high virtual memory mappings.

> [   52.013431] last sysfs file: /sys/devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.3/ttyUSB3/port_number
> [   52.013700] CPU 0 
> [   52.013900] Modules linked in: ip6t_LOG af_packet xt_tcpudp xt_pkttype ipt_LOG xt_limit bnep sco rfcomm l2cap crc16 snd_pcm_oss snd_mixer_oss snd_seq binfmt_misc snd_seq_device ip6t_REJECT nf_conntrack_ipv6 ip6table_raw xt_NOTRACK ipt_REJECT xt_state iptable_raw iptable_filter ip6table_mangle nf_conntrack_netbios_ns nf_conntrack_ipv4 cpufreq_conservative nf_conntrack nf_defrag_ipv4 cpufreq_ondemand ip_tables cpufreq_userspace cpufreq_powersave acpi_cpufreq ip6table_filter ip6_tables x_tables freq_table ipv6 microcode fuse loop sr_mod cdrom dm_mod arc4 ecb btusb snd_hda_codec_realtek bluetooth iwlagn snd_hda_intel snd_hda_codec iwlcore pcmcia snd_hwdep snd_pcm sdhci_pci mac80211 snd_timer joydev sdhci toshiba_acpi yenta_socket usbhid cfg80211 snd option rtc_cmos mmc_core firewire_ohci 
 video rsrc_nonstatic psmouse firewire_core backlight soundcore iTCO_wdt rtc_core hid battery ac intel_agp button usb_storage snd_page_alloc usbserial rfkill pcmcia_core iTCO_vendor_support !
 e1000e rtc_lib led_class serio_raw crc_itu_t output uinput sg ehci_hcd uhci_hcd sd_mod crc_t10dif usbcore ext3 jbd fan ahci libata thermal processor
> [   52.016961] Pid: 9, comm: events/0 Not tainted 2.6.32-rc6-tst #160 PORTEGE R500
> [   52.016961] RIP: 0010:[<ffffffff81054bff>]  [<ffffffff81054bff>] worker_thread+0x15b/0x22a
> [   52.016961] RSP: 0018:ffff88007f0d9e40  EFLAGS: 00010046
> [   52.016961] RAX: ffff88007e056b68 RBX: ffff88007f09bd48 RCX: 6b6b6b6b6b6b6b6b

The code is

   8:	ff 13                	callq  *(%rbx)
   a:	48 83 c3 08          	add    $0x8,%rbx
   e:	48 83 3b 00          	cmpq   $0x0,(%rbx)
  12:	eb ec                	jmp    0x0
  14:	e8 3d ef ff ff       	callq  0xffffffffffffef56
  19:	49 8b 45 08          	mov    0x8(%r13),%rax
  1d:	4d 89 65 30          	mov    %r12,0x30(%r13)
  21:	4c 89 ef             	mov    %r13,%rdi
  24:	48 8b 08             	mov    (%rax),%rcx
  27:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2b:*	48 89 51 08          	mov    %rdx,0x8(%rcx)     <-- trapping instruction
  2f:	48 89 0a             	mov    %rcx,(%rdx)
  32:	48 89 40 08          	mov    %rax,0x8(%rax)

and %rcx is 0x6b6b6b6b6b6b6b6b, which is the POISON_FREE byte sequence.

So somebody is trying to remove a list entry that was already free'd.

		Linus
