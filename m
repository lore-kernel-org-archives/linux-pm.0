From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: let SPI masters ignore their children for PM
Date: Mon, 23 May 2016 14:56:29 +0200
Message-ID: <CACRpkdZPNwnhDHDVD3=Mm0iYqCavH0Oemu7qZ4bRM3AfWbH38A@mail.gmail.com>
References: <1460375463-15557-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35656 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbcEWM4a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 08:56:30 -0400
Received: by mail-oi0-f43.google.com with SMTP id x19so275517036oix.2
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2016 05:56:30 -0700 (PDT)
In-Reply-To: <1460375463-15557-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Apr 11, 2016 at 1:51 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Let all SPI masters ignore their children: when it comes
> to power management: SPI children have no business doing
> keeping their parents awake: they are completely autonomous
> devices that just use their parent to talk, and the latter
> usecase must be power managed by the host itself on a
> per-message basis.
>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Mark did this slip through the cracks or is there some
problem with it?

The corresponding patch to I2C is applied in commit
04f59143b571 "i2c: let I2C masters ignore their children for PM"

Tell me if I should resend it.

Yours,
Linus Walleij
