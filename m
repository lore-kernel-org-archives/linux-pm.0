From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: ux500: Fix regression while init PM domains
Date: Mon, 9 Oct 2017 01:31:38 +0200
Message-ID: <CACRpkdau60y2foj06R7=BTAJ4sob+QNLOadCDajnznZtdohdYA@mail.gmail.com>
References: <1507263625-16756-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:50197 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdJHXbj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Oct 2017 19:31:39 -0400
Received: by mail-it0-f44.google.com with SMTP id 72so7344359itl.5
        for <linux-pm@vger.kernel.org>; Sun, 08 Oct 2017 16:31:38 -0700 (PDT)
In-Reply-To: <1507263625-16756-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "arm@kernel.org" <arm@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Fri, Oct 6, 2017 at 6:20 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The commit afece3ab9a36 ("PM / Domains: Add time accounting to various
> genpd states") causes a boot regression for ux500.
>
> The problem occurs when the ux500 machine code calls pm_genpd_init(), which
> since the above change triggers a call to ktime_get(). More precisely,
> because ux500 initializes PM domains in the init_IRQ() phase of the boot,
> timekeeping has not yet been initialized.
>
> Fix the problem by moving the initialization of the PM domains to after
> timekeeping has been initialized.
>
> Fixes: afece3ab9a36 ("PM / Domains: Add time accounting to various genpd..")
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

ARM SoC folks: please apply this directly for fixes!

Yours,
Linus Walleij
