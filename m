From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Thu, 25 Sep 2014 12:54:56 +0200
Message-ID: <87sijg6kcf.fsf@nemi.mork.no>
References: <87zjdq8k7i.fsf@nemi.mork.no> <20140924095111.GC10438@suse.de>
	<87vbodiaq9.fsf@nemi.mork.no> <19091504.rBv2mCrhao@vostro.rjw.lan>
	<87egv0i2sl.fsf@nemi.mork.no> <20140925091318.GA4269@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:33719 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbaIYK4I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 06:56:08 -0400
In-Reply-To: <20140925091318.GA4269@suse.de> (Joerg Roedel's message of "Thu,
	25 Sep 2014 11:13:18 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Joerg Roedel <jroedel@suse.de> writes:
> On Thu, Sep 25, 2014 at 09:20:58AM +0200, Bj=C3=B8rn Mork wrote:
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>>=20
>> > I've decided to go with a revert for 3.17, as we don't seem to hav=
e an immediate
>> > fix and the final 3.17 may be as close as this Sunday.  So I'm goi=
ng to send my
>> > final pull request for 3.17 to Linus tomorrow or early on Friday.
>>=20
>> Sounds safest to me, FWIW.
>
> Yes, sorry for the delay, I am still fighting with my cold and couldn=
't
> get around to send a fix sooner :/

If it's any comfort, a cold was the reason I found this :-)

I didn't plan on testing 3.17 at all. Instead I wanted to beat on
Debian's 3.16 packages for a while to make sure it is in perfect
condition for the jessie release.  But then I catched the cold and felt
like just relaxing with a movie.  And instantly hit the i915 ring
initialization bug. Which has a workaround in the queue for 3.16, so
there is nothing to worry about:
https://git.kernel.org/cgit/linux/kernel/git/stable/stable-queue.git/tr=
ee/queue-3.16/drm-i915-read-head-register-back-in-init_ring_common-to-e=
nforce-ordering.patch

Except that this bug hit me there and then and I wasn't exactly in the
mood for building a new kernel.  So I just installed Debian's
experimental 3.17-rc5 build as a quickfix instead and watched the movie=
=2E

Then, much later, I noticed the oops.  Which I wouldn't have done
without the cold.

>> For the next round of this, I think the only missing part was some t=
est
>> like
>>=20
>>         if (!forbidden_pages_map || !free_pages_map)
>>            goto return_without_freeing_anything;
>
> Right, this is pretty much the fix. Can you please test the attached
> patch?
>
>> And BTW, I believe it would be useful if at least one more person in=
 the
>> world tested hibernation between each release ;-)
>
> Well, I tested these patches on at least 4 or 5 different hardware
> configurations. I also know of other people testing hibernation with =
-rc
> kernels, but this is the first report of this issue I have seen. I
> wonder what it different in your setup so that you trigger this bug.

I do wonder about that as well. AFAIK I don't do anything extraordinary=
=2E
My hardware is somewhat dated but should still be pretty common.

I use "s2disk" from the Debian wheezy "uswsusp" package (version
1.0+20110509-3) to hibernate the system.  Don't think I do anything
fancy.  I just run s2disk and that's that.

The fact that the test was there before indicates that the NULL maps ar=
e
to be expected, but maybe that is really just painting over some
hardware related problem? My laptop is a Lenovo Thinkpad X301 from
~2008, having much of the hardware in common with most laptops from tha=
t
time:

