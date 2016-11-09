From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Discussion] Performance levels of power domains
Date: Wed, 9 Nov 2016 17:16:16 +0530
Message-ID: <CAKohpo=D5KVNVEHqUd5SuEy0UNvTSqaUBd8MNuM8OTO=jjqKqw@mail.gmail.com>
References: <CAKohpokwTOZbbRP4XRV1jPoQ=gKxD2UKBYSXcZe8iBgDnr9-BQ@mail.gmail.com>
 <7hvawfq6kh.fsf@baylibre.com> <CAJZ5v0jPeauJGpQfr1VjDo1Z-Xd6UT4_4QLeso_CSEtB4zyaag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35560 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbcKILqR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 06:46:17 -0500
Received: by mail-qt0-f173.google.com with SMTP id c47so124850978qtc.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Nov 2016 03:46:17 -0800 (PST)
In-Reply-To: <CAJZ5v0jPeauJGpQfr1VjDo1Z-Xd6UT4_4QLeso_CSEtB4zyaag@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@kernel.org>

On 27 October 2016 at 15:41, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Oct 26, 2016 at 9:00 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>>
>>> Hi Guys,
>>>
>>> I wanted to involve you guys to get a discussion going
>>> for a problem we want to solve, and so this mail.
>>>
>>>
>>> Platform details:
>>>
>>> Some of the Qualcom SoCs have the option to configure
>>> the performance level of their Power Domains. The performance
>>> levels are identified by integer values (lets say 0-9, 0 being the lowest).
>>>
>>> Another M3 core handles the *real* voltage scaling based on the input
>>> received (from software) in terms of these performance levels. The M3
>>> core translates the levels into a range of voltages (corners) and selects
>>> the right one by itself.
>>>
>>> Software needs to provide the performance level for the entire domain
>>> to the M3 core and so software also needs to handle performance requests
>>> from all the devices that lie in the domain X and find a Performance Level P,
>>> which can satisfy all the devices (normally the highest requrested level).
>>>
>>>
>>> Problem statement:
>>>
>>> As we aren't dealing with Voltages here, we can't really get the benefits
>>> of the Regulators framework. The regulators are managed internally
>>> by the M3 core. All we need is a way for software to comeout with inputs
>>> for the M3 core.
>>>
>>> The OPP framework can be used to include performance levels for
>>> each OPP (frequency) entry.
>>>
>>> But what framework can be used to select performance level of power
>>> domains ?
>>>
>>> By name, power-domain or genpd looks to be the right choice, but until
>>> now it is only managing power-on and power-off of devices and domains.
>>
>> genpd has also recently been extended to support multiple states, though
>> those are still idle states, not active (performance) states.
>>
>>> Should we extend that (along with runtime PM), or do something else?
>>
>> Yes.  As I've suggested to qcom/linaro folks (off-list discussions), I
>> think extending genpd to handle performance states is a logical
>> extension.  Otherwise, you will be (re)inventing something that looks an
>> awful lot like genpd anyways.
>
> On the Intel side we also have a mechanism to tell the processor about
> the power/performance preference and it would be good to have a common
> way to do it on all platforms and genpd doesn't look like a
> particularly good place for that.
>
>> The other related framework is per-device PM QoS which could be used to
>> set constraints on specific devices, and the genpd governors would then
>> be responsible for looking at the constraints and changing states as
>> needed.
>
> Right.
>
> Let's talk about this at the LPC.

Any updates from LPC on this ?
