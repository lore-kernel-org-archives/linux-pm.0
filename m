From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/2] clk: Add consumer APIs for discovering possible parent clocks
Date: Thu, 30 Jun 2016 03:46:56 +0200
Message-ID: <2091721.Cm4CVR1ptK@vostro.rjw.lan>
References: <1466058085-19353-1-git-send-email-oss@buserror.net> <DBXPR04MB49546917495DA33834B05D7F0230@DBXPR04MB495.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64680 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751499AbcF3BnD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2016 21:43:03 -0400
In-Reply-To: <DBXPR04MB49546917495DA33834B05D7F0230@DBXPR04MB495.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian Tang <yuantian.tang@nxp.com>
Cc: Scott Wood <oss@buserror.net>, Russell King <linux@armlinux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Yang-Leo Li <leoyang.li@nxp.com>, Xiaofeng Ren <xiaofeng.ren@nxp.com>, Scott Wood <scottwood@freescale.com>

On Wednesday, June 29, 2016 05:50:26 AM Yuantian Tang wrote:
> Hi,
> 
> This patch is acked by clock maintainer. If no comments from anyone else, we will merge it in next week.

There is a cpufreq commit depending on it.  Are you going to handle that one too?

Thanks,
Rafael

