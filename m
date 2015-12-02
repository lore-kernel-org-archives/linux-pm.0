From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Validate cases of a non-bound driver in genpd governor
Date: Thu, 03 Dec 2015 00:28:29 +0100
Message-ID: <9799311.U71mByL4LE@vostro.rjw.lan>
References: <1449061707-16030-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54266 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758310AbbLBXFR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 18:05:17 -0500
In-Reply-To: <1449061707-16030-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>

On Wednesday, December 02, 2015 02:08:27 PM Ulf Hansson wrote:
> Recently genpd removed the requirement of a having a driver bound for its
> attached devices to allow genpd to power off. That change should also have
> removed a corresponding validation in the governor, let's correct that.
> 
> Fixes: 298cd0f08801 ("PM / Domains: Remove dev->driver check for runtime")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied, thanks!

Rafael

