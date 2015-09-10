From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Thu, 10 Sep 2015 06:34:26 +0530
Message-ID: <20150910010426.GM5266@linux>
References: <20150902080639.GA26744@linux>
 <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
 <20150909062722.GA5266@linux>
 <20150909075930.GB3260@x1>
 <20150909083031.GB5266@linux>
 <20150909133930.GE3260@x1>
 <20150909160212.GJ5266@linux>
 <20150909163620.GF3260@x1>
 <55F0C5AB.5060609@kernel.org>
 <20150910005722.GA15099@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150910005722.GA15099@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 09-09-15, 17:57, Stephen Boyd wrote:
> I think it will work for qcom use cases.

Thanks for the Rant Rob, it finally got me moving :)

> We can collapse the
> tables down to one node and have speed bin and version as the
> opp-supported-hw property. The opp-microvolt-names property would

I am probably going to remove opp-microvolt-names property as well, if
we are going to use separate entries for all voltage ranges in OPP
node. i.e. two voltage ranges, slow and fast, like this:

                     regulator A       regulator B
opp-microvolt-slow = <tarA minA maxA>, <tarB minB maxB>;
opp-microvolt-fast = <tarA minA maxA>, <tarB minB maxB>;

> be where we put the different voltage bins. What about the other
> properties like opp-microamp or opp-suspend? Will all of those

Lets keep them as is for now, unless we have a real user.

> also get *-names properties to index into them based on some
> string? I don't actually need those for my devices, but I'm just
> pointing it out in case someone else wants to compress tables but
> they have different microamps or clock latencies, etc.
> 
> Finally, does this mean we will get rid of operating-points-names?

That's the next thing I wanted to ask from Rob. We are surely not
going to use them and there are no users or kernel code to support
them today. Can we get rid of them from the DT ?

-- 
viresh
