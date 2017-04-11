From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v2 2/4] cpufreq: imx6q: Set max suspend_freq to avoid
 changes during suspend
Date: Tue, 11 Apr 2017 11:16:23 +0300
Message-ID: <1491898583.26722.2.camel@nxp.com>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
 <5f61b819733127ddc7d41e82bf703a355c845b49.1491324640.git.leonard.crestez@nxp.com>
 <20170411063738.GE3670@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170411063738.GE3670@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Lucas Stach <l.stach@pengutronix.de>
Cc: Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2017-04-11 at 12:07 +0530, Viresh Kumar wrote:
> On 04-04-17, 20:04, Leonard Crestez wrote:
> > If the cpufreq driver tries to modify voltage/freq during suspend/resume
> > it might need to control an external PMIC via I2C or SPI but those
> > devices might be already suspended. This issue is likely to happen
> > whenever the LDOs have their vin-supply set.
> > 
> > To avoid this scenario we just increase cpufreq to the maximum before
> > suspend.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > ---
> >  drivers/cpufreq/imx6q-cpufreq.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)

> I have already Acked this earlier, why didn't you add it ?

Because v2 is different based on comments from Lucas. It didn't seem
appropriate to keep an old "Acked-by" in this case.
