From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v7 2/8] arm: parse cpu capacity-dmips-mhz from DT
Date: Mon, 12 Sep 2016 09:55:39 +0100
Message-ID: <20160912085539.GM10409@e106622-lin>
References: <1473085372-2840-1-git-send-email-juri.lelli@arm.com>
 <1473085372-2840-3-git-send-email-juri.lelli@arm.com>
 <CAKfTPtDEmAwLR58hOFeAVgfKaSVCQaLrr3VyH_QMkcuty5YiKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtDEmAwLR58hOFeAVgfKaSVCQaLrr3VyH_QMkcuty5YiKQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 12/09/16 10:36, Vincent Guittot wrote:
> Hi Juri,
> 
> On 5 September 2016 at 16:22, Juri Lelli <juri.lelli@arm.com> wrote:
> > With the introduction of cpu capacity-dmips-mhz bindings, CPU capacities
> > can now be calculated from values extracted from DT and information
> > coming from cpufreq. Add parsing of DT information at boot time, and
> > complement it with cpufreq information. We keep code that can produce
> > same information, based on different DT properties and hard-coded
> > values, as fall-back for backward compatibility.
> >
> > Caveat: the information provided by this patch will start to be used in
> > the future. We need to #define arch_scale_cpu_capacity to something
> > provided in arch, so that scheduler's default implementation (which gets
> > used if arch_scale_cpu_capacity is not defined) is overwritten.
> >
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> 
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> 

Thanks!

Best,

- Juri