bjorn@nemi:~$ lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation Mobile 4 Series Chipset M=
emory Controller Hub [8086:2a40] (rev 07)
00:02.0 VGA compatible controller [0300]: Intel Corporation Mobile 4 Se=
ries Chipset Integrated Graphics Controller [8086:2a42] (rev 07)
00:02.1 Display controller [0380]: Intel Corporation Mobile 4 Series Ch=
ipset Integrated Graphics Controller [8086:2a43] (rev 07)
00:03.0 Communication controller [0780]: Intel Corporation Mobile 4 Ser=
ies Chipset MEI Controller [8086:2a44] (rev 07)
00:19.0 Ethernet controller [0200]: Intel Corporation 82567LM Gigabit N=
etwork Connection [8086:10f5] (rev 03)
00:1a.0 USB controller [0c03]: Intel Corporation 82801I (ICH9 Family) U=
SB UHCI Controller #4 [8086:2937] (rev 03)
00:1a.1 USB controller [0c03]: Intel Corporation 82801I (ICH9 Family) U=
SB UHCI Controller #5 [8086:2938] (rev 03)
00:1a.2 USB controller [0c03]: Intel Corporation 82801I (ICH9 Family) U=
SB UHCI Controller #6 [8086:2939] (rev 03)
00:1a.7 USB controller [0c03]: Intel Corporation 82801I (ICH9 Family) U=
SB2 EHCI Controller #2 [8086:293c] (rev 03)
00:1b.0 Audio device [0403]: Intel Corporation 82801I (ICH9 Family) HD =
Audio Controller [8086:293e] (rev 03)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801I (ICH9 Family) PCI E=
xpress Port 1 [8086:2940] (rev 03)
00:1c.1 PCI bridge [0604]: Intel Corporation 82801I (ICH9 Family) PCI E=
xpress Port 2 [8086:2942] (rev 03)
00:1d.0 USB controller [0c03]: Intel Corporation 82801I (ICH9 Family) U=
SB UHCI Controller #1 [8086:2934] (rev 03)
00:1d.1 USB controller [0c03]: Intel Corporation 82801I (ICH9 Family) U=
SB UHCI Controller #2 [8086:2935] (rev 03)
00:1d.2 USB controller [0c03]: Intel Corporation 82801I (ICH9 Family) U=
SB UHCI Controller #3 [8086:2936] (rev 03)
00:1d.7 USB controller [0c03]: Intel Corporation 82801I (ICH9 Family) U=
SB2 EHCI Controller #1 [8086:293a] (rev 03)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge [8=
086:2448] (rev 93)
00:1f.0 ISA bridge [0601]: Intel Corporation ICH9M-E LPC Interface Cont=
roller [8086:2917] (rev 03)
00:1f.2 SATA controller [0106]: Intel Corporation 82801IBM/IEM (ICH9M/I=
CH9M-E) 4 port SATA Controller [AHCI mode] [8086:2929] (rev 03)
00:1f.3 SMBus [0c05]: Intel Corporation 82801I (ICH9 Family) SMBus Cont=
roller [8086:2930] (rev 03)
03:00.0 Network controller [0280]: Intel Corporation Wireless 7260 [808=
6:08b1] (rev 63)

bjorn@nemi:~$ lsusb=20
Bus 005 Device 003: ID 1199:a001 Sierra Wireless, Inc.=20
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 007 Device 002: ID 8087:07dc Intel Corp.=20
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 003: ID 17ef:4807 Lenovo UVC Camera
Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 002: ID 0a5c:2145 Broadcom Corp. BCM2045B (BDC-2.1) [Blu=
etooth Controller]
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub


The only odd parts are the newer 7260 wifi card (with the 8087:07dc
additional bluetooth device), and the even newer EM7345 LTE modem
(1199:a001).  There is of course a slight chance that one of these
devices cause something odd to happen during hibernate/resume.

The newer bluetooth device does trigger a firmware related warning
during resume, which I haven't bothered investigating yet.  I guess it
could theoretically be related to other resume issues:

Sep 25 12:19:52 nemi kernel: [   51.128904] ------------[ cut here ]---=
---------
Sep 25 12:19:52 nemi kernel: [   51.128915] WARNING: CPU: 0 PID: 5119 a=
t drivers/base/firmware_class.c:1124 _request_firmware+0x277/0x68d()
Sep 25 12:19:52 nemi kernel: [   51.128920] Modules linked in: xt_multi=
port iptable_filter ip_tables bnep dm_mod xt_hl nf_log_ipv6 nf_log_comm=
on xt_LOG binfmt_misc ip6table_filter ip6_tables x_tables nfsd nfs_acl =
nfs lockd fscache sunrpc 8021q garp stp mrp llc tun loop fuse iTCO_wdt =
iTCO_vendor_support snd_hda_codec_conexant snd_hda_codec_generic cdc_mb=
im cdc_wdm cdc_ncm usbnet coretemp kvm_intel mii arc4 cdc_acm kvm evdev=
 psmouse serio_raw uvcvideo ecb videobuf2_vmalloc videobuf2_memops vide=
