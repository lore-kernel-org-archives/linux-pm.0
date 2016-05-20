From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] cpufreq: imx6: Fix the secondary_sel_clk clock string
Date: Fri, 20 May 2016 00:09:21 -0300
Message-ID: <CAOMZO5BjUP8JSKb9ZPYSUd7uTML3Q4vF4-PPGrQMEaZ-C45Oow@mail.gmail.com>
References: <1463713188-6896-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35904 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbcETDJW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 23:09:22 -0400
In-Reply-To: <1463713188-6896-1-git-send-email-festevam@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Ping Bai <ping.bai@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, stable <stable@vger.kernel.org>

On Thu, May 19, 2016 at 11:59 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Commit a35fc5a33b62a6 ("cpufreq: imx: update the clock switch flow to
> support imx6ul") introduced the 'secondary_sel_clk' clock, which is
> specific for the i.mx6ul case, but used the wrong clock string inside
> the clk_get() function.
>
> Use the correct clock string: "secondary_sel_clk".

Sorry, the  'secondary_sel' name is the one define in imx6ul.dtsi.

This patch 'fixed' the issue because it did not register cpufreq for mx6ul.

We still need to provide a proper fix for cpufreq on mx6ul. Please
discard this patch.
