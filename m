From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] PM / Domains: Further consolidate and clarify genpd code
Date: Thu, 21 Apr 2016 02:33:26 +0200
Message-ID: <8995224.0UngCiYHF5@vostro.rjw.lan>
References: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org> <CAPDyKFqER0GSsKr2D_zkZch4evtRGk1Cyi7UR=QFkJ0kqAQAUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51060 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751279AbcDUAaf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 20:30:35 -0400
In-Reply-To: <CAPDyKFqER0GSsKr2D_zkZch4evtRGk1Cyi7UR=QFkJ0kqAQAUw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>

On Wednesday, April 20, 2016 07:55:09 PM Ulf Hansson wrote:
> On 31 March 2016 at 11:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > This is yet another quite trivial series of patches that further intends to
> > consolidate and clarify some of the code for the generic PM domain (genpd).
> >
> > Ulf Hansson (3):
> >   PM / Domains: Rename stop_ok to suspend_ok for the genpd governor
> >   PM / Domains: Rename pm_genpd_runtime_suspend|resume()
> >   PM / Domains: Remove ->save|restore_state() callbacks
> >
> >  drivers/base/power/domain.c          | 131 ++++++++++++++++-------------------
> >  drivers/base/power/domain_governor.c |  20 +++---
> >  include/linux/pm_domain.h            |   6 +-
> >  3 files changed, 70 insertions(+), 87 deletions(-)
> >
> > --
> > 1.9.1
> >
> 
> Rafael, Kevin, do these look okay with you?

I'm waiting for Kevin.

Thanks,
Rafael

