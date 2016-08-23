From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v1 3/3] PM / AVS: rockchip-cpu-avs: add driver handling Rockchip cpu avs
Date: Tue, 23 Aug 2016 11:03:44 +0200
Message-ID: <3008348.gWNc8j0KGA@diego>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com> <20160819133636.GA26913@rob-hp-laptop> <c853c8fd-285a-603d-b294-750cdbf7f200@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:60796 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757114AbcHWJES (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Aug 2016 05:04:18 -0400
In-Reply-To: <c853c8fd-285a-603d-b294-750cdbf7f200@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Finley Xiao <finley.xiao@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com, frowand.list@gmail.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, mark.rutland@arm.com, khilman@kernel.org, nm@ti.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, jay.xu@rock-chips.com, rocky.hao@rock-chips.com, tim.chen@rock-chips.com, tony.xie@rock-chips.com, ulysses.huang@rock-chips.com, lin.huang@rock-chips.com

Hi Finley,

Am Dienstag, 23. August 2016, 12:10:27 schrieb Finley Xiao:
> 在 2016/8/19 21:36, Rob Herring 写道:
> > On Tue, Aug 16, 2016 at 10:38:59AM +0800, Finlye Xiao wrote:
> >> From: Finley Xiao <finley.xiao@rock-chips.com>
> >> 
> >> This patch supports adjusting opp's voltage according to leakage
> >> 
> >> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> >> ---
> >> 
> >>   .../devicetree/bindings/power/rockchip-cpu-avs.txt |  37 +++
> >>   drivers/power/avs/Kconfig                          |   8 +
> >>   drivers/power/avs/Makefile                         |   1 +
> >>   drivers/power/avs/rockchip-cpu-avs.c               | 314
> >>   +++++++++++++++++++++ 4 files changed, 360 insertions(+)
> >>   create mode 100644
> >>   Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt create
> >>   mode 100644 drivers/power/avs/rockchip-cpu-avs.c
> >> 
> >> diff --git a/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
> >> b/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt new file
> >> mode 100644
> >> index 0000000..90f6b08
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
> >> @@ -0,0 +1,37 @@
> >> +Rockchip cpu avs device tree bindings
> >> +-------------------------------------
> >> +
> >> +Under the same frequency, the operating voltage tends to decrease with
> >> +increasing leakage. so it is necessary to adjust opp's voltage according
> >> +to leakage for power.
> >> +
> >> +
> >> +Required properties:
> >> +- compatible: Should be one of the following.
> >> +  - "rockchip,rk3399-cpu-avs" - for RK3399 SoCs.
> >> +- leakage-volt-<name>: Named leakage-volt property. At runtime, the
> >> +  platform can find a cpu's cluster_id according to it's cpu_id and
> >> match
> >> +  leakage-volt-<name> property. The property is an array of 3-tuples
> >> +  items, and each item consists of leakage and voltage like
> >> +  <min-leakage-mA max-leakage-mA vol-uV>.
> >> +	min-leakage: minimum leakage in mA.
> >> +	max-leakage: maximum leakage in mA.
> >> +	vol: voltage in microvolt.
> > 
> > How do you determine these values? When do they vary?
> 
> How do you determine these values?
> 
> run antutu-benchmark
> leakage     freq 	min_volt
> 30mA 	    1608MHz 	1025mV
> 40mA 	    1608MHz 	1000mV
> 50mA 	    1608MHz 	975mV
> 
>  From the table, we see the min_volt decrease with increasing leakage.
> So we can set the default opp-microvolt 1025mV for 1608MHz,
> and add an leakage_volt_cluster0 property as follows.
> leakage_volt_cluster0 = <
> 		/*  min(mA)   max(mA)    volt(uV)*/
> 		    0         40        0
> 		    41        50        (-25000)
> 		    51        254       (-50000)
> 
> >;
> 
> If the leakage is between 41mA and 50mA，the opp-microvolt will subtract
> 25mV。 If the leakage is between 41mA and 50mA，the opp-microvolt will
> subtract 50mV。
> 
> When do they vary?
> 
>  From the code,
> cpufreq_online
> --cpufreq_driver->init(policy);  /* add new opp table */
> --blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> CPUFREQ_START, policy);
> --cpufreq_init_policy
> ----cpufreq_set_policy
> --------__cpufreq_governor(policy, CPUFREQ_GOV_START);
> 
> The cpu's opp table is added in the init function(cpufreq_init)，and I will
> register a cpufreq notifier, once the first cpu of cluster is onlined,
> my notifer will be called, and if the event is CPUFREQ_START，it will modify
> the opp-microvolt according to leakage_volt_cluster0.

I think what Rob was asking with "when do they vary" is, are these leakage 
values the same for each and every rk3399 soc or are they determined 
separately for each board-type using the rk3399.


