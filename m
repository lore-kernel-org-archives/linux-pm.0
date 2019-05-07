From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/3] cpufreq: Add imx-cpufreq-dt driver
Date: Tue, 7 May 2019 11:05:55 +0530
Message-ID: <20190507053555.tse4q5y6wfbakhth@vireshk-i7>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
 <20190503065026.qwroewhu5lxckqgl@vireshk-i7>
 <AM0PR04MB64343A9439DF8FA943BFE2D4EE350@AM0PR04MB6434.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AM0PR04MB64343A9439DF8FA943BFE2D4EE350@AM0PR04MB6434.eurprd04.prod.outlook.com>
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jacky Bai <ping.bai@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 03-05-19, 11:51, Leonard Crestez wrote:
> On 03.05.2019 09:50, Viresh Kumar wrote:
> > On 02-05-19, 22:44, Leonard Crestez wrote:
> >> Right now in upstream imx8m cpufreq support just lists a common subset
> >> of OPPs because the higher ones should only be attempted after checking
> >> speed grading in fuses.
> >>
> >> Add a small driver which checks speed grading from nvmem cells before
> >> registering cpufreq-dt.
> >>
> >> It seems that cpufreq-dt insists on adding the opp and regulator itself
> >> so can't actually call dev_pm_opp_of_add_table and then
> >> dev_pm_opp_disable
> > 
> > Well we can surely implement it someway if that is what you want, like we can
> > pass postinit() callback in platform data to cpufreq-dt which can get called
> > after OPP table is added, etc.
> > 
> > But disabling OPPs after they are added isn't a great way of handling it as
> > well.
> > 
> >> so implementation was switched to opp-supported-hw.
> > 
> > I will say that this is far better than disabling the OPPs after adding them. So
> > this is a good way of doing it.
> 
> The intention seems to be that dev_pm_opp_disable is used at run-time 
> for stuff like thermal issues while init-time opp selection should be 
> done in other ways.
> 
> Is this what you mean? It's not very obvious from API.

Well there are no hard and fast rules for using the API and what I was
talking about was as to which API makes more sense. I am less in favor
of using dev_pm_opp_disable() here as we will make the OPP available
first on the platform and then disable it. What if the cpufreq core
gets a chance to run in between and program the OPP which isn't
allowed on the SoC ? That may cause problems, right ? And so disable
should be used for things which are getting used just fine and at some
point of time we decide to disable them.

-- 
viresh
