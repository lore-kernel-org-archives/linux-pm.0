From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] Revert "cpufreq: intel_pstate: Fix ->set_policy()
 interface for no_turbo"
Date: Mon, 06 Aug 2018 09:49:29 -0700
Message-ID: <cd2287153b369d88cc240068adc7d341ef675acf.camel@linux.intel.com>
References: <20180804152932.3861-1-gabriele.mzt@gmail.com>
         <ccf46de4-d75e-306b-9554-9d33f68d2379@gmail.com>
         <CAJZ5v0iwhVu6PwztsbN8cYmQtnjD2SyFkazkObc1o-1JX6GO5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iwhVu6PwztsbN8cYmQtnjD2SyFkazkObc1o-1JX6GO5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-08-06 at 10:30 +0200, Rafael J. Wysocki wrote:
> On Sat, Aug 4, 2018 at 7:31 PM, Gabriele Mazzotta
> <gabriele.mzt@gmail.com> wrote:
> > On 04/08/2018 17:29, Gabriele Mazzotta wrote:
> > > This change does not take into account that some BIOSes change
> > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE depending on the power source.
> > > If the turbo is disabled when the system boots, policy.max_freq
> > > is set to pstate.max_pstate. However, if the BIOS later enables
> > > the turbo, the CPU will never be able to run at
> > > pstate.turbo_pstate.
> > > 
> > > Since now intel_pstate_set_policy() does its calculations using
> > > pstate.max_freq and pstate.turbo_freq, we can always calculate
> > > cpuinfo.max_freq using pstate.turbo_pstate, thus allowing system
> > > with varying MSR_IA32_MISC_ENABLE_TURBO_DISABLE to run at full
> > > speed when the turbo is enabled.
> 
> Well, the problem with this approach is that always using
> pstate.turbo_pstate as the max causes the governor to overestimate
> the
> target frequency when the turbo range is not available (the target
> depends on the width of the entire available P-state range including
> turbo, so if the turbo range is not available, the number take into
> that computation is too large).
> 
> Are we expected to get notified when the BIOS updates
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE?

Let's try this:
- boot with kernel command line 

intel_pstate=support_acpi_ppc dyndbg="file processor_perflib.c +p"
dyndbg="file intel_pstate.c +p"

and send dmesg after you change power sources.

- Also try with
intel_pstate=disable dyndbg="file processor_perflib.c +p"

and send dmesg.

Thanks,
Srinivas
