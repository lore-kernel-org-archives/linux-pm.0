From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 0/7] PM / Domains: Implement domain performance states
Date: Wed, 15 Mar 2017 16:19:57 +0530
Message-ID: <CAKohpomJj8543r7DARW9LXoL1QERFUAkdG0qXsMf76+zbR7QJw@mail.gmail.com>
References: <cover.1487926924.git.viresh.kumar@linaro.org> <m237ekrhok.fsf@baylibre.com>
 <20170313103933.GA3102@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:37015 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbdCOKt7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2017 06:49:59 -0400
Received: by mail-it0-f41.google.com with SMTP id g138so16613168itb.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2017 03:49:59 -0700 (PDT)
In-Reply-To: <20170313103933.GA3102@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>

On 13 March 2017 at 16:09, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 10-03-17, 12:38, Kevin Hilman wrote:
>> Why limit it to just voltage levels.
>>
>> As I suggested earlier, I think this should use OPPs.  Remember that a
>> PM domain is not limited to a hardware power domain, but is just a
>> grouping mechanism for devices that share some PM properties.  As
>> mentioned by Geert, this can also be a clock domain, where frequencies
>> would make sense as well.  One can imagine using this type of PM domain
>> to manage an interconnect/bus which has scalable voltage/frequencies as
>> well.
>
> Okay, I tried to do that change today and am blocked a bit right now.
>
> The OPP core and all of its APIs/interfaces have dependency on the
> "struct device" for their working. It gets the of_node from it, stores
> the device pointer to manage cases where multiple devices share OPP
> table, uses it to get clk and regulators.
>
> But the "genpd" structure doesn't have a 'struct device' associated
> with it. How should I make both of them work together?
>
> I tried to create separate helpers that don't accept 'dev', but that
> is also not good.  Just too much redundant code everywhere.
>
> Would creating a 'dev' structure within 'generic_pm_domain' be
> acceptable? Or should we ask the domain-drivers to call something like
> of_genpd_parse_idle_states(), with a fake 'dev' structure which has
> its of_node initialized? Or maybe move that hack within the OPP-core
> API, which can create a dev structure at runtime for the genpd passed
> to it and get the OPP table out?

Ulf/Kevin,

I am currently blocked on this decision. Will it be possible for you guys
to suggest something, so that I can send V3 soon ?

The most ideal solution seems to be adding a device structure in genpd
structure and add a genpd bus as well probably.

--
viresh
