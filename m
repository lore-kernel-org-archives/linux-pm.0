From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/9] cpufreq: Auto-register the driver as a thermal cooling device if asked
Date: Mon, 28 Jan 2019 13:03:20 +0100
Message-ID: <12294707.IXbBkGfcfl@aspire.rjw.lan>
References: <cover.1548654899.git.amit.kucheria@linaro.org> <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org> <3afd5b04-5caf-053d-48c9-f719eec58da0@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3afd5b04-5caf-053d-48c9-f719eec58da0@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Tao Wang <kevin.wangtao@hisilicon.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 28, 2019 9:32:44 AM CET Daniel Lezcano wrote:
> On 28/01/2019 07:41, Amit Kucheria wrote:
> > All cpufreq drivers do similar things to register as a cooling device.
> > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > to register the cooling device on their behalf. This allows us to get
> > rid of duplicated code in the drivers.
> > 
> > In order to allow this, we add a struct thermal_cooling_device pointer
> > to struct cpufreq_policy so that drivers don't need to store it in a
> > private data structure.
> > 
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> 
> [ ... ]
> 
> > +/*
> > + * Set by drivers that want the core to automatically register the cpufreq
> > + * driver as a thermal cooling device.
> > + */
> > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
> > +
> 
> Isn't the CPUFREQ_IS_COOLING_DEV more appropriate? We define a property
> of the cpufreq driver and the resulting action is to auto-register, no?

Yes.

Cheers,
Rafael
