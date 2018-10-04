From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v9 03/11] PM / Domains: Document flags for genpd
Date: Thu, 4 Oct 2018 16:57:37 +0200
Message-ID: <CAPDyKFr1H_ah3OYqghQgADs8fwNd+HpjWw9VfGR1T1-K5KbnhQ@mail.gmail.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-4-ulf.hansson@linaro.org> <20181004134839.GZ5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004134839.GZ5662@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 4 October 2018 at 15:48, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Ulf Hansson <ulf.hansson@linaro.org> [181003 14:43]:
>> + * GENPD_FLAG_IRQ_SAFE:              This informs genpd that its backend callbacks,
>> + *                           ->power_on|off(), doesn't sleep. Hence, these
>> + *                           can be invoked from within atomic context, which
>> + *                           enables genpd to power on/off the PM domain,
>> + *                           even when pm_runtime_is_irq_safe() returns true,
>> + *                           for any of its attached devices. Note that, a
>> + *                           genpd having this flag set, requires its
>> + *                           masterdomains to also have it set.
>> + *
>
> Let's try to avoid adding more irq_safe stuff because of having that
> propagate to the masterdomains..

I am not sure I get your point. This is just documenting existing
functionality in genpd, there is nothing new here.

>
> I think you can just flag the power_on/off in genpd, then have cpu_pm
> callbacks do it.

Not really sure what you propose, but feel free to send a patch.

Do note, genpd has since the beginning of its time tried to cope with
pm_runtime_irq_safe() devices. I admit it's quite complicated, however
GENPD_FLAG_IRQ_SAFE greatly improved the support for such devices and
their PM domains. Moreover, we need this functionality, in one way or
the other, as long as there users of pm_runtime_irq_safe().

Kind regards
Uffe
