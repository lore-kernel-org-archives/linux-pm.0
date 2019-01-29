From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Date: Tue, 29 Jan 2019 09:52:15 -0800
Message-ID: <20190129175215.GK81583@google.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-2-quentin.perret@arm.com>
 <20190128190251.GH81583@google.com>
 <20190129090331.fgygq3dsaoqvegsl@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129090331.fgygq3dsaoqvegsl@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

Hi Quentin,

On Tue, Jan 29, 2019 at 09:03:34AM +0000, Quentin Perret wrote:
> Hi Matthias,
> 
> On Monday 28 Jan 2019 at 11:02:51 (-0800), Matthias Kaehlcke wrote:
> > > +/**
> > > + * of_dev_pm_opp_get_cpu_power() - Estimates the power of a CPU
> > > + * @mW:		pointer to the power estimate in milli-watts
> > > + * @KHz:	pointer to the OPP's frequency, in kilo-hertz
> > 
> > nit: should be kHz
> 
> Right, I can change that :-)
> 
> > 
> > > + * @cpu:	CPU for which power needs to be estimated
> > > + *
> > > + * Computes the power estimated by @CPU at the first OPP above @KHz (ceil),
> > > + * and updates @KHz and @mW accordingly.
> > > + *
> > > + * The power is estimated as P = C * V^2 * f, with C the CPU's capacitance
> > > + * (read from the 'dynamic-power-coefficient' devicetree binding) and V and f
> > > + * respectively the voltage and frequency of the OPP.
> > > + *
> > > + * Return: -ENODEV if the CPU device cannot be found, -EINVAL if the power
> > > + * calculation failed because of missing parameters, 0 otherwise.
> > > + */
> > > +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> > 
> > I think it is more common to put the input parameters first, then the
> > output ones, i.e. cpu, kHz, mW.
> 
> Hmm, the issue is this must match the expectations of the EM framework:
> 
> https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L62
> 
> So, I don't really have a choice. Or we can change the core code if this
> _really_ is a problem -- we don't have users yet so now is the best time
> to do so I guess ...

I see.

I think it would be preferable to follow the common scheme, but it's
also not a major issue, up to you whether you want to change the
definition of the callback. It's certainly true that now would be the
best time for a change.

Cheers

Matthias
