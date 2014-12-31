From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 02/26] thermal: db8500: pass cpu_present_mask to cpufreq_cooling_register()
Date: Wed, 31 Dec 2014 09:11:49 +0100
Message-ID: <CACRpkdbeY9HzUbPODHpE0qsnitWVUiRhOu0-qBbe-iRi2e+yTg@mail.gmail.com>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
	<fc802a046dd2ad250e934a05af1104789f5c12e7.1417664938.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:47885 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbaLaILu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Dec 2014 03:11:50 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so14131258ier.6
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2014 00:11:49 -0800 (PST)
In-Reply-To: <fc802a046dd2ad250e934a05af1104789f5c12e7.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, edubezval@gmail.com, linaro-kernel <linaro-kernel@lists.linaro.org>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, javi.merino@arm.com, Hongbo Zhang <hongbo.zhang@linaro.com>

On Thu, Dec 4, 2014 at 5:11 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> cpufreq_cooling_register() expects mask of all the CPUs where frequency
> constraint is applicable.
>
> This platform has more than one CPU to which these constraints will apply and so
> passing mask of only CPU0 wouldn't be sufficient. Also, this platform has a
> single cluster of CPUs and the constraint applies to all CPUs.
>
> If CPU0 is hoplugged out then we may face strange BUGs as cpu_cooling framework
> isn't aware of any siblings sharing clock line.
>
> Fix it by passing cpu_present_mask to cpufreq_cooling_register().
>
> Cc: Hongbo Zhang <hongbo.zhang@linaro.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
