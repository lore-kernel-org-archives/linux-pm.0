From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Wed, 24 Sep 2014 09:45:26 +0200
Message-ID: <87vbodihrd.fsf@nemi.mork.no>
References: <87zjdq8k7i.fsf@nemi.mork.no> <2218322.ridXK8jFtJ@vostro.rjw.lan>
	<878ulaxn6d.fsf@nemi.mork.no> <1435748.4Qh6HZyMEY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:38420 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbaIXHs1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 03:48:27 -0400
In-Reply-To: <1435748.4Qh6HZyMEY@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Tue, 23 Sep 2014 23:20:09 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Joerg Roedel <jroedel@suse.de>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Tuesday, September 23, 2014 07:27:06 PM Bj=C3=B8rn Mork wrote:
>>=20
>> --=3D-=3D-=3D
>> Content-Type: text/plain; charset=3Dutf-8
>> Content-Transfer-Encoding: quoted-printable
>>=20
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>>=20
>>=20
>> > I would suspect one of these commits:
>> >
>> > 84c91b7ae07c PM / hibernate: avoid unsafe pages in e820 reserved r=
egions
>> > 0f7d83e85dbd PM / Hibernate: Touch Soft Lockup Watchdog in rtree_n=
ext_node
>> > 9047eb629e5c PM / Hibernate: Remove the old memory-bitmap implemen=
tation
>> > 6efde38f0769 PM / Hibernate: Iterate over set bits instead of PFNs=
 in sws=3D
>> usp_free()
>> > 3a20cb177961 PM / Hibernate: Implement position keeping in radix t=
ree
>> > 07a338236fdc PM / Hibernate: Add memory_rtree_find_bit function
>> > f469f02dc6fa PM / Hibernate: Create a Radix-Tree to store memory b=
itmap
>> >
>> > so I guess you can start from checking them (the topmpost one is t=
he late=3D
>> st).
>>=20
>> Thanks.  Yes, you were correct. The bad commit is
>>=20
>>  6efde38f0769 PM / Hibernate: Iterate over set bits instead of PFNs =
in swsu=3D
>> sp_free()
>>=20
>> I have confirmed that reverting only this commit on top of a clean
>> v3.17-rc6 fixes the problem.  I am attaching the context-modified re=
vert
>> patch I used.
>
> Instead of reverting the commit, can you please check if adding an "i=
f (page)"
> check around=20
>
> 		memory_bm_clear_current(forbidden_pages_map);
> 		memory_bm_clear_current(free_pages_map);
> 		__free_page(page);
>
> in swsusp_free() makes the NULL pointer deref go away?

Tested.  But on a hunch, I also added this just to be sure:


@@ -1343,7 +1343,15 @@ void swsusp_free(void)
 {
        unsigned long fb_pfn, fr_pfn;
=20
+WARN_ON(!forbidden_pages_map);
+if (!forbidden_pages_map)
+       return;
+
        memory_bm_position_reset(forbidden_pages_map);
+WARN_ON(!free_pages_map);
+if (!free_pages_map)
+       return;
+
        memory_bm_position_reset(free_pages_map);
=20



And got:


[   34.500851] WARNING: CPU: 1 PID: 5052 at kernel/power/snapshot.c:134=
6 swsusp_free+0x25/0x160()
[   34.500854] Modules linked in: xt_multiport iptable_filter ip_tables=
 dm_mod bnep xt_hl nf_log_ipv6 nf_log_common xt_LOG binfmt_misc ip6tabl=
e_filter ip6_tables x_tables nfsd nfs_acl nfs lockd fscache sunrpc 8021=
q garp stp mrp llc tun loop fuse snd_hda_codec_conexant snd_hda_codec_g=
eneric iTCO_wdt iTCO_vendor_support arc4 coretemp kvm_intel cdc_mbim kv=
m cdc_wdm uvcvideo cdc_ncm videobuf2_vmalloc evdev videobuf2_memops vid=
eobuf2_core psmouse cdc_acm v4l2_common usbnet mii videodev serio_raw i=
2c_i801 iwlmvm snd_hda_intel snd_hda_controller mac80211 snd_hda_codec =
snd_hwdep snd_pcm_oss snd_mixer_oss iwlwifi i915 lpc_ich i2c_algo_bit m=
fd_core drm_kms_helper snd_pcm cfg80211 snd_timer drm wmi thinkpad_acpi=
 nvram snd soundcore battery ecb ac btusb bluetooth video rfkill button=
 acpi_cpufreq processor ext4 crc16 jbd2 mbcache nbd sg sd_mod crc_t10di=
f sr_mod crct10dif_generic cdrom crct10dif_common microcode ahci libahc=
i libata scsi_mod uhci_hcd ehci_pci ehci_hcd e1000e usbcore ptp usb_com=
mon pps_core thermal thermal_sys
[   34.501050] CPU: 1 PID: 5052 Comm: s2disk Not tainted 3.17.0-rc6+ #2=
60
[   34.501054] Hardware name: LENOVO 2776LEG/2776LEG, BIOS 6EET55WW (3.=
15 ) 12/19/2011
[   34.501057]  0000000000000009 ffff88021e9cfde8 ffffffff813bea17 0000=
000000000000
[   34.501066]  0000000000000000 ffff88021e9cfe28 ffffffff8103eb60 ffff=
ffff8107f8be
[   34.501075]  ffffffff8107c902 ffff8800ae809a00 0000000000000010 ffff=
880232149690
[   34.501083] Call Trace:
[   34.501092]  [<ffffffff813bea17>] dump_stack+0x4e/0x68
[   34.501100]  [<ffffffff8103eb60>] warn_slowpath_common+0x7c/0x96
[   34.501107]  [<ffffffff8107f8be>] ? lock_system_sleep+0x22/0x24
[   34.501113]  [<ffffffff8107c902>] ? swsusp_free+0x25/0x160
[   34.501119]  [<ffffffff8103eb8f>] warn_slowpath_null+0x15/0x17
[   34.501125]  [<ffffffff8107c902>] swsusp_free+0x25/0x160
[   34.501131]  [<ffffffff8107fb82>] snapshot_release+0x13/0x68
[   34.501138]  [<ffffffff81136c78>] __fput+0x10d/0x1e5
[   34.501144]  [<ffffffff81136d80>] ____fput+0x9/0xb
[   34.501151]  [<ffffffff81056a51>] task_work_run+0x81/0xb0
[   34.501159]  [<ffffffff810026d8>] do_notify_resume+0x55/0x66
[   34.501166]  [<ffffffff811ee7ce>] ? trace_hardirqs_on_thunk+0x3a/0x3=
f
[   34.501172]  [<ffffffff813c4a98>] int_signal+0x12/0x17
[   34.501177] ---[ end trace fd197b669f9d81a3 ]---

where 1346 is

bjorn@canardo:/usr/local/src/build-tmp/linux$ sed -ne 1346p kernel/powe=
r/snapshot.c
WARN_ON(!forbidden_pages_map);


So it looks like that map for some reason is uninitialized when
swsusp_free() is called after a hibernate->resume cycle.  Is this only
hitting me?  If so, then I *really* wonder what I'm doing out of the
ordinary...



Bj=C3=B8rn
