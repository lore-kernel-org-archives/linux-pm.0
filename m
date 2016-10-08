From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH 2/4][RFC v2] PM / sleep: Introduce arch-specific hook for
 disable/enable nonboot cpus
Date: Sun, 9 Oct 2016 00:58:43 +0800
Message-ID: <20161008165843.GB24225@sharon>
References: <cover.1466844557.git.yu.c.chen@intel.com>
 <fb78859e5c1ea061ce4e35e200821ed170e6658d.1466844557.git.yu.c.chen@intel.com>
 <8f0aeb0a-5e72-8327-2406-a78ad783f6f2@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8f0aeb0a-5e72-8327-2406-a78ad783f6f2@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Andy,
On Fri, Oct 07, 2016 at 12:31:41PM -0700, Andy Lutomirski wrote:
> On 06/25/2016 09:18 AM, Chen Yu wrote:
> >There is requirement that we need to do some arch-specific
> >operations before putting the nonboot CPUs offline/online.
> >One of the requirements comes from the hibernation resume
> >process on x86_64, we need to kick all the offlin-CPUs
> >online and offline again, in order to put them in a safe
> >state, thus to avoid possible unwilling wake up during
> >hibernation resume.
> >
> >Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> >---
> > kernel/cpu.c | 12 ++++++++++++
> > 1 file changed, 12 insertions(+)
> >
> >diff --git a/kernel/cpu.c b/kernel/cpu.c
> >index d25266e..ce6e5e4 100644
> >--- a/kernel/cpu.c
> >+++ b/kernel/cpu.c
> >@@ -1017,6 +1017,16 @@ EXPORT_SYMBOL_GPL(cpu_up);
> > #ifdef CONFIG_PM_SLEEP_SMP
> > static cpumask_var_t frozen_cpus;
> >
> >+void __weak arch_disable_nonboot_cpus_pre(void)
> 
> I don't like using __weak.  It penalizes code size on architectures that
> don't hook these functions.  My preferred pattern is:
> 
> include/linux/something.h:
> 
> #include <asm/something.h>
> 
> #ifndef arch_do_xyz
> static inline void arch_do_xyz() {}
> #endif
> 
> arch/whatever/asm/something.h:
> 
> extern void arch_do_xyz();  /* or static inline... */
> #define arch_do_xyz
> 
> 
> This is totally free for architectures that don't have the hooks and it can
> potentially be inlined on architectures that do have the hooks. Everyone
> wins except that it's about five additional lines of code.
> 
Thanks for your guidance, this patch was deprecated previously, but I'll
take your advice the next time when writing similar patch.  
> --Andy
Thanks,
Yu
