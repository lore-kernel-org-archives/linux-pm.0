From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/5] Switch to the DT cpufreq policy on the Integrator
Date: Mon, 24 Oct 2016 21:28:19 +0200
Message-ID: <CACRpkdZvUh0Z0kxu+WmvwqH3kuaOxaP1Cgxv0WUE2PT-eLs62w@mail.gmail.com>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org> <6720864.e2sjvVVhdQ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33849 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbcJXT2V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 15:28:21 -0400
Received: by mail-qt0-f178.google.com with SMTP id q7so133894706qtq.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2016 12:28:21 -0700 (PDT)
In-Reply-To: <6720864.e2sjvVVhdQ@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>

On Wed, Oct 19, 2016 at 12:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I don't see any hard dependency here, so I'd suggest to merge the
> two cpufreq patches through the subsystem tree, and the ARM patches
> through arm-soc.

That's right, Viresh can you merge patches 1 and 5 to the
cpufreq tree please?

I will funnel patches 2, 3 and 4 to ARM SoC.

Yours,
Linus Walleij
