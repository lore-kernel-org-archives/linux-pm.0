From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] cpufreq: imx6q: Move speed grading check to cpufreq driver
Date: Mon, 16 Oct 2017 02:13:24 +0200
Message-ID: <5060748.qBWaaqo0sL@aspire.rjw.lan>
References: <1506784606-2064-1-git-send-email-festevam@gmail.com> <20171013065141.GI8833@dragon> <CAOMZO5AwB_2Nbky1wA8neU2-2-LDCTCMFOKGQk4jn5O9zuwKpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53851 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751348AbdJPAXA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Oct 2017 20:23:00 -0400
In-Reply-To: <CAOMZO5AwB_2Nbky1wA8neU2-2-LDCTCMFOKGQk4jn5O9zuwKpQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, vireshk@kernel.org, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Yongcai Huang <anson.huang@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Otavio Salvador <otavio.salvador@ossystems.com.br>, Fabio Estevam <fabio.estevam@nxp.com>

On Sunday, October 15, 2017 5:42:19 PM CEST Fabio Estevam wrote:
> Hi Viresh,
> 
> On Fri, Oct 13, 2017 at 3:51 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> 
> >> Looks fine to me.
> >>
> >> @Shawn: Can you please let us know if you are fine with it?
> >
> > Acked-by: Shawn Guo <shawnguo@kernel.org>
> 
> Will this one go through your tree?

No, it won't.

It could go in via the PM tree (which covers cpufreq), but I'd prefer
it to go in via arm-soc.

Thanks,
Rafael
