From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 14:09:59 -0400
Message-ID: <20060614180959.GD13105@redhat.com>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 14, 2006 at 10:52:52AM -0700, Linus Torvalds wrote:

 > My Mac Mini (Intel dual-core CPU) now resumes and suspends in SMP mode =

 > too, which was not true just a couple of days ago. It even seems to do i=
t =

 > fairly reliable.
 > And the console fixes is apparently what got things working in SMP mode. =


I bet you're not using slab debug are you? :)
Peter is hitting this with his mini on resume...


Restarting tasks...<6>usb 1-2: USB disconnect, address 4
 done
Thawing cpus ...
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=3Dc07a0000 soft=3Dc0780000
Initializing CPU#1
BUG: sleeping function called from invalid context at mm/page_alloc.c:945
in_atomic():0, irqs_disabled():1
 <c045131c> __alloc_pages+0x32/0x2c2  <c0425583> printk+0x1f/0xaf
 <c060c6bc> schedule+0xb00/0xb69  <c045160e> get_zeroed_page+0x31/0x3d
 <c040a1bd> cpu_init+0x10a/0x329  <c0417698> start_secondary+0xc/0x3ef
 <c0417a9d> cpu_exit_clear+0x22/0x43 =


....

__tx_submit: hci0 tx submit failed urb f5542360 type 1 err -19
usb 2-2: not running at top speed; connect to a high speed hub
usb 2-2: configuration #1 chosen from 1 choice
usb 3-2: USB disconnect, address 2
sky2 eth0: disabling interface
usb 3-2: new full speed USB device using uhci_hcd and address 3
usb 3-2: configuration #1 chosen from 1 choice
hiddev96: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-00=
00:00:1d.2-2
usb 4-1: USB disconnect, address 3
slab error in cache_free_debugcheck(): cache `size-512': double free, or me=
mory outside object was overwritten
 <c0465ccd> cache_free_debugcheck+0x135/0x23a  <c0466335> kfree+0x61/0x93
 <f8c9f20a> hci_usb_close+0xf0/0x157 [hci_usb]  <f8c9f298> hci_usb_disconne=
ct+0x27/0x70 [hci_usb]
 <c0581b01> usb_disable_interface+0x22/0x2f  <c0583591> usb_unbind_interfac=
e+0x34/0x6a
 <c054f638> __device_release_driver+0x60/0x78  <c054f885> device_release_dr=
iver+0x2b/0x3a
 <c054efa0> bus_remove_device+0x6d/0x7f  <c054e353> device_del+0x38/0x68
 <c0581c15> usb_disable_device+0x68/0xc9  <c057e32e> usb_disconnect+0x99/0x=
fa
 <c057f319> hub_thread+0x34c/0xa3d  <c060e880> _spin_unlock_irq+0x5/0x7
 <c060c6bc> schedule+0xb00/0xb69  <c0435e4c> autoremove_wake_function+0x0/0=
x35
 <c057efcd> hub_thread+0x0/0xa3d  <c0435d87> kthread+0x9d/0xc9
 <c0435cea> kthread+0x0/0xc9  <c0402005> kernel_thread_helper+0x5/0xb
f7700930: redzone 1:0x5a5a5a5a, redzone 2:0x170fc2a5.
------------[ cut here ]------------
kernel BUG at mm/slab.c:2664!
invalid opcode: 0000 [#1]
SMP =

last sysfs file: /class/usb_device/usbdev2.2/dev
Modules linked in: rfcomm hidp l2cap ohci1394 ieee1394 button sky2 hci_usb =
autofs4 bluetooth sunrpc ip_conntrack_netbios_ns ipt_REJECT iptable_filter =
ip_tables xt_state ip_conntrack nfnetlink xt_tcpudp ip6table_filter ip6_tab=
les x_tables ipv6 cpufreq_ondemand video battery ac parport_pc lp parport h=
w_random snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi=
_event snd_seq snd_seq_device i2c_i801 snd_pcm_oss snd_mixer_oss i2c_core i=
de_cd snd_pcm sg snd_timer snd ehci_hcd uhci_hcd soundcore snd_page_alloc c=
drom dm_snapshot dm_zero dm_mirror dm_mod ext3 jbd ata_piix libata sd_mod s=
csi_mod
CPU:    0
EIP:    0060:[<c0465d5e>]    Not tainted VLI
EFLAGS: 00010012   (2.6.16-1.2273_FC6 #1) =

EIP is at cache_free_debugcheck+0x1c6/0x23a
eax: f7700928   ebx: f77000f8   ecx: 00000830   edx: 00000008
esi: f7ffea80   edi: f7700930   ebp: 00000004   esp: f7fb0e40
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 146, threadinfo=3Df7fb0000 task=3Dc1b2e6d0)
Stack: c063173b f7700930 5a5a5a5a 170fc2a5 f554234c f77000c0 f7ffea80 f7ff6=
164 =

       f7700934 00000282 c0466335 f5542360 f554234c f8ca2e94 f6a8e1fc f8c9f=
20a =

       f7714168 f7714160 f7714168 f76b9184 f76b91e4 f76b90bc f7ff1200 00000=
246 =

Call Trace:
 <c0466335> kfree+0x61/0x93  <f8c9f20a> hci_usb_close+0xf0/0x157 [hci_usb]
 <f8c9f298> hci_usb_disconnect+0x27/0x70 [hci_usb]  <c0581b01> usb_disable_=
interface+0x22/0x2f
 <c0583591> usb_unbind_interface+0x34/0x6a  <c054f638> __device_release_dri=
ver+0x60/0x78
 <c054f885> device_release_driver+0x2b/0x3a  <c054efa0> bus_remove_device+0=
x6d/0x7f
 <c054e353> device_del+0x38/0x68  <c0581c15> usb_disable_device+0x68/0xc9
 <c057e32e> usb_disconnect+0x99/0xfa  <c057f319> hub_thread+0x34c/0xa3d
 <c060e880> _spin_unlock_irq+0x5/0x7  <c060c6bc> schedule+0xb00/0xb69
 <c0435e4c> autoremove_wake_function+0x0/0x35  <c057efcd> hub_thread+0x0/0x=
a3d
 <c0435d87> kthread+0x9d/0xc9  <c0435cea> kthread+0x0/0xc9
 <c0402005> kernel_thread_helper+0x5/0xb =

Code: 8b 8e 8c 00 00 00 8b 58 0c 89 f8 29 d8 f7 f1 3b 86 98 00 00 00 89 c5 =
72 08 0f 0b 67 0a ec 13 63 c0 0f af cd 8d 04 0b 39 c7 74 08 <0f> 0b 68 0a e=
c 13 63 c0 f6 86 95 00 00 00 02 74 15 89 f8 b9 05 =

EIP: [<c0465d5e>] cache_free_debugcheck+0x1c6/0x23a SS:ESP 0068:f7fb0e40
 <3>BUG: sleeping function called from invalid context at include/linux/rws=
em.h:43
in_atomic():0, irqs_disabled():1
 <c0430416> blocking_notifier_call_chain+0x18/0x4b  <c04277c1> do_exit+0x19=
/0x7bd
 <c053af00> do_unblank_screen+0x2a/0x127  <c04054d5> die+0x2a5/0x2ca
 <c0405b6b> do_invalid_op+0x0/0xab  <c0405c0d> do_invalid_op+0xa2/0xab
 <c0465d5e> cache_free_debugcheck+0x1c6/0x23a  <c0402005> kernel_thread_hel=
per+0x5/0xb
 <c0425583> printk+0x1f/0xaf  <c04049d7> error_code+0x4f/0x54
 <c0465d5e> cache_free_debugcheck+0x1c6/0x23a  <c0466335> kfree+0x61/0x93
 <f8c9f20a> hci_usb_close+0xf0/0x157 [hci_usb]  <f8c9f298> hci_usb_disconne=
ct+0x27/0x70 [hci_usb]
 <c0581b01> usb_disable_interface+0x22/0x2f  <c0583591> usb_unbind_interfac=
e+0x34/0x6a
 <c054f638> __device_release_driver+0x60/0x78  <c054f885> device_release_dr=
iver+0x2b/0x3a
 <c054efa0> bus_remove_device+0x6d/0x7f  <c054e353> device_del+0x38/0x68
 <c0581c15> usb_disable_device+0x68/0xc9  <c057e32e> usb_disconnect+0x99/0x=
fa
 <c057f319> hub_thread+0x34c/0xa3d  <c060e880> _spin_unlock_irq+0x5/0x7
 <c060c6bc> schedule+0xb00/0xb69  <c0435e4c> autoremove_wake_function+0x0/0=
x35
 <c057efcd> hub_thread+0x0/0xa3d  <c0435d87> kthread+0x9d/0xc9
 <c0435cea> kthread+0x0/0xc9  <c0402005> kernel_thread_helper+0x5/0xb


 > As a result I will actually apply the console fixes patch (the fixed one=
, =

 > with SYSTEM_RUNNING ;) immediately after the 2.6.17 release, so if peopl=
e =

 > have problems with it or suggesting for a way to disable the console =

 > shutoff, please speak up. It's too late to do it for 2.6.17, or I would =

 > have already applied it rather than post it to linux-pm..

Ooh, a 2.6.17 soon ? :)

		Dave

-- =

http://www.codemonkey.org.uk
