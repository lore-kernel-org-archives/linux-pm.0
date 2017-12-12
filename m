From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: imx6q: fix speed grading regression on i.MX6
 QuadPlus
Date: Tue, 12 Dec 2017 20:11:33 +0530
Message-ID: <20171212144133.GR25177@vireshk-i7>
References: <20171211131900.17423-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39876 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbdLLOlg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 09:41:36 -0500
Received: by mail-pg0-f66.google.com with SMTP id w7so13539151pgv.6
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2017 06:41:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171211131900.17423-1-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de, patchwork-lst@pengutronix.de

On 11-12-17, 14:19, Lucas Stach wrote:
> The commit moving the speed grading check to the cpufreq driver introduced
> some additional checks, so the OPP disable is only attempted on SoCs where
> those OPPs are present. The compatible checks are missing the QuadPlus
> compatible, so invalid OPPs are not correctly disabled there.
> 
> Move both checks to a single condition, so we don't need to sprinkle even
> more calls to of_machine_is_compatible().
> 
> Fixes: 2b3d58a3adca (cpufreq: imx6q: Move speed grading check to cpufreq driver)
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
