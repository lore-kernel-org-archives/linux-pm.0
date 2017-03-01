From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3 2/7] PM / OPP: Introduce "domain-performance-state"
 binding to OPP nodes
Date: Wed, 1 Mar 2017 09:45:45 +0100
Message-ID: <CAMuHMdWnDJ2RvGgYOxSiB=2Z32-bZwNjnEQG6TK2Umtf4eiAYw@mail.gmail.com>
References: <cover.1487926924.git.viresh.kumar@linaro.org> <ceb1bf5f696138c30b30743c24b619336d438d7c.1487926924.git.viresh.kumar@linaro.org>
 <20170228003948.ihf4c2ppu2rf3lt2@rob-hp-laptop> <20170228065711.GD19417@vireshk-i7>
 <CAL_JsqLx6Y=JgaVtJPFwERQ_=5qwqp5EY1+B=cdfBJO55Vct4w@mail.gmail.com>
 <CAPDyKFo5TjTa-hTzNp5KCpozU87L22piCXaSjWMTr4xVkgP+Pg@mail.gmail.com>
 <CAL_Jsq+7DGX_1U99cc3rhk8zzSj6iKe3kpijp7KTz90xXA_V9g@mail.gmail.com> <20170301061402.GE24323@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33835 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdCAIps (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 03:45:48 -0500
In-Reply-To: <20170301061402.GE24323@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Mar 1, 2017 at 7:14 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 28-02-17, 09:52, Rob Herring wrote:
>> On Tue, Feb 28, 2017 at 9:14 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > This comes from the early design of the generic PM domain, thus I
>> > assume we have some HW with such complex PM topology. However, I don't
>> > know if it is actually being used.
>> >
>> > Moreover, the corresponding DT bindings for "power-domains" parents,
>> > can easily be extended to cover more than one parent. See more in
>> > Documentation/devicetree/bindings/power/power_domain.txt
>>
>> I could easily see device having 2 power domains. For example a cpu
>> may have separate domains for RAM/caches and logic.
>
> An important thing here is that PM domain doesn't support such devices. i.e. a
> device isn't allowed to have multiple PM domains today. So a way to support such
> devices can be to create a virtual PM domain, that has two parents and device as
> its child.

As clock domains (and their support code) are fairly orthogonal to power
areas, currently our power area controller driver just forwards the
clock handling
to the clock driver (cfr. rcar-sysc).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
