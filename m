From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 19:22:31 +0530
Message-ID: <CAKohpokag-ppE7WH=jPS6-i_T-5PyaDKyKS8uC+Xt2QGxLHYkw@mail.gmail.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
	<54353223.7080704@redhat.com>
	<CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
	<5437C12D.1070803@redhat.com>
	<CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com>
	<5437C535.3070707@redhat.com>
	<CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com>
	<5437C778.4040108@redhat.com>
	<1412942496.13463.28.camel@x200t>
	<CAKohpomvrKxnk3ZOtZxZEO+fVWSr5gB1AadtFUib8jsqndDgtg@mail.gmail.com>
	<1412947425.13463.37.camel@x200t>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:43479 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422AbaJJNwc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 09:52:32 -0400
Received: by mail-oi0-f49.google.com with SMTP id a3so6449713oib.8
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2014 06:52:31 -0700 (PDT)
In-Reply-To: <1412947425.13463.37.camel@x200t>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>
Cc: Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

On 10 October 2014 18:53, Robert Sch=C3=B6ne <robert.schoene@tu-dresden=
=2Ede> wrote:
> I finally got a stack:

Thanks a lot..

> Oct 10 15:19:44 basti kernel: [  395.641363] BUG: unable to handle ke=
rnel paging request at ffff8800b2783b10
> Oct 10 15:19:44 basti kernel: [  395.641412] IP: [<ffff8800b2783b10>]=
 0xffff8800b2783b10
