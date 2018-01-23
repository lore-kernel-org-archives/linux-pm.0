From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Fixup domain-idle-states OF parsing
Date: Tue, 23 Jan 2018 21:34:30 +0100
Message-ID: <CAPDyKFqFNrGXd4xcqfaf3au4V6b6oPFSHOOhv03P52sJiBkasg@mail.gmail.com>
References: <1516702990-25564-1-git-send-email-ulf.hansson@linaro.org> <20180123161201.GA29171@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:42150 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbeAWUec (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jan 2018 15:34:32 -0500
Received: by mail-it0-f68.google.com with SMTP id p139so2544710itb.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2018 12:34:31 -0800 (PST)
In-Reply-To: <20180123161201.GA29171@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On 23 January 2018 at 17:12, Lina Iyer <ilina@codeaurora.org> wrote:
> Hi Ulf,
>
> Thanks for the fix. The allocation is more than what is needed and this
> will fix that.
>
> On Tue, Jan 23 2018 at 10:23 +0000, Ulf Hansson wrote:
>>
>> but also makes of_genpd_parse_idle_states() to return the wrong number of
>> allocated elements to the caller.
>>
> How is this happening?
>
>>
>> Fixes: b539cc82d493 ("PM / Domains: Ignore domain-idle-states that are not
>> compatible")
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>> drivers/base/power/domain.c | 76
>> +++++++++++++++++++++++++++------------------
>> 1 file changed, 45 insertions(+), 31 deletions(-)
>>
>> -       /* Loop over the phandles until all the requested entry is found
>> */
>> -       of_for_each_phandle(&it, err, dn, "domain-idle-states", NULL, 0) {
>> -               np = it.node;
>> -               match_id = of_match_node(idle_state_match, np);
>> -               if (!match_id)
>> -                       continue;
>> -               ret = genpd_parse_state(&st[i++], np);
>
> This increments only if the state node matches the compatible.
>
>> -               if (ret) {
>> -                       pr_err
>> -                       ("Parsing idle state node %pOF failed with err
>> %d\n",
>> -                                                       np, ret);
>> -                       of_node_put(np);
>> -                       kfree(st);
>> -                       return ret;
>> -               }
>> +       ret = genpd_iterate_idle_states(dn, st);
>> +       if (ret <= 0) {
>> +               kfree(st);
>> +               return ret < 0 ? ret : -EINVAL;
>>         }
>>
>> -       *n = i;
>
> Returns the count of matched state nodes.
>
> What am I missing?

You are correct, there is nothing wrong here in regards to counting
and returning the number a *valid* idle states nodes.

However, I was referring in the changelog to the number of elements
that has been *allocated*. Obviously the number of elements allocated
will not match the numbers of valid idle state nodes, in case there is
one of more nodes not being compatible.

This is probably not an issue, so let me re-phrase the change log, to
make this more clear.

Thanks for reviewing!

Kind regards
Uffe
