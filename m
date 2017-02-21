From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 4/6] PM / domain: Register for PM QOS performance notifier
Date: Tue, 21 Feb 2017 16:28:13 +0100
Message-ID: <CAPDyKFqsJsXqR--EL-srPTLLZXxHLYJMGWhTor+YJCO1XxjmQA@mail.gmail.com>
References: <cover.1486611268.git.viresh.kumar@linaro.org> <a973289cb908a391533a4b940af671beb2e8ace4.1486611268.git.viresh.kumar@linaro.org>
 <m27f4o4bl9.fsf@baylibre.com> <20170220050138.GO21911@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36164 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbdBUP2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2017 10:28:16 -0500
Received: by mail-qk0-f179.google.com with SMTP id x71so59102472qkb.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2017 07:28:15 -0800 (PST)
In-Reply-To: <20170220050138.GO21911@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>

[...]

>
>> > +   /* Propagate only if this domain has a single parent */
>>
>> Why?  This limitation should be explained in the cover letter and
>> changelog.  I would also expect some sort of WARN here since this could
>> otherwise be a rather silent failures.
>
> I think this limitation can just be removed, but I am confused a bit.
>
> I thought that support for multiple parent domains isn't yet there,
> isn't it? And that few people are trying to add it in kernel and the
> stuff is still under review. Like this thread:

A genpd PM domain can have several parents (or to use the genpd
terminology, masters).

This is different from allowing a device to be attached to more than
one PM domains, which is what I think you are referring to. That isn't
supported.

>
> https://lkml.org/lkml/2016/11/22/792
>
> --
> viresh

Kind regards
Uffe
