From: skannan@codeaurora.org
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Date: Mon, 06 Aug 2018 13:54:24 -0700
Message-ID: <b362d9f769fde3ce1a2dcd89f20eb476@codeaurora.org>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
 <153334001055.10763.8002698033760154254@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153334001055.10763.8002698033760154254@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

On 2018-08-03 16:46, Stephen Boyd wrote:
> Quoting Taniya Das (2018-07-24 03:42:49)
>> diff --git 
>> a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt 
>> b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>> new file mode 100644
>> index 0000000..22d4355
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>> @@ -0,0 +1,172 @@
> [...]
>> +
>> +               CPU7: cpu@700 {
>> +                       device_type = "cpu";
>> +                       compatible = "qcom,kryo385";
>> +                       reg = <0x0 0x700>;
>> +                       enable-method = "psci";
>> +                       next-level-cache = <&L2_700>;
>> +                       qcom,freq-domain = <&freq_domain_table1>;
>> +                       L2_700: l2-cache {
>> +                               compatible = "cache";
>> +                               next-level-cache = <&L3_0>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       qcom,cpufreq-hw {
>> +               compatible = "qcom,cpufreq-hw";
>> +
>> +               clocks = <&rpmhcc RPMH_CXO_CLK>;
>> +               clock-names = "xo";
>> +
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
>> +               ranges;
>> +               freq_domain_table0: freq_table0 {
>> +                       reg = <0 0x17d43000 0 0x1400>;
>> +               };
>> +
>> +               freq_domain_table1: freq_table1 {
>> +                       reg = <0 0x17d45800 0 0x1400>;
>> +               };
> 
> Sorry, this is just not proper DT design. The whole node should have a
> reg property, and it should contain two (or three if we're handling the
> L3 clk domain?) different offsets for the different power clusters. The
> problem seems to still be that we don't have a way to map the CPUs to
> the clk domains they're in provided by this hardware block. Making
> subnodes is not the solution.

The problem is mapping clock domains to logical CPUs that CPUfreq uses. 
The physical CPU to logical CPU mapping can be changed by the kernel 
(even through DT if I'm not mistaken). So we need to have a way to tell 
in DT which physical CPUs are connected to which CPU freq clock domain.

As for subnodes or not, we don't have any strong opinion, but couple of 
other points to consider. Two or more CPUfreq policies might have a 
common frequency table (read from HW), but separate control of 
frequency. So, you also need a way to group frequency table with CPU 
freq policies. If you have a better design, we are open to that 
suggestion.

Thanks,
Saravana
