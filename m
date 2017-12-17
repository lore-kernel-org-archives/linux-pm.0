From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: imx6q: fix speed grading regression on i.MX6 QuadPlus
Date: Sun, 17 Dec 2017 19:06:41 +0100
Message-ID: <3041111.LGmKWMtgYY@aspire.rjw.lan>
References: <20171211131900.17423-1-l.stach@pengutronix.de> <20171212144133.GR25177@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46418 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752393AbdLQSH3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Dec 2017 13:07:29 -0500
In-Reply-To: <20171212144133.GR25177@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de, patchwork-lst@pengutronix.de

On Tuesday, December 12, 2017 3:41:33 PM CET Viresh Kumar wrote:
> On 11-12-17, 14:19, Lucas Stach wrote:
> > The commit moving the speed grading check to the cpufreq driver introduced
> > some additional checks, so the OPP disable is only attempted on SoCs where
> > those OPPs are present. The compatible checks are missing the QuadPlus
> > compatible, so invalid OPPs are not correctly disabled there.
> > 
> > Move both checks to a single condition, so we don't need to sprinkle even
> > more calls to of_machine_is_compatible().
> > 
> > Fixes: 2b3d58a3adca (cpufreq: imx6q: Move speed grading check to cpufreq driver)
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/cpufreq/imx6q-cpufreq.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!
