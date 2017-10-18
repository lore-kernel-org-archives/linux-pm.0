From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3] cpufreq: imx6q: Move speed grading check to cpufreq
 driver
Date: Wed, 18 Oct 2017 10:09:17 +0800
Message-ID: <20171018020916.GB18810@dragon>
References: <1506784606-2064-1-git-send-email-festevam@gmail.com>
 <20171013065141.GI8833@dragon>
 <CAOMZO5AwB_2Nbky1wA8neU2-2-LDCTCMFOKGQk4jn5O9zuwKpQ@mail.gmail.com>
 <5060748.qBWaaqo0sL@aspire.rjw.lan>
 <CAOMZO5DTtE12znCVbA1YG=1ugggn1fqfbsuCXnkFTwV8b=yNEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761614AbdJRCJ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Oct 2017 22:09:29 -0400
Content-Disposition: inline
In-Reply-To: <CAOMZO5DTtE12znCVbA1YG=1ugggn1fqfbsuCXnkFTwV8b=yNEg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, vireshk@kernel.org, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Yongcai Huang <anson.huang@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Otavio Salvador <otavio.salvador@ossystems.com.br>, Fabio Estevam <fabio.estevam@nxp.com>

On Mon, Oct 16, 2017 at 08:46:10AM -0200, Fabio Estevam wrote:
> On Sun, Oct 15, 2017 at 10:13 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> > It could go in via the PM tree (which covers cpufreq), but I'd prefer
> > it to go in via arm-soc.
> 
> Sounds good for me. In this case I think Shawn will apply it.

Okay, applied to imx/soc branch, thanks.

Shawn
