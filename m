From: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
Date: Tue, 28 Aug 2018 19:28:06 -0500
Message-ID: <1dd3074eabb496155c4d1abb83c82c52529a656a.camel@buserror.net>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
         <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
         <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, vabhav.sharma@nxp.com
Cc: Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-kernel-owner@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Will Deacon <will.deacon@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sriram Dash <sriram.dash@nxp.com>, linux-clk <linux-clk@vger.kernel.org>, Udit Kumar <udit.kumar@nxp.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, V.Sethi@nxp.com, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>, Priyanka Jain <priyanka.jain@>
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-08-21 at 15:45 -0500, Rob Herring wrote:
> On Mon, Aug 20, 2018 at 1:52 PM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
> > +/ {
> > +       model = "NXP Layerscape LX2160ARDB";
> > +       compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
> > +
> > +       aliases {
> > +               crypto = &crypto;
> 
> Drop this. Aliases should be numbered, and this is not a standard
> alias name either.

Is this a new rule?  In any case, U-Boot looks for a "crypto" alias.

-Scott
