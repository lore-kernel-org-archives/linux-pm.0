From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Fri, 5 May 2017 09:18:37 +0800
Message-ID: <20170505011834.GS18578@dragon>
References: <1493823533.11226.28.camel@nxp.com>
 <e46a57c2-4a28-a8b6-445e-299dd9d8659c@denx.de>
 <1493834298.11226.40.camel@nxp.com>
 <51fb1bd0-028d-c431-acc8-3c4f1d25fdba@denx.de>
 <1493890943.11226.42.camel@nxp.com>
 <6dbf67a0-42ea-ee84-d144-41422a21c1c5@denx.de>
 <20170504124446.GO18578@dragon>
 <4ba6bdf2-56b2-972d-3326-0eda3985c80b@denx.de>
 <20170504134100.GR18578@dragon>
 <8c3827c4-1272-f004-52d9-7c79e93813c6@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbdEEBTL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 May 2017 21:19:11 -0400
Content-Disposition: inline
In-Reply-To: <8c3827c4-1272-f004-52d9-7c79e93813c6@denx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Peter Chen <Peter.Chen@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, May 04, 2017 at 04:34:14PM +0200, Marek Vasut wrote:
> On 05/04/2017 03:41 PM, Shawn Guo wrote:
> > So I guess you do not understand how the OPP hackery was born and why it
> > shouldn't be there for mainline kernel at all.
> 
> The OPP hackery is there to keep both regulators configured the same
> way, since they share the same input voltage rail IMO.

Yes.  But configuring both regulators the same way is only required in
vendor kernel where 'LDO bypass' mode is used.  With 'LDO enable' mode
which is the case for upstream kernel, both regulators can be configured
differently even they share the same input rail.

> If you model the
> power distribution correctly, the OPP hackery can be removed.

The OPP hackery can be removed even without reg_arm/reg_soc modeling.
That's why we can do hackery dropping and reg_arm/reg_soc modeling in
separate patches.

@Leonard, if someday we support 'LDO bypass' mode in upstream kernel,
the OPP hackery needs to be back in some way even with reg_arm/reg_soc
modeling in place, right?  Or will we have a better way to ensure SW1A
rail can always feed a correct voltage directly to reg_arm&reg_soc?

Shawn
