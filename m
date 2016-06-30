From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] x86/power/64: Fix kernel text mapping corruption
 during image restoration
Date: Thu, 30 Jun 2016 11:45:05 +0200
Message-ID: <20160630094505.GA17833@pd.tnic>
References: <20160617105435.GB15997@pd.tnic>
 <CAGXu5jK4w+2WOEeNqv2CU5wqTY3oDY3pWPgJkM7Lp2AmEZuj2g@mail.gmail.com>
 <65d98ad4-124b-64e4-84e5-877af71a1d44@deltatee.com>
 <2398306.qXx6AZtdS5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2398306.qXx6AZtdS5@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Logan Gunthorpe <logang@deltatee.com>, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 30, 2016 at 04:20:43AM +0200, Rafael J. Wysocki wrote:
> That's not what Boris was seeing at least.

Well, I had it a couple of times during testing patches. This is all
from the logs:

[   65.121109] PM: Basic memory bitmaps freed
[   65.125991] Restarting tasks ... 
[   65.129342] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[   65.129585] done.
[   65.141314] BUG: unable to handle kernel paging request at ffff88042b957e40
[   65.141316] IP: [<ffff88042b957e40>] 0xffff88042b957e40
[   65.141318] PGD 2067067 PUD 206a067 PMD 800000042b8001e3 
[   65.141319] Oops: 0011 [#1] PREEMPT SMP
[   65.141327] Modules linked in: binfmt_misc ipv6 vfat fat amd64_edac_mod edac_mce_amd fuse dm_crypt dm_mod amdkfd kvm_amd kvm amd_iommu_v2 irqbypass crc32_pclmul radeon aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd fam15h_power k10temp acpi_cpufreq
[   65.141328] CPU: 6 PID: 1 Comm: init Not tainted 4.7.0-rc3+ #4
[   65.141329] Hardware name: To be filled by O.E.M. To be filled by O.E.M./M5A97 EVO R2.0, BIOS 1503 01/16/2013
[   65.141329] task: ffff88042b958000 ti: ffff88042b954000 task.ti: ffff88042b954000
[   65.141331] RIP: 0010:[<ffff88042b957e40>]  [<ffff88042b957e40>] 0xffff88042b957e40
[   65.141331] RSP: 0018:ffff88042b957e00  EFLAGS: 00010282
[   65.141332] RAX: 0000000000000000 RBX: ffff88042b957f58 RCX: 0000000000000000
[   65.141333] RDX: 0000000000000001 RSI: ffffffff81063b59 RDI: ffffffff8168898c
[   65.141333] RBP: ffff88042b957ef0 R08: 0000000000000000 R09: 0000000000000002
[   65.141334] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88042b954000
[   65.141334] R13: ffff88042b954000 R14: ffff88042b957f58 R15: ffff88042b958000
[   65.141335] FS:  00007fad32173800(0000) GS:ffff88043dd80000(0000) knlGS:0000000000000000
[   65.141336] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   65.141336] CR2: ffff88042b957e40 CR3: 00000004298e6000 CR4: 00000000000406e0
[   65.141336] Stack:
[   65.141338]  ffff880037b81000 ffff880037b81000 0000000000000000 ffffffff81181e1e
[   65.141339]  ffffff9c00000002 ffff880429e8c600 ffffffff811782bf 0000000000000011
[   65.141340]  000000000000049c 0000000000000001 0000000000001180 0000000000000000
[   65.141340] Call Trace:
[   65.141344]  [<ffffffff81181e1e>] ? getname_flags+0x5e/0x1b0
[   65.141346]  [<ffffffff811782bf>] ? cp_new_stat+0x10f/0x120
[   65.141348]  [<ffffffff810bb33a>] ? ktime_get_ts64+0x4a/0xf0
[   65.141353]  [<ffffffff81185fc7>] ? poll_select_copy_remaining+0xe7/0x130
[   65.141355]  [<ffffffff8100263a>] exit_to_usermode_loop+0x8a/0xb0
[   65.141356]  [<ffffffff81002a6b>] syscall_return_slowpath+0x5b/0x70
[   65.141358]  [<ffffffff81688e72>] entry_SYSCALL_64_fastpath+0xa5/0xa7
[   65.141374] Code: 00 00 00 1e 1e 18 81 ff ff ff ff 02 00 00 00 9c ff ff ff 00 c6 e8 29 04 88 ff ff bf 82 17 81 ff ff ff ff 11 00 00 00 00 00 00 00 <9c> 04 00 00 00 00 00 00 01 00 00 00 00 00 00 00 80 11 00 00 00 
[   65.141375] RIP  [<ffff88042b957e40>] 0xffff88042b957e40
[   65.141376]  RSP <ffff88042b957e00>
[   65.141376] CR2: ffff88042b957e40
[   65.141378] ---[ end trace 5dc71ecf8d888ee6 ]---
[   65.141509] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[   65.141509] 
[   65.149191] Kernel Offset: disabled
[   65.449314] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

