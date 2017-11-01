From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Wed, 1 Nov 2017 15:39:51 -0500
Message-ID: <CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ@mail.gmail.com>
References: <cover.1509453284.git.viresh.kumar@linaro.org> <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
 <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com> <CAKohpokvQD4Z6YY6MRG8c+hnsS=Z52X4XhyTgC5FTgf7VuaNmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpokvQD4Z6YY6MRG8c+hnsS=Z52X4XhyTgC5FTgf7VuaNmw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 31, 2017 at 9:17 PM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 31 October 2017 at 16:02, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> Why not a new property for magic values? opp-magic? Don't we want to
>> know when we have magic values?
>
> I have kept a separate property since beginning (domain-performance-state)
> and moved to using these magic values in the existing field because of the
> suggestion Kevin gave earlier.
>
> https://marc.info/?l=linux-kernel&m=149306082218001&w=2
>
> I am not sure what to do now :)

Okay, I guess reusing the properties is fine.

>> Wouldn't magic values in opp-hz get propagated to user space?
>
> The OPP core puts them in debugfs just to know how the OPPs are
> set. Otherwise, I am not sure that the power domain core/drivers would
> be exposing that to user space.

I was thinking thru the cpufreq interface, but I guess this is not for cpus.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
