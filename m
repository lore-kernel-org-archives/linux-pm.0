From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Discussion] Performance levels of power domains
Date: Thu, 27 Oct 2016 12:14:30 +0200
Message-ID: <CAJZ5v0j6si=s75KgPUQ0EmdzbvQgoYj0ziDNH+MmomZhj9MfdQ@mail.gmail.com>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
 <7hvawfq6kh.fsf@baylibre.com> <20161027034638.GA10423@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34462 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936101AbcJ0Nut (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2016 09:50:49 -0400
Received: by mail-lf0-f41.google.com with SMTP id b81so31719575lfe.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Oct 2016 06:50:48 -0700 (PDT)
In-Reply-To: <20161027034638.GA10423@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@kernel.org>

On Thu, Oct 27, 2016 at 5:46 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
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

Well, as I've just written in a message to Kevin, there are reasons
why genpd may not be the best place for that.

Thanks,
Rafael
