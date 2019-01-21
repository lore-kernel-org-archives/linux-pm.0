From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 2/9] drivers: thermal: of-thermal: Print name of device
 node with error
Date: Mon, 21 Jan 2019 15:09:58 +0530
Message-ID: <CAHLCerNqZny+KSs-S-+KbpdGjxtB4wafygAY4M7oNc8kvEqT2A@mail.gmail.com>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <f7c145e6d5164c3386f0a325a4cdcc726362f6db.1547458732.git.amit.kucheria@linaro.org>
 <154751007298.169631.16954120258961808334@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154751007298.169631.16954120258961808334@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Andy Gross <andy.gross@linaro.org>, Taniya Das <tdas@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 15, 2019 at 5:24 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-01-14 02:21:04)
> > Make it easier to debug devicetree definition in case of errors.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/of-thermal.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> > index 4bfdb4a1e47d..08c3ccbdacf8 100644
> > --- a/drivers/thermal/of-thermal.c
> > +++ b/drivers/thermal/of-thermal.c
> > @@ -867,14 +867,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
> >
> >         ret = of_property_read_u32(np, "polling-delay-passive", &prop);
> >         if (ret < 0) {
> > -               pr_err("missing polling-delay-passive property\n");
> > +               pr_err("%pOFn: missing polling-delay-passive property\n", np->name);
>
> Not sure you've triggered this code path because it's an error, but I'd
> expect it to just be np, not np->name here. It's too bad the compiler
> can't catch this.

Not sure what happened here in the refactor before sending but good
catch. Fixed now.

Thanks,
Amit
