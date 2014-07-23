From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: Add bindings for CPU clock sharing topology
Date: Wed, 23 Jul 2014 10:25:08 +0530
Message-ID: <CAKohpokPAcmERN3S3Wbf7a4gXaQAWyBtKV7RXDHYThMWW57fGA@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
	<CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
	<CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
	<CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
	<CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com>
	<53CA8D95.8010108@ti.com>
	<CABGGisyDf7xt7CNii_NJ_stvBGNEeiXBMFxNkA2myS8OQ-VCtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:54014 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512AbaGWEzJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 00:55:09 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so911591oag.21
        for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2014 21:55:08 -0700 (PDT)
In-Reply-To: <CABGGisyDf7xt7CNii_NJ_stvBGNEeiXBMFxNkA2myS8OQ-VCtw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <rob.herring@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mike Turquette <mike.turquette@linaro.org>, Grant Likely <grant.likely@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>

On 21 July 2014 22:30, Rob Herring <rob.herring@linaro.org> wrote:

> To me, but every time I suggest adding things to the topology the ARM
> folks object... I really think we should have built the topology into
> the /cpus hierarchy. Then we could add properties at the correct place
> in the hierarchy where they are common.
>
> I don't really like the proposal here. It just doesn't look like a
> clean description of the h/w.

I knew it wouldn't be easy to get these bindings correctly in the first
attempt atleast, but I still went for it so that this thread can progress:

https://lkml.org/lkml/2014/7/18/3

There are changes waiting to get some kind of intermediate solution
in, so that other platforms can reuse cpufreq-cpu0 driver. Also, so that
cpufreq-cpu0 can be converted to cpufreq-generic, so that it can support
almost any platform.

Can you please reply to that thread to suggest some intermediate
solution that we can get fixed in 3.17? Mvebu and Krait are waiting for
these patches to get in..

The solution can be simple enough as right now we have only two kinds
of platforms:
- All CPUs share clock
- All CPUs have separate clocks

The most simple solution of that could have been a Kconfig entry, but that
would be a problem for multi-arch builds if these platforms do want to get
build with multi-arch config. Otherwise we have to get some binding in
place for 3.17..

Please see if you can get that thread going :)

> Ignoring compatibility, I would like to see something like
> operating-points and/or the clock properties be moved up to /cpus if
> they are shared and be per cpu node when they are not. This of course
> does not work if you have independent OPPs for each cluster with a
> shared clock within cluster.

Yeah, that had always been the issue. People probably tried to get a
cluster {} block as well to simplify that but there were some objections
to it as well, though not sure what happened to that stuff..
