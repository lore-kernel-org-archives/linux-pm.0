From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/5] cpufreq: cpu0: disable unsupported OPPs
Date: Fri, 19 Sep 2014 09:49:39 -0700
Message-ID: <CAKohpo=s+X8dXZpcj5q5exR+Q=E-CxTNbdYem4D=zHeQ3A_qXA@mail.gmail.com>
References: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
	<1411143381-10516-2-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:49808 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbaISQtk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Sep 2014 12:49:40 -0400
Received: by mail-ob0-f169.google.com with SMTP id wm4so1917396obc.28
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2014 09:49:39 -0700 (PDT)
In-Reply-To: <1411143381-10516-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Cc'ing Mark Brown to get his views on the idea.

On 19 September 2014 09:16, Lucas Stach <l.stach@pengutronix.de> wrote:
> If the regulator connected to the CPU voltage plane doesn't
> support an OPP specified voltage with the acceptable tolerance
> it's better to just disable the OPP instead of constantly
> failing the voltage scaling later on.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 60 ++++++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 23 deletions(-)

And this file doesn't exist anymore (its renamed). Rebase over
Rafael's linux-next branch for that.
