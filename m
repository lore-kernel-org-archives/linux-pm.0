From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Implement free_opp_table function
Date: Fri, 16 May 2014 22:41:49 +0530
Message-ID: <CAKohpokCBbL1OkxB3rh0Pr3yqiG1H6UsZgD-WQTRvihxJt1-Qw@mail.gmail.com>
References: <1400231366-1221-1-git-send-email-inderpal.s@samsung.com>
	<CAKohponY6Nn5kYGyps2SLm5uBbH1JWuJBpzzVD=QOc=oM7crAg@mail.gmail.com>
	<CAOqmu82GQ2qsm0c7fq8n5ovR7+4j5t_Y3=03S=nWtR+bH3yhdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:60185 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757269AbaEPRLt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 May 2014 13:11:49 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so3322700oah.35
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2014 10:11:49 -0700 (PDT)
In-Reply-To: <CAOqmu82GQ2qsm0c7fq8n5ovR7+4j5t_Y3=03S=nWtR+bH3yhdg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Inderpal Singh <inderpal.s@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>

On 16 May 2014 22:38, Inderpal Singh <inderpal.s@samsung.com> wrote:
>>> +       while (!list_empty(&dev_opp->opp_list)) {
>>> +               opp = list_entry_rcu(dev_opp->opp_list.next,
>>> +                                       struct dev_pm_opp, node);
>>
>> list_for_each_entry_rcu ?
>>
>
> list_for_each_entry_rcu can not be used as opp is being deleted in the loop.

So what? The above code can be replaced easily I think.
This is how it is implemented:

#define list_for_each_entry_rcu(pos, head, member) \
        for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                &pos->member != (head); \
                pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
