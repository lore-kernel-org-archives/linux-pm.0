From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: Add bindings for CPU clock sharing topology
Date: Thu, 24 Jul 2014 16:09:31 +0530
Message-ID: <CAKohpo=CqhA-TOfJh3U0G+tEMqvn_tiyWK=Yd6yNdAoDYQ-1BA@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
	<CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
	<CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
	<CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
	<CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com>
	<53CA8D95.8010108@ti.com>
	<CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
	<20140724003314.6419.51564@quantum>
	<CABGGisxHxdTyh500ey+KVLV3EnfYZvtsCV=Nt4Nqu7p6KJOwdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:59098 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbaGXKjb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 06:39:31 -0400
Received: by mail-oi0-f46.google.com with SMTP id i138so1873493oig.5
        for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2014 03:39:31 -0700 (PDT)
In-Reply-To: <CABGGisxHxdTyh500ey+KVLV3EnfYZvtsCV=Nt4Nqu7p6KJOwdA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <rob.herring@linaro.org>
Cc: Mike Turquette <mike.turquette@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grant Likely <grant.likely@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>

On 24 July 2014 07:54, Rob Herring <rob.herring@linaro.org> wrote:

>> A previous approach tried to compare struct clk pointers, which is a bad
>> idea since those are just cookies and should not be deref'd by drivers.
>> However a similar approach would be to compare the phandle, right?

Yeah. So what's the right way then?

> I think there needs to be a way to query whether a rate change for a
> clock affects other children. As pointed out previously, the clock to
> a core may not be shared, but it's parent that can change rates could
> be shared. This could be done with functions
> clk_get_parent_rate_change to return the clock in heirarchy which can
> change rates, and clk_is_parent_clk which tells if one clock is a
> child of another clock. It's been a while since I've looked at the
> clock api. It could also be done by experiment. Change the rate for
> core 0 and see if core 1's rate is changed and still equal. There's
> probably some ordering issue with doing that though.

But Mike sort of Nak'd that as well earlier :)
