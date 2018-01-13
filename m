From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V8 3/3] OPP: Allow "opp-hz" and "opp-microvolt" to
 contain magic values
Date: Fri, 12 Jan 2018 16:46:42 -0800
Message-ID: <20180113004642.GT28313@codeaurora.org>
References: <20171226202955.32j7gzonrixtwdpt@rob-hp-laptop>
 <20171227085645.GF8312@vireshk-i7>
 <CAL_JsqJzMfNhHK=6Wt4dzBRS9BVGMZ-f7uk3OnUupudTfwuyUA@mail.gmail.com>
 <20171228043725.GB8652@vireshk-i7>
 <20171229003253.GD7997@codeaurora.org>
 <20171229045854.GE8652@vireshk-i7>
 <20180105221954.GC21040@codeaurora.org>
 <20180108041643.GC4003@vireshk-i7>
 <20180110025454.GG21040@codeaurora.org>
 <20180110053726.GA3626@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42790 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965265AbeAMAqo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jan 2018 19:46:44 -0500
Content-Disposition: inline
In-Reply-To: <20180110053726.GA3626@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 01/10, Viresh Kumar wrote:
> On 09-01-18, 18:54, Stephen Boyd wrote:
> > My read of Kevin's comments lead me to think he's saying that a
> > generic 'domain-performance-state' property is worse than putting
> > the numbers directly inside of the opp table with a comment above
> > it. Now that's all fine, but now that we have required-opps
> > binding we sort of have the domain-performance-state property
> > again, but it's a phandle instead of a raw state number.
> > 
> > So we have
> > 
> > 	required-opps = <&perf_state>;
> > 
> > but what was proposed before was
> > 
> > 	domain-performance-state = <1>;
> > 
> > or Kevin's 
> > 
> > 	opp-table = <100000 1>;
> 
> His concern was also on what will we do if "frequency" or other OPP
> properties aren't known tomorrow by the kernel but the firmware? In
> Qcom case, its just the voltage (corner) today, but it can very well
> be other properties tomorrow. Are we going to add more platform
> specific bindings then ?

Yes, we would add more bindings.

> And this is the main reason why I have been
> aligned towards using something like this patch.

Once we exceed the number of properties that can fit into the
existing voltage and frequency properties we'll only be able to
make it work by adding a platform specific property. That's one
concern, but it's a future concern so it's not a real problem
yet.

If you can clearly describe in the commit text why we shouldn't
use platform specific properties it would be helpful.

> 
> If we drop the magic-values idea and hence this patch, then we can
> either add a "domain-performance-state" property, which will only be
> used by the power domains or leave it for the platforms to add
> something like "qcom,corner".
> 
> All we are doing here is putting a voltage (corner) value, unknown to
> the kernel, in a new property instead of "opp-microvolt". But the
> above question still remains, what about other properties that may
> need magic values in future.
> 
> Honestly speaking, I am not sure what's the right thing to do here. I
> will do whatever you and Rob incline for.
> 

Hopefully Rob and Kevin can reply here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
