From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 3/5] cpufreq: imx6q: Set max suspend_freq to avoid
 changes during suspend
Date: Tue, 4 Apr 2017 20:04:55 +0300
Message-ID: <1491325495.27463.7.camel@nxp.com>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
         <94d99b261124b813adecf11e86a0ffe05c37f276.1490987945.git.leonard.crestez@nxp.com>
         <1491299500.2367.16.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491299500.2367.16.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2017-04-04 at 11:51 +0200, Lucas Stach wrote:
> Am Freitag, den 31.03.2017, 22:25 +0300 schrieb Leonard Crestez:
> > 
> > If the cpufreq driver tries to modify voltage/freq during suspend/resume
> > it might need to control an external PMIC via I2C or SPI but those
> > devices might be already suspended.
> > 
> > To avoid this scenario we just increase cpufreq to highest setpoint
> > before suspend. This issue can easily be triggered by ldo-bypass but in
> > theory any regulator set_voltage call can end up having to modify
> > external supply voltages.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/imx6q-cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> > index be90ee3..e2c1fbf 100644
> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> > @@ -162,6 +162,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
> >  static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
> >  {
> >  	policy->clk = arm_clk;
> > +	policy->suspend_freq = freq_table[soc_opp_count - 1].frequency;
> I think soc_opp_count includes all OPPs from the DT, some of which might
> be disabled based on the fuse settings of the SoC. So this should
> probably not switch to the highest OPP unconditionally, but rather
> switch to the highest _enabled_ OPP.

You're right, this does not appear to be correct. Looking at
soc_opp_count it should probably be a local variable in the code
initializing imx6_soc_volt. And the imx6_soc_volt array itself could
now be replaced with opp's support for multiple supply voltages.

I'll post v2.
