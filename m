From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC V2 1/6] cpufreq: Replace "max_transition_latency" with "dynamic_switching"
Date: Fri, 14 Jul 2017 13:11:58 +0200
Message-ID: <CAJZ5v0hagTXFmV94abxeEL5=dPn0FQtW7SogyK6iJd6ika+GUQ@mail.gmail.com>
References: <cover.1499853492.git.viresh.kumar@linaro.org> <4b9ff9a3f546b2269ddb2da27c9e5be5f106a70f.1499853492.git.viresh.kumar@linaro.org>
 <CAJZ5v0g-DgV6G-J9pkAYKooqgbJDV_ML8cR8wquKksN=x_JpoQ@mail.gmail.com> <20170714070142.GA14515@isilmar-4.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36388 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdGNLL7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2017 07:11:59 -0400
In-Reply-To: <20170714070142.GA14515@isilmar-4.linta.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jul 14, 2017 at 9:01 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Thu, Jul 13, 2017 at 06:19:53PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Jul 13, 2017 at 7:40 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > There is no limitation in the ondemand or conservative governors which
>> > disallow the transition_latency to be greater than 10 ms.
>> >
>> > The max_transition_latency field is rather used to disallow automatic
>> > dynamic frequency switching for platforms which didn't wanted these
>> > governors to run.
>> >
>> > Replace max_transition_latency with a boolean (dynamic_switching) and
>> > check for transition_latency == CPUFREQ_ETERNAL along with that. This
>> > makes it pretty straight forward to read/understand now.
>>
>> Well, using CPUFREQ_ETERNAL for that on the driver side is still not
>> particularly straightforward IMO, so maybe add a
>> "no_dynamic_switching" to the driver structure and set it to "true"
>> for the one driver in question?
>
> IIRC it's not just one driver which sets the latency to CPUFREQ_ETERNAL, and
> where dynamic switching might be harmful or at least lead to undefined
> behavior.

OK

Still, though, using CPUFREQ_ETERNAL to indicate the "no dynamic
switching" condition is somewhat convoluted, so why don't we have a
flag to *explicitly* say that instead?

Do you know which drivers they are or is it just all drivers that use
CPUFREQ_ETERNAL?

Thanks,
Rafael
