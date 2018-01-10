From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 3/3] OPP: Allow "opp-hz" and "opp-microvolt" to
 contain magic values
Date: Wed, 10 Jan 2018 11:07:26 +0530
Message-ID: <20180110053726.GA3626@vireshk-i7>
References: <476d7ae69184d787ccc6d99f8df6069007fd0a91.1513591822.git.viresh.kumar@linaro.org>
 <20171226202955.32j7gzonrixtwdpt@rob-hp-laptop>
 <20171227085645.GF8312@vireshk-i7>
 <CAL_JsqJzMfNhHK=6Wt4dzBRS9BVGMZ-f7uk3OnUupudTfwuyUA@mail.gmail.com>
 <20171228043725.GB8652@vireshk-i7>
 <20171229003253.GD7997@codeaurora.org>
 <20171229045854.GE8652@vireshk-i7>
 <20180105221954.GC21040@codeaurora.org>
 <20180108041643.GC4003@vireshk-i7>
 <20180110025454.GG21040@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46699 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeAJFhb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jan 2018 00:37:31 -0500
Received: by mail-pl0-f68.google.com with SMTP id i6so6671498plt.13
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2018 21:37:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180110025454.GG21040@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 09-01-18, 18:54, Stephen Boyd wrote:
> My read of Kevin's comments lead me to think he's saying that a
> generic 'domain-performance-state' property is worse than putting
> the numbers directly inside of the opp table with a comment above
> it. Now that's all fine, but now that we have required-opps
> binding we sort of have the domain-performance-state property
> again, but it's a phandle instead of a raw state number.
> 
> So we have
> 
> 	required-opps = <&perf_state>;
> 
> but what was proposed before was
> 
> 	domain-performance-state = <1>;
> 
> or Kevin's 
> 
> 	opp-table = <100000 1>;

His concern was also on what will we do if "frequency" or other OPP
properties aren't known tomorrow by the kernel but the firmware? In
Qcom case, its just the voltage (corner) today, but it can very well
be other properties tomorrow. Are we going to add more platform
specific bindings then ? And this is the main reason why I have been
aligned towards using something like this patch.

If we drop the magic-values idea and hence this patch, then we can
either add a "domain-performance-state" property, which will only be
used by the power domains or leave it for the platforms to add
something like "qcom,corner".

All we are doing here is putting a voltage (corner) value, unknown to
the kernel, in a new property instead of "opp-microvolt". But the
above question still remains, what about other properties that may
need magic values in future.

Honestly speaking, I am not sure what's the right thing to do here. I
will do whatever you and Rob incline for.

-- 
viresh
