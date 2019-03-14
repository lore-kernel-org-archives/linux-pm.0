From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/7] x86/tsc: Update cpufreq transition notifier to
 handle multiple CPUs
Date: Thu, 14 Mar 2019 15:33:58 +0530
Message-ID: <20190314100358.tpkianohhoxnfsmu@vireshk-i7>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
 <8a27342332bc467242f6ccdb4d4bd4d10f8aa552.1552545525.git.viresh.kumar@linaro.org>
 <CAJZ5v0i=QoToW0WCaL50t0qe5sKSe6J3W+EnFTvYuVCp6MvZDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i=QoToW0WCaL50t0qe5sKSe6J3W+EnFTvYuVCp6MvZDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 14-03-19, 10:33, Rafael J. Wysocki wrote:
> On Thu, Mar 14, 2019 at 7:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > -               set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > +               if (boot_cpu) {
> > +                       boot_cpu_data.loops_per_jiffy = lpj;
> > +               } else {
> > +                       for_each_cpu(cpu, freq->cpus)
> 
> This needs to iterate over policy->cpus or you change the behavior.
> 
> Not that it will matter a lot (x86 in one CPU per policy anyway in the
> vast majority of cases), but it is a change nevertheless.  Moreover,
> I'm not even sure if doing that for offline CPUs makes sense.

Okay.

-- 
viresh
