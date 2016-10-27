From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Discussion] Performance levels of power domains
Date: Thu, 27 Oct 2016 13:58:08 +0530
Message-ID: <20161027082808.GD10423@vireshk-i7>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
 <7hvawfq6kh.fsf@baylibre.com>
 <20161027034638.GA10423@vireshk-i7>
 <CAKfTPtDD=nGiOno9z2q3pcgQFB8RJwTb1fSmOZJRPZEy0Et8DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33819 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936192AbcJ0PfF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2016 11:35:05 -0400
Received: by mail-pf0-f180.google.com with SMTP id n85so20042036pfi.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Oct 2016 08:35:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKfTPtDD=nGiOno9z2q3pcgQFB8RJwTb1fSmOZJRPZEy0Et8DA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@kernel.org>

On 27-10-16, 09:17, Vincent Guittot wrote:
> The M3 core takes only care of the voltage but not the clock ?

Yes. The is handled normally.

> Just to be sure to understand the problem:
> -There is no real voltage value but instead an opaque index that has
> to be used with frequency instead of a voltage.
> -This index is used by the M3 core to set voltages but M3 core doesn't
> set the clock which is managed by Linux.
> -The M3 core takes only one index input for the whole voltage domain
> and Linux must aggregate the constraints (with probably a max policy)
> of all devices that belong this domain
> 
> Am i missing something ?

No. All matches to my understanding of the problem.

-- 
viresh
