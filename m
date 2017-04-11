From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/4] cpufreq: imx6q: Set max suspend_freq to avoid
 changes during suspend
Date: Tue, 11 Apr 2017 12:07:38 +0530
Message-ID: <20170411063738.GE3670@vireshk-i7>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
 <5f61b819733127ddc7d41e82bf703a355c845b49.1491324640.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5f61b819733127ddc7d41e82bf703a355c845b49.1491324640.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04-04-17, 20:04, Leonard Crestez wrote:
> If the cpufreq driver tries to modify voltage/freq during suspend/resume
> it might need to control an external PMIC via I2C or SPI but those
> devices might be already suspended. This issue is likely to happen
> whenever the LDOs have their vin-supply set.
> 
> To avoid this scenario we just increase cpufreq to the maximum before
> suspend.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

I have already Acked this earlier, why didn't you add it ?

-- 
viresh