obuf2_core v4l2_common btusb videodev bluetooth snd_hda_intel iwlmvm sn=
d_hda_controller mac80211 snd_hda_codec snd_hwdep snd_pcm_oss lpc_ich m=
fd_core i2c_i801 snd_mixer_oss iwlwifi snd_pcm cfg80211 snd_timer wmi t=
hinkpad_acpi nvram snd soundcore rfkill ac battery i915 i2c_algo_bit dr=
m_kms_helper video drm acpi_cpufreq button processor ext4 crc16 jbd2 mb=
cache nbd sg sd_mod crc_t10dif crct10dif_generic sr_mod crct10dif_commo=
n cdrom microcode ahci libahci libata scsi_mod ehci_pci uhci_hcd ehci_h=
cd usbcore usb_common e1000e ptp pps_core thermal thermal_sys
Sep 25 12:19:52 nemi kernel: [   51.129255] CPU: 0 PID: 5119 Comm: kwor=
ker/u9:0 Tainted: G        W      3.17.0-rc6+ #261
Sep 25 12:19:52 nemi kernel: [   51.129261] Hardware name: LENOVO 2776L=
EG/2776LEG, BIOS 6EET55WW (3.15 ) 12/19/2011
Sep 25 12:19:52 nemi kernel: [   51.129305] Workqueue: hci0 hci_power_o=
n [bluetooth]
Sep 25 12:19:52 nemi kernel: [   51.129312]  0000000000000009 ffff88023=
184fae8 ffffffff813be9c7 0000000000003dea
Sep 25 12:19:52 nemi kernel: [   51.129326]  0000000000000000 ffff88023=
184fb28 ffffffff8103eb60 ffff88023184faf8
Sep 25 12:19:52 nemi kernel: [   51.129340]  ffffffff812a61a5 00000000f=
ffffff5 ffff880223e6b180 ffff8800b17dd4c0
Sep 25 12:19:52 nemi kernel: [   51.129355] Call Trace:
Sep 25 12:19:52 nemi kernel: [   51.129367]  [<ffffffff813be9c7>] dump_=
stack+0x4e/0x68
Sep 25 12:19:52 nemi kernel: [   51.129377]  [<ffffffff8103eb60>] warn_=
slowpath_common+0x7c/0x96
Sep 25 12:19:52 nemi kernel: [   51.129389]  [<ffffffff812a61a5>] ? _re=
quest_firmware+0x277/0x68d
Sep 25 12:19:52 nemi kernel: [   51.129400]  [<ffffffff8103eb8f>] warn_=
slowpath_null+0x15/0x17
Sep 25 12:19:52 nemi kernel: [   51.129411]  [<ffffffff812a61a5>] _requ=
est_firmware+0x277/0x68d
Sep 25 12:19:52 nemi kernel: [   51.129422]  [<ffffffff812a667b>] reque=
st_firmware+0x30/0x44
Sep 25 12:19:52 nemi kernel: [   51.129449]  [<ffffffffa058bcd4>] btusb=
_setup_intel+0x297/0x675 [btusb]
Sep 25 12:19:52 nemi kernel: [   51.129513]  [<ffffffffa0071366>] ? usb=
_autopm_put_interface+0x35/0x39 [usbcore]
Sep 25 12:19:52 nemi kernel: [   51.129584]  [<ffffffffa05ddccf>] hci_d=
ev_do_open+0x13b/0x986 [bluetooth]
Sep 25 12:19:52 nemi kernel: [   51.129596]  [<ffffffff810533c2>] ? pro=
cess_one_work+0x136/0x3bf
Sep 25 12:19:52 nemi kernel: [   51.129653]  [<ffffffffa05de561>] hci_p=
ower_on+0x47/0x16a [bluetooth]
Sep 25 12:19:52 nemi kernel: [   51.129664]  [<ffffffff81053487>] proce=
ss_one_work+0x1fb/0x3bf
Sep 25 12:19:52 nemi kernel: [   51.129675]  [<ffffffff810533c2>] ? pro=
cess_one_work+0x136/0x3bf
Sep 25 12:19:52 nemi kernel: [   51.129710]  [<ffffffff81053841>] worke=
r_thread+0x1cc/0x2a3
Sep 25 12:19:52 nemi kernel: [   51.129721]  [<ffffffff81053675>] ? pro=
cess_scheduled_works+0x2a/0x2a
Sep 25 12:19:52 nemi kernel: [   51.129731]  [<ffffffff81057dc0>] kthre=
ad+0xb5/0xbd
Sep 25 12:19:52 nemi kernel: [   51.129743]  [<ffffffff810759e3>] ? tra=
ce_hardirqs_on+0xd/0xf
Sep 25 12:19:52 nemi kernel: [   51.129754]  [<ffffffff81057d0b>] ? __k=
thread_parkme+0x5c/0x5c
Sep 25 12:19:52 nemi kernel: [   51.129765]  [<ffffffff813c472c>] ret_f=
rom_fork+0x7c/0xb0
Sep 25 12:19:52 nemi kernel: [   51.129775]  [<ffffffff81057d0b>] ? __k=
thread_parkme+0x5c/0x5c
Sep 25 12:19:52 nemi kernel: [   51.129782] ---[ end trace 059b5e271143=
04b7 ]---
Sep 25 12:19:52 nemi kernel: [   51.129791] bluetooth hci0: firmware: i=
ntel/ibt-hw-37.7.bseq will not be loaded
Sep 25 12:19:52 nemi kernel: [   51.129802] Bluetooth: hci0 failed to o=
pen default Intel fw file: intel/ibt-hw-37.7.bseq


And I have always(?) had the strange NMI warning in resume logs:=20

 Sep 25 12:19:55 nemi kernel: [   54.623454] Uhhuh. NMI received for un=
known reason 31 on CPU 0.

but Google has taught me to simply ignore that.  I see it as just an
example of why it's pointless to log firmware errors without a clear
indication what the user is supposed to do about it.  I might be wrong
:-)

That's all I got.  I was hoping someone could explain under what
circumstances those maps will be NULL.

> Anyway, it would be great if you could test the patch below :)

The patch works fine for me.  Thanks.  I look forward to the next
revision of this set.  It looks like a really nice cleanup. And I am
sorry that I didn't catch the bug earlier in the 3.17 cycle.


Bj=C3=B8rn
