From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Tue, 14 Oct 2014 13:12:50 -0400
Message-ID: <543D5992.10605@redhat.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com> <54353223.7080704@redhat.com> <CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com> <5437C12D.1070803@redhat.com> <CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com> <5437C535.3070707@redhat.com> <CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com> <5437C778.4040108@redhat.com> <1412942496.13463.28.camel@x200t> <CAKohpomvrKxnk3ZOtZxZEO+fVWSr5gB1AadtFUib8jsqndDgtg@mail.gmail.com> <1412947425.13463.37.camel@x200t> <CAKohpokag-ppE7WH=jPS6-i_T-5PyaDKyKS8uC+Xt2QGxLHYkw@mail.gmail.com> <1412949926.13463.47.camel@x200t> <CAKohpokBzXG=zSicg5uMGK7=qTCOObG_r4Z4trkRmQxftv0vyw@mail.gmail.com> <543D0C43.3070701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29268 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580AbaJNRNG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Oct 2014 13:13:06 -0400
In-Reply-To: <543D0C43.3070701@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?UTF-8?B?Um9iZXJ0IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>



On 10/14/2014 07:42 AM, Prarit Bhargava wrote:
>=20
>=20
> On 10/14/2014 02:58 AM, Viresh Kumar wrote:
>> On 10 October 2014 19:35, Robert Sch=C3=B6ne <robert.schoene@tu-dres=
den.de> wrote:
>>> @all:
>>> I have to leave now and will not be available for a week.
>>>
>>> @Viresh:
>>> The line you are looking for is 2c8 (260h+68h, length check passed)=
=2E
>>> Here it is with the surrounding instructions:
>>
>> Thanks..
>>
>> I now understand most of the races you and Prarit have reported.
>> Finally I was able to get my multi-cluster board up and could test t=
his
>> myself :)
>>
>> So you need to try my cpufreq/governor-fixes-v4 branch to confirm if
>> this fixes your issues or not.
>>
>> @Prarit: As Robert probably isn't around this week, would it be poss=
ible for
>> you to test this stuff ?
>=20
> Hi Viresh,
>=20
> I've been running both my test and Robert's test for about 5 mins.  I=
n Robert's
> case I don't see any problems ... in my case I do occasionally get a =
system
> panic because of the sysfs access race I described in the other threa=
d (cpu 1
> holds a sysfs file open, while cpu 2 changes the governor ...)
>=20
> I do have some concerns about the nature of this patchset; I feel it =
is more of
> a band-aid approach to the whole cpufreq mechanism.  Having said that=
, I haven't
> offered an alternative yet so I can't really object too loudly :)
>=20
> I'll do a more formal review when you post to the list.
>=20

I spoke too soon :(  On a larger system (128 processors, 64 cores, two =
threads
each)) the system locks up in about 1 minute using Robert's test.  The


[ 2484.634827] NMI watchdog: BUG: soft lockup - CPU#31 stuck for 22s! [=
tee:34538]^M
[ 2484.634827] Modules linked in: sg nfsv3 rpcsec_gss_krb5 nfsv4 dns_re=
solver
nfs fscache cfg80211 rfkill x86_pkg_temp_thermal intel_powerclamp coret=
emp
kvm_intel kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_=
intel
aesni_intel lrw igb gf128mul iTCO_wdt ioatdma ptp glue_helper sb_edac
iTCO_vendor_support ablk_helper pps_core lpc_ich edac_core dca cryptd m=
fd_core
shpchp pcspkr i2c_i801 ipmi_si ipmi_msghandler wmi nfsd acpi_cpufreq au=
th_rpcgss
nfs_acl lockd grace sunrpc xfs libcrc32c sd_mod sr_mod cdrom crc_t10dif
crct10dif_common mgag200 syscopyarea sysfillrect sysimgblt i2c_algo_bit
drm_kms_helper ttm isci drm libsas ahci libahci scsi_transport_sas liba=
ta
i2c_core dm_mirror dm_region_hash dm_log dm_mod^M

[ 2484.634850] CPU: 31 PID: 34538 Comm: tee Tainted: G             L 3.=
17.0+ #10^M
[ 2484.634851] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
RMLSDP.86I.00.29.D696.1311111329 11/11/2013^M
[ 2484.634851] task: ffff881010376c80 ti: ffff880804938000 task.ti:
ffff880804938000^M
[ 2484.634852] RIP: 0010:[<ffffffff814e65dc>]  [<ffffffff814e65dc>]
__cpufreq_governor+0x6c/0x2c0^M
[ 2484.634855] RSP: 0018:ffff88080493bc68  EFLAGS: 00000246^M
[ 2484.634856] RAX: 0000000000000001 RBX: ffffffff8165a622 RCX: 0000000=
000262988^M
[ 2484.634857] RDX: 0000000000000000 RSI: ffffffff81a72960 RDI: ffff881=
00db9b400^M
[ 2484.634857] RBP: ffff88080493bc90 R08: 0000000000000000 R09: 0000000=
000124f80^M
[ 2484.634858] R10: 0000000000262988 R11: 0000000000000246 R12: ffff880=
80493bcd8^M
[ 2484.634858] R13: ffffffff813a0c22 R14: ffff88080493bbe0 R15: ffff880=
80490f518^M
[ 2484.634859] FS:  00007f8045e7f740(0000) GS:ffff88081f060000(0000)
knlGS:0000000000000000^M
[ 2484.634860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
[ 2484.634860] CR2: 000000000080b108 CR3: 000000080e86f000 CR4: 0000000=
0001407e0^M
[ 2484.634861] Stack:^M
[ 2484.634861]  ffff88080493bcd8 ffff88100db9b400 0000000000000000
ffffffff81a72960^M
[ 2484.634862]  ffff88100db9b400 ffff88080493bcc8 ffffffff814e6a33
ffff88100db9b400^M
[ 2484.634863]  ffff88080d0c5430 0000000000000009 0000000000000009
ffff88100db9b400^M
[ 2484.634865] Call Trace:^M
[ 2484.634865]  [<ffffffff814e6a33>] cpufreq_set_policy+0x203/0x310^M
[ 2484.634867]  [<ffffffff814e6e1d>] store_scaling_governor+0xad/0xf0^M
[ 2484.634869]  [<ffffffff814e6d30>] ? cpufreq_update_policy+0x1f0/0x1f=
0^M
[ 2484.634872]  [<ffffffff810b5500>] ? add_wait_queue_exclusive+0x20/0x=
50^M
[ 2484.634873]  [<ffffffff814e5899>] store+0x79/0xc0^M
[ 2484.634875]  [<ffffffff8126197d>] sysfs_kf_write+0x3d/0x50^M
[ 2484.634876]  [<ffffffff81260ec0>] kernfs_fop_write+0xe0/0x160^M
[ 2484.634878]  [<ffffffff811e9a67>] vfs_write+0xb7/0x1f0^M
[ 2484.634879]  [<ffffffff811ea685>] SyS_write+0x55/0xd0^M
[ 2484.634881]  [<ffffffff8165c8e9>] system_call_fastpath+0x16/0x1b^M
[ 2484.634883] Code: 05 3b 87 5c 00 04 0f 85 50 02 00 00 0f 1f 00 48 8b=
 05 71 35
a2 00 0f b6 50 10 83 e2 08 eb 08 0f b6 43 64 84 c0 74 10 84 d2 75 f4 <4=
8> 8b 43
50 0f b6 40 50 84 c0 75 f0 48 c7 c7 60 27 a7 81 e8 1c ^M

P.
