From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH 01/13] clk: tegra: Add binding for the Tegra124 DFLL clocksource
Date: Fri, 11 Jul 2014 10:08:55 -0700
Message-ID: <CAL1qeaHETQ7kSGNjPiwi_9WNMtr9qZp0KwjZCCxY29+_N4AcuA@mail.gmail.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
	<1405028569-14253-2-git-send-email-ttynkkynen@nvidia.com>
	<CAL1qeaFF0ZpUFovxTuLXrBPRg2Lbf-754Z=ztD5HFZPbfnDsAw@mail.gmail.com>
	<53C01558.3090607@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:33843 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628AbaGKRI5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jul 2014 13:08:57 -0400
Received: by mail-vc0-f169.google.com with SMTP id la4so2690315vcb.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2014 10:08:55 -0700 (PDT)
In-Reply-To: <53C01558.3090607@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, Mike Turquette <mturquette@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Viresh Kumar <viresh.kumar@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>

On Fri, Jul 11, 2014 at 9:48 AM, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
>
>
> On 11/07/14 19:28, Andrew Bresticker wrote:
>>
>> On Thu, Jul 10, 2014 at 2:42 PM, Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>> wrote:
>>>
>>> The DFLL is the main clocksource for the fast CPU cluster on Tegra124
>>> and also provides automatic CPU rail voltage scaling as well. The DFLL
>>> is a separate IP block from the usual Tegra124 clock-and-reset
>>> controller, so it gets its own node in the device tree.
>>
>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
>>> b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
>>
>>
>>> +- nvidia,pmic-voltage-table: Array of 2-tuples.  Each entry should have
>>> the
>>> +  form <register-value voltage-in-uV>, indicating the register value
>>> that
>>> +  needs to be programmed to the PMIC for changing the VDD_CPU voltage to
>>> +  the specified voltage. The table must be in ascending order by the
>>> voltage.
>>
>>
>> Instead of listing the register values for each voltage in the DT,
>> can't you use regulator_list_voltage() to create this map?
>>
>
> I don't see a way to get the register values that way, unless we assume that
> the mapping is linear and doesn't have holes.

Hmm... I guess if you don't assume it's linear and continuous you'd
have to iterate over all 256 selectors.
