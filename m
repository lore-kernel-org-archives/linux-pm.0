From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Discussion] Performance levels of power domains
Date: Thu, 27 Oct 2016 12:26:38 +0200
Message-ID: <CAJZ5v0hXM-UTq4nv5NFbjikLXR4=-RK=kY5qTSL=vuL2HhY1uA@mail.gmail.com>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
 <7hvawfq6kh.fsf@baylibre.com> <CAJZ5v0jPeauJGpQfr1VjDo1Z-Xd6UT4_4QLeso_CSEtB4zyaag@mail.gmail.com>
 <20161027102329.GF10423@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38081 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938597AbcJ0OQx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2016 10:16:53 -0400
Received: by mail-wm0-f47.google.com with SMTP id n67so45903950wme.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Oct 2016 07:16:39 -0700 (PDT)
In-Reply-To: <20161027102329.GF10423@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@kernel.org>

On Thu, Oct 27, 2016 at 12:23 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27-10-16, 12:11, Rafael J. Wysocki wrote:
>> On the Intel side we also have a mechanism to tell the processor about
>> the power/performance preference and it would be good to have a common
>> way to do it on all platforms and genpd doesn't look like a
>> particularly good place for that.
>>
>> Let's talk about this at the LPC.
>
> Thanks for your feedback Rafael.
>
> As I wouldn't be attending the LPC (though would try to get some
> information from the guys who are going to attend it), will it be
> possible for you to summarize why you think genpd is not the right
> choice here?

There is a mechanism to tell the processor about power/performance
preferences on the Intel side and it is not related to genpd in any
way.

Thanks,
Rafael
