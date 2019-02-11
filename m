From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: Allow light-weight tear down on CPU offline operation
Date: Mon, 11 Feb 2019 11:56:37 +0100
Message-ID: <CAJZ5v0jKFaF5JRuwzR=d5Zc9p86m0eBDSmC-+d3LSKgyWuUpYg@mail.gmail.com>
References: <cover.1549874368.git.viresh.kumar@linaro.org> <03ac36a174f6c28be0b3af9d2db8631d56695f1d.1549874368.git.viresh.kumar@linaro.org>
 <CAJZ5v0hhxUQxf9VbhU_6B29MYspNo0Go+o4_OkxgnBe8+bGTdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hhxUQxf9VbhU_6B29MYspNo0Go+o4_OkxgnBe8+bGTdw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 11, 2019 at 11:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Feb 11, 2019 at 9:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The cpufreq core doesn't remove the cpufreq policy anymore on CPU
> > offline operation, rather that happens when the CPU device gets
> > unregistered from the kernel. This allows faster recovery when the CPU
> > comes back online. This is also very useful during system wide
> > suspend/resume where we offline all non-boot CPUs during suspend and
> > then bring them back on resume.
> >
> > This commit takes the same idea a step ahead to allow drivers to do
> > light weight tear-down during CPU offline operation.
> >
> > A new callback is introduced, light_weight_exit(), which gets called
> > when all the CPUs of a policy are removed/offlined and the existing
> > exit() callback gets called when the policy gets freed.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---

[cut]

> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 9db074ecbbd7..36ce31516041 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -325,6 +325,7 @@ struct cpufreq_driver {
> >         /* optional */
> >         int             (*bios_limit)(int cpu, unsigned int *limit);
> >
> > +       int             (*light_weight_exit)(struct cpufreq_policy *policy);
>
> Can you call it "offline"?
>
> >         int             (*exit)(struct cpufreq_policy *policy);
> >         void            (*stop_cpu)(struct cpufreq_policy *policy);
> >         int             (*suspend)(struct cpufreq_policy *policy);
> > --

Also, I would prefer a corresponding "online" callback to be there too
for symmetry and I'd prefer the core to decide to call "online"
instead of "init" for the light-weight case instead of ->init() itself
having to figure out the context.
