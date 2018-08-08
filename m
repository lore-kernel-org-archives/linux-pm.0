From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Date: Wed, 8 Aug 2018 08:16:01 +0530
Message-ID: <1aa8b42d-721f-1f5b-b1be-a6b4f220d023@codeaurora.org>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
 <153334001055.10763.8002698033760154254@swboyd.mtv.corp.google.com>
 <b362d9f769fde3ce1a2dcd89f20eb476@codeaurora.org>
 <20180807111237.GA1588@e107155-lin>
 <74d27daca2bb03716fc84f9c57118af0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <74d27daca2bb03716fc84f9c57118af0@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: skannan@codeaurora.org, Sudeep Holla <sudeep.holla@arm.com>
Cc: Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org



On 8/8/2018 12:54 AM, skannan@codeaurora.org wrote:
> On 2018-08-07 04:12, Sudeep Holla wrote:
>> On Mon, Aug 06, 2018 at 01:54:24PM -0700, skannan@codeaurora.org wrote:
>>> On 2018-08-03 16:46, Stephen Boyd wrote:
>>> >Quoting Taniya Das (2018-07-24 03:42:49)
>>> >>diff --git
>>> >>a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>>> >>b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>>> >>new file mode 100644
>>> >>index 0000000..22d4355
>>> >>--- /dev/null
>>> >>+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>>> >>@@ -0,0 +1,172 @@
>>> >[...]
>>> >>+
>>> >>+               CPU7: cpu@700 {
>>> >>+                       device_type = "cpu";
>>> >>+                       compatible = "qcom,kryo385";
>>> >>+                       reg = <0x0 0x700>;
>>> >>+                       enable-method = "psci";
>>> >>+                       next-level-cache = <&L2_700>;
>>> >>+                       qcom,freq-domain = <&freq_domain_table1>;
>>> >>+                       L2_700: l2-cache {
>>> >>+                               compatible = "cache";
>>> >>+                               next-level-cache = <&L3_0>;
>>> >>+                       };
>>> >>+               };
>>> >>+       };
>>> >>+
>>> >>+       qcom,cpufreq-hw {
>>> >>+               compatible = "qcom,cpufreq-hw";
>>> >>+
>>> >>+               clocks = <&rpmhcc RPMH_CXO_CLK>;
>>> >>+               clock-names = "xo";
>>> >>+
>>> >>+               #address-cells = <2>;
>>> >>+               #size-cells = <2>;
>>> >>+               ranges;
>>> >>+               freq_domain_table0: freq_table0 {
>>> >>+                       reg = <0 0x17d43000 0 0x1400>;
>>> >>+               };
>>> >>+
>>> >>+               freq_domain_table1: freq_table1 {
>>> >>+                       reg = <0 0x17d45800 0 0x1400>;
>>> >>+               };
>>> >
>>> >Sorry, this is just not proper DT design. The whole node should have a
>>> >reg property, and it should contain two (or three if we're handling the
>>> >L3 clk domain?) different offsets for the different power clusters. The
>>> >problem seems to still be that we don't have a way to map the CPUs to
>>> >the clk domains they're in provided by this hardware block. Making
>>> >subnodes is not the solution.
>>>
>>> The problem is mapping clock domains to logical CPUs that CPUfreq 
>>> uses. The
>>> physical CPU to logical CPU mapping can be changed by the kernel (even
>>> through DT if I'm not mistaken). So we need to have a way to tell in DT
>>> which physical CPUs are connected to which CPU freq clock domain.
>>>
>>
>> How about passing CPU freq clock domain id as along with phandle in
>> qcom,freq-domain ?
> 
> Now sure what you mean here. There's no such this as CPUfreq clock 
> domain id. It has policies that are made up of logical CPU numbers. 
> Logical CPU is not something that you can fix in DT.
> 
> -Saravana

Sudeep,

Earlier the design was the freq_domain would take the CPU phandles

freq_domain:
   cpus = <&cpu0 &cpu1....>;

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
