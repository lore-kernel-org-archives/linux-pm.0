From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
Date: Fri, 15 Mar 2019 17:17:53 +0000
Message-ID: <VI1PR04MB55334013173D78F365CA5E19EE440@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <AM0PR04MB421150DF12C869161E7ED4C180440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <56e96a3a-4901-c79c-e91d-6b6a0690e5b7@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Bailon <abailon@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "ptitiano@baylibre.com" <ptitiano@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Zening Wang <zening.wang@nxp.com>, "khilman@baylibre.com" <khilman@baylibre.com>, "ccaione@baylibre.com" <ccaione@baylibre.com>, Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 3/15/19 11:31 AM, Alexandre Bailon wrote:=0A=
>>> This series is sent as RFC mostly because the current support of i.MX S=
oC won't=0A=
>>> benefit of busfreq framework, because the clocks' driver don't support=
=0A=
>>> interconnect / dram frequency scaling.=0A=
>>> As exemple, this series implements busfreq for i.MX8MM whose upstreamin=
g=0A=
>>> is in progress. Because this relies on ATF to do the frequency scaling,=
 it won't=0A=
>>> be hard make it work.=0A=
=0A=
>> How can I test this patch series?=0A=
>> Any additional patches you can share with us?=0A=
>> Or what else we need to do to test it? We can help with it.=0A=
=0A=
> Many other patches will be required to test the series.=0A=
> There are a couple of patches that updates i.MX device drivers to=0A=
> request for bandwidth (does similar thing as bus_freq_request and=0A=
> bus_freq_release).=0A=
=0A=
The interconnect framework asks for bandwidth in bytes/second but in NXP =
=0A=
tree most requests are of the form "request_bus_freq(BUS_FREQ_HIGH);". =0A=
In many cases (ethernet) it doesn't seem you can calculate a specific =0A=
bandwidth usefully.=0A=
=0A=
Instead of asking for "infinite bandwidth zero latency" to force =0A=
everything to "high" it would be nicer to "request an opp".=0A=
=0A=
Power-domain bindings mentioned that consumer-devices can specify a =0A=
"required-opps" property but I've found zero users in tree. Maybe some =0A=
helpers could be written to parse that property and automatically =0A=
request ICC opp on device suspend/resume via device-links?=0A=
=0A=
I know that stuff was written for genpd but it looks like a very good =0A=
fit to me.=0A=
=0A=
> In addition, a patch to that allow to scale the DRAM=0A=
> frequency using CCF is required. I'm still working on this patch.=0A=
=0A=
I'm not sure what you mean here, do you want a clk set_rate to change =0A=
the DRAM freq? It makes sense for DDRC to be a node in the interconnect =0A=
framework and switch OPP inside icc implementation via an ATF call.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
