From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Date: Wed, 13 Feb 2019 15:45:02 +0530
Message-ID: <20190213101502.v75d3nfwctcks2gx@vireshk-i7>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
 <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
 <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
 <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB391662EC01B6160C1AA9A540F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB391662EC01B6160C1AA9A540F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "heiko@sntech.de" <heiko@sntech.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "festevam@gmail.com" <festevam@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, Andy Gross <andy.gross@linaro.org>, dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, Daniel Baluta <daniel.baluta@nxp.com>, linux-arm-
List-Id: linux-pm@vger.kernel.org

On 13-02-19, 08:53, Anson Huang wrote:
> Forgot to mention, i.MX system controller cpufreq actually can NOT do any CPU
> clock/voltage scaling from Linux kernel, they are controlled by system controller
> firmware and ONLY can be requested via RPC with secure mode, so Linux kernel
> has to call SMC and trap to ARM-Trusted-Firmware to do it, in this case, is cpufreq-dt
> still suitable to support it? I saw cpufreq-dt driver will do CPU clock/voltage scaling
> directly.

What about moving those SMC calls to the clk-driver, then it wouldn't
matter to the cpufreq driver on how the clock is getting changed.

-- 
viresh
