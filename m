From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Wed, 1 Nov 2017 14:43:33 -0700
Message-ID: <20171101214333.GG30645@codeaurora.org>
References: <cover.1509453284.git.viresh.kumar@linaro.org>
 <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
 <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com>
 <CAKohpokvQD4Z6YY6MRG8c+hnsS=Z52X4XhyTgC5FTgf7VuaNmw@mail.gmail.com>
 <CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11/01, Rob Herring wrote:
> On Tue, Oct 31, 2017 at 9:17 PM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On 31 October 2017 at 16:02, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >> Why not a new property for magic values? opp-magic? Don't we want to
> >> know when we have magic values?
> >
> > I have kept a separate property since beginning (domain-performance-state)
> > and moved to using these magic values in the existing field because of the
> > suggestion Kevin gave earlier.
> >
> > https://marc.info/?l=linux-kernel&m=149306082218001&w=2
> >
> > I am not sure what to do now :)
> 
> Okay, I guess reusing the properties is fine.
> 

We call them corners on qcom platforms. Any reason we can't keep
using that name? I'd rather not have to keep telling people that
these fake values in some misnamed property is actually a corner.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
