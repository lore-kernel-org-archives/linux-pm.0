From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] i2c: let I2C masters inherit suspend child ignorance
Date: Mon, 11 Apr 2016 08:53:40 +0200
Message-ID: <CACRpkdb7r02E990LJEPwLWuZgPeK2w_jg054kFk12wxSUPY02Q@mail.gmail.com>
References: <1460035237-12037-1-git-send-email-linus.walleij@linaro.org>
	<1460035237-12037-3-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35665 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbcDKGxq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 02:53:46 -0400
Received: by mail-oi0-f52.google.com with SMTP id p188so196502795oih.2
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2016 23:53:46 -0700 (PDT)
In-Reply-To: <1460035237-12037-3-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On Thu, Apr 7, 2016 at 3:20 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> @@ -1566,6 +1566,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>
>         pm_runtime_no_callbacks(&adap->dev);
>         pm_runtime_enable(&adap->dev);
> +       pm_suspend_inherit_ignore_children(&adap->dev);

If everyone agrees that i2c devices should never require the bus
to be resumed, we can of course use the big hammer and
just:

pm_suspend_ignore_children(&adap->dev, true);

Same for SPI. (And w1, ...)

Thoughts?

Yours,
Linus Walleij
