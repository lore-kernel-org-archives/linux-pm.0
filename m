From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] PM / Domains: Allow genpd to power on during the
 system PM phase
Date: Wed, 11 May 2016 23:25:47 +0200
Message-ID: <CAJZ5v0hsC9f7JFbs+A8GGWxc7jUJig+PvA4XLtE6VU2kiUbxYQ@mail.gmail.com>
References: <1462953610-20824-1-git-send-email-ulf.hansson@linaro.org>
	<1462953610-20824-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:32941 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbcEKVZt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2016 17:25:49 -0400
Received: by mail-lf0-f52.google.com with SMTP id y84so61709113lfc.0
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2016 14:25:48 -0700 (PDT)
In-Reply-To: <1462953610-20824-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Alex Deucher <alexander.deucher@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>

On Wed, May 11, 2016 at 10:00 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> If the PM domain is powered off when the first device in the domain starts
> its system PM prepare phase, genpd prevents any further attempts to power
> on the PM domain during the system PM phase. This constraint affects not
> only the current device which is being prepared, but all devices within
> the same PM domain.

What exactly do you mean by "the system PM phase"?
