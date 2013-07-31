From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC 3/3] cpufreq: cpufreq-cpu0: clk rate-change notifiers
Date: Wed, 31 Jul 2013 10:09:03 +0530
Message-ID: <CAKohpom-8KXixJ0ZbQ7Poh3uqJCqo7LFyYEfYeMyp+yZx9QmHA@mail.gmail.com>
References: <1373247868-21444-1-git-send-email-mturquette@linaro.org>
	<1373247868-21444-4-git-send-email-mturquette@linaro.org>
	<CAOh2x=kAM98Qta5RquVVByR8jJ3=t+6fNZ4o4WSroVCCZi+0Cg@mail.gmail.com>
	<20130731014328.5270.4248@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35741 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab3GaEjE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2013 00:39:04 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so496402obc.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2013 21:39:03 -0700 (PDT)
In-Reply-To: <20130731014328.5270.4248@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 31 July 2013 07:13, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Viresh Kumar (2013-07-07 21:10:54)
>> On Mon, Jul 8, 2013 at 7:14 AM, Mike Turquette <mturquette@linaro.org> wrote:
>> > Removes direct handling of OPP tables and voltage regulators by calling
>> > of_clk_cpufreq_notifier_handler, introduced by commit "clk: cpufreq
>> > helper for voltage scaling".
>> >
>> > In the future this can help consolidate code found across similar
>> > CPUfreq drivers.
>> >
>> > Signed-off-by: Mike Turquette <mturquette@linaro.org>
>> > ---
>> >  drivers/cpufreq/cpufreq-cpu0.c | 125 ++++++++---------------------------------
>> >  1 file changed, 22 insertions(+), 103 deletions(-)
>>
>> Good patch, really gets lots of stuff out from cpufreq drivers.
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Viresh,
>
> Thanks for the Ack. I received no comments on this series besides your
> own, so I plan to merge it. Do you want to take patch #3, or do you want
> me to take it, or should I give you and Rafael a stable branch instead?

Its only related to cpufreq-cpu0 and to handle dependencies well they
should go through a single tree.. Probably your tree is the right place for
now. Rafael?
