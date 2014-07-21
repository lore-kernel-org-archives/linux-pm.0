From: Rob Herring <rob.herring@linaro.org>
Subject: Re: [RFC] cpufreq: Add bindings for CPU clock sharing topology
Date: Mon, 21 Jul 2014 12:00:42 -0500
Message-ID: <CABGGisyDf7xt7CNii_NJ_stvBGNEeiXBMFxNkA2myS8OQ-VCtw@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
 <CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
 <CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
 <CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
 <CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com> <53CA8D95.8010108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:61516 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932818AbaGURBE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 13:01:04 -0400
Received: by mail-la0-f50.google.com with SMTP id gf5so4836797lab.37
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2014 10:01:02 -0700 (PDT)
In-Reply-To: <53CA8D95.8010108@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mike Turquette <mike.turquette@linaro.org>, Grant Likely <grant.likely@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>

On Sat, Jul 19, 2014 at 10:24 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Viresh,
>
> On Saturday 19 July 2014 10:46 AM, Viresh Kumar wrote:
>> On 19 July 2014 03:22, Olof Johansson <olof@lixom.net> wrote:
>>> What is the current API that is being broken, in your opinion?
>>
>> So, currently the nodes doesn't have any such property. And drivers
>> consider all of them as sharing clocks, for eg: cpufreq-cpu0.
>>
>> Now, if we use those older DT's after the new changes, drivers would
>> consider CPUs as having separate clocks. And that would be opposite
>> of what currently happens.
>>
>> Not sure if this counts as broken.
>>
>>>> But if that isn't the case, the bindings are very simple & clear to handle.
>>>> Diff for new bindings:
>>>
>>> It's somewhat confusing to see a diff to the patch instead of a new
>>> version. It seems to remove the cpu 0 entry now?
>>
>> Not really, I removed an unwanted example. This is how it looks:
>>
>>
>>
>> * Generic CPUFreq clock bindings
>>
>> Clock lines may or may not be shared among different CPUs on a platform.
>>
>> Possible configurations:
>> 1.) All CPUs share a single clock line
>> 2.) All CPUs have independent clock lines
>> 3.) CPUs within a group/cluster share clock line but each group/cluster have a
>>     separate line for itself
>>
>> Optional Properties:
>> - clock-master: Contains phandle of the master cpu controlling clocks.
>>
>>   Ideally there is nothing like a "master" CPU as any CPU can play with DVFS
>>   settings. But we have to choose one cpu out of a group, so that others can
>>   point to it.
>>
>>   If there is no "clock-master" property for a cpu node, it is considered as
>>   master. It may or may not have other slave CPUs pointing towards it.
>>
>
> Sorry for jumping late, but one of the point I was raising as part of your
> other series was to extend the CPU topology bindings to cover the voltage
> domain information which is probably what is really needed to let the
> CPUfreq extract the information. Not sure if it was already discussed.
>
> After all the CPU clocks, cluster, clock-gating, power domains are pretty much
> related. So instead of having new binding for CPUFreq, I was wondering whether
> we can extend the CPU topology binding information to include missing information.
> Scheduler work anyway needs that information.
>
> Ref: Documentation/devicetree/bindings/arm/topology.txt
>
> Does that make sense ?

To me, but every time I suggest adding things to the topology the ARM
folks object... I really think we should have built the topology into
the /cpus hierarchy. Then we could add properties at the correct place
in the hierarchy where they are common.

I don't really like the proposal here. It just doesn't look like a
clean description of the h/w.

Ignoring compatibility, I would like to see something like
operating-points and/or the clock properties be moved up to /cpus if
they are shared and be per cpu node when they are not. This of course
does not work if you have independent OPPs for each cluster with a
shared clock within cluster.

The operating-points binding has obvious shortcomings and this is
another example. Someone needs to step up with a new binding that
addresses this and all other issues (e.g. turbo modes, extra per OPP
data, etc.). I don't really want to see halfway fixes to the binding
that ignore the other issues (unless there is a really simple
solution).

Rob
