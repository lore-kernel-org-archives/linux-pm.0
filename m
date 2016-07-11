From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86: fix rdmsr MSR_PLATFORM_INFO unsafe warning in kvm
 guest
Date: Mon, 11 Jul 2016 09:38:37 +0200
Message-ID: <20160711073837.GA25250@gmail.com>
References: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com>
 <CANRm+CzKhfyUFGDUJcVYryv3=ORPQ4AG4jbY2eP7NvkLK=Wg2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANRm+CzKhfyUFGDUJcVYryv3=ORPQ4AG4jbY2eP7NvkLK=Wg2g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, lkp@01.org, the arch/x86 maintainers <x86@kernel.org>, Wanpeng Li <wanpeng.li@hotmail.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jacob Pan <jacob.jun.pan@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org


* Wanpeng Li <kernellwp@gmail.com> wrote:

> Hi Ingo, Thomas,
> 2016-06-22 9:28 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> > From: Wanpeng Li <wanpeng.li@hotmail.com>
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at arch/x86/mm/extable.c:50 ex_handler_rdmsr_unsafe+0x6a/0x70
> > unchecked MSR access error: RDMSR from 0xce
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.7.0-rc3+ #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> >  0000000000000000 ffffffff81c03ce0 ffffffff813b3eae ffffffff81c03d30
> >  0000000000000000 ffffffff81c03d20 ffffffff81067181 0000003200000001
> >  ffffffff81c03df8 ffffffff8179676c 0000000000000000 ffffffff81fcd2c0
> > Call Trace:
> >  dump_stack+0x67/0x99
> >  __warn+0xd1/0xf0
> >  warn_slowpath_fmt+0x4f/0x60
> >  ex_handler_rdmsr_unsafe+0x6a/0x70
> >  fixup_exception+0x39/0x50
> >  do_general_protection+0x93/0x1b0
> >  general_protection+0x22/0x30
> >  ? cpu_khz_from_msr+0xd8/0x1c0
> >  native_calibrate_cpu+0x30/0x5b0
> >  tsc_init+0x2b/0x297
> >  x86_late_time_init+0xf/0x11
> >  start_kernel+0x398/0x451
> >  ? set_init_arg+0x55/0x55
> >  x86_64_start_reservations+0x2f/0x31
> >  x86_64_start_kernel+0xea/0xed
> >
> > After commit (fc141535ad8 : "x86 tsc_msr: Extend to include Intel Core
> > Architecture"), rdmsr MSR_PLATFORM_INFO is used to get maximum non-turbo
> 
> I just saw commit (fc273eeef314c : "x86 tsc_msr: Extend to include
> Intel Core Architecture") was merged in tip tree, then this patch is
> needed to fix that commit. The bug is reported by LKP several weeks
> ago, and kvm maintainer Paolo has already replied "This looks good" to
> this patch.

Applied, thanks!

	Ingo
