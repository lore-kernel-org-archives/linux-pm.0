From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Wed, 1 Nov 2017 02:17:57 +0000
Message-ID: <CAKohpokvQD4Z6YY6MRG8c+hnsS=Z52X4XhyTgC5FTgf7VuaNmw@mail.gmail.com>
References: <cover.1509453284.git.viresh.kumar@linaro.org> <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
 <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 31 October 2017 at 16:02, Rob Herring <robh+dt@kernel.org> wrote:
> Why not a new property for magic values? opp-magic? Don't we want to
> know when we have magic values?

I have kept a separate property since beginning (domain-performance-state)
and moved to using these magic values in the existing field because of the
suggestion Kevin gave earlier.

https://marc.info/?l=linux-kernel&m=149306082218001&w=2

I am not sure what to do now :)

> Wouldn't magic values in opp-hz get propagated to user space?

The OPP core puts them in debugfs just to know how the OPPs are
set. Otherwise, I am not sure that the power domain core/drivers would
be exposing that to user space.

> I can
> see the complaints now. "My 4GHz processor is running at 6Hz!" Just
> like people complain when BogoMIPS is not high enough.

Hmm, would adding the right user type in bindings would be good enough
for that? I mean, we can clearly add that only power-domains that are
managed by firmware are allowed to use magic values here. But not sure
if we should put such stuff in bindings.

--
viresh
