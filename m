From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Discussion] Performance levels of power domains
Date: Thu, 27 Oct 2016 15:53:29 +0530
Message-ID: <20161027102329.GF10423@vireshk-i7>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
 <7hvawfq6kh.fsf@baylibre.com>
 <CAJZ5v0jPeauJGpQfr1VjDo1Z-Xd6UT4_4QLeso_CSEtB4zyaag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36096 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942363AbcJ0OMq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2016 10:12:46 -0400
Received: by mail-pf0-f177.google.com with SMTP id e6so18387184pfk.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Oct 2016 07:12:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jPeauJGpQfr1VjDo1Z-Xd6UT4_4QLeso_CSEtB4zyaag@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@kernel.org>

On 27-10-16, 12:11, Rafael J. Wysocki wrote:
> On the Intel side we also have a mechanism to tell the processor about
> the power/performance preference and it would be good to have a common
> way to do it on all platforms and genpd doesn't look like a
> particularly good place for that.
> 
> Let's talk about this at the LPC.

Thanks for your feedback Rafael.

As I wouldn't be attending the LPC (though would try to get some
information from the guys who are going to attend it), will it be
possible for you to summarize why you think genpd is not the right
choice here?

-- 
viresh
