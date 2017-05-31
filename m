From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] cpufreq: imx6q: imx6ull should use the same flow as imx6ul
Date: Wed, 31 May 2017 01:07:17 -0300
Message-ID: <CAOMZO5A+suW4gS0_7U+g=abvXfFp-bXs5wE1jNPZWwy7HUgSwA@mail.gmail.com>
References: <30688f5aa17763362275c199b2d61841497c26a4.1496159470.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:35432 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdEaEHS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 00:07:18 -0400
In-Reply-To: <30688f5aa17763362275c199b2d61841497c26a4.1496159470.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bai Ping <ping.bai@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>

On Tue, May 30, 2017 at 12:57 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> From: Octavian Purdila <octavian.purdila@nxp.com>
>
> This fixes an issue with imx6ull where setting the frequency to 528Mhz
> would actually set the ARM clock to 324Mhz.
>
> Signed-off-by: Octavian Purdila <octavian.purdila@nxp.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
