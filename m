From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [RFC] cpufreq: Add "dvfs-method" binding to probe cpufreq drivers
Date: Wed, 26 Nov 2014 08:34:15 -0800
Message-ID: <54760107.3010205@oracle.com>
References: <596a6d49f2b3e2837aa9a54a3e1249161d3c9265.1416991009.git.viresh.kumar@linaro.org> <CAKohpomBijLiBgV31ZhZDTctsTLccBZ+93r+esG-WRZAS4sqww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:51905 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbaKZQeu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 11:34:50 -0500
In-Reply-To: <CAKohpomBijLiBgV31ZhZDTctsTLccBZ+93r+esG-WRZAS4sqww@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, "olof@lixom.net" <olof@lixom.net>, Thomas Abraham <ta.omasab@gmail.com>

On 11/26/2014 12:49 AM, Viresh Kumar wrote:
> Fixing Santosh's email id as he switched employer ..
>
Yeah I did ;-)

> On 26 November 2014 at 14:16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> DT based cpufreq drivers doesn't require much support from platform code now a
>> days as most of the stuff is moved behind generic APIs. Like clk APIs for
>> changing clock rates, regulator APIs for changing voltages, etc.
>>
>> One of the bottleneck still left was how to select which cpufreq driver to probe
>> for a given platform as there might be multiple drivers available.
>>
>> Traditionally, we used to create platform devices from machine specific code
>> which binds with a cpufreq driver. And while we moved towards DT based device
>> creation, these devices stayed as is.
>>
>> The problem is getting worse now as we have architectures now with Zero platform
>> specific code. Forcefully these platforms have to create a new file in
>> drivers/cpufreq/ to just add these platform devices in order to use the generic
>> drivers like cpufreq-dt.c.
>>
We should definitely avoid that since that code is just pointless. Good
to see that you picked up that.

>> This has been discussed again and again, but with no solution yet. Last it was
>> discussed here:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256154.html
>>
>> This patch is an attempt towards getting the bindings.
>>
>> We only need to have one entry in cpus@cpu0 node which will match with drivers
>> name.
>>
>> We can then add another file drivers/cpufreq/device_dt.c, which will add a
>> platform device with the name it finds from cpus@cpu0 node and existing drivers
>> will work without any change. Or something else if somebody have a better
>> proposal. But lets fix the bindings first.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   .../devicetree/bindings/cpufreq/drivers.txt        | 53 ++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/cpufreq/drivers.txt
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/drivers.txt b/Documentation/devicetree/bindings/cpufreq/drivers.txt
>> new file mode 100644
>> index 0000000..bd14917
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/drivers.txt
>> @@ -0,0 +1,53 @@
>> +Binding to select which cpufreq driver to register
>> +
>> +It is a generic DT binding for selecting which cpufreq-driver to register for
>> +any platform.
>> +
>> +The property  listed below must be defined under node /cpus/cpu@0 node. We don't
>> +support multiple CPUFreq driver currently for different cluster and so this
>> +information isn't required to be present in CPUs of all clusters.
>> +
>> +Required properties:
>> +- None
>> +
>> +Optional properties:
>> +- dvfs-method: CPUFreq driver to probe. For example: "arm-bL-cpufreq-dt",
>> +  "cpufreq-dt", etc
>> +
>> +Examples:
>> +
>> +cpus {
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +
>> +       cpu@0 {
>> +               compatible = "arm,cortex-a9";
>> +               reg = <0>;
>> +               next-level-cache = <&L2>;
>> +               operating-points = <
>> +                       /* kHz    uV */
>> +                       792000  1100000
>> +                       396000  950000
>> +                       198000  850000
>> +               >;
>> +               dvfs-method = "cpufreq-dt";
>> +       };

Its really not 'dvfs-method' but really the actual driver which you
want to probe. Also we should just have one global way to parse
DT vs non-DT cpufreq drivers. In other words, instead of matching
multiple driver strings for different drivers, we should come up with
slightly generic binding. Probably 'cpufreq-dt' for all DT based probed
CPUFREQ drivers.

What you say ?

Regards,
Santosh



