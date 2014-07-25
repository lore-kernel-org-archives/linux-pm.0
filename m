From: Mike Turquette <mike.turquette@linaro.org>
Subject: Re: [RFC] cpufreq: Add bindings for CPU clock sharing topology
Date: Fri, 25 Jul 2014 13:02:14 -0700
Message-ID: <20140725200214.22930.56323@quantum>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:53176 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934959AbaGYUCT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jul 2014 16:02:19 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so6237370pdi.39
        for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2014 13:02:19 -0700 (PDT)
In-Reply-To: <CAKohpo=CqhA-TOfJh3U0G+tEMqvn_tiyWK=Yd6yNdAoDYQ-1BA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <rob.herring@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grant Likely <grant.likely@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>

Quoting Viresh Kumar (2014-07-24 03:39:31)
> On 24 July 2014 07:54, Rob Herring <rob.herring@linaro.org> wrote:
> 
> >> A previous approach tried to compare struct clk pointers, which is a bad
> >> idea since those are just cookies and should not be deref'd by drivers.
> >> However a similar approach would be to compare the phandle, right?
> 
> Yeah. So what's the right way then?
> 
> > I think there needs to be a way to query whether a rate change for a
> > clock affects other children. As pointed out previously, the clock to
> > a core may not be shared, but it's parent that can change rates could
> > be shared. This could be done with functions
> > clk_get_parent_rate_change to return the clock in heirarchy which can
> > change rates, and clk_is_parent_clk which tells if one clock is a
> > child of another clock. It's been a while since I've looked at the
> > clock api. It could also be done by experiment. Change the rate for
> > core 0 and see if core 1's rate is changed and still equal. There's
> > probably some ordering issue with doing that though.
> 
> But Mike sort of Nak'd that as well earlier :)

Sorry for being NAKy. Pushing more query functions into the clk api will
be a bad thing in the long term. First there are races: if a driver
queries the clock framework and then calls another clk.h api function
based on that result, we would need to lock the whole block of code
since the query may be invalid immediately after the result is returned.

Secondly, it is common for hardware to be designed with various use case
configurations already known. From a software point of view this is
"compile-time" info since we already know what OPPs we want to run at,
how we want to multiplex our clock outputs, etc. Often we know exactly
what we want to do from a hardware integration standpoint, and by trying
to have some algorithmic approach in software where we walk the tree and
figure stuff out dynamically is just going to make life hard for us.

I also think this whole push to consolidate every cpufreq machine driver
into cpufreq-cpu0 is complete madness. Machine drivers exist for a
reason. Now with this big push to remove cpufreq drivers we are just
pushing more and more logic into the clock framework (see some recent
patch series introducing "cpu clocks" as clock providers, which
essentially do what the old cpufreq machine drivers used to do).

So my opinion is to figure out how to specify the shared-clock versus
independent-clock parameter it DT. I think the big issue here is the
topology semantics around the cpus node, and I'll stay out of that
stuff. But let's please not introduce a random API for a single merge
window and let's also not over-consolidate machine driver code just for
the sake of having fewer C files.

Regards,
Mike
