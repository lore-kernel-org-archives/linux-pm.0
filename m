From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC] cpufreq: Add bindings for CPU clock sharing topology
Date: Thu, 17 Jul 2014 23:17:49 -0700
Message-ID: <CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:49195 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759402AbaGRGRu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 02:17:50 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so6509865vcb.23
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2014 23:17:49 -0700 (PDT)
In-Reply-To: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, mike.turquette@linaro.org, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Nishanth Menon <nm@ti.com>, Sudeep.Holla@arm.com, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, arvind.chauhan@arm.com, Arnd Bergmann <arnd.bergmann@linaro.org>

On Thu, Jul 17, 2014 at 10:35 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Clock lines may or may not be shared among different CPUs on a platform. When
> clock lines are shared between CPUs, they change DVFS state together.
>
> Possible configurations:
>
> 1.) All CPUs share a single clock line.
> 2.) All CPUs have independent clock lines.
> 3.) CPUs within a group/cluster share clock line but each group/cluster have a
>     separate line for itself.
>
> There is no generic way available today to detect which CPUs share clock lines
> and so this is an attempt towards that.
>
> Much of the information is present in the commit and so no point duplicating it
> here.
>
> These are obviously not finalized yet and this is an attempt to initiate a
> discussion around this.
>
> Please share your valuable feedback.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> I wasn't sure about the path/name of this file, so please don't blast me on that
> :)
>
>  .../devicetree/bindings/cpufreq/cpu_clocks.txt     | 159 +++++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt b/Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt
> new file mode 100644
> index 0000000..30ce9ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt
> @@ -0,0 +1,159 @@
> +* Generic CPUFreq clock bindings
> +
> +Clock lines may or may not be shared among different CPUs on a platform.
> +
> +Possible configurations:
> +1.) All CPUs share a single clock line
> +2.) All CPUs have independent clock lines
> +3.) CPUs within a group/cluster share clock line but each group/cluster have a
> +    separate line for itself
> +
> +Optional Properties:
> +- clock-master: This declares cpu as clock master. Other CPUs can either define
> +  "clock-ganged" or "clock-master" property, but shouldn't be missing both.
> +
> +- clock-ganged: Should have phandle of a cpu declared as "clock-master".

Why complicate it by using two properties?

If there is no property, then the CPUs are assumed to be controlled
independently.

if there is a clock-master = <phandle> property, then that points at
the cpu that is the main one controlling clock for the group.

There's really no need to label the master -- it will be the only one
with incoming links but nothing outgoing. And a master without slaves
is an independently controlled cpu so you should be fine in that
aspect too.


-Olof
