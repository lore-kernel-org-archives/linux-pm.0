From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: drivers: don't check range of target freq in .target()
Date: Wed, 27 Mar 2013 14:55:29 +0100
Message-ID: <CACRpkdbsOq_5NoS-OP4XXWo1ae6RjCcJLnSaa1qyWHsOxXA2dg@mail.gmail.com>
References: <2ece6d9fe8dfb6882a1c83a1cb2404bacc40b22d.1364138740.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:55286 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab3C0Nza (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 09:55:30 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so7444667iag.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2013 06:55:29 -0700 (PDT)
In-Reply-To: <2ece6d9fe8dfb6882a1c83a1cb2404bacc40b22d.1364138740.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Sekhar Nori <nsekhar@ti.com>, Rickard ANDERSSON <rickard.andersson@stericsson.com>

On Sun, Mar 24, 2013 at 4:29 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Cpufreq core checks the range of target_freq before calling driver->target() and
> so we don't need to do it again.
>
> Remove it.
>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
