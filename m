From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/5] Switch to the DT cpufreq policy on the Integrator
Date: Mon, 24 Oct 2016 22:15:48 +0200
Message-ID: <CAJZ5v0gb8XTTrSgQzT==7=tLiAyy3RemmVnDYfm-kNULw0_uZQ@mail.gmail.com>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
 <6720864.e2sjvVVhdQ@wuerfel> <CACRpkdZvUh0Z0kxu+WmvwqH3kuaOxaP1Cgxv0WUE2PT-eLs62w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34313 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938945AbcJXUPz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 16:15:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id d199so11457201wmd.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2016 13:15:54 -0700 (PDT)
In-Reply-To: <CACRpkdZvUh0Z0kxu+WmvwqH3kuaOxaP1Cgxv0WUE2PT-eLs62w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>

On Mon, Oct 24, 2016 at 9:28 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Oct 19, 2016 at 12:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> I don't see any hard dependency here, so I'd suggest to merge the
>> two cpufreq patches through the subsystem tree, and the ARM patches
>> through arm-soc.
>
> That's right, Viresh can you merge patches 1 and 5 to the
> cpufreq tree please?

Well, that would be me.

Can you please resend the two as a separate series, with all tags
collected so far if any?

Thanks,
Rafael
