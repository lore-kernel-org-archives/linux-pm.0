From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] PM / Domains: Remove redundant pm_runtime_get|put*() in pm_genpd_prepare()
Date: Wed, 27 Apr 2016 23:28:51 +0200
Message-ID: <9274144.HrCSulKu8o@vostro.rjw.lan>
References: <1461653238-3891-1-git-send-email-ulf.hansson@linaro.org> <1461653238-3891-2-git-send-email-ulf.hansson@linaro.org> <CAPDyKFq_6ZFt6W5wkYzpw2tq=-9496e00TkspRL4U8-P+239Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47863 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751103AbcD0VZv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 17:25:51 -0400
In-Reply-To: <CAPDyKFq_6ZFt6W5wkYzpw2tq=-9496e00TkspRL4U8-P+239Aw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Tuesday, April 26, 2016 09:08:22 AM Ulf Hansson wrote:
> On 26 April 2016 at 08:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > The PM core increases and decreases the runtime PM usage count in the
> > system PM prepare phase. This makes some of the pm_runtime_get|put*()
> > calls in pm_gendp_prepare() redundant, so let's remove them.
> 
> Huh, I noticed I missed to update pm_gendp_prepare() to pm_genpd_prepare().
> 
> Rafael, can you amend the patch or you want me to send a v3?

No worries, I've fixed it up.

This one and the [2/2] applied, thanks!

