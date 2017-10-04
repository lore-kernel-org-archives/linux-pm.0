From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V10 0/3] PM / Domains: Performance state support
Date: Wed, 4 Oct 2017 09:54:36 +0200
Message-ID: <CAPDyKFoM1fMkZ=j5EjUTiYR6Q9QprOZRAAkVEvfZixU6dJspoA@mail.gmail.com>
References: <cover.1505859768.git.viresh.kumar@linaro.org> <CAPDyKFoG7MovwoSfagw-CTo7WBGcQGjHgNtornNKGXNJ_AxLag@mail.gmail.com>
 <20171004064521.GA3002@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:44815 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdJDHyi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 03:54:38 -0400
Received: by mail-io0-f174.google.com with SMTP id m16so1384313iod.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Oct 2017 00:54:37 -0700 (PDT)
In-Reply-To: <20171004064521.GA3002@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

On 4 October 2017 at 08:45, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 03-10-17, 09:52, Ulf Hansson wrote:
>> We sorted out things at LPC!
>>
>> However, the last weeks discussions at Linaro connect, raised a couple
>> of more concerns with the current approach. Let me summarize them
>> here.
>>
>> 1)
>> The ->dev_get_performance_state(), which currently translates
>> frequency for a device to a performance index of its PM domain, is too
>> closely integrated with genpd. Instead this kind of translation rather
>> belongs as a part of the OPP core, because of not limiting this only
>> to translate frequencies, but perhaps *later* also voltages.
>>
>> 2)
>> Propagating an aggregated increased requested performance state index
>> for a genpd, upwards in the hierarchy of its master domains, is
>> currently not needed by any existing SoCs.
>>
>> 3) If some day the need for 2) becomes required, we must not assume a
>> 1 to 1 mapping of the supported performance state index for a
>> master/subdomain. For example a domain may support 1-5, while its
>> master may support 1-8.
>>
>> Taking this into consideration, this series need yet another round of
>> re-spin. The ->dev_get_performance_state() part should be move to the
>> OPP layer and the code dealing with the aggregation of the performance
>> state index can be greatly simplified.
>
> Thanks for the summary.
>
> From the above, it looks like I can send this series right away instead of
> waiting for the multiple genpd per device thing? Is that the case ?

Yes, I think so!

Kind regards
Uffe
