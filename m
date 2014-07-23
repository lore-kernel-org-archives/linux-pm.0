From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 2/7] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Wed, 23 Jul 2014 18:32:04 +0100
Message-ID: <20140723173204.GB21746@e102568-lin.cambridge.arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1405958786-17243-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAJ5Y-eY9YACzk_8LpZ9mnaj4stqOF_uWWt1+tL7nexqZj-ZFyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJ5Y-eY9YACzk_8LpZ9mnaj4stqOF_uWWt1+tL7nexqZj-ZFyQ@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Devicetree List <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Rob Herring <robh+dt@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit>
List-Id: linux-pm@vger.kernel.org

Hi Ashwin,

On Wed, Jul 23, 2014 at 05:34:16PM +0100, Ashwin Chaugule wrote:
> Hi Lorenzo,
> 
> On 21 July 2014 12:06, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > +/**
> > + * dt_init_idle_driver() - Parse the DT idle states and initialize the
> > + *                        idle driver states array
> > + *
> > + * @drv:         Pointer to CPU idle driver to be initialized
> > + * @start_idx:    First idle state index to be initialized
> > + *
> > + * On success the states array in the cpuidle driver contains
> > + * initialized entries in the states array, starting from index start_idx.
> > + *
> > + * Return:
> > + *     0 on success
> > + *     <0 on failure
> > + */
> > +int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int start_idx)
> > +{
> > +       unsigned int i, state_idx = start_idx;
> > +       struct cpuidle_state *idle_state;
> > +       struct device_node *state_node, *cpu_node;
> > +
> > +
> > +       if (state_idx >= CPUIDLE_STATE_MAX)
> > +               return -EINVAL;
> > +       /*
> > +        * We get the idle states for the first logical cpu in the
> > +        * driver mask. The kernel does not check idle states on all
> > +        * cpus in the driver mask, they are assumed to be the same
> > +        * by default.
> > +        */
> > +       cpu_node = of_cpu_device_node_get(cpumask_first(drv->cpumask));
> 
> Is this an assumption for the short term? My understanding from the
> corresponding ACPI discussions is that the order of idle states may
> not necessarily be same for all CPUs, even for big.Little?

Well, it is more of a problem of the CPUidle infrastructure than related
to this specific patchset. The idle states for a specific cpumask (ie CPUidle
driver) are expected to be all the same, same order same data.

Current driver can be used on homegeneous ARM64 SMP systems, but I am fairly
confident we can extend it for big.LITTLE and also other funky SMP
configurations, the parsing code only expects all cpus in the mask
to have the same set of idle states (and so does the CPUidle core), if that's
not the case, the cpus belong in different CPUidle drivers (ie a CPUidle
driver is a set of states valid on a cpumask).

So my answer is yes, it is a proper assumption and not only for the
short term, but in general.

HTH,
Lorenzo
