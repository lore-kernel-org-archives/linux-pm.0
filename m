From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V11 0/7] PM / Domains: Performance state support
Date: Wed, 11 Oct 2017 13:43:18 +0200
Message-ID: <CAPDyKFq9zgU5=EZsg4t4Jo4EA11v5Vaz23sQV9qHJoXL=58RoA@mail.gmail.com>
References: <cover.1507703370.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1507703370.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 11 October 2017 at 09:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> This version contains the changes we discussed during Linaro Connect.
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
> OPP core. The third patch adds a new API to the OPP core to get
> performance state corresponding to OPPs (This should rather come via DT
> and would be removed once we have fixed bindings for performance
> states).
>
> Rest of the patches [4-7/7] are included to show how user drivers would
> end up using the new APIs and these patches aren't ready to get merged
> yet and are marked clearly like that. Moreover some of them may go via
> SoC specific trees instead of the PM tree.
>
> This is currently tested by:
> - /me by hacking the kernel a bit with virtual power-domains for the ARM
>   64 hikey platform.
> - Rajendra Nayak, on msm8996 platform (Qcom) with MMC controller.
>
> Thanks Rajendra for helping me testing this out.
>
> I also had a chat with Rajendra and we should be able to get a Qualcomm
> specific power domain driver (which uses these changes) in coming weeks.
>
> I am targeting the first 3 patches for 4.15-rc1, if possible.

I have looked through the series and overall it looks okay to me. I
think my comments on patch1 should be rather simple to address - and
so I agree that aiming for 4.15rc1 seems like a reasonable plan.

Kind regards
Uffe
