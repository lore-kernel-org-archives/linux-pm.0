From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v12 1/4] PM / Domains: Add a generic data pointer to the
 genpd_power_state struct
Date: Thu, 21 Mar 2019 10:52:53 +0100
Message-ID: <a750f654-3bc0-f102-245f-fbc8abb08298@linaro.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-2-ulf.hansson@linaro.org>
 <11aa2536-9f9c-059d-a4d6-3f683be7caeb@linaro.org>
 <CAPDyKFoz8d2DTKTtBPn7+1wf_gGsANwU12++Wkb_KKndqGwWZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoz8d2DTKTtBPn7+1wf_gGsANwU12++Wkb_KKndqGwWZQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21/03/2019 10:36, Ulf Hansson wrote:
> On Thu, 21 Mar 2019 at 08:47, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

[ ... ]

>>>       cancel_work_sync(&genpd->power_off_work);
>>> -     kfree(genpd->free);
>>> +     if (genpd->free_states)
>>
>> Is this test necessary as the free_states function is initialized with
>> the genpd_set_default_power_state() in any case?
> 
> That's the case when the genpd provider did not allocate states, so
> then we know genpd deals with this properly for us.
> 
> In the other case, when genpd provider has allocates states, then we
> need to check that the provider has assigned the ->free_states()
> callback before we invokes it, as there is no guarantees that it had.
> 
> I was initially tempted to do this check already at pm_genpd_init(),
> as it would allow us to check for the error condition and return an
> error code if it's not been assigned. However, that requires me to
> change all providers that currently "allocates" their states, so that
> isn't really a smooth way forward. Perhaps, we should simply print a
> message to the log about this condition in pm_genpd_init(), as to
> start with!? I can add a patch on top doing that.

Yes, that would make sense to track those providers which do not
initialize the free field.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
