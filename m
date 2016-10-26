From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [Discussion] Performance levels of power domains
Date: Wed, 26 Oct 2016 16:22:34 +0530
Message-ID: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35959 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753618AbcJZKwg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 06:52:36 -0400
Received: by mail-qt0-f179.google.com with SMTP id 12so2278244qtm.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2016 03:52:35 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@kernel.org>

Hi Guys,

I wanted to involve you guys to get a discussion going
for a problem we want to solve, and so this mail.


Platform details:

Some of the Qualcom SoCs have the option to configure
the performance level of their Power Domains. The performance
levels are identified by integer values (lets say 0-9, 0 being the lowest).

Another M3 core handles the *real* voltage scaling based on the input
received (from software) in terms of these performance levels. The M3
core translates the levels into a range of voltages (corners) and selects
the right one by itself.

Software needs to provide the performance level for the entire domain
to the M3 core and so software also needs to handle performance requests
from all the devices that lie in the domain X and find a Performance Level P,
which can satisfy all the devices (normally the highest requrested level).


Problem statement:

As we aren't dealing with Voltages here, we can't really get the benefits
of the Regulators framework. The regulators are managed internally
by the M3 core. All we need is a way for software to comeout with inputs
for the M3 core.

The OPP framework can be used to include performance levels for
each OPP (frequency) entry.

But what framework can be used to select performance level of power
domains ?

By name, power-domain or genpd looks to be the right choice, but until
now it is only managing power-on and power-off of devices and domains.

Should we extend that (along with runtime PM), or do something else?

Qualcomm guys, please correct my understanding of the hardware in
case, something wasn't explained correctly.

--
viresh
