From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
Date: Wed, 10 Apr 2019 10:59:15 +0530
Message-ID: <20190410052915.jrb67qmpwnmy4ird@vireshk-i7>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <AM0PR04MB421150DF12C869161E7ED4C180440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <56e96a3a-4901-c79c-e91d-6b6a0690e5b7@baylibre.com>
 <VI1PR04MB55334013173D78F365CA5E19EE440@VI1PR04MB5533.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB55334013173D78F365CA5E19EE440@VI1PR04MB5533.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Alexandre Bailon <abailon@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>, Aisheng Dong <aisheng.dong@nxp.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "ptitiano@baylibre.com" <ptitiano@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Zening Wang <zening.wang@nxp.com>, "khilman@baylibre.com" <khilman@baylibre.com>, "ccaione@baylibre.com" <ccaione@baylibre.com>, Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 15-03-19, 17:17, Leonard Crestez wrote:
> On 3/15/19 11:31 AM, Alexandre Bailon wrote:
> >>> This series is sent as RFC mostly because the current support of i.MX SoC won't
> >>> benefit of busfreq framework, because the clocks' driver don't support
> >>> interconnect / dram frequency scaling.
> >>> As exemple, this series implements busfreq for i.MX8MM whose upstreaming
> >>> is in progress. Because this relies on ATF to do the frequency scaling, it won't
> >>> be hard make it work.
> 
> >> How can I test this patch series?
> >> Any additional patches you can share with us?
> >> Or what else we need to do to test it? We can help with it.
> 
> > Many other patches will be required to test the series.
> > There are a couple of patches that updates i.MX device drivers to
> > request for bandwidth (does similar thing as bus_freq_request and
> > bus_freq_release).
> 
> The interconnect framework asks for bandwidth in bytes/second but in NXP 
> tree most requests are of the form "request_bus_freq(BUS_FREQ_HIGH);". 
> In many cases (ethernet) it doesn't seem you can calculate a specific 
> bandwidth usefully.
> 
> Instead of asking for "infinite bandwidth zero latency" to force 
> everything to "high" it would be nicer to "request an opp".
> 
> Power-domain bindings mentioned that consumer-devices can specify a 
> "required-opps" property but I've found zero users in tree. Maybe some 
> helpers could be written to parse that property and automatically 
> request ICC opp on device suspend/resume via device-links?

Documentation/devicetree/bindings/power/qcom,rpmpd.txt is using it currently in
mainline.

> I know that stuff was written for genpd but it looks like a very good 
> fit to me.

Yes, the very first user is genpd but we have designed it with an open mind and
so it shouldn't be difficult to make use of it at other places.

There is some WIP which you can look at :

- Introduce OPP bandwidth bindings
  lore.kernel.org/lkml/20190313090010.20534-1-georgi.djakov@linaro.org

- DVFS in the OPP core
  https://lore.kernel.org/lkml/20190320094918.20234-1-rnayak@codeaurora.org

-- 
viresh
