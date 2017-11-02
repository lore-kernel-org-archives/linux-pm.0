From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Thu, 2 Nov 2017 00:15:33 -0700
Message-ID: <20171102071533.GM30645@codeaurora.org>
References: <cover.1509453284.git.viresh.kumar@linaro.org>
 <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
 <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com>
 <CAKohpokvQD4Z6YY6MRG8c+hnsS=Z52X4XhyTgC5FTgf7VuaNmw@mail.gmail.com>
 <CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ@mail.gmail.com>
 <20171101214333.GG30645@codeaurora.org>
 <20171102045155.GX4240@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171102045155.GX4240@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11/02, Viresh Kumar wrote:
> On 01-11-17, 14:43, Stephen Boyd wrote:
> > On 11/01, Rob Herring wrote:
> > > On Tue, Oct 31, 2017 at 9:17 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > On 31 October 2017 at 16:02, Rob Herring <robh+dt@kernel.org> wrote:
> > > >> Why not a new property for magic values? opp-magic? Don't we want to
> > > >> know when we have magic values?
> > > >
> > > > I have kept a separate property since beginning (domain-performance-state)
> > > > and moved to using these magic values in the existing field because of the
> > > > suggestion Kevin gave earlier.
> > > >
> > > > https://marc.info/?l=linux-kernel&m=149306082218001&w=2
> > > >
> > > > I am not sure what to do now :)
> > > 
> > > Okay, I guess reusing the properties is fine.
> > > 
> > 
> > We call them corners on qcom platforms. Any reason we can't keep
> > using that name? I'd rather not have to keep telling people that
> > these fake values in some misnamed property is actually a corner.
> 
> Surely not "corners", as these are platform and OS independent
> bindings we are talking about here. Even the kernel code shouldn't
> generally do that. Though your platform specific genpd driver can :)
> 

Sorry I'm not following. We're going to need to have platform
specific code that understands platform specific bindings that
aren't shoved into the generic OPP bindings.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
