From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: imx6: Fix the secondary_sel_clk clock string
Date: Fri, 20 May 2016 08:33:57 +0530
Message-ID: <20160520030357.GA12608@vireshk-i7>
References: <1463713188-6896-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36203 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbcETDEA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 23:04:00 -0400
Received: by mail-pa0-f47.google.com with SMTP id bt5so34832267pac.3
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 20:04:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1463713188-6896-1-git-send-email-festevam@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: rafael.j.wysocki@intel.com, ping.bai@nxp.com, shawnguo@kernel.org, kernel@pengutronix.de, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, stable@vger.kernel.org

On 19-05-16, 23:59, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Commit a35fc5a33b62a6 ("cpufreq: imx: update the clock switch flow to
> support imx6ul") introduced the 'secondary_sel_clk' clock, which is
> specific for the i.mx6ul case, but used the wrong clock string inside 
> the clk_get() function.
> 
> Use the correct clock string: "secondary_sel_clk".
> 
> This fixes a kernel crash after running the 'reboot' command on a
> mx6ul.
> 
> Fixes: a35fc5a33b62a6 ("cpufreq: imx: update the clock switch flow to support imx6ul")
> Cc: <stable@vger.kernel.org> # 4.4.x
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
