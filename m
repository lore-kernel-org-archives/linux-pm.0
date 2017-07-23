From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V8 1/6] PM / Domains: Add support to select
 performance-state of domains
Date: Sun, 23 Jul 2017 09:20:42 +0200
Message-ID: <CAPDyKFo_10Q3GOmygejBjW15jk23tbgDNrK2aMV+DvcF5S8oQw@mail.gmail.com>
References: <cover.1498026827.git.viresh.kumar@linaro.org> <52daf22d2c9d92b0e61c8c5c5a88516d7a08a31a.1498026827.git.viresh.kumar@linaro.org>
 <CAPDyKFqaFvET9yM_6wr7b1Zw=hePQrE-Ak-7YPCR9izooh4LBA@mail.gmail.com>
 <20170719123751.GF352@vireshk-i7> <CAPDyKFr0ZMeS=57p48W9f_j3U0T41msxOqQHBXB_soA8-weM+w@mail.gmail.com>
 <20170721090519.GO352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:35144 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdGWHUo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jul 2017 03:20:44 -0400
Received: by mail-ua0-f173.google.com with SMTP id d29so52321642uai.2
        for <linux-pm@vger.kernel.org>; Sun, 23 Jul 2017 00:20:43 -0700 (PDT)
In-Reply-To: <20170721090519.GO352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

On 21 July 2017 at 11:05, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21-07-17, 10:35, Ulf Hansson wrote:
>> This depends on how drivers are dealing with runtime PM in conjunction
>> with the new pm_genpd_update_performance_state().
>>
>> In case you don't want to manage some of this in genpd, then each
>> driver will have to drop their constraints every time they are about
>> to runtime suspend its device. And restore them at runtime resume.
>>
>> To me, that's seems like a bad idea. Then it's better to make genpd
>> deal with this - somehow.
>
> Right. So we should call the ->set_performance_state() from off/on as
> well. Will do that.
>
>> Yes!
>>
>> On top of that change, you could also add some validation if the
>> get/set callbacks is there are any constraints on how they must be
>> assigned.
>
> I am not sure if I understood that, sorry. What other constraints are
> you talking about ?

Just thinking that if a genpd is about to be added as a subdomain, and
it has ->get_performance_state(), but not ->set_performance_state(),
perhaps we should require its master to have
->set_performance_state().

Anyway, I let you do the thinking of what is and what is not needed here.

[...]

>>
>> My main concern is the order of how you take the looks. We never take
>> a masters lock before the current domain lock.
>
> Right and this patch doesn't break that.
>
>> And when walking the topology, we use the slave links and locks the
>> first master from that list. Continues with that tree, then get back
>> to slave list and pick the next master.
>
> Again, that's how this patch does it.
>
>> If you change that order, we could end getting deadlocks.
>
> And because that order isn't changed at all, we shouldn't have
> deadlocks.

True. Trying to clarify more below...

>
>> >> A general comment is that I think you should look more closely in the
>> >> code of genpd_power_off|on(). And also how it calls the
>> >> ->power_on|off() callbacks.
>> >>
>> >> Depending whether you want to update the performance state of the
>> >> master domain before the subdomain or the opposite, you will find one
>> >> of them being suited for this case as well.
>> >
>> > Isn't it very much similar to that already ? The only major difference
>> > is link->performance_state and I already explained why is it required
>> > to be done that way to avoid deadlocks.
>>
>> No, because you walk the master lists. Thus getting a different order or locks.
>>
>> I did some drawing of this, using the slave links, and I don't see any
>> issues why you can't use that instead.
>
> Damn, I am confused on which part are you talking about. Let me paste
> the code here once again and clarify how this is supposed to work just fine :)

I should have been more clear. Walking the master list, then checking
each link without using locks - why is that safe?

Then even if you think it's safe, then please explain in detail why its needed.

Walking the slave list as being done for power off/on should work
perfectly okay for your case as well. No?

[...]

Kind regards
Uffe
