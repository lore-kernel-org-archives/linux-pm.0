From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] power: reset: gpio-poweroff: let devm_gpiod_get set
 direction of gpio
Date: Tue, 19 May 2015 15:48:08 +0200
Message-ID: <CACRpkdZCUdTM0FskjvPy-1-AF-BxHh6ks1WU-g_LemrXGYgt6A@mail.gmail.com>
References: <1431981907-32578-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35375 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbbESNsJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 09:48:09 -0400
Received: by oign205 with SMTP id n205so11116723oig.2
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2015 06:48:08 -0700 (PDT)
In-Reply-To: <1431981907-32578-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sascha Hauer <kernel@pengutronix.de>, Alexandre Courbot <acourbot@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, May 18, 2015 at 10:45 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() function=
s)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additio=
nal
> parameter that allows to specify direction and initial value for outp=
ut.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