...

[  381.835297] Restarting tasks ... 
[  381.838620] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[  381.838689] done.
[  381.850763] BUG: unable to handle kernel paging request at ffff88042b957e40
[  381.850765] IP: [<ffff88042b957e40>] 0xffff88042b957e40
[  381.850766] PGD 2065067 PUD 2068067 PMD 800000042b8001e3 
[  381.850767] Oops: 0011 [#1] PREEMPT SMP
[  381.850778] Modules linked in: binfmt_misc ipv6 vfat fat amd64_edac_mod edac_mce_amd fuse dm_crypt dm_mod amdkfd kvm_amd kvm amd_iommu_v2 radeon irqbypass crc32_pclmul aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd k10temp fam15h_power acpi_cpufreq
[  381.850779] CPU: 3 PID: 1 Comm: init Not tainted 4.7.0-rc3+ #1
[  381.850780] Hardware name: To be filled by O.E.M. To be filled by O.E.M./M5A97 EVO R2.0, BIOS 1503 01/16/2013
[  381.850781] task: ffff88042b958000 ti: ffff88042b954000 task.ti: ffff88042b954000
[  381.850782] RIP: 0010:[<ffff88042b957e40>]  [<ffff88042b957e40>] 0xffff88042b957e40
[  381.850783] RSP: 0018:ffff88042b957e00  EFLAGS: 00010282
[  381.850783] RAX: 0000000000000000 RBX: ffff88042b957f58 RCX: 0000000000000000
[  381.850784] RDX: 0000000000000001 RSI: ffffffff81062a2d RDI: ffffffff81687d8c
[  381.850784] RBP: ffff88042b957ef0 R08: 0000000000000000 R09: 0000000000000002
[  381.850785] R10: 00000000ffffffff R11: 0000000000000001 R12: ffff88042b954000
[  381.850785] R13: ffff88042b954000 R14: ffff88042b957f58 R15: ffff88042b958000
[  381.850786] FS:  00007f1143649800(0000) GS:ffff88043dcc0000(0000) knlGS:0000000000000000
[  381.850787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  381.850787] CR2: ffff88042b957e40 CR3: 00000004298af000 CR4: 00000000000406e0
[  381.850788] Stack:
[  381.850789]  ffff88042b1ed000 ffff88042b1ed000 0000000000000000 ffffffff8117f8ae
[  381.850790]  ffffff9c00000002 ffff88042b09ac00 ffffffff81175d5f 0000000000000011
[  381.850791]  0000000000001c3d 0000000000000001 0000000000001180 0000000000000000
[  381.850792] Call Trace:
[  381.850795]  [<ffffffff8117f8ae>] ? getname_flags+0x5e/0x1b0
[  381.850797]  [<ffffffff81175d5f>] ? cp_new_stat+0x10f/0x120
[  381.850799]  [<ffffffff810b9eca>] ? ktime_get_ts64+0x4a/0xf0
[  381.850800]  [<ffffffff81183a57>] ? poll_select_copy_remaining+0xe7/0x130
[  381.850802]  [<ffffffff8100263a>] exit_to_usermode_loop+0x8a/0xb0
[  381.850804]  [<ffffffff81002a6b>] syscall_return_slowpath+0x5b/0x70
[  381.850806]  [<ffffffff81688272>] entry_SYSCALL_64_fastpath+0xa5/0xa7
[  381.850820] Code: 00 00 00 ae f8 17 81 ff ff ff ff 02 00 00 00 9c ff ff ff 00 ac 09 2b 04 88 ff ff 5f 5d 17 81 ff ff ff ff 11 00 00 00 00 00 00 00 <3d> 1c 00 00 00 00 00 00 01 00 00 00 00 00 00 00 80 11 00 00 00 
[  381.850821] RIP  [<ffff88042b957e40>] 0xffff88042b957e40
[  381.850821]  RSP <ffff88042b957e00>
[  381.850821] CR2: ffff88042b957e40
[  381.850824] ---[ end trace b4f9b4244a59d886 ]---
[  381.851025] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

...

[   49.003526] Restarting tasks ... 
[   49.007083] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[   49.007237] done.
[   49.022621] BUG: unable to handle kernel paging request at ffff88042b957e40
[   49.022624] IP: [<ffff88042b957e40>] 0xffff88042b957e40
[   49.022627] PGD 2065067 PUD 2068067 PMD 800000042b8001e3 
[   49.022629] Oops: 0011 [#1] PREEMPT SMP
[   49.022642] Modules linked in: binfmt_misc ipv6 vfat fat amd64_edac_mod edac_mce_amd fuse dm_crypt dm_mod kvm_amd kvm amdkfd irqbypass crc32_pclmul amd_iommu_v2 radeon aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd k10temp fam15h_power acpi_cpufreq
[   49.022645] CPU: 4 PID: 1 Comm: init Not tainted 4.7.0-rc3+ #2
[   49.022646] Hardware name: To be filled by O.E.M. To be filled by O.E.M./M5A97 EVO R2.0, BIOS 1503 01/16/2013
[   49.022648] task: ffff88042b958000 ti: ffff88042b954000 task.ti: ffff88042b954000
[   49.022650] RIP: 0010:[<ffff88042b957e40>]  [<ffff88042b957e40>] 0xffff88042b957e40
[   49.022652] RSP: 0018:ffff88042b957e00  EFLAGS: 00010282
[   49.022653] RAX: 0000000000000000 RBX: ffff88042b957f58 RCX: 0000000000000000
[   49.022654] RDX: 0000000000000001 RSI: ffffffff81062a2d RDI: ffffffff81687d8c
[   49.022655] RBP: ffff88042b957ef0 R08: 0000000000000000 R09: 0000000000000002
[   49.022657] R10: 00000000ffffffff R11: 0000000000000001 R12: ffff88042b954000
[   49.022658] R13: ffff88042b954000 R14: ffff88042b957f58 R15: ffff88042b958000
[   49.022660] FS:  00007fe2cd5dc800(0000) GS:ffff88043dd00000(0000) knlGS:0000000000000000
[   49.022661] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.022662] CR2: ffff88042b957e40 CR3: 0000000429edd000 CR4: 00000000000406e0
[   49.022663] Stack:
[   49.022666]  ffff88042aca7000 ffff88042aca7000 0000000000000000 ffffffff8117f8ae
[   49.022668]  ffffff9c00000002 ffff880429e6e000 ffffffff81175d5f 0000000000000011
[   49.022674]  0000000000001c49 0000000000000001 0000000000001180 0000000000000000
[   49.022675] Call Trace:
[   49.022680]  [<ffffffff8117f8ae>] ? getname_flags+0x5e/0x1b0
[   49.022683]  [<ffffffff81175d5f>] ? cp_new_stat+0x10f/0x120
[   49.022686]  [<ffffffff810b9eca>] ? ktime_get_ts64+0x4a/0xf0
[   49.022689]  [<ffffffff81183a57>] ? poll_select_copy_remaining+0xe7/0x130
[   49.022692]  [<ffffffff8100263a>] exit_to_usermode_loop+0x8a/0xb0
[   49.022695]  [<ffffffff81002a6b>] syscall_return_slowpath+0x5b/0x70
[   49.022698]  [<ffffffff81688272>] entry_SYSCALL_64_fastpath+0xa5/0xa7
[   49.022725] Code: 00 00 00 ae f8 17 81 ff ff ff ff 02 00 00 00 9c ff ff ff 00 e0 e6 29 04 88 ff ff 5f 5d 17 81 ff ff ff ff 11 00 00 00 00 00 00 00 <49> 1c 00 00 00 00 00 00 01 00 00 00 00 00 00 00 80 11 00 00 00 
[   49.022727] RIP  [<ffff88042b957e40>] 0xffff88042b957e40
[   49.022728]  RSP <ffff88042b957e00>
[   49.022729] CR2: ffff88042b957e40
[   49.022732] ---[ end trace 6694c76b6124dda9 ]---
[   49.022911] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[   49.022911] 
[   49.030807] Kernel Offset: disabled
[   49.348267] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

...

[   39.616661] PM: Basic memory bitmaps freed
[   39.621491] Restarting tasks ... 
[   39.624829] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[   39.624908] done.
[   39.636878] BUG: unable to handle kernel paging request at ffff88042b957e40
[   39.636880] IP: [<ffff88042b957e40>] 0xffff88042b957e40
[   39.636882] PGD 2065067 PUD 2068067 PMD 800000042b8001e3 
[   39.636883] Oops: 0011 [#1] PREEMPT SMP
[   39.636890] Modules linked in: binfmt_misc ipv6 vfat fat amd64_edac_mod edac_mce_amd fuse dm_crypt dm_mod kvm_amd kvm irqbypass crc32_pclmul amdkfd amd_iommu_v2 radeon aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd fam15h_power k10temp acpi_cpufreq
[   39.636892] CPU: 6 PID: 1 Comm: init Not tainted 4.7.0-rc4+ #1
[   39.636893] Hardware name: To be filled by O.E.M. To be filled by O.E.M./M5A97 EVO R2.0, BIOS 1503 01/16/2013
[   39.636894] task: ffff88042b958000 ti: ffff88042b954000 task.ti: ffff88042b954000
[   39.636895] RIP: 0010:[<ffff88042b957e40>]  [<ffff88042b957e40>] 0xffff88042b957e40
[   39.636895] RSP: 0018:ffff88042b957e00  EFLAGS: 00010282
[   39.636896] RAX: 0000000000000000 RBX: ffff88042b957f58 RCX: 0000000000000000
[   39.636897] RDX: 0000000000000001 RSI: ffffffff81062a2d RDI: ffffffff81687d8c
[   39.636897] RBP: ffff88042b957ef0 R08: 0000000000000000 R09: 0000000000000002
[   39.636898] R10: 00000000ffffffff R11: 0000000000000001 R12: ffff88042b954000
[   39.636898] R13: ffff88042b954000 R14: ffff88042b957f58 R15: ffff88042b958000
[   39.636899] FS:  00007f45944a4800(0000) GS:ffff88043dd80000(0000) knlGS:0000000000000000
[   39.636900] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.636900] CR2: ffff88042b957e40 CR3: 0000000429015000 CR4: 00000000000406e0
[   39.636901] Stack:
[   39.636902]  ffff8800b9ec5000 ffff8800b9ec5000 0000000000000000 ffffffff8117f8be
[   39.636903]  ffffff9c00000002 ffff88042ae8aa80 ffffffff81175d6f 0000000000000011
[   39.636904]  000000000000284c 0000000000000001 0000000000001180 0000000000000000
[   39.636905] Call Trace:
[   39.636908]  [<ffffffff8117f8be>] ? getname_flags+0x5e/0x1b0
[   39.636910]  [<ffffffff81175d6f>] ? cp_new_stat+0x10f/0x120
[   39.636912]  [<ffffffff810b9eaa>] ? ktime_get_ts64+0x4a/0xf0
[   39.636917]  [<ffffffff81183a67>] ? poll_select_copy_remaining+0xe7/0x130
[   39.636919]  [<ffffffff8100263a>] exit_to_usermode_loop+0x8a/0xb0
[   39.636921]  [<ffffffff81002a6b>] syscall_return_slowpath+0x5b/0x70
[   39.636922]  [<ffffffff81688272>] entry_SYSCALL_64_fastpath+0xa5/0xa7
[   39.636939] Code: 00 00 00 be f8 17 81 ff ff ff ff 02 00 00 00 9c ff ff ff 80 aa e8 2a 04 88 ff ff 6f 5d 17 81 ff ff ff ff 11 00 00 00 00 00 00 00 <4c> 28 00 00 00 00 00 00 01 00 00 00 00 00 00 00 80 11 00 00 00 
[   39.636939] RIP  [<ffff88042b957e40>] 0xffff88042b957e40
[   39.636940]  RSP <ffff88042b957e00>
[   39.636940] CR2: ffff88042b957e40
[   39.636943] ---[ end trace 7b732e7484eb8577 ]---
[   39.637066] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[   39.637066] 
[   39.644839] Kernel Offset: disabled
[   39.944295] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

...



-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
