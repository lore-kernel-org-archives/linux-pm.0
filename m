From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Tue, 28 Nov 2017 17:38:52 +0100
Message-ID: <CAPDyKFryn5=GMs+hiRcxGOC1U=-LL9RQdnY3cWniyE+4pwQDog@mail.gmail.com>
References: <cover.1509453284.git.viresh.kumar@linaro.org> <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
 <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com>
 <CAKohpokvQD4Z6YY6MRG8c+hnsS=Z52X4XhyTgC5FTgf7VuaNmw@mail.gmail.com>
 <CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ@mail.gmail.com>
 <20171101214333.GG30645@codeaurora.org> <20171102045155.GX4240@vireshk-i7>
 <20171102071533.GM30645@codeaurora.org> <20171102090033.GZ4240@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171102090033.GZ4240@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 2 November 2017 at 10:00, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 02-11-17, 00:15, Stephen Boyd wrote:
>> Sorry I'm not following. We're going to need to have platform
>> specific code that understands platform specific bindings that
>> aren't shoved into the generic OPP bindings.
>
> At least I am not targeting any platform specific binding right now.
> The way I see this to work is:
>
> - We will reuse earlier bindings and allow opp-hz and opp-microvolt to
>   contain special values (this patch).
> - Platform specific DT entries will put corner numbers in opp-hz (or
>   opp-microvolt) fields.
> - Some platform specific driver (in OPP or genpd) will be used to
>   convert OPP into a performance state (corner) value. Now that can
>   simply read opp-hz (or opp-microvolt) and return its value.

Since the "operating-points-v2" phandle(s) belongs in the power-domain
controller device node, which anyway is being parsed by the genpd SoC
specific driver, I assume it makes sense to start the initialization
from there. Unless there is something that prevents that, of course.

Then whatever library/helper functions we need for parse and create
the OPP tables, can be provided to the OPP framework and the OPP OF
library.

> - OPP core will request for a performance state (code is already
>   merged for that).
>
> And so there is no platform specific binding here. Do you want to do
> this differently ?

This makes sense to me!

Also, the SoC (QCOM) specific genpd driver is free to use the
terminology "corner values", when it translates opp-hz|microvolt into
such values.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
