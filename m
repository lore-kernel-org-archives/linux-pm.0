From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: ux500: Fix regression while init PM domains
Date: Thu, 19 Oct 2017 17:46:46 +0200
Message-ID: <CAK8P3a17dK5yJdm9Cgu67UXmb1hL+OjU_OK28wcm2qcBndekxw@mail.gmail.com>
References: <1507263625-16756-1-git-send-email-ulf.hansson@linaro.org> <CACRpkdau60y2foj06R7=BTAJ4sob+QNLOadCDajnznZtdohdYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:49206 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754048AbdJSPqr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2017 11:46:47 -0400
Received: by mail-oi0-f65.google.com with SMTP id w197so15610582oif.6
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2017 08:46:47 -0700 (PDT)
In-Reply-To: <CACRpkdau60y2foj06R7=BTAJ4sob+QNLOadCDajnznZtdohdYA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "arm@kernel.org" <arm@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Oct 9, 2017 at 1:31 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Oct 6, 2017 at 6:20 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> The commit afece3ab9a36 ("PM / Domains: Add time accounting to various
>> genpd states") causes a boot regression for ux500.
>>
>> The problem occurs when the ux500 machine code calls pm_genpd_init(), which
>> since the above change triggers a call to ktime_get(). More precisely,
>> because ux500 initializes PM domains in the init_IRQ() phase of the boot,
>> timekeeping has not yet been initialized.
>>
>> Fix the problem by moving the initialization of the PM domains to after
>> timekeeping has been initialized.
>>
>> Fixes: afece3ab9a36 ("PM / Domains: Add time accounting to various genpd..")
>> Cc: Thara Gopinath <thara.gopinath@linaro.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> ARM SoC folks: please apply this directly for fixes!

Applied, thanks!
