From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Tue, 25 Apr 2017 14:02:04 -0300
Message-ID: <CAOMZO5BsgXRfgZ0hszk2Vgo2keVDHH1BLbJTbW+awMS2cBoNow@mail.gmail.com>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36205 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1945895AbdDYRCF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 13:02:05 -0400
In-Reply-To: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Peter Chen <Peter.Chen@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christoph Fritz <chf.fritz@googlemail.com>

Hi Leonard,

On Tue, Apr 25, 2017 at 1:57 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> The board file for imx6sx-dbg overrides cpufreq operating points to use
> higher voltages. This is done because the board has a shared rail for
> VDD_ARM_IN and VDD_SOC_IN and when using LDO bypass the shared voltage
> needs to be a value suitable for both ARM and SOC.
>
> This was introduced in:
>
> commit 54183bd7f766 ("ARM: imx6sx-sdb: add revb board and make it default")
>
> This only only applies to LDO bypass mode, a feature not present in
> upstream. When LDOs are enabled the effect is to use higher voltages than
> necesarry for no good reason.
>
> Setting these higher voltages can make some boards fail to boot with ugly
> semi-random crashes, reminiscent of memory corruption. These failures
> happen the first time the lowest idle state is used. Remove the OPP
> override in order to fix those crashes.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>
> ---
> It's not clear exactly why the crashes happen. Perhaps waking up from idle
> draws more power than is available? Removing this override is a correct
> change anyway so maybe there is no need to investigate deeper.

Marek just sent a similar one a few minutes ago:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/503230.html
