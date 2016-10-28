From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Discussion] Performance levels of power domains
Date: Fri, 28 Oct 2016 09:32:40 +0530
Message-ID: <20161028040240.GI10423@vireshk-i7>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
 <7hvawfq6kh.fsf@baylibre.com>
 <CAJZ5v0jPeauJGpQfr1VjDo1Z-Xd6UT4_4QLeso_CSEtB4zyaag@mail.gmail.com>
 <CAPDyKFrO6VxnfnG7ragPj80auWPJWMmfRABwsNnCg3U4gGCR4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35797 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755811AbcJ1ECo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2016 00:02:44 -0400
Received: by mail-pf0-f179.google.com with SMTP id s8so29599036pfj.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Oct 2016 21:02:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFrO6VxnfnG7ragPj80auWPJWMmfRABwsNnCg3U4gGCR4g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@kernel.org>

On 27-10-16, 13:46, Ulf Hansson wrote:
> One thing that would be interesting to know is where the
> power/performance preference "voting" can be done. Is that in also in
> the separate processor or is that a job for the kernel?

In our case it is required to be done by the kernel.

> Perhaps the OPP framework might be better place? One could also think
> of extending this to support "OPP PM domains"...

OPP framework will surely get some updates for this, as it needs to
relate the frequencies with power levels for the domains.

-- 
viresh
