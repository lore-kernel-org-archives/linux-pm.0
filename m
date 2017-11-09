From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] soc: amlogic: meson-gx-pwrc-vpu: fix power-off when powered by bootloader
Date: Wed, 08 Nov 2017 16:50:55 -0800
Message-ID: <7hshdoi8b4.fsf@baylibre.com>
References: <1509723804-21114-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:55580 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbdKIAvI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2017 19:51:08 -0500
Received: by mail-pf0-f193.google.com with SMTP id 17so3003504pfn.12
        for <linux-pm@vger.kernel.org>; Wed, 08 Nov 2017 16:51:08 -0800 (PST)
In-Reply-To: <1509723804-21114-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Fri, 3 Nov 2017 16:43:24 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: arm@kernel.org
Cc: carlo@caione.org, linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>

Arnd, Olof,

Neil Armstrong <narmstrong@baylibre.com> writes:

> In the case the VPU power domain has been powered on by the bootloader
> and no driver are attached to this power domain, the genpd will power it
> off after a certain amount of time, but the clocks hasn't been enabled
> by the kernel itself and the power-off will trigger some faults.
> This patch enable the clocks to have a coherent state for an eventual
> poweroff and switches to the pm_domain_always_on_gov governor.
>
> Fixes: 75fcb5ca4b46 ("soc: amlogic: add Meson GX VPU Domains driver")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

This fixes a patch that's currently in arm-soc next/drivers (or
amlogic/drivers-2 to be precise.)

If it's not too late, please feel free to apply directly.  If not, I
will queue up for v4.15-rc fixes cycle.

Thanks,

Kevin
