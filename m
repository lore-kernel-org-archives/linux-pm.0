From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 1/5] ACPI: Introduce CPU performance controls using CPPC
Date: Fri, 02 Oct 2015 00:02:05 +0200
Message-ID: <2003142.IBZn391liD@vostro.rjw.lan>
References: <cover.1441830300.git.ashwin.chaugule@linaro.org> <14309818.LXTR0vLlii@vostro.rjw.lan> <CAJ5Y-eYZxR4Sk27bhnBytamBi=aDp0475GC0oU-hNn=ZQ-iDUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJ5Y-eYZxR4Sk27bhnBytamBi=aDp0475GC0oU-hNn=ZQ-iDUg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, October 01, 2015 06:20:50 AM Ashwin Chaugule wrote:
> Hi Rafael,
> 
> On 28 September 2015 at 09:36, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Sunday, September 27, 2015 01:15:20 PM Ashwin Chaugule wrote:
> >> On 25 September 2015 at 20:05, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Wednesday, September 09, 2015 04:27:04 PM Ashwin Chaugule wrote:
> >> >> +int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
> >> >> +{
> >> >> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> >> >> +     struct cpc_register_resource *delivered_reg, *reference_reg;
> >> >> +     u64 delivered, reference;
> >> >> +     int ret = 0;
> >> >> +
> >> >> +     if (!cpc_desc) {
> >> >> +             pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> >> >> +             return -ENODEV;
> >> >> +     }
> >> >> +
> >> >> +     delivered_reg = &cpc_desc->cpc_regs[DELIVERED_CTR];
> >> >> +     reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
> >> >> +
> >> >> +     spin_lock(&pcc_lock);
> >> >
> >> > I still have the question about this lock.
> >> >
> >> > Why does it have to be a spinlock?
> >>
> >> The idea is to let CPUs send in their requests as quickly as possible.
> >> The PCC transaction only relays the request. So the CPUs don't really
> >> wait for all the clk + voltage toggling etc. I think any other
> >> primitive, might cause unnecessary delays in sending requests.
> >
> > It might if there was contention.
> >
> >> Also FWIW, this is another thing I was influenced by from the pcc-cpufreq.c
> >> driver. :)
> >
> > OK, so this sounds like an optimization, which is fine.
> >
> 
> Great. Would you prefer a git pull request

No pull requests, please.

> with the kernel doc + compiler warning fix, or should I send V10 ?

You can simply update the patches that need to be updated.

Thanks,
Rafael

