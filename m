From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] PM / Domains: Second step in improving system PM code in genpd
Date: Wed, 27 Apr 2016 23:29:25 +0200
Message-ID: <4547966.5d0pIpHDtv@vostro.rjw.lan>
References: <1461673411-14245-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53665 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751967AbcD0V0X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 17:26:23 -0400
In-Reply-To: <1461673411-14245-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Tuesday, April 26, 2016 02:23:29 PM Ulf Hansson wrote:
> This is the second step in improving the system PM code in genpd. The first
> patch is actually fixing a bug while it also enables for further clean-ups,
> which is done in the second patch.
> 
> The next step of improving system PM code in genpd will move it to the part of
> trying to optimize the behaviour, such as avoid waking up devices unless it's
> really needed.
> 
> Note, these two patches is based upon "[PATCH v2 0/2] PM / Domains: Initial
> improvements of system PM code in genpd", which was recently posted. Probably
> it's a good idea to combine these series into one, if/when new re-spins are
> needed.
> 
> Ulf Hansson (2):
>   PM / Domains: Allow genpd to power on during the system PM phase
>   PM / Domains: Remove redundant wrapper functions for system PM
> 
>  drivers/base/power/domain.c | 271 ++++++--------------------------------------
>  include/linux/pm_domain.h   |   1 -
>  2 files changed, 35 insertions(+), 237 deletions(-)

Kevin?

