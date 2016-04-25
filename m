From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM / Domains: Remove redundant pm_runtime_get|put*() in pm_genpd_prepare()
Date: Tue, 26 Apr 2016 01:46:48 +0200
Message-ID: <7353906.1GbTRIjUbl@vostro.rjw.lan>
References: <1461312955-8547-1-git-send-email-ulf.hansson@linaro.org> <7h37qdxz5t.fsf@baylibre.com> <CAPDyKFqtQhbaDw4_k7xc=mMHBda1fn55t7_9w+PKYQHzSdcTpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60325 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752074AbcDYXnu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 19:43:50 -0400
In-Reply-To: <CAPDyKFqtQhbaDw4_k7xc=mMHBda1fn55t7_9w+PKYQHzSdcTpw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Monday, April 25, 2016 10:21:34 AM Ulf Hansson wrote:
> On 22 April 2016 at 20:43, Kevin Hilman <khilman@baylibre.com> wrote:
> > Ulf Hansson <ulf.hansson@linaro.org> writes:
> >
> >> The PM core increases the runtime PM usage count in the system PM prepare
> >> phase.
> >
> > nit: increases/decreases ... prepare/complete
> >
> >> This makes some of the pm_runtime_get|put*() calls in
> >> pm_gendp_prepare() redundant, so let's remove them.
> >
> > s/gendp/genpd/
> >
> > And also add pm_genpd_complete()
> 
> As a matter fact that isn't the case. There's no pm_runtime_put*() in
> pm_genpd_complete().
> 
> Although, perhaps you were thinking about enabling/disabling of
> runtime PM, as that is being done in pm_genpd_prepare() and
> pm_genpd_complete(). I intend to change as well, but in a separate
> patch.
> 
> >
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Otherwise...
> >
> > Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> >
> 
> Thanks for reviewing, I will update the change log accordingly!

OK, I'll be expecting an update of the series then.

Thanks,
Rafael

