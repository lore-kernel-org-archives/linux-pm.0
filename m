From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [RFC] cpufreq: Add imx-cpufreq-dt driver
Date: Thu, 25 Apr 2019 11:38:40 +0000
Message-ID: <0e33e8f8e7f5aae410750a815dffc0cd8d2b1d2e.camel@nxp.com>
References: <83a3ade389239bd492ee646aa4868c5e37e65434.1556187603.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <83a3ade389239bd492ee646aa4868c5e37e65434.1556187603.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-ID: <57215398384D874883E3369C039A37DC@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Leonard Crestez <leonard.crestez@nxp.com>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Minor comment,

<snip>
> +	u32 (*check_speed_grading)(struct device *);
> +	int ret;
> +
> +       	np = of_find_node_by_path("/");

Indentation looks strange here ^

> +	id = of_match_node(imx_cpufreq_dt_match_list, np);
> +	of_node_put(np);
> +	if (!id)
> +		return -ENODEV;
> 
