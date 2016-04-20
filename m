From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] PM / Domains: Further consolidate and clarify genpd code
Date: Wed, 20 Apr 2016 19:55:09 +0200
Message-ID: <CAPDyKFqER0GSsKr2D_zkZch4evtRGk1Cyi7UR=QFkJ0kqAQAUw@mail.gmail.com>
References: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33694 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbcDTRzL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 13:55:11 -0400
Received: by mail-wm0-f43.google.com with SMTP id 127so13118363wmz.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2016 10:55:10 -0700 (PDT)
In-Reply-To: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>

On 31 March 2016 at 11:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> This is yet another quite trivial series of patches that further intends to
> consolidate and clarify some of the code for the generic PM domain (genpd).
>
> Ulf Hansson (3):
>   PM / Domains: Rename stop_ok to suspend_ok for the genpd governor
>   PM / Domains: Rename pm_genpd_runtime_suspend|resume()
>   PM / Domains: Remove ->save|restore_state() callbacks
>
>  drivers/base/power/domain.c          | 131 ++++++++++++++++-------------------
>  drivers/base/power/domain_governor.c |  20 +++---
>  include/linux/pm_domain.h            |   6 +-
>  3 files changed, 70 insertions(+), 87 deletions(-)
>
> --
> 1.9.1
>

Rafael, Kevin, do these look okay with you?

Kind regards
Uffe
