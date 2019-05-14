From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
Date: Tue, 14 May 2019 19:34:10 +0000
Message-ID: <AM0PR04MB643434FB6A26B4D70F52F350EE080@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <CAEG3pNA+U1tw4sWq9i2cTni6QKQkLyd3qyZXd2i8M7WFDF4ZsQ@mail.gmail.com>
 <8af96425-a6f5-0114-7abb-c2a67b952e1b@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Bailon <abailon@baylibre.com>, Jacky Bai <ping.bai@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Patrick Titiano <ptitiano@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Emilio Lopez <emilio@elopez.com.ar>, Hans de Goede <hdegoede@redhat.com>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Zening Wang <zening.wang@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, dl-linux-imx <linux-imx@nxp.com>, Anson Huang <anson.huang@nxp.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 15.03.2019 18:55, Alexandre Bailon wrote:=0A=
>> On Wed, Mar 13, 2019 at 12:33 PM Alexandre Bailon <abailon@baylibre.com>=
 wrote:=0A=
=0A=
>>> As exemple, this series implements busfreq for i.MX8MM whose=0A=
>>> upstreaming is in progress. Because this relies on ATF to=0A=
>>> do the frequency scaling, it won't be hard make it work.=0A=
>>=0A=
>> It's not clear to me whether this series actual scales the dram=0A=
>> frequency based on what you said above. Is it just theoretical or do=0A=
>> you have it working with a pile of out-of-tree patches? Would be good=0A=
>> to include that pile of patches in your integration branch that I=0A=
>> suggested above.=0A=
=0A=
> The current series only introduce busfreq generic driver, and the=0A=
> busfreq driver for the imx8mm.=0A=
> As is, the imx8mm driver will just be loaded, but do nothing because=0A=
> none of the drivers have been updated to request bandwidth using the=0A=
> interconnect framework.=0A=
> =0A=
> My intent was to sent a first draft o busfreq, to get some feedback,=0A=
> before to send a more complete, and fully functional series.=0A=
=0A=
It's been a while since this was first posted and imx8mm now boots fine =0A=
in linux-next. Is there a more up-to-date WIP branch somewhere? =0A=
Otherwise I can try to hack this series into a bootable form.=0A=
=0A=
 > In addition, the current clock driver of imx8mm doesn't allow dram=0A=
 > frequency scaling, so if busfreq driver tries, it will fail (should be=
=0A=
 > harmless because any other clocks should restored to their previous=0A=
 > rate).=0A=
=0A=
I'm confused about this. In NXP tree the actual DRAM switch is done =0A=
inside ATF via SIP calls and involves corralling all CPUs. Do you want =0A=
an "dram" clk which wraps the SIP calls required to changing dram =0A=
frequency and root switching etc?=0A=
=0A=
I've been looking at the busfreq implementation in the NXP tree and =0A=
refactoring just the "dram freq switch" behind a clk might work nicely.=0A=
=0A=
This would be similar to the imx_cpu clk used for cpufreq-dt and it =0A=
might even be possible to upstream this separately from the rest of =0A=
busfreq logic dealing with device requests.=0A=
=0A=
=0A=
I haven't done a very careful review but I noticed you're not using the =0A=
OPP framework and instead redefined everything? It's not clear why.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
