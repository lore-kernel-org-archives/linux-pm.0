From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH][RFC v3] x86, hotplug: Use hlt instead of mwait if invoked
 from disable_nonboot_cpus
Date: Thu, 07 Jul 2016 09:38:14 +0100
Message-ID: <577E14F6.6060706@arm.com>
References: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com> <209704957.TWElLMTLfP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <209704957.TWElLMTLfP@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 07/07/16 01:33, Rafael J. Wysocki wrote:
> Below is my sort of version of this (untested) and I did it this way, because
> the issue is specific to resume from hibernation (the workaround need not be
> applied anywhere else) and the hibernate_resume_nonboot_cpu_disable() thing may
> be useful to arm64 too if I'm not mistaken (James?).

Yes, we will always need to do something extra (based on data in the
arch_hibernation_header) to resume if CPU0 was offline, or kexec meant we no
longer know which CPU the firmware will boot us on.


> Actually, if arm64 uses it too, the __weak implementation can be dropped,
> because it will be possible to make it depend on ARCH_HIBERNATION_HEADER
> (x86 and arm64 are the only users of that).

Heh, I avoided that as it felt too much like a hack!



Thanks,

James
