From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] cpufreq: imx6q: imx6ull should use the same flow as
 imx6ul
Date: Wed, 21 Jun 2017 13:53:04 +0300
Message-ID: <1498042384.32344.1.camel@nxp.com>
References: <30688f5aa17763362275c199b2d61841497c26a4.1496159470.git.leonard.crestez@nxp.com>
         <CAOMZO5A+suW4gS0_7U+g=abvXfFp-bXs5wE1jNPZWwy7HUgSwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn3nam01on0080.outbound.protection.outlook.com ([104.47.33.80]:59616
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751953AbdFUKxV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Jun 2017 06:53:21 -0400
In-Reply-To: <CAOMZO5A+suW4gS0_7U+g=abvXfFp-bXs5wE1jNPZWwy7HUgSwA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bai Ping <ping.bai@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>

On Wed, 2017-05-31 at 01:07 -0300, Fabio Estevam wrote:
> On Tue, May 30, 2017 at 12:57 PM, Leonard Crestez
> <leonard.crestez@nxp.com> wrote:
> > 
> > From: Octavian Purdila <octavian.purdila@nxp.com>
> > 
> > This fixes an issue with imx6ull where setting the frequency to
> > 528Mhz
> > would actually set the ARM clock to 324Mhz.
> > 
> > Signed-off-by: Octavian Purdila <octavian.purdila@nxp.com>
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

This is a gentle reminder that this patch has been posted 3 weeks ago
but has not yet been applied.

--
Regards,
Leonard
