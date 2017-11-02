From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 1/5] PM / Domains: Allow genpd users to specify default active wakeup behavior
Date: Thu, 02 Nov 2017 14:59:25 +0100
Message-ID: <7ha804lr2a.fsf@baylibre.com>
References: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
        <1509473494-19740-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:52063 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933020AbdKBN72 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2017 09:59:28 -0400
Received: by mail-wr0-f182.google.com with SMTP id j15so5095599wre.8
        for <linux-pm@vger.kernel.org>; Thu, 02 Nov 2017 06:59:28 -0700 (PDT)
In-Reply-To: <1509473494-19740-2-git-send-email-geert+renesas@glider.be>
        (Geert Uytterhoeven's message of "Tue, 31 Oct 2017 19:11:30 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> It is quite common for PM Domains to require slave devices to be kept
> active during system suspend if they are to be used as wakeup sources.
> To enable this, currently each PM Domain or driver has to provide its
> own gpd_dev_ops.active_wakeup() callback.
>
> Introduce a new flag GENPD_FLAG_ACTIVE_WAKEUP to consolidate this.
> If specified, all slave devices configured as wakeup sources will be
> kept active during system suspend.
>
> PM Domains that need more fine-grained controls, based on the slave
> device, can still provide their own callbacks, as before.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
