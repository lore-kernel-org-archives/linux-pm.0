From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] cpufreq: integrator: fix integrator_cpufreq_remove return type
Date: Thu, 2 Oct 2014 10:28:44 +0200
Message-ID: <CACRpkdZXWNs8-y_13tmKerjfROdjd-EaXi6i3TSK2xPH-_rz7w@mail.gmail.com>
References: <1845195.odREGsY0qB@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33400 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbaJBI2p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 04:28:45 -0400
Received: by mail-ig0-f180.google.com with SMTP id uq10so1954962igb.13
        for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2014 01:28:44 -0700 (PDT)
In-Reply-To: <1845195.odREGsY0qB@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Sep 26, 2014 at 10:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> When building this driver as a module, we get a helpful warning
> about the return type:
>
> drivers/cpufreq/integrator-cpufreq.c:232:2: warning: initialization from incompatible pointer type
>   .remove = __exit_p(integrator_cpufreq_remove),
>
> If the remove callback returns void, the caller gets an undefined
> value as it expects an integer to be returned. This fixes the
> problem by passing down the value from cpufreq_unregister_driver.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
