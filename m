From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND PATCH V2] PM / Domains: Fix potential deadlock while adding/removing subdomains
Date: Wed, 27 Jan 2016 23:38:02 +0100
Message-ID: <6700382.MaxBWu9PE9@vostro.rjw.lan>
References: <1453882237-2816-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51824 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932216AbcA0WhJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2016 17:37:09 -0500
In-Reply-To: <1453882237-2816-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Wednesday, January 27, 2016 09:10:37 AM Ulf Hansson wrote:
> We must preserve the same order of how we acquire and release the lock for
> genpd, as otherwise we may encounter deadlocks.
> 
> The power on phase of a genpd starts by acquiring its lock. Then it walks
> the hierarchy of its parent domains to be able to power on these first, as
> per design of genpd.
> 
> From a locking perspective this means the locks of the parents becomes
> acquired after the lock of the subdomain.
> 
> Let's fix pm_genpd_add|remove_subdomain() to maintain the same order of
> acquiring/releasing the genpd lock as being applied in the power on/off
> sequence.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	Fix lockdep warning.

Applied, thanks!

