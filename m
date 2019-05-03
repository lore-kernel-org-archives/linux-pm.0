From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/3] cpufreq: Add imx-cpufreq-dt driver
Date: Fri, 3 May 2019 15:23:45 +0530
Message-ID: <20190503095345.axz6pojgfmhgqjqa@vireshk-i7>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
 <df3a41d8bf57b8dd8f8c17599eeca98d6e43962c.1556836868.git.leonard.crestez@nxp.com>
 <20190503065227.afqgmylbjwhg2mc3@vireshk-i7>
 <AM0PR04MB64345196835732B019F1D885EE350@AM0PR04MB6434.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AM0PR04MB64345196835732B019F1D885EE350@AM0PR04MB6434.eurprd04.prod.outlook.com>
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

On 03-05-19, 09:44, Leonard Crestez wrote:
> On 03.05.2019 09:52, Viresh Kumar wrote:

> > Why add another virtual device-driver pair here? The only reason why we have
> > been adding it was to get deferred probe to work which doesn't look like the
> > case for this driver. Why not do everything from the init() routine ?
> 
> The imx-cpufreq-dt platform_driver reads from fuses (nvmem/imx-ocotp) 
> which can be theoretically be built as a module and also has clock 

I am not against making this driver a module, that is okay.

> requirements. No sure we should rely that the call to read from nvmem 
> never returns EPROBE_DEFER.

Okay, I didn't realize that we can get EPROBE_DEFER from
nvmem_cell_read_u32(). Should be fine then.

-- 
viresh
