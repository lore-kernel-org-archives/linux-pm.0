From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Tue, 25 Apr 2017 20:23:24 +0300
Message-ID: <1493141004.3557.8.camel@nxp.com>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
         <CAOMZO5BsgXRfgZ0hszk2Vgo2keVDHH1BLbJTbW+awMS2cBoNow@mail.gmail.com>
         <CAOMZO5CKUsEr1yf5RrsPLipNtLC_6sK0dPjT2M-eN-uo8hEbrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam01on0052.outbound.protection.outlook.com ([104.47.34.52]:47771
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1952010AbdDYRXd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Apr 2017 13:23:33 -0400
In-Reply-To: <CAOMZO5CKUsEr1yf5RrsPLipNtLC_6sK0dPjT2M-eN-uo8hEbrQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Peter Chen <Peter.Chen@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christoph Fritz <chf.fritz@googlemail.com>

On Tue, 2017-04-25 at 14:02 -0300, Fabio Estevam wrote:
> On Tue, Apr 25, 2017 at 2:02 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > 
> > Hi Leonard,
> > 
> > On Tue, Apr 25, 2017 at 1:57 PM, Leonard Crestez
> > <leonard.crestez@nxp.com> wrote:
> > > 
> > > The board file for imx6sx-dbg overrides cpufreq operating points to use
> > > higher voltages. This is done because the board has a shared rail for
> > > VDD_ARM_IN and VDD_SOC_IN and when using LDO bypass the shared voltage
> > > needs to be a value suitable for both ARM and SOC.
> > > 
> > > This was introduced in:
> > > 
> > > commit 54183bd7f766 ("ARM: imx6sx-sdb: add revb board and make it default")
> > > 
> > > This only only applies to LDO bypass mode, a feature not present in
> > > upstream. When LDOs are enabled the effect is to use higher voltages than
> > > necesarry for no good reason.
> > > 
> > > Setting these higher voltages can make some boards fail to boot with ugly
> > > semi-random crashes, reminiscent of memory corruption. These failures
> > > happen the first time the lowest idle state is used. Remove the OPP
> > > override in order to fix those crashes.
> > > 
> > > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > > 
> > > ---
> > > It's not clear exactly why the crashes happen. Perhaps waking up from idle
> > > draws more power than is available? Removing this override is a correct
> > > change anyway so maybe there is no need to investigate deeper.

> > Marek just sent a similar one a few minutes ago:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/503230.html

> Forgot to add Marek.

Wow, that was literally 15 minutes before my patch. In my defense I did
search the archives before starting to format the patch but it had not
arrived yet.

Anyway, that version also sets the supply for reg_arm and reg_soc. It
is not necessary for fixing the crash I'm seeing but is good because it
will result in the minimum voltage on VDD_ARM_SOC_IN rather than a fix
1375mv. I tested Marek's patch and it works fine on my rev B board
(which otherwise fails to boot upstream).

-- 
Regards,
Leonard
