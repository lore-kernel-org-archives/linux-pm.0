From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date: Thu, 23 Aug 2018 11:38:31 -0700
Message-ID: <153504951102.28926.11593809590549791317@swboyd.mtv.corp.google.com>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
 <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
 <1ddda4b9e6dcd7ad415235f4d6af2dc7@codeaurora.org>
 <153333504360.10763.8964005567051510823@swboyd.mtv.corp.google.com>
 <4d37a1ee4f2d5b30da3f62cbfca756a8@codeaurora.org>
 <153370933225.220756.12056174025047430491@swboyd.mtv.corp.google.com>
 <c83e4248-aef2-bb40-8d8e-47d9b2918cc7@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c83e4248-aef2-bb40-8d8e-47d9b2918cc7@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>, skannan@codeaurora.org
Cc: Evan Green <evgreen@google.com>, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, anischal@codeaurora.org, devicetree@vger.kernel.org, robh@kernel.org, amit.kucheria@linaro.org
List-Id: linux-pm@vger.kernel.org

Quoting Taniya Das (2018-08-08 03:15:26)
> =

> =

> On 8/8/2018 11:52 AM, Stephen Boyd wrote:
> >>
> >> Binding describes hardware controllable by the OS. That's the reality.
> >> Let's not add mandatory clock bindings for clocks that the OS can't do
> >> anything about.
> >>
> > =

> > It seems that you believe clks should only be used to turn on/off and
> > control rates. That is not the whole truth. Sometimes clks are there
> > just to express the clk frequencies that are present in the design so
> > that drivers can figure out what to do.
> > =

> =

> Stephen,
> =

> As this clock is not configurable by linux clock drivers and we really =

> do not care the parent src(as mentioned by Saravana) to generate the =

> 300MHz, would it be good to define a fixed rate clock so as to express =

> the HW connectivity & frequency?
> =


As a hack that works great, but why do we need to workaround problems by
adding a fixed rate clk to DT for this PLL? The PLL is provided by GCC
node so it should be connected to the GCC node.
