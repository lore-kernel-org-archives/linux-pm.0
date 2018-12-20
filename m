From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM domains
Date: Thu, 20 Dec 2018 16:49:09 +0100
Message-ID: <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org> <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Dec 2018 at 15:19, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > Following changes are about to implement support for PM domains to PSCI.
> > Those changes are mainly going to be implemented in a new separate file,
> > hence a couple of the internal PSCI functions needs to be shared to be
> > accessible. So, let's do that via adding new PSCI header file.
> >
> > Moreover, the changes deploying support for PM domains, needs to be able to
> > switch the PSCI FW into the OS initiated mode. For that reason, let's add a
> > new function that deals with this and share it via the new PSCI header
> > file.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - New patch. Re-places the earlier patch: "drivers: firmware: psci:
> >         Share a few internal PSCI functions".
> >
> > ---
> >  drivers/firmware/psci/psci.c | 28 +++++++++++++++++++++-------
> >  drivers/firmware/psci/psci.h | 14 ++++++++++++++
> >  2 files changed, 35 insertions(+), 7 deletions(-)
> >  create mode 100644 drivers/firmware/psci/psci.h
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index 8dbcdecc2ae4..623591b541a4 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -34,6 +34,8 @@
> >  #include <asm/smp_plat.h>
> >  #include <asm/suspend.h>
> >
> > +#include "psci.h"
> > +
> >  /*
> >   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> >   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> > @@ -90,23 +92,35 @@ static u32 psci_function_id[PSCI_FN_MAX];
> >  static DEFINE_PER_CPU(u32, domain_state);
> >  static u32 psci_cpu_suspend_feature;
> >
> > -static inline u32 psci_get_domain_state(void)
> > +u32 psci_get_domain_state(void)
> >  {
> >       return __this_cpu_read(domain_state);
> >  }
> >
> > -static inline void psci_set_domain_state(u32 state)
> > +void psci_set_domain_state(u32 state)
> >  {
> >       __this_cpu_write(domain_state, state);
> >  }
> >
> > +bool psci_set_osi_mode(void)
> > +{
> > +     int ret;
> > +
> > +     ret = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
> > +                     PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
> > +     if (ret)
> > +             pr_warn("failed to enable OSI mode: %d\n", ret);
> > +
> > +     return !ret;
> > +}
>
> Please keep the convention with the error code (0 => success)
>
> In the next patch it can be called:
>
> if (psci_has_osi_support())
>         osi_mode_enabled = psci_set_osi_mode() ? false : true;
>

Sure!

> > +
> >  static inline bool psci_has_ext_power_state(void)
> >  {
> >       return psci_cpu_suspend_feature &
> >                               PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
> >  }
> >
> > -static inline bool psci_has_osi_support(void)
> > +bool psci_has_osi_support(void)
> >  {
> >       return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
> >  }
> > @@ -285,10 +299,7 @@ static int __init psci_features(u32 psci_func_id)
> >                             psci_func_id, 0, 0);
> >  }
> >
> > -#ifdef CONFIG_CPU_IDLE
> > -static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> > -
> > -static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> > +int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> >  {
> >       int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
> >
> > @@ -305,6 +316,9 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_CPU_IDLE
>
> It would be nicer if you can remove the CONFIG_CPU_IDLE by replacing it
> with a specific one (eg. CONFIG_PSCI_IDLE) and make it depend on
> CONFIG_CPU_IDLE, so the config options stay contained in their
> respective subsystems directory.

I am all for simplifying the Kconfig options in here, as indeed it's
rather messy. However, I would rather avoid folding in additional
cleanup changes to this series, is already extensive enough.

Would you be okay if we deal with that on top?

[...]

Kind regards
Uffe
