From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/8] PM / OPP: Multiple regulator support
Date: Wed, 26 Oct 2016 08:51:24 +0530
Message-ID: <20161026032124.GG9162@vireshk-i7>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <CAJZ5v0jNJBDKq+ccHKRA6JGAOXV0qT0-k1mwAcBkCv-7JtzACw@mail.gmail.com>
 <CAKohpon8f-7ppaFsb+wZH4Dj527HXRF73E8taYN9QfcojjJa3g@mail.gmail.com>
 <41a8b4a1-94d3-e086-a328-495f69815d1c@ti.com>
 <20161024042659.GD24749@vireshk-i7>
 <4059f5a9-5308-8a5e-827b-4f822d9049d2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35493 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbcJZDV3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 23:21:29 -0400
Received: by mail-pf0-f173.google.com with SMTP id s8so130723200pfj.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 20:21:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4059f5a9-5308-8a5e-827b-4f822d9049d2@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>

On 25-10-16, 16:13, Dave Gerlach wrote:
> I think what you have shared below is a good safety check but if I rename
> the regulator properties in the DT for the cpu (to vdd and vbb, meaning
> cpufreq detects no regulator) and do *not* call dev_pm_opp_set_regulators
> before cpufreq-dt probes we fail before we even get to that point:
> 
> [16.946] cpu cpu0: opp_parse_supplies: Invalid number of elements in
> opp-microvolt property (6) with supplies (1)
> [16.967] cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -22
> [16.982] cpu cpu0: dev_pm_opp_get_opp_count: OPP table not found (-19)
> [16.982] cpu cpu0: OPP table is not ready, deferring probe
> 
> This failure is because opp_parse_supplies assumes a count of 1 regulator if
> no regulators at all are present and then hard fails if too many voltages
> have been passed for each OPP.

Exactly. And yes this is intentional.

> It seems we need a check much earlier similar
> to what you suggested below to allow us to defer if an OPP has supplied
> voltages but no regulator has been registered with the system. I think this
> is reasonable even for the 1 regulator case, no?

No.

OPP core needs to know about regulators only if the user drivers want it to
manage DVFS. It is still possible for cpufreq drivers to use OPP framework for
managing the tables, but do the real DVFS stuff themselves. That's why it is not
compulsory in the code to set regulator names.

And its only wrong if dev_pm_opp_set_rate() is called without first setting the
regulators..

> cpufreq-dt won't handle this properly as is, but now that the opp core is
> evolving perhaps it makes sense to modify the resources_available check
> slightly to rely on the OPP core rather than just a dummy
> regulator_get_optional to see if the regulator is ready.

I am not sure yet on what to change there. You mean regarding multiple
regulators?

-- 
viresh
