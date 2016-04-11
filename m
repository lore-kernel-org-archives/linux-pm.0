From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] PM / sleep: add a helper function to inherit child ignorance
Date: Mon, 11 Apr 2016 13:54:24 +0200
Message-ID: <CACRpkdbeYpL7mMLniwepAEMo7-cD=BuXbSCEcwFvHK31oPHXdQ@mail.gmail.com>
References: <1460035237-12037-1-git-send-email-linus.walleij@linaro.org>
	<1460035237-12037-2-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35585 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbcDKLyZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 07:54:25 -0400
Received: by mail-oi0-f48.google.com with SMTP id p188so203642927oih.2
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2016 04:54:25 -0700 (PDT)
In-Reply-To: <1460035237-12037-2-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On Thu, Apr 7, 2016 at 3:20 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> A few subsystems dealing with peripherals on slow buses with
> transfer-oriented runtime PM will need to inherit the child
> ignorance property of their parent hardware devices.
>
> Especially struct i2c_adapter and struct spi_master needs
> this.
>
> This adds a helper function to deal with this and make it
> clear what is going on.
>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Just drop this, I submitted new patches to simply mark all
I2C adapters and SPI hosts as ignoring their children.

Yours,
Linus Walleij
