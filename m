From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Thu, 4 May 2017 08:46:49 -0300
Message-ID: <CAOMZO5D8J-2jFqiPTCjMNRSVVYwvOeBkyXHzxyrfdkEV6gHA7A@mail.gmail.com>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
 <HE1PR04MB1450DA079FC35180FBE305388B100@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <20170504114343.GN18578@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:38244 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdEDLqu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2017 07:46:50 -0400
In-Reply-To: <20170504114343.GN18578@dragon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Peter Chen <peter.chen@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Shawn,

On Thu, May 4, 2017 at 8:43 AM, Shawn Guo <shawnguo@kernel.org> wrote:

> Per comments from Henri and Leonard, it sounds like the issue only
> happens on RevC board?

That's correct. I do not observe any crashes on my revA board.
