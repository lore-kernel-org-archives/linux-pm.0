From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: Add bindings for CPU clock sharing topology
Date: Mon, 25 Aug 2014 12:35:44 +0530
Message-ID: <CAKohpo=s9A_EtJ2d2E9sjVkR8xs-bgRisnk=jZUeyWEf3uP5gg@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
	<CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
	<CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
	<CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
	<CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com>
	<53CA8D95.8010108@ti.com>
	<CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
	<20140724003314.6419.51564@quantum>
	<CABGGisxHxdTyh500ey+KVLV3EnfYZvtsCV=Nt4Nqu7p6KJOwdA@mail.gmail.com>
	<CAKohpo=CqhA-TOfJh3U0G+tEMqvn_tiyWK=Yd6yNdAoDYQ-1BA@mail.gmail.com>
	<20140725200214.22930.56323@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:55651 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538AbaHYHFp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Aug 2014 03:05:45 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so10344081obc.32
        for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2014 00:05:44 -0700 (PDT)
In-Reply-To: <20140725200214.22930.56323@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mike.turquette@linaro.org>
Cc: Rob Herring <rob.herring@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grant Likely <grant.likely@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>

On 26 July 2014 01:32, Mike Turquette <mike.turquette@linaro.org> wrote:
> So my opinion is to figure out how to specify the shared-clock versus
> independent-clock parameter it DT. I think the big issue here is the
> topology semantics around the cpus node, and I'll stay out of that
> stuff. But let's please not introduce a random API for a single merge
> window and let's also not over-consolidate machine driver code just for
> the sake of having fewer C files.

Returning almost after a month to this :(

- I agree that consolidation to cpufreq-cpu0 driver is good but adding a
backend clk driver for that is bad. I would look around supporting callbacks
to cpufreq-cpu0 driver. So that ->target()/->target_index() can be specified
by platform drivers and rest of the code can be used. But that's the next
problem to solve.

- Back to the first issue. How do we sharing information from DT ?

As I read them (and I may be wrong in understanding that), there were
conflicting ideas from many..

Can we please decide how we want to see these bindings? So, that I can
implement them quickly and close this thread...

Its just hanging in the middle as there wasn't a single clean solution yet.

--
viresh
