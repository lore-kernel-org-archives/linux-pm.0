From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v8 00/26] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Date: Tue, 3 Jul 2018 09:54:12 +0200
Message-ID: <CAJZ5v0hcBiYPMh8V50yq0jQud32Ey8V-ukiavJkP4PU4zAiFyg@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <CAPDyKFpy8rpjRTBsHUFa_L0M_C=vH+6qjq=Kxdn+0j+T5NNSMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpy8rpjRTBsHUFa_L0M_C=vH+6qjq=Kxdn+0j+T5NNSMQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 3, 2018 at 7:44 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Rafael,
>
> On 20 June 2018 at 19:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Changes in v8:
>>  - Added some tags for reviews and acks.
>>  - Cleanup timer patch (patch6) according to comments from Rafael.
>>  - Rebased series on top of v4.18rc1 - it applied cleanly, except for patch 5.
>>  - While adopting patch 5 to new genpd changes, I took the opportunity to
>>    improve the new function description a bit.
>>  - Corrected malformed SPDX-License-Identifier in patch20.
>
> There have only been a minor comment from you at patch3 (about
> squashing it with patch21), with that fixed and assuming there are no
> further comments - would you like me to collect the changes and send
> it to you as a pull request?

I have not looked at them in detail yet, sorry.

I any case, I'll apply the patches by hand.

Thanks,
Rafael
