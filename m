From: Borislav Petkov <bp@alien8.de>
Subject: Re: ktime_get_ts64() splat during resume
Date: Fri, 17 Jun 2016 16:33:46 +0200
Message-ID: <20160617143346.GA3912@pd.tnic>
References: <20160617105435.GB15997@pd.tnic>
 <alpine.DEB.2.11.1606171351390.5839@nanos>
 <20160617132943.GA3336@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:43691 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbcFQOdt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jun 2016 10:33:49 -0400
Content-Disposition: inline
In-Reply-To: <20160617132943.GA3336@nazgul.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Logan Gunthorpe <logang@deltatee.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kees Cook <keescook@chromium.org>, stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>

Ok,

bisect is done, full log below.

Rafael, that fix

  70595b479ce1 ("x86/power/64: Fix crash whan the hibernation code passes control to the image kernel")

breaks s2disk here. It explodes during resume and a statically allocated
struct's member is NULL. See

https://lkml.kernel.org/r/20160617105435.GB15997@pd.tnic

for the splat and some debugging attempts.

Reverting 70595b479ce1 fixes the issue here.

@stable folk: You might want to hold off on picking up that one yet...


Now, I have serial connected to that box so if you want me to dump stuff
and try patches, let me know.

Btw, while I have your ear, can you pick up my einj fixes please?

:-)

-> https://lkml.kernel.org/r/1463992084-10012-1-git-send-email-bp@alien8.de

Thanks!

git bisect start
# bad: [f0e52976a6fad5aa2c8868d5fa91deee91299ebb] Merge remote-tracking branch 'tip/master' into tip-timers-splat
git bisect bad f0e52976a6fad5aa2c8868d5fa91deee91299ebb
# good: [bb967271c0317de8eed56b20aae978d31507b033] Merge tag 'pwm/for-4.7-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm
git bisect good bb967271c0317de8eed56b20aae978d31507b033
# good: [bb41dcd3fd81971ce17f7c0e5020d343d905358f] Merge branch 'sched/core'
git bisect good bb41dcd3fd81971ce17f7c0e5020d343d905358f
# bad: [457642d3e6e1f7412c8174dbaeb06232618b2698] Merge branch 'x86/mm'
git bisect bad 457642d3e6e1f7412c8174dbaeb06232618b2698
# bad: [d818e3414b9def094a93ce57caad9cb75ecb2a17] Merge branch 'x86/boot'
git bisect bad d818e3414b9def094a93ce57caad9cb75ecb2a17
# good: [02e8fda2cc00419a11cf38199afea4c0d7172be8] x86/signals: Add build-time checks to the siginfo compat code
git bisect good 02e8fda2cc00419a11cf38199afea4c0d7172be8
# good: [c702ff2fc395d8d9949eef8f72fd8726943c5aa1] Merge branch 'timers/core'
git bisect good c702ff2fc395d8d9949eef8f72fd8726943c5aa1
# good: [0ef1f6adccfea59c600edca7632ff0834ddfee5b] Merge branch 'x86/asm'
git bisect good 0ef1f6adccfea59c600edca7632ff0834ddfee5b
# bad: [70595b479ce173425dd5cb347dc6c8b1060dfb2c] x86/power/64: Fix crash whan the hibernation code passes control to the image kernel
git bisect bad 70595b479ce173425dd5cb347dc6c8b1060dfb2c
# good: [8d950d2fb23b696d393020486ab6a350bcb2c582] MAINTAINERS: Update the Calgary IOMMU entry
git bisect good 8d950d2fb23b696d393020486ab6a350bcb2c582
# first bad commit: [70595b479ce173425dd5cb347dc6c8b1060dfb2c] x86/power/64: Fix crash whan the hibernation code passes control to the image kernel

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
