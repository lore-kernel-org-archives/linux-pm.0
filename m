From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3 v3] mfd: db8500-prcmu: Get rid of cpufreq dependency
Date: Tue, 22 Aug 2017 15:44:18 +0200
Message-ID: <CACRpkdZ91zUPE8Oyf+ZALekCUbAakM=PX6DiYTO-VZewGGNFmg@mail.gmail.com>
References: <20170822131741.23473-1-linus.walleij@linaro.org>
 <20170822131741.23473-2-linus.walleij@linaro.org> <7661350.vR4F4a82RE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34107 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932856AbdHVNoT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2017 09:44:19 -0400
Received: by mail-oi0-f43.google.com with SMTP id j144so58023861oib.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2017 06:44:19 -0700 (PDT)
In-Reply-To: <7661350.vR4F4a82RE@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Aug 22, 2017 at 3:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, August 22, 2017 3:17:40 PM CEST Linus Walleij wrote:
>> The ARMSS clock, also known as the operating point of the
>> CPU, should not cross-depend on cpufreq like this. Move
>> the code to use just frequencies and remove the false
>> frequency (1GHz) and put in the actual frequency provided
>> by the ARMSS clock (998400000 Hz) as part of the process.
>>
>> After this and the related cpufreq patch, the DB8500 will
>> simply use the standard DT cpufreq driver to change the
>> operating points through the common clock framework using
>> the ARMSS clock.
>>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Well, I've already applied the v2, so do you want me to replace the
> commit with this patch?

If you can, else tell me and I can send a fixup patch.

I want to keep Lee happy!

Yours,
Linus Walleij
