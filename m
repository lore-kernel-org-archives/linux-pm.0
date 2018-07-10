From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v3] soc: imx: gpc: Turn PU domain on/off in sleep on 6qp
Date: Tue, 10 Jul 2018 10:05:43 +0200
Message-ID: <1531209943.3163.31.camel@pengutronix.de>
References: <ab0c7997bdb0caf6fe7e842315bb9565c2cb059d.1530895248.git.leonard.crestez@nxp.com>
         <CAPDyKFqb6eZ2SYG612yqiNisv7UV1q3UHYfZfemmvv9Q4w=Png@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqb6eZ2SYG612yqiNisv7UV1q3UHYfZfemmvv9Q4w=Png@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Fabio Estevam <fabio.estevam@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Robin Gong <yibin.gong@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, den 10.07.2018, 00:27 +0200 schrieb Ulf Hansson:
> > On 6 July 2018 at 18:46, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > On imx6qp power gating on the PU domain is disabled because of errata
> > ERR009619. However power gating during suspend/resume can still be
> > performed.
> 
> Sounds a bit hand wavy. Exactly why can it be done during system suspend/resume?

Power gating this domain in normal operation may introduce a glitch in
unrelated modules, potentially disturbing a running display scanout.
This is not a concern when the whole system enters suspend state, so
it's safe to do in this case.

Regards,
Lucas

> > 
> > Enable this by implementing SLEEP_PM_OPS in imx_pgc_power_domain_driver.
> > 
> > In order to ensure correct ordering add device links from devices inside
> > the PU domain to the pgc platform_device.
> 
> In genpd, the PM domain gets powered off after all device's
> corresponding ->suspend_noirq() callback has been invoked - and it
> also considers if there are some wakeup settings enabled, possibly
> avoiding to do the power off.
> 
> It sound like the imx's power domain driver ->power_off|on() callback
> should deal with this, to make get a consistent behavior. I understand
> that you currently can't tell under what circumstances the
> ->power_off|on() callbacks are being invoked, that may need some
> changes in genpd.
> 
> Currently we have a flag, GENPD_FLAG_ALWAYS_ON which makes genpd to
> always prevent power off. Perhaps we should add a new flag
> "GENPD_FLAG_RUNTIME_ON", which makes genpd to call the
> ->power_on|off() callbacks, but only during system wide PM.
> 
> Thoughts?

Yes, this might work for this case.

Regards,
Lucas
