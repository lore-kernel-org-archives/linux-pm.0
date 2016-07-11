From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH] x86: fix rdmsr MSR_PLATFORM_INFO unsafe warning in kvm guest
Date: Mon, 11 Jul 2016 10:38:32 +0800
Message-ID: <CANRm+CzKhfyUFGDUJcVYryv3=ORPQ4AG4jbY2eP7NvkLK=Wg2g@mail.gmail.com>
References: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com>
Sender: kvm-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, lkp@01.org, the arch/x86 maintainers <x86@kernel.org>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jacob Pan <jacob.jun.pan@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

Hi Ingo, Thomas,
2016-06-22 9:28 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> From: Wanpeng Li <wanpeng.li@hotmail.com>
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at arch/x86/mm/extable.c:50 ex_handler_rdmsr_u=
nsafe+0x6a/0x70
> unchecked MSR access error: RDMSR from 0xce
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.7.0-rc3+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/=
01/2011
>  0000000000000000 ffffffff81c03ce0 ffffffff813b3eae ffffffff81c03d30
>  0000000000000000 ffffffff81c03d20 ffffffff81067181 0000003200000001
>  ffffffff81c03df8 ffffffff8179676c 0000000000000000 ffffffff81fcd2c0
> Call Trace:
>  dump_stack+0x67/0x99
>  __warn+0xd1/0xf0
>  warn_slowpath_fmt+0x4f/0x60
>  ex_handler_rdmsr_unsafe+0x6a/0x70
>  fixup_exception+0x39/0x50
>  do_general_protection+0x93/0x1b0
>  general_protection+0x22/0x30
>  ? cpu_khz_from_msr+0xd8/0x1c0
>  native_calibrate_cpu+0x30/0x5b0
>  tsc_init+0x2b/0x297
>  x86_late_time_init+0xf/0x11
>  start_kernel+0x398/0x451
>  ? set_init_arg+0x55/0x55
>  x86_64_start_reservations+0x2f/0x31
>  x86_64_start_kernel+0xea/0xed
>
> After commit (fc141535ad8 : "x86 tsc_msr: Extend to include Intel Cor=
e
> Architecture"), rdmsr MSR_PLATFORM_INFO is used to get maximum non-tu=
rbo

I just saw commit (fc273eeef314c : "x86 tsc_msr: Extend to include
Intel Core Architecture") was merged in tip tree, then this patch is
needed to fix that commit. The bug is reported by LKP several weeks
ago, and kvm maintainer Paolo has already replied "This looks good" to
this patch.

Regards,
Wanpeng Li

> ratio for recent Intel Core Architecture which results in kvm guest r=
dmsr
> unsafe warning.
>
> As Radim pointed out before:
>
> | MSR_PLATFORM_INFO: Intel changes it from family to family and there=
 is
> | no obvious overlap or default.  If we picked 0 (any other fixed val=
ue),
> | then the guest would have to know that 0 doesn't mean that
> | MSR_PLATFORM_INFO returned 0, but that KVM doesn't emulate this MSR=
 and
> | the value cannot be used.  This is very similar to handling a #GP i=
n the
> | guest, but also has a disadvantage, because KVM cannot say that
> | MSR_PLATFORM_INFO is 0.  Simple emulation is not possible.
>
> This patch fix it by using rdmsr_safe to read MSR_PLATFORM_INFO in kv=
m
> guest in order that #GP can be fixed up, then tsc will be calibrated =
by
> PIT, HPET etc.
>
> Reported-by: kernel test robot <xiaolong.ye@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: jacob.jun.pan@intel.com
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
> ---
>  arch/x86/kernel/tsc_msr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
> index e0c2b30..e6e465e 100644
> --- a/arch/x86/kernel/tsc_msr.c
> +++ b/arch/x86/kernel/tsc_msr.c
> @@ -70,7 +70,7 @@ static int match_cpu(u8 family, u8 model)
>   */
>  unsigned long cpu_khz_from_msr(void)
>  {
> -       u32 lo, hi, ratio, freq_id, freq;
> +       u32 lo, hi, freq_id, freq, ratio =3D 0;
>         unsigned long res;
>         int cpu_index;
>
> @@ -123,8 +123,8 @@ unsigned long cpu_khz_from_msr(void)
>         }
>
>  get_ratio:
> -       rdmsr(MSR_PLATFORM_INFO, lo, hi);
> -       ratio =3D (lo >> 8) & 0xff;
> +       if (!rdmsr_safe(MSR_PLATFORM_INFO, &lo, &hi))
> +               ratio =3D (lo >> 8) & 0xff;
>
>  done:
>         /* TSC frequency =3D maximum resolved freq * maximum resolved=
 bus ratio */
> --
> 1.9.1
>
