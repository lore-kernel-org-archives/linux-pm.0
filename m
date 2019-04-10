From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] OPP: Add support for parsing the interconnect
 bandwidth
Date: Wed, 10 Apr 2019 09:23:56 +0530
Message-ID: <20190410035356.up3qxkc6az5lpjyt@vireshk-i7>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-3-georgi.djakov@linaro.org>
 <20190314063047.urmzez52bdyrkdsu@vireshk-i7>
 <0cb2d777-4d05-2b06-e458-755d171b3436@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0cb2d777-4d05-2b06-e458-755d171b3436@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, sibis@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09-04-19, 17:37, Georgi Djakov wrote:
> Hi Viresh,
> 
> On 3/14/19 08:30, Viresh Kumar wrote:
> > On 13-03-19, 11:00, Georgi Djakov wrote:
> >> The OPP bindings now support bandwidth values, so add support to parse it
> >> from device tree and store it into the new dev_pm_opp_icc_bw struct, which
> >> is part of the dev_pm_opp.
> >>
> >> Also add and export the dev_pm_opp_set_path() and dev_pm_opp_put_path()
> >> helpers, to set (and release) an interconnect path to a device. The
> >> bandwidth of this path will be updated when the OPPs are switched.
> >>
> >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> ---
> >>  drivers/opp/core.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/opp/of.c       | 44 +++++++++++++++++++++++++++
> >>  drivers/opp/opp.h      |  6 ++++
> >>  include/linux/pm_opp.h | 14 +++++++++
> >>  4 files changed, 131 insertions(+)
> >>
> >> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> >> index e06a0ab05ad6..4b019cecaa07 100644
> >> --- a/drivers/opp/core.c
> >> +++ b/drivers/opp/core.c
> >> @@ -19,6 +19,7 @@
> >>  #include <linux/slab.h>
> >>  #include <linux/device.h>
> >>  #include <linux/export.h>
> >> +#include <linux/interconnect.h>
> >>  #include <linux/pm_domain.h>
> >>  #include <linux/regulator/consumer.h>
> >>  
> >> @@ -1645,6 +1646,72 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
> >>  }
> >>  EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
> >>  
> >> +/**
> >> + * dev_pm_opp_set_path() - Set interconnect path for a device
> >> + * @dev: Device for which interconnect path is being set.
> >> + * @name: Interconnect path name or NULL.
> >> + *
> >> + * This must be called before any OPPs are initialized for the device.
> >> + */
> >> +struct opp_table *dev_pm_opp_set_path(struct device *dev, const char *name)
> > 
> > Maybe the OPP core can do it itself in a similar way to how we do
> > clk_get() today ?

It took me a decade to understand my own comment ;)

> Do you mean to directly call of_icc_get() in _allocate_opp_table()?

I believe I wanted to say s/clk_get()/clk_set_rate()/ . i.e. if someone calls
set-opp-rate, then the path should get set as well accordingly automagically.

-- 
viresh