> Oct 10 15:19:44 basti kernel: [  395.641449] PGD 1fc9067 PUD 1fce067 =
PMD b2737063 PTE 80000000b2783163
> Oct 10 15:19:44 basti kernel: [  395.641503] Oops: 0011 [#1] SMP
> Oct 10 15:19:44 basti kernel: [  395.641533] Modules linked in: sep3_=
15(OE) pax(OE) nfsv3(E) rfcomm(E) bnep(E) bluetooth(E) nfsd(E) auth_rpc=
gss(E) binfmt_misc(E) nfs_acl(E) nfs(E) lockd(E) sunrpc(E) fscache(E) s=
nd_hda_codec_hdmi(E) snd_hda_codec_conexant(E) snd_hda_codec_generic(E)=
 intel_rapl(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) =
x86_adapt_driver(OE) snd_hda_intel(E) snd_hda_controller(E) i915(E) kvm=
_intel(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_pcm(E) crct10dif_pcl=
mul(E) snd_timer(E) mei_me(E) i2c_algo_bit(E) video(E) drm_kms_helper(E=
) mei(E) drm(E) crc32_pclmul(E) ghash_clmulni_intel(E) ppdev(E) aesni_i=
ntel(E) lp(E) parport_pc(E) parport(E) snd(E) aes_x86_64(E) glue_helper=
(E) lrw(E) gf128mul(E) ablk_helper(E) gpio_ich(E) cryptd(E) soundcore(E=
) mac_hid(E) lpc_ich(E) serio_raw(E) tpm_infineon(E) psmouse(E) ahci(E)=
 libahci(E) e1000e(E) ptp(E) pps_core(E)
> Oct 10 15:19:44 basti kernel: [  395.642169] CPU: 6 PID: 3079 Comm: t=
ee Tainted: G           OE  3.17.0+ #3
> Oct 10 15:19:44 basti kernel: [  395.642209] Hardware name: FUJITSU E=
SPRIMO P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for D3061-A1x 07/04/2011
> Oct 10 15:19:44 basti kernel: [  395.642262] task: ffff88022bb96400 t=
i: ffff880227ea4000 task.ti: ffff880227ea4000
> Oct 10 15:19:44 basti kernel: [  395.642303] RIP: 0010:[<ffff8800b278=
3b10>]  [<ffff8800b2783b10>] 0xffff8800b2783b10
> Oct 10 15:19:44 basti kernel: [  395.642352] RSP: 0018:ffff880227ea7b=
78  EFLAGS: 00010293
> Oct 10 15:19:44 basti kernel: [  395.642383] RAX: ffff88022ba5d340 RB=
X: 0000000000000000 RCX: 0000000000000000
> Oct 10 15:19:44 basti kernel: [  395.642423] RDX: ffff8802314f0a08 RS=
I: 0000000000000100 RDI: 0000000000000000
> Oct 10 15:19:44 basti kernel: [  395.642463] RBP: ffff880227ea7ba8 R0=
8: ffff8802314f0a00 R09: 0000000000000004
> Oct 10 15:19:44 basti kernel: [  395.642503] R10: ffffffff81d1a660 R1=
1: 0000000000000246 R12: 0000000000000000
> Oct 10 15:19:44 basti kernel: [  395.642543] R13: ffff8802314f0a00 R1=
4: ffff88022ba5d240 R15: 0000000000000002
> Oct 10 15:19:44 basti kernel: [  395.642583] FS:  00002b1d0969ab80(00=
00) GS:ffff88023e380000(0000) knlGS:0000000000000000
> Oct 10 15:19:44 basti kernel: [  395.642629] CS:  0010 DS: 0000 ES: 0=
000 CR0: 0000000080050033
> Oct 10 15:19:44 basti kernel: [  395.642662] CR2: ffff8800b2783b10 CR=
3: 00000000b4e89000 CR4: 00000000000407e0
> Oct 10 15:19:44 basti kernel: [  395.642717]  ffffffff815e1918 ffff88=
022ba5d240 ffff8802314f0a00 0000000000000003
> Oct 10 15:19:44 basti kernel: [  395.642773]  0000000000000002 ffff88=
023e210ea0 ffff880227ea7c28 ffffffff815e1c06
> Oct 10 15:19:44 basti kernel: [  395.642828]  0000000000010aa8 ffff88=
022ba5d258 ffffffff81cd9ab0 ffff88023e210ea0
> Oct 10 15:19:44 basti kernel: [  395.642885] Call Trace:
> Oct 10 15:19:44 basti kernel: [  395.642906]  [<ffffffff815e1918>] ? =
gov_queue_work+0x68/0xd0
> Oct 10 15:19:44 basti kernel: [  395.642941]  [<ffffffff815e1c06>] cp=
ufreq_governor_dbs+0x286/0x740
> Oct 10 15:19:44 basti kernel: [  395.642980]  [<ffffffff815dfd87>] od=
_cpufreq_governor_dbs+0x17/0x20
> Oct 10 15:19:44 basti kernel: [  395.643017]  [<ffffffff815dc03f>] __=
cpufreq_governor+0xdf/0x270
> Oct 10 15:19:44 basti kernel: [  395.643089]  [<ffffffff815dcd56>] st=
ore_scaling_governor+0x96/0xf0
> Oct 10 15:19:44 basti kernel: [  395.643166]  [<ffffffff815db989>] st=
ore+0x79/0xc0
> Oct 10 15:19:44 basti kernel: [  395.643232]  [<ffffffff81247c90>] ke=
rnfs_fop_write+0xe0/0x160
> Oct 10 15:19:44 basti kernel: [  395.643300]  [<ffffffff811d2bd6>] Sy=
S_write+0x46/0xb0
> Oct 10 15:19:44 basti kernel: [  395.643363] Code: 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 de 84 2b 02 88 ff ff 80 6a c4=
 81 ff ff ff ff 40 b5 9c 2b 02 88 ff ff <d0> 35 78 b2 00 88 ff ff 80 be=
 08 81 ff ff ff ff 00 00 00 00 00
> Oct 10 15:19:44 basti kernel: [  395.643772]  RSP <ffff880227ea7b78>
> Oct 10 15:19:44 basti kernel: [  395.643817] ---[ end trace c4d3fedcd=
d4b353b ]---

Okay, this is something new..

Would it be possible for you to get the line in cpufreq_governor.c
file which did this?
=46or that you can use objdump.

This is how I do it on ARM:

arm-linux-gnueabihf-objdump -r -S -l --disassemble cpufreq_governor.o |=
 less

If you are using x86 then simply use objdump, otherwise your toolchain =
will
have a command for this..

Then search for gov_queue_work in this and confirm the length of routin=
e is
0xd0 (Came from gov_queue_work+0x68/0xd0) and then tell us what's there
at 0x68 ...

Sorry if you already knew all this, just for completeness I am sharing =
this :)

If you find some difficulty with this, just attach the file and send it=
 to me +
let me know what compiler you used, + system architecture.

I tried running your script on a single-cluster (sorry I couldn't get t=
he other
board up yet :( ), and couldn't hit this issue.

Once again, thanks for testing.

--
viresh
