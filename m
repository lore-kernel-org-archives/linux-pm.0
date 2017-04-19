From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v2 0/4] ARM: imx: Set LDO regulator supply
Date: Wed, 19 Apr 2017 12:28:01 +0300
Message-ID: <1492594081.15137.0.camel@nxp.com>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:55264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1761616AbdDSJ2K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Apr 2017 05:28:10 -0400
In-Reply-To: <cover.1491324640.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, 2017-04-04 at 20:04 +0300, Leonard Crestez wrote:
> Setting the LDO regulator parent is optional but beneficial. It will cause
> the PMIC output voltage to be dynamically set to the minimum input for the
> LDOs, this should be more efficient.
> 
> This propagation was introduced by:
> commit fc42112c0eaa ("regulator: core: Propagate voltage changes to supply
> regulators")
> 
> Changes since v1:
>  * Drop patch 1 since it only avoids logging a warning and the gpc driver
> is going through more changes.
>  * Initialize cpufreq->suspend_freq based on policy->max instead.
>  * Remove reference to ldo-bypass from suspend_freq patch message.

Hello,

This is a gentle reminder that this was sent ~2 weeks ago and patches 1
and 2 are still waiting (with no objections). Patches 3/4 were applied.

--
Regards,
Leonard
