From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [RFC PATCH 1/2] pm: Add PM domain notifications
Date: Thu, 11 Dec 2014 20:04:25 +0900
Message-ID: <CAAFQd5DrzYRCF3tW7cg=rZ3wB1G2kQtWbCx+Pby9obNTewsFdg@mail.gmail.com>
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
 <1418286387-9663-2-git-send-email-tfiga@chromium.org> <548973B7.3050107@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:50511 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756314AbaLKLEr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Dec 2014 06:04:47 -0500
Received: by mail-qg0-f51.google.com with SMTP id e89so3491750qgf.24
        for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2014 03:04:47 -0800 (PST)
Received: from mail-qc0-f180.google.com (mail-qc0-f180.google.com. [209.85.216.180])
        by mx.google.com with ESMTPSA id u95sm656085qgu.47.2014.12.11.03.04.45
        for <linux-pm@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Dec 2014 03:04:45 -0800 (PST)
Received: by mail-qc0-f180.google.com with SMTP id i8so3542935qcq.25
        for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2014 03:04:45 -0800 (PST)
In-Reply-To: <548973B7.3050107@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Kurtz <djkurtz@chromium.org>

Hi Sylwester,

On Thu, Dec 11, 2014 at 7:36 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> Hi Tomasz,
>
> On 11/12/14 09:26, Tomasz Figa wrote:
> > From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >
> > This patch adds notifiers to the runtime PM/genpd subsystem. It is now
> > possible to register a notifier, which will be called before and after
> > the generic power domain subsystem calls the power domain's power_on
> > and power_off callbacks.
> >
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > [tfiga@chromium.org: rebased]
> > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>
> Not sure if you've noticed it, I posted an updated version of this patch
> recently [1]. The notifiers list is moved to struct generic_pm_domain
> there and it also allows to register a notifier for selected power domain
> by name.
[snip]
> [1] http://www.spinics.net/lists/linux-samsung-soc/msg38549.html

Ah, haven't noticed, sorry. The API using devices looks the same, so I
guess we can simply have patch 2/2 of this series applied on top of
your patch.

By the way, look-up by name (presumably hardcoded somewhere?) sounds a
bit strange to me. What was the reason for it to be added?

Best regards,
Tomasz
