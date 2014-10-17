From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 17 Oct 2014 08:12:44 -0400
Message-ID: <544107BC.3090002@redhat.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com> <54353223.7080704@redhat.com> <CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com> <5437C12D.1070803@redhat.com> <CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com> <5437C535.3070707@redhat.com> <CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com> <5437C778.4040108@redhat.com> <1412942496.13463.28.camel@x200t> <CAKohpomvrKxnk3ZOtZxZEO+fVWSr5gB1AadtFUib8jsqndDgtg@mail.gmail.com> <1412947425.13463.37.camel@x200t> <CAKohpokag-ppE7WH=jPS6-i_T-5PyaDKyKS8uC+Xt2QGxLHYkw@mail.gmail.com> <1412949926.13463.47.camel@x200t> <CAKohpokBzXG=zSicg5uMGK7=qTCOObG_r4Z4trkRmQxftv0vyw@mail.gmail.com> <543D0C43.3070701@redhat.com> <543D5992.10605@redhat.com> <CAKohpom6Eii=4OUe-gn8vJM
 RD56kxKN2iobqoKkqHLa2eYah3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57480 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbaJQMM5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Oct 2014 08:12:57 -0400
In-Reply-To: <CAKohpom6Eii=4OUe-gn8vJMRD56kxKN2iobqoKkqHLa2eYah3Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?UTF-8?B?Um9iZXJ0IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>



On 10/16/2014 06:58 AM, Viresh Kumar wrote:
> On 14 October 2014 22:42, Prarit Bhargava <prarit@redhat.com> wrote:
>> I spoke too soon :(  On a larger system (128 processors, 64 cores, two threads
>> each)) the system locks up in about 1 minute using Robert's test.  The
> 
> :(
> 
>> [ 2484.634827] NMI watchdog: BUG: soft lockup - CPU#31 stuck for 22s! [tee:34538]^M
>> [ 2484.634827] Modules linked in: sg nfsv3 rpcsec_gss_krb5 nfsv4 dns_resolver
>> nfs fscache cfg80211 rfkill x86_pkg_temp_thermal intel_powerclamp coretemp
>> kvm_intel kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel
>> aesni_intel lrw igb gf128mul iTCO_wdt ioatdma ptp glue_helper sb_edac
>> iTCO_vendor_support ablk_helper pps_core lpc_ich edac_core dca cryptd mfd_core
>> shpchp pcspkr i2c_i801 ipmi_si ipmi_msghandler wmi nfsd acpi_cpufreq auth_rpcgss
>> nfs_acl lockd grace sunrpc xfs libcrc32c sd_mod sr_mod cdrom crc_t10dif
>> crct10dif_common mgag200 syscopyarea sysfillrect sysimgblt i2c_algo_bit
>> drm_kms_helper ttm isci drm libsas ahci libahci scsi_transport_sas libata
>> i2c_core dm_mirror dm_region_hash dm_log dm_mod^M
>>
>> [ 2484.634850] CPU: 31 PID: 34538 Comm: tee Tainted: G             L 3.17.0+ #10^M
>> [ 2484.634851] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
>> RMLSDP.86I.00.29.D696.1311111329 11/11/2013^M
>> [ 2484.634851] task: ffff881010376c80 ti: ffff880804938000 task.ti:
>> ffff880804938000^M
>> [ 2484.634852] RIP: 0010:[<ffffffff814e65dc>]  [<ffffffff814e65dc>]
>> __cpufreq_governor+0x6c/0x2c0^M
>> [ 2484.634855] RSP: 0018:ffff88080493bc68  EFLAGS: 00000246^M
>> [ 2484.634856] RAX: 0000000000000001 RBX: ffffffff8165a622 RCX: 0000000000262988^M
>> [ 2484.634857] RDX: 0000000000000000 RSI: ffffffff81a72960 RDI: ffff88100db9b400^M
>> [ 2484.634857] RBP: ffff88080493bc90 R08: 0000000000000000 R09: 0000000000124f80^M
>> [ 2484.634858] R10: 0000000000262988 R11: 0000000000000246 R12: ffff88080493bcd8^M
>> [ 2484.634858] R13: ffffffff813a0c22 R14: ffff88080493bbe0 R15: ffff88080490f518^M
>> [ 2484.634859] FS:  00007f8045e7f740(0000) GS:ffff88081f060000(0000)
>> knlGS:0000000000000000^M
>> [ 2484.634860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
>> [ 2484.634860] CR2: 000000000080b108 CR3: 000000080e86f000 CR4: 00000000001407e0^M
>> [ 2484.634861] Stack:^M
>> [ 2484.634861]  ffff88080493bcd8 ffff88100db9b400 0000000000000000
>> ffffffff81a72960^M
>> [ 2484.634862]  ffff88100db9b400 ffff88080493bcc8 ffffffff814e6a33
>> ffff88100db9b400^M
>> [ 2484.634863]  ffff88080d0c5430 0000000000000009 0000000000000009
>> ffff88100db9b400^M
>> [ 2484.634865] Call Trace:^M
>> [ 2484.634865]  [<ffffffff814e6a33>] cpufreq_set_policy+0x203/0x310^M
>> [ 2484.634867]  [<ffffffff814e6e1d>] store_scaling_governor+0xad/0xf0^M
>> [ 2484.634869]  [<ffffffff814e6d30>] ? cpufreq_update_policy+0x1f0/0x1f0^M
>> [ 2484.634872]  [<ffffffff810b5500>] ? add_wait_queue_exclusive+0x20/0x50^M
>> [ 2484.634873]  [<ffffffff814e5899>] store+0x79/0xc0^M
>> [ 2484.634875]  [<ffffffff8126197d>] sysfs_kf_write+0x3d/0x50^M
>> [ 2484.634876]  [<ffffffff81260ec0>] kernfs_fop_write+0xe0/0x160^M
>> [ 2484.634878]  [<ffffffff811e9a67>] vfs_write+0xb7/0x1f0^M
>> [ 2484.634879]  [<ffffffff811ea685>] SyS_write+0x55/0xd0^M
>> [ 2484.634881]  [<ffffffff8165c8e9>] system_call_fastpath+0x16/0x1b^M
>> [ 2484.634883] Code: 05 3b 87 5c 00 04 0f 85 50 02 00 00 0f 1f 00 48 8b 05 71 35
>> a2 00 0f b6 50 10 83 e2 08 eb 08 0f b6 43 64 84 c0 74 10 84 d2 75 f4 <48> 8b 43
>> 50 0f b6 40 50 84 c0 75 f0 48 c7 c7 60 27 a7 81 e8 1c ^M
> 
> Not sure what's going on here.. Better would be if you can decode things like
> this while reporting bugs:
> 
> __cpufreq_governor+0x6c/0x2c0
> 

/home/linux/drivers/cpufreq/cpufreq.c: 119
0xffffffff814e65dc <__cpufreq_governor+0x6c>:   mov    0x50(%rbx),%rax
0xffffffff814e65e0 <__cpufreq_governor+0x70>:   movzbl 0x50(%rax),%eax

bool is_governor_busy(struct cpufreq_policy *policy)
{
        if (have_governor_per_policy())
                return policy->governor_busy;
        else
                return policy->governor->governor_busy;  <<< this line?
}

> So that we know what part of code screwed it up..
> 
