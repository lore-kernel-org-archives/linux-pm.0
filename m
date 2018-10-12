From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC v1 2/8] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
Date: Fri, 12 Oct 2018 09:43:31 +0200
Message-ID: <CAJZ5v0hXM9krdacL09kJSn30AL_5kN+4U3d02rZX7-V2DWg_VQ@mail.gmail.com>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-3-git-send-email-rplsssn@codeaurora.org>
 <8161939.SRDo8Qx48D@aspire.rjw.lan> <20181011220842.GE2371@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011220842.GE2371@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, rplsssn@codeaurora.org, Andy Gross <andy.gross@linaro.org>, david.brown@linaro.org, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, "Nayak, Rajendra" <rnayak@codeaurora.org>, bjorn.andersson@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, evgreen@chromium.org, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 12, 2018 at 12:08 AM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Thu, Oct 11 2018 at 14:56 -0600, Rafael J. Wysocki wrote:
> >On Wednesday, October 10, 2018 11:20:49 PM CEST Raju P.L.S.S.S.N wrote:
> >> From: Ulf Hansson <ulf.hansson@linaro.org>
> >>
> >> To allow CPUs being power managed by PM domains, let's deploy support for
> >> runtime PM for the CPU's corresponding struct device.
> >>
> >> More precisely, at the point when the CPU is about to enter an idle state,
> >> decrease the runtime PM usage count for its corresponding struct device,
> >> via calling pm_runtime_put_sync_suspend(). Then, at the point when the CPU
> >> resumes from idle, let's increase the runtime PM usage count, via calling
> >> pm_runtime_get_sync().
> >>
> >> Cc: Lina Iyer <ilina@codeaurora.org>
> >> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> >> (am from https://patchwork.kernel.org/patch/10478153/)
> >> ---
> >>  kernel/cpu_pm.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> >> index 67b02e1..492d4a8 100644
> >> --- a/kernel/cpu_pm.c
> >> +++ b/kernel/cpu_pm.c
> >> @@ -16,9 +16,11 @@
> >>   */
> >>
> >>  #include <linux/kernel.h>
> >> +#include <linux/cpu.h>
> >>  #include <linux/cpu_pm.h>
> >>  #include <linux/module.h>
> >>  #include <linux/notifier.h>
> >> +#include <linux/pm_runtime.h>
> >>  #include <linux/spinlock.h>
> >>  #include <linux/syscore_ops.h>
> >>
> >> @@ -91,6 +93,7 @@ int cpu_pm_enter(void)
> >>  {
> >>      int nr_calls;
> >>      int ret = 0;
> >> +    struct device *dev = get_cpu_device(smp_processor_id());
> >>
> >>      ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
> >>      if (ret)
> >> @@ -100,6 +103,9 @@ int cpu_pm_enter(void)
> >>               */
> >>              cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
> >>
> >> +    if (!ret && dev && dev->pm_domain)
> >> +            pm_runtime_put_sync_suspend(dev);
> >
> >This may cause a power domain to go off, but if it goes off, then the idle
> >governor has already selected idle states for all of the CPUs in that domain.
> >
> >Is there any way to ensure that turning the domain off (and later on) will
> >no cause the target residency and exit latency expectations for those idle
> >states to be exceeded?
> >
> Good point.
>
> The cluster states should account for that additional latency.

But even then, you need to be sure that the idle governor selected
"cluster" states for all of the CPUs in the cluster.  It might select
WFI for one of them for reasons unrelated to the distance to the next
timer (so to speak), for example.

> Just the CPU's power down states need not care about that.

The meaning of this sentence isn't particularly clear to me. :-)

> But, it would be nice if the PM domain governor could be cognizant of
> the idle state chosen for each CPU, that way we dont configure the
> domain to be powered off when the CPUs have just chosen to power down
> (not chosen a cluster state). I think that is a whole different topic to
> discuss.

This needs to be sorted out before the approach becomes viable, though.

Basically, the domain governor needs to track what the idle governor
did for all of the CPUs in the domain and only let the domain go off
if the latency matches all of the states selected by the idle
governor.  Otherwise the idle governor's assumptions would be violated
and it would become essentially useless overhead.

Thanks,
Rafael
