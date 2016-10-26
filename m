From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [Discussion] Performance levels of power domains
Date: Wed, 26 Oct 2016 12:00:14 -0700
Message-ID: <7hvawfq6kh.fsf@baylibre.com>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36705 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754845AbcJZTAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 15:00:16 -0400
Received: by mail-pf0-f173.google.com with SMTP id e6so1569191pfk.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2016 12:00:16 -0700 (PDT)
In-Reply-To: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
        (Viresh Kumar's message of "Wed, 26 Oct 2016 16:22:34 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@kernel.org>

Viresh Kumar <viresh.kumar@linaro.org> writes:

> Hi Guys,
>
> I wanted to involve you guys to get a discussion going
> for a problem we want to solve, and so this mail.
>
>
> Platform details:
>
> Some of the Qualcom SoCs have the option to configure
> the performance level of their Power Domains. The performance
> levels are identified by integer values (lets say 0-9, 0 being the lowest).
>
> Another M3 core handles the *real* voltage scaling based on the input
> received (from software) in terms of these performance levels. The M3
> core translates the levels into a range of voltages (corners) and selects
> the right one by itself.
>
> Software needs to provide the performance level for the entire domain
> to the M3 core and so software also needs to handle performance requests
> from all the devices that lie in the domain X and find a Performance Level P,
> which can satisfy all the devices (normally the highest requrested level).
>
>
> Problem statement:
>
> As we aren't dealing with Voltages here, we can't really get the benefits
> of the Regulators framework. The regulators are managed internally
> by the M3 core. All we need is a way for software to comeout with inputs
> for the M3 core.
>
> The OPP framework can be used to include performance levels for
> each OPP (frequency) entry.
>
> But what framework can be used to select performance level of power
> domains ?
>
> By name, power-domain or genpd looks to be the right choice, but until
> now it is only managing power-on and power-off of devices and domains.

genpd has also recently been extended to support multiple states, though
those are still idle states, not active (performance) states.

> Should we extend that (along with runtime PM), or do something else?

Yes.  As I've suggested to qcom/linaro folks (off-list discussions), I
think extending genpd to handle performance states is a logical
extension.  Otherwise, you will be (re)inventing something that looks an
awful lot like genpd anyways.

The other related framework is per-device PM QoS which could be used to
set constraints on specific devices, and the genpd governors would then
be responsible for looking at the constraints and changing states as
needed.

Kevin
