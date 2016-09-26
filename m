From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] PM / OPP: Multiple regulators aren't supported yet
Date: Mon, 26 Sep 2016 10:37:56 +0530
Message-ID: <20160926050756.GJ17336@vireshk-i7>
References: <be2c4fb0bb58f5b29facbc6f5aaf3dca13cf209e.1474450324.git.viresh.kumar@linaro.org>
 <fc02fca412ffdb749bd811c8f1dc40fa2ae3fc3f.1474450324.git.viresh.kumar@linaro.org>
 <20160923195913.GA12969@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160923195913.GA12969@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23-09-16, 14:59, Rob Herring wrote:
> On Wed, Sep 21, 2016 at 03:02:50PM +0530, Viresh Kumar wrote:
> > Multiple regulators per device aren't supported yet by the kernel code
> > and the bindings provided in documentation aren't sufficient to handle
> > that case (as there is no way for kernel code to link multiple
> > voltage/current values to a power supply).
> 
> What do you mean? Because the supplies are in the cpu node?

Not just that. For example if two supplies are present in CPU node like:
ABC-supply and XYZ-supply. And the values present in OPP node are like:

               opp00 {
                       opp-hz = /bits/ 64 <1700000000>;
                        /*                     ABC supply                XYZ        supply */
                       opp-microvolt = <1300000 1300000 1300000>, <1400000 1400000 1400000>;
                       opp-microamp = <70000>;
                       clock-latency-ns = <30>;
                       opp-suspend;
               };


Then the code can get regulators with those names (ABC and XYZ), but it can't
figure out which triplet in the "opp-microvolt" property belongs to which
supply.

I am working on some solution to that, but wanted to keep the entire series self
sufficient and so removing the leftovers first in this patch.

-- 
viresh
