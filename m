From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: imx6q: Move speed grading check to cpufreq
 driver
Date: Wed, 4 Oct 2017 11:43:28 +0530
Message-ID: <20171004061328.GC8478@vireshk-i7>
References: <1506784606-2064-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:52298 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdJDGNb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 02:13:31 -0400
Received: by mail-pf0-f179.google.com with SMTP id a1so2546620pfj.9
        for <linux-pm@vger.kernel.org>; Tue, 03 Oct 2017 23:13:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1506784606-2064-1-git-send-email-festevam@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, kernel@pengutronix.de, shawnguo@kernel.org, anson.huang@nxp.com, linux-arm-kernel@lists.infradead.org, otavio.salvador@ossystems.com.br, Fabio Estevam <fabio.estevam@nxp.com>

On 30-09-17, 12:16, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> On some i.MX6 SoCs (like i.MX6SL, i.MX6SX and i.MX6UL) that do not have
> speed grading check, opp table will not be created in platform code,
> so cpufreq driver prints the following error message:
> 
> cpu cpu0: dev_pm_opp_get_opp_count: OPP table not found (-19)
> 
> However, this is not really an error in this case because the
> imx6q-cpufreq driver first calls dev_pm_opp_get_opp_count()
> and if it fails, it means that platform code does not provide
> OPP and then dev_pm_opp_of_add_table() will be called.
> 
> In order to avoid such confusing error message, move the speed grading
> check from platform code to the imx6q-cpufreq driver.
> 
> This way the imx6q-cpufreq no longer has to check whether OPP table
> is supplied by platform code.
> 
> Tested on a i.MX6Q and i.MX6UL based boards.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Previous discussion on this topic:
> https://patchwork.kernel.org/patch/9295059/
> 
> Changes since v2:
> - Fixed a typo in the commit log (missed SL) - Otavio
> - Remove __init anotation from imx6q_opp_check_speed_grading()
> Changes since v1:
> - Remove unneeded has_speed_grading() function.

Looks fine to me.

@Shawn: Can you please let us know if you are fine with it?

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
