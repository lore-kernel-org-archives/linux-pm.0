From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [Discussion] Performance levels of power domains
Date: Thu, 27 Oct 2016 09:17:55 +0200
Message-ID: <CAKfTPtDD=nGiOno9z2q3pcgQFB8RJwTb1fSmOZJRPZEy0Et8DA@mail.gmail.com>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
 <7hvawfq6kh.fsf@baylibre.com> <20161027034638.GA10423@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37470 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbcJ0HSW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2016 03:18:22 -0400
Received: by mail-wm0-f52.google.com with SMTP id 140so13416144wmv.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Oct 2016 00:18:21 -0700 (PDT)
In-Reply-To: <20161027034638.GA10423@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@kernel.org>

On 27 October 2016 at 05:46, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-10-16, 12:00, Kevin Hilman wrote:
>> Yes.  As I've suggested to qcom/linaro folks (off-list discussions), I
>
> No one told me this story :)
>
>> think extending genpd to handle performance states is a logical
>> extension.  Otherwise, you will be (re)inventing something that looks an
>> awful lot like genpd anyways.
>
> I completely agree. Runtime PM and genpd look to be the perfect
> placeholder for such stuff. I actually tried to convince Ulf yesterday
> on this and he wasn't sure if it will ever get accepted upstream and
> that's when I started this thread :)
>
>> The other related framework is per-device PM QoS which could be used to
>> set constraints on specific devices, and the genpd governors would then
>> be responsible for looking at the constraints and changing states as
>> needed.
>
> I am not sure if genpd governors are also background governors like
> cpufreq, but we need to make sure that the voltage is raised after the
> function requesting a change returns, so that the clk rate can be
> increased then.

The M3 core takes only care of the voltage but not the clock ?

Just to be sure to understand the problem:
-There is no real voltage value but instead an opaque index that has
to be used with frequency instead of a voltage.
-This index is used by the M3 core to set voltages but M3 core doesn't
set the clock which is managed by Linux.
-The M3 core takes only one index input for the whole voltage domain
and Linux must aggregate the constraints (with probably a max policy)
of all devices that belong this domain

Am i missing something ?

Vincent
>
> --
> viresh
