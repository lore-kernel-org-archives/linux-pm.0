From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] cpufreq: dbx500: add a Kconfig symbol
Date: Fri, 12 May 2017 11:18:55 +0200
Message-ID: <CACRpkdbayePnJE1oWCiqfW3KhQXru7PS+qjRmxX7zdzz-qFWdg@mail.gmail.com>
References: <20170511121258.3521041-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33910 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932610AbdELJS5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 May 2017 05:18:57 -0400
Received: by mail-io0-f172.google.com with SMTP id k91so36643990ioi.1
        for <linux-pm@vger.kernel.org>; Fri, 12 May 2017 02:18:56 -0700 (PDT)
In-Reply-To: <20170511121258.3521041-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, May 11, 2017 at 2:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Moving the cooling code into the cpufreq driver caused a possible build failure
> when the cpu_thermal helper code is a loadable module or disabled:
>
> drivers/cpufreq/dbx500-cpufreq.o: In function `dbx500_cpufreq_ready':
> dbx500-cpufreq.c:(.text.dbx500_cpufreq_ready+0x4): undefined reference to `cpufreq_cooling_register'
>
> This adds the same dependency that we have in other cpufreq drivers,
> forcing the driver to be disabled when we can't possibly link it.
>
> Fixes: 19678ffb9fd6 ("cpufreq: dbx500: Manage cooling device from cpufreq driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
