From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V10 0/3] PM / Domains: Performance state support
Date: Tue, 3 Oct 2017 09:52:50 +0200
Message-ID: <CAPDyKFoG7MovwoSfagw-CTo7WBGcQGjHgNtornNKGXNJ_AxLag@mail.gmail.com>
References: <cover.1505859768.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:46769 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdJCHwv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2017 03:52:51 -0400
Received: by mail-io0-f174.google.com with SMTP id d16so6863990ioj.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Oct 2017 00:52:51 -0700 (PDT)
In-Reply-To: <cover.1505859768.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

On 20 September 2017 at 00:32, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Ulf,
>
> This version contains the changes we discussed during the LPC.
>
> Some platforms have the capability to configure the performance state of
> their power domains. The process of configuring the performance state is
> pretty much platform dependent and we may need to work with a wide range
> of configurables.  For some platforms, like Qcom, it can be a positive
> integer value alone, while in other cases it can be voltage levels, etc.
>
> The power-domain framework until now was only designed for the idle
> state management of the device and this needs to change in order to
> reuse the power-domain framework for active state management of the
> devices.
>
> The first patch updates the genpd framework to supply new APIs to
> support active state management and the second patch uses them from the
> OPP core. The third patch adds some more checks to the genpd core to
> catch bugs.
>
> Rest of the patches [4-7/7] are included just to show how user drivers
> would end up using the new APIs and these patches aren't there to get
> merged and are marked clearly like that.
>
> The ideal way is still to get the relation between device and domain
> states via the DT instead of platform code, but that can be done
> incrementally later once we have some users for it upstream.
>
> This is currently tested by:
> - /me by hacking the kernel a bit with virtual power-domains for the ARM
>   64 hikey platform. I have also tested the complex cases where the
>   device's parent power domain doesn't have set_performance_state()
>   callback set, but parents of that domains have it. Lockdep configs
>   were enabled for these tests.
> - Rajendra Nayak, on msm8996 platform (Qcom) with MMC controller.
>
> Thanks Rajendra for helping me testing this out.
>
> I also had a chat with Rajendra and we should be able to get a Qualcomm
> specific power domain driver (which uses these changes) in coming weeks.
> Though it wouldn't solve all the problems around corners they have, as
> they need more updates later on (Like support for multiple masters for a
> device, etc).

We sorted out things at LPC!

However, the last weeks discussions at Linaro connect, raised a couple
of more concerns with the current approach. Let me summarize them
here.

1)
The ->dev_get_performance_state(), which currently translates
frequency for a device to a performance index of its PM domain, is too
closely integrated with genpd. Instead this kind of translation rather
belongs as a part of the OPP core, because of not limiting this only
to translate frequencies, but perhaps *later* also voltages.

2)
Propagating an aggregated increased requested performance state index
for a genpd, upwards in the hierarchy of its master domains, is
currently not needed by any existing SoCs.

3) If some day the need for 2) becomes required, we must not assume a
1 to 1 mapping of the supported performance state index for a
master/subdomain. For example a domain may support 1-5, while its
master may support 1-8.

Taking this into consideration, this series need yet another round of
re-spin. The ->dev_get_performance_state() part should be move to the
OPP layer and the code dealing with the aggregation of the performance
state index can be greatly simplified.

[...]

Kind regards
Uffe
