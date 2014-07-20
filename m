From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: Add bindings for CPU clock sharing topology
Date: Sun, 20 Jul 2014 17:37:32 +0530
Message-ID: <CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
	<CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
	<CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
	<CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
	<CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com>
	<53CA8D95.8010108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:59411 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbaGTMHd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jul 2014 08:07:33 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so6000589oag.2
        for <linux-pm@vger.kernel.org>; Sun, 20 Jul 2014 05:07:32 -0700 (PDT)
In-Reply-To: <53CA8D95.8010108@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mike Turquette <mike.turquette@linaro.org>, Grant Likely <grant.likely@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>

On 19 July 2014 20:54, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> Sorry for jumping late

No, you aren't late. Its just 2 days old thread :)

> but one of the point I was raising as part of your
> other series was to extend the CPU topology bindings to cover the voltage
> domain information which is probably what is really needed to let the
> CPUfreq extract the information. Not sure if it was already discussed.

Not it wasn't.

> After all the CPU clocks, cluster, clock-gating, power domains are pretty much
> related. So instead of having new binding for CPUFreq, I was wondering whether
> we can extend the CPU topology binding information to include missing information.
> Scheduler work anyway needs that information.
>
> Ref: Documentation/devicetree/bindings/arm/topology.txt
>
> Does that make sense ?

Yeah it does, but I am not sure what exactly the bindings should look then.
So, the most basic step could be moving the new bindings to topology.txt
and name clock-master to dvfs-master.

What else?

If its going to be much controversial then we *can* go for just dvfs bindings
for now and then update them later.

Doesn't make sense? :)
