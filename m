From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Date: Wed, 8 Aug 2018 09:37:38 +0100
Message-ID: <20180808083738.GA25416@e107155-lin>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
 <153334001055.10763.8002698033760154254@swboyd.mtv.corp.google.com>
 <b362d9f769fde3ce1a2dcd89f20eb476@codeaurora.org>
 <20180807111237.GA1588@e107155-lin>
 <74d27daca2bb03716fc84f9c57118af0@codeaurora.org>
 <1aa8b42d-721f-1f5b-b1be-a6b4f220d023@codeaurora.org>
 <153370890232.220756.13782706852981763402@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <153370890232.220756.13782706852981763402@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Taniya Das <tdas@codeaurora.org>, skannan@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, amit.kucheria@linaro.org, evgreen@google.com, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 07, 2018 at 11:15:02PM -0700, Stephen Boyd wrote:
> Quoting Taniya Das (2018-08-07 19:46:01)
[...]

> > Sudeep,
> > 
> > Earlier the design was the freq_domain would take the CPU phandles
> > 
> > freq_domain:
> >    cpus = <&cpu0 &cpu1....>;
> > 
> 
> I believe Sudeep is recommending something I recommended earlier. It
> would look like:
> 
>    cpu7 {
> 	   qcom,freq-domain = <&cpufreq_hw 1>;
>    }
> 
> to indicate that cpu7 is in cpufreq_hw's frequency domain #1. That
> should probably be called clk domain BTW.
>

Thanks Stephen, that's exactly what I meant. You have explained all the
details saving me time :)

> If that was done with a phandle and a single cell, then we should have
> something similar on the cpufreq_hw node side indicating how to parse
> the cells in qcom,freq-domain. A property like #qcom,freq-domain-cells =
> <1> to indicate that one u32 follows the phandle.
>

As Saravana mentions in the other email I can't believe it's just made up
of logical CPU numbers. If that's the case is it software configurable.

--
Regards,
Sudeep
