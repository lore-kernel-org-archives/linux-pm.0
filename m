From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: Add imx-cpufreq-dt driver
Date: Thu, 25 Apr 2019 16:02:34 +0530
Message-ID: <20190425103234.4u6dsh4jxhifiux7@vireshk-i7>
References: <83a3ade389239bd492ee646aa4868c5e37e65434.1556187603.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <83a3ade389239bd492ee646aa4868c5e37e65434.1556187603.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On 25-04-19, 10:29, Leonard Crestez wrote:
> Right now in upstream imx8m cpufreq support just lists a common subset
> of OPPs because the higher ones should only be attempted after checking
> speed grading in fuses.
> 
> This is not a reasonable limitation and means we must still carry a
> separate cpufreq driver in NXP tree.
> 
> This is a small driver which checks speed grading from nvmem before
> registering cpufreq-dt. Unlike imx6q-cpufreq and various other rejected
> imx7/8 cpufreq drivers it contains no actual frequency switching code,
> just fuse reading through nvmem API.
> 
> Code is inspired by similar cpufreq wrappers from a dozen different
> vendors. Currently for imx8mm but same issue applies to imx8mq and
> others.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
>  drivers/cpufreq/Kconfig.arm          |   5 ++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>  drivers/cpufreq/imx-cpufreq-dt.c     | 101 +++++++++++++++++++++++++++
>  4 files changed, 109 insertions(+)
>  create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c
> 
> Since nvmem is a module this driver also needs to be turned into a
> proper module, right now it will simply fail if nvmem is unavailable at
> init time. Let me know if you agree with this approach before I turn it
> into a module.
> 
> In vendor tree this is done in soc driver but many other vendors do it
> in drivers/cpufreq so this is where it belongs.
> 
> This is select by default in Kconfig, if anything fails then regular
> cpufreq-dt is not available. This is intentional because higher OPPs are
> potentially unstable.

No objections on this stuff from me. This is how we are doing it for
everyone using cpufreq-dt.

-- 
viresh
