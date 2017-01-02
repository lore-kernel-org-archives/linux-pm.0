From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/2] PM / Domains / OPP: Introduce
 domain-performance-state binding
Date: Mon, 2 Jan 2017 16:14:12 +0530
Message-ID: <20170102104412.GH13679@vireshk-i7>
References: <cover.1481539827.git.viresh.kumar@linaro.org>
 <20161222181422.2cpmdfzeyxdi6vpa@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161222181422.2cpmdfzeyxdi6vpa@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org, Nayak Rajendra <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 22-12-16, 12:14, Rob Herring wrote:
> On Mon, Dec 12, 2016 at 04:26:17PM +0530, Viresh Kumar wrote:
> > Hello,
> > 
> > Some platforms have the capability to configure the performance state of
> > their Power Domains. The performance levels are represented by positive
> > integer values, a lower value represents lower performance state.
> > 
> > We had some discussions about it in the past on the PM list [1], which is
> > followed by discussions during the LPC. The outcome of all that was that we
> > should extend Power Domain framework to support active state power management
> > as well.
> > 
> > The power-domains until now were only concentrating on the idle state
> > management of the device and this needs to change in order to reuse the
> > infrastructure of power domains for active state management.
> 
> From a h/w perspective, are idle states really different from 
> performance states? 

Its a tricky question TBH :)

The device is almost powered off during the idle states, while
performance states here are the functioning of the device. I haven't
answered your question well, perhaps I need a more direct question :)

> > To get a complete picture of the proposed plan, following is what we
> > need to do:
> > - Create DT bindings to get domain performance state information for the
> >   platforms.
> 
> I would do this last so you can evolve things if you're not certain 
> about what the bindings should look like. You can always start with 
> things in the kernel and add to DT later.

I didn't knew that and it looks like a very good option. I am not sure
if I would like to do that for this series though. Maybe lets discuss
the bindings a bit more and if we aren't able to find a common ground,
I can try code first.

> While in theory we should be able to just "describe the h/w" in DT and 

Right.

> develop the Linux side independently, this feels too much like the 
> bindings are just evolving with Linux needs.

:)

-- 
viresh
