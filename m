From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device
 creation support
Date: Fri, 1 Apr 2016 09:15:09 -0500
Message-ID: <CAL_JsqK2oAX2jw6GjT7RUWkhL2zPB9=QUQ--S2u-1t852GG7VQ@mail.gmail.com>
References: <cover.1459233524.git.viresh.kumar@linaro.org> <12972545.Mi9sHiNJpR@wuerfel>
 <20160330032240.GB8773@vireshk-i7> <7250220.227umpmTug@wuerfel> <20160401102350.GA5532@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34784 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbcDAOP3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 10:15:29 -0400
In-Reply-To: <20160401102350.GA5532@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Matthew McClintock <mmcclint@codeaurora.org>, xf@rock-chips.com, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Mason <slash.tmp@free.fr>

On Fri, Apr 1, 2016 at 5:23 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Cc'ing Rob and Mason.
>
> On 30-03-16, 09:53, Arnd Bergmann wrote:
>> I think it should be something in the /cpus or the /opp_table hierarchy,
>> not the root of the device tree, but other than that I don't care much
>> whether it's a variation of the oppv2 compatible string or an additional
>> property in any of the nodes.
>
> So you mean for future DT files we can have something like this:
>
>         cpus {
>                 compatible = "operation-points-v2";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 cpu@0 {
>                         compatible = "arm,cortex-a9";
>                         reg = <0>;
>                         next-level-cache = <&L2>;
>                         operating-points-v2 = <&cpu0_opp_table>;
>                 };
>         };
>
>         cpu0_opp_table: opp_table0 {
>                 opp@1000000000 {
>                         opp-hz = /bits/ 64 <1000000000>;
>                         opp-microvolt = <970000 975000 985000>;
>                         opp-microamp = <70000>;
>                         clock-latency-ns = <300000>;
>                         opp-suspend;
>                 };
>                 opp@1100000000 {
>                         opp-hz = /bits/ 64 <1100000000>;
>                         opp-microvolt = <980000 1000000 1010000>;
>                         opp-microamp = <80000>;
>                         clock-latency-ns = <310000>;
>                 };
>         };
> };
>
>
> And the cpufreq-dt driver can match /cpus node's compatible string against
> "operating-points-v2" and create a device at runtime ?
>
> @Rob: Will that be acceptable to you? We are discussing (again) about how to
> probe cpufreq-dt driver automatically for platforms :)

No, I don't think that belongs in /cpus.

Part of the problem is this requires a DT change if you switch between
a platform-specific driver and generic driver.

I don't understand the issue having a little bit of code to parse the
DT and create the device. If you are worried about having a long list
of platforms, you could instead check the tree for operating-points-v2
property in the cpu node and create the device unless the platform is
black-listed.

Rob
