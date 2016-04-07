From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device
 creation support
Date: Thu, 7 Apr 2016 14:00:36 +0530
Message-ID: <20160407083036.GB3201@vireshk-i7>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
 <12972545.Mi9sHiNJpR@wuerfel>
 <20160330032240.GB8773@vireshk-i7>
 <7250220.227umpmTug@wuerfel>
 <20160401102350.GA5532@vireshk-i7>
 <CAL_JsqK2oAX2jw6GjT7RUWkhL2zPB9=QUQ--S2u-1t852GG7VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34335 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbcDGIak (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 04:30:40 -0400
Received: by mail-pf0-f180.google.com with SMTP id c20so51597260pfc.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2016 01:30:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL_JsqK2oAX2jw6GjT7RUWkhL2zPB9=QUQ--S2u-1t852GG7VQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@linaro.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Matthew McClintock <mmcclint@codeaurora.org>, xf@rock-chips.com, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Mason <slash.tmp@free.fr>

On 01-04-16, 09:15, Rob Herring wrote:
> On Fri, Apr 1, 2016 at 5:23 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > So you mean for future DT files we can have something like this:
> >
> >         cpus {
> >                 compatible = "operation-points-v2";
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >
> >                 cpu@0 {
> >                         compatible = "arm,cortex-a9";
> >                         reg = <0>;
> >                         next-level-cache = <&L2>;
> >                         operating-points-v2 = <&cpu0_opp_table>;
> >                 };
> >         };
> >
> >         cpu0_opp_table: opp_table0 {
> >                 opp@1000000000 {
> >                         opp-hz = /bits/ 64 <1000000000>;
> >                         opp-microvolt = <970000 975000 985000>;
> >                         opp-microamp = <70000>;
> >                         clock-latency-ns = <300000>;
> >                         opp-suspend;
> >                 };
> >                 opp@1100000000 {
> >                         opp-hz = /bits/ 64 <1100000000>;
> >                         opp-microvolt = <980000 1000000 1010000>;
> >                         opp-microamp = <80000>;
> >                         clock-latency-ns = <310000>;
> >                 };
> >         };
> > };
> >
> >
> > And the cpufreq-dt driver can match /cpus node's compatible string against
> > "operating-points-v2" and create a device at runtime ?
> >
> > @Rob: Will that be acceptable to you? We are discussing (again) about how to
> > probe cpufreq-dt driver automatically for platforms :)
> 
> No, I don't think that belongs in /cpus.
> 
> Part of the problem is this requires a DT change if you switch between
> a platform-specific driver and generic driver.

Right.

> I don't understand the issue having a little bit of code to parse the
> DT and create the device.

I am fine with that, we were just re-evaluating our options :)

> If you are worried about having a long list
> of platforms,

At least I am not.

> you could instead check the tree for operating-points-v2
> property in the cpu node and create the device unless the platform is
> black-listed.

I don't really like the black-list idea much. It forces a Non
cpufreq-dt platform to edit cpufreq-dt related file, just to make its
own cpufreq driver work.

I find that ugly somehow :)

-- 
viresh
