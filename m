From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Convert pm_genpd_init() to return an error code
Date: Mon, 04 Jul 2016 15:06:44 +0200
Message-ID: <11964222.jExDB8jlfn@vostro.rjw.lan>
References: <1466159272-9726-1-git-send-email-ulf.hansson@linaro.org> <m2ziqfagg7.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47755 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753595AbcGDNCL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2016 09:02:11 -0400
In-Reply-To: <m2ziqfagg7.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Monday, June 20, 2016 11:00:24 AM Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > The are already cases when pm_genpd_init() can fail. Currently we hide the
> > failures instead of propagating an error code, which is a better method.
> >
> > Moreover, to prepare for future changes like moving away from using a
> > fixed array-size of the struct genpd_power_state, to instead dynamically
> > allocate data for it, the pm_genpd_init() API needs to be able to return
> > an error code, as allocation can fail.
> >
> > Current users of the pm_genpd_init() is thus requested to start dealing
> > with error codes. In the transition phase, users will have to live with
> > only error messages being printed to log.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Acked-by: Kevin Hilman <khilman@baylibre.com>

Applied, thanks!

