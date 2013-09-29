From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: ux500: cpuidle: fix section mismatch
Date: Mon, 30 Sep 2013 01:12:10 +0200
Message-ID: <CACRpkdZN0ErvBSYuOK3XP5JgLZRqJ7Rvcc=sj=naT9c4tSSG5Q@mail.gmail.com>
References: <1380302195-18678-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62954 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab3I2XML (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2013 19:12:11 -0400
Received: by mail-ie0-f174.google.com with SMTP id u16so8491690iet.19
        for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2013 16:12:10 -0700 (PDT)
In-Reply-To: <1380302195-18678-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Sep 27, 2013 at 7:16 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> The dbx500_cpuidle_probe is tagged as an __init section but the variable
> dbx500_cpuidle_plat_driver is not.
>
> The dbx500_cpuidle_probe could not be declared as __init because of macro
> module_platform_driver builds the exit function, tags as __exit and this one
> refers to the dbx500_cpuidle_plat_driver which is an __initdata.
>
> That leads to a section mismatch.
>
> Fix it by removing the __init tag for the probe function.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Sorry if I caused this and thanks for fixing it up!

Yours,
Linus Walleij
