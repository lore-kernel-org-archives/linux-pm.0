From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH v3 0/2] PM / Domains: Second step in improving
 system PM code in genpd
Date: Wed, 15 Jun 2016 10:22:23 +0200
Message-ID: <CAPDyKFpWTTv7oHaTh84OgHbYHgP+N2oLxTynDkaO=tdiKCLa4g@mail.gmail.com>
References: <1464601388-26693-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38548 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbcFOIW0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 04:22:26 -0400
Received: by mail-wm0-f46.google.com with SMTP id m124so24041254wme.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 01:22:25 -0700 (PDT)
In-Reply-To: <1464601388-26693-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Alex Deucher <alexander.deucher@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>

On 30 May 2016 at 11:43, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Changes in v3:
>         - Changelog of patch 1/2.
>
> Changes in v2:
>         - Updated changelogs for both patches according to comments from Kevin.
>         - Updated patch 1/2, as I realized one genpd client driver, (ab)uses
>         genpd's suspend_power_off flag.
>
> This is the second step in improving the system PM code in genpd. The first
> patch is actually fixing a bug while it also enables for further clean-ups,
> which is done in the second patch.
>
> The next step of improving system PM code in genpd will move it to the part of
> trying to optimize the behaviour, such as avoid waking up devices unless it's
> really needed.
>
> Ulf Hansson (2):
>   PM / Domains: Allow genpd to power on during the system PM phases
>   PM / Domains: Remove redundant wrapper functions for system PM
>
>  drivers/base/power/domain.c             | 271 +++++---------------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c |  23 ---
>  include/linux/pm_domain.h               |   1 -
>  3 files changed, 35 insertions(+), 260 deletions(-)
>
> --
> 1.9.1
>

Rafael, Kevin - any comments on this?

Kind regards
Uffe
