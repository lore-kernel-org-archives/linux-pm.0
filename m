From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 06/16] cpufreq: dbx500: use cpufreq_generic_get() routine
Date: Wed, 28 Aug 2013 14:14:27 +0200
Message-ID: <CACRpkdZjtP8Fv0-wkqo-TFU+iwrm2w3WQ14sHy-n07XZMPdcHQ@mail.gmail.com>
References: <cover.1377272740.git.viresh.kumar@linaro.org>
	<5f8581601947988a49c36f465e36028758539cc0.1377272740.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:38035 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab3H1MO2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 08:14:28 -0400
Received: by mail-oa0-f49.google.com with SMTP id n12so4449292oag.22
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2013 05:14:27 -0700 (PDT)
In-Reply-To: <5f8581601947988a49c36f465e36028758539cc0.1377272740.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Aug 23, 2013 at 5:50 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> We have common infrastructure available with us for getting a CPUs clk rate.
> Lets use it for this driver.
>
> We don't have to find closest frequency in platform specific ->get() routine
> wihch dbx500 driver was doing and hence it can be removed as well.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
