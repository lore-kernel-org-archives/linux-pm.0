From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v3 1/2] soc: imx: gpc: Disable 6sl display power gating
 for ERR006287
Date: Wed, 11 Jul 2018 14:29:46 +0200
Message-ID: <1531312186.3163.52.camel@pengutronix.de>
References: <cover.1531310547.git.leonard.crestez@nxp.com>
         <d694bc32feb1c9638485700ba53cd6e51bea495c.1531310547.git.leonard.crestez@nxp.com>
         <1531311392.3163.47.camel@pengutronix.de>
         <1cc67fd7d1214f93f7ace6f0c2a46303f79a828e.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1cc67fd7d1214f93f7ace6f0c2a46303f79a828e.camel@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, den 11.07.2018, 15:21 +0300 schrieb Leonard Crestez:
> On Wed, 2018-07-11 at 14:16 +0200, Lucas Stach wrote:
> > Am Mittwoch, den 11.07.2018, 15:11 +0300 schrieb Leonard Crestez:
> > > Handle this in the safest possible way by keeping the DISP domain
> > > always-on.
> > > 
> > > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > 
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > 
> > Can you send a follow on patch to switch the i.MX6QP errata
> > workaround
> > to use GENPD_FLAG_ALWAYS_ON and remove the -EBUSY stuff in the
> > power
> > down path?
> 
> Sure.
> 
> I was thinking of converting it to a new GENPD_FLAG which allows
> power_off in suspend (as suggested by Ulf) but switching to
> GENPD_FLAG_ALWAYS_ON in order to simplify the code could be done
> first.

Sure, if you are going to work on this I'm fine with converting it over
to this without first going for GENPD_FLAG_ALWAYS_ON. Just wanted to
make sure that things are consistent.

> The -EBUSY stuff is not very harmful.

It's dead code once the appropriate flags have been added to the
domain, so should be removed.

Regards,
Lucas
