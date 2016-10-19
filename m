From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 5/6] clk: pxa: transfer CPU clock setting from pxa2xx-cpufreq
Date: Wed, 19 Oct 2016 22:15:43 +0200
Message-ID: <877f943xjk.fsf@belgarion.home>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
        <1476130149-31834-6-git-send-email-robert.jarzmik@free.fr>
        <87zim23zw3.fsf@belgarion.home> <20161018234855.GO8871@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:36855 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753152AbcJSUPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2016 16:15:48 -0400
In-Reply-To: <20161018234855.GO8871@codeaurora.org> (Stephen Boyd's message of
        "Tue, 18 Oct 2016 16:48:55 -0700")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 10/18, Robert Jarzmik wrote:
>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>> Hi Michael and Stephen,
>> 
>> I'm planing on sending a v2 next week with minor corrections, mostly in the data
>> tables (pxa25x_freqs and pxa27x_freqs), as testing prooved some values were wrong.
>> 
>> If you want me modify this serie, will you have time to review for next week or
>> should I delay the v2 posting ?
>> 
>
> No need to delay. clk patches look fine with a quick glance. It
> would be really neat if we could make cpufreq-dt work without DT.
> What's blocking that? OPP tables?

Heu I'm not the author of cpufreq-dt, so I'm not the best to answer.
To answer the question "without DT", it depends if you mean "with ACPI" or "with
platform_data" or something else.

>From what I've seen so far, the missing/blocking points are :
 - the OPP points definition as you said
 - probably same thing for the input power supply / regulator
 - the cooling parts probably
 - and more generaly all the cpufreq-dt is built around device-tree
 - last point, the name from KConfig, "Generic DT based cpufreq driver"
   => that strongly suggest it's device-tree only

I'm deeply convinced that Viresh being one of the authors will shed more light
on this.

Cheers.

-- 
Robert
