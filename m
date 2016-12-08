From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/10] PM / OPP: Error out on failing to add static OPPs
 for v1 bindings
Date: Thu, 8 Dec 2016 20:17:11 +0530
Message-ID: <CAKohpo=uoRxhCDL-u33pc9SFCogGkRCVGtyV13D=uGBNrC+-ow@mail.gmail.com>
References: <cover.1481015522.git.viresh.kumar@linaro.org> <1f876a6d176784f9ab901aea7ff521d53522682d.1481015522.git.viresh.kumar@linaro.org>
 <20161207011722.GJ4388@codeaurora.org> <20161207032555.GE31255@vireshk-i7>
 <20161207211343.GA5423@codeaurora.org> <20161208033059.GA24152@vireshk-i7>
 <20161208063918.GG2749@dragon> <20161208064513.GC31711@vireshk-i7> <20161208142706.GH2749@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34226 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbcLHOrM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2016 09:47:12 -0500
Received: by mail-io0-f177.google.com with SMTP id p42so4696213ioo.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Dec 2016 06:47:12 -0800 (PST)
In-Reply-To: <20161208142706.GH2749@dragon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

On 8 December 2016 at 19:57, Shawn Guo <shawnguo@kernel.org> wrote:
> That's the same case when Performance governor is selected, and should
> be guaranteed safe, shouldn't it?

Depends on platform I would say. For example for a big LITTLE platform, running
the big core on max not only increases the amount of power it uses but also the
amount of heat it generates, which is really scary.

Performance governor is fine for testing but it is not used for battery operated
devices in production code.

>> We will surely overheat most of the SoCs
>> and burn them out.
>
> IMO, the problem is on OPP table.  Every entry in the table should be
> safe for running for any time.

Not necessarily. The highest OPPs might be suggested to run only
for small period of time only. And there is nothing wrong in it.

Over that if some of the OPPs fail to get registered from the OPP
table in DT, it surely hints at some sort of bugs in the code or DT.

Why should we try to go ahead if only a part of the DT table gets
registered? I don't find a compelling reason for that. It will never
happen normally anyway, as we wouldn't have any errors.

--
viresh
