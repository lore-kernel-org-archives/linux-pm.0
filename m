From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq drivers
Date: Mon, 1 Dec 2014 12:14:54 -0600
Message-ID: <CAL_JsqLgxPf2hoW5Q55P2M1bSg6S+pVwpSyBa2WmZBQvUZfAXA@mail.gmail.com>
References: <cover.1417433163.git.viresh.kumar@linaro.org> <7885354.QleDlR7NUO@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:55880 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066AbaLASPQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 13:15:16 -0500
In-Reply-To: <7885354.QleDlR7NUO@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kesavan.abhilash@gmail.com, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, k.chander@samsung.com, santosh shilimkar <santosh.shilimkar@oracle.com>, Stephen Boyd <sboyd@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>

On Mon, Dec 1, 2014 at 6:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 01 December 2014 17:11:21 Viresh Kumar wrote:
>>
>> DT based cpufreq drivers doesn't require much support from platform code now a
>> days as most of the stuff is moved behind generic APIs. Like clk APIs for
>> changing clock rates, regulator APIs for changing voltages, etc.
>>
>> One of the bottleneck still left was how to select which cpufreq driver to probe
>> for a given platform as there might be multiple drivers available.
>>
>> Traditionally, we used to create platform devices from machine specific code
>> which binds with a cpufreq driver. And while we moved towards DT based device
>> creation, these devices stayed as is.
>>
>> The problem is getting worse now as we have architectures now with Zero platform
>> specific code. Forcefully these platforms have to create a new file in
>> drivers/cpufreq/ to just add these platform devices in order to use the generic
>> drivers like cpufreq-dt.c.
>>
>> This has been discussed again and again, but with no solution yet. Last it was
>> discussed here:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256154.html
>>
>> This patch is an attempt towards getting the bindings.
>>
>> We only need to have cpufreq drivers name string present in "compatible"
>> property for the root node.. If a cpufreq driver with DT support exists with
>> that name, then cpufreq core will create a platform device for that.
>>
>> The first patch presents the new binding, second one creates another file
>> responsible for creating platform devices for all DT based cpufreq drivers.
>>
>> And later patches update platforms to migrate to it one by one.
>>
>> A BLACKLIST of platforms already supported by these drivers is also created for
>> backward compatibility of newer kernels with older DTs. And so for such
>> platforms DT files aren't updated.
>>
>> An initial RFC that presented the idea was discussed here:
>> https://www.mail-archive.com/devicetree@vger.kernel.org/msg52509.html
>>
>> Tested-ON: Exynos5250. (The last patch for exynos depends on some commits to be
>> upstreamed in 3.19, presented here just for testing).
>
> Thanks a lot for working on this, we really need to figure it out one day!
>
> Your patches seem well-implemented, so if everybody thinks the general
> approach is the best solution, we should do that. From my point of view,
> there are two things I would do differently:

I think the changes here for the "legacy" DTs are fine, but they
should be separated from the DT binding changes.

> - In the DT binding, I would strongly prefer anything but the root compatible
>   property as the key for the new platforms. Clearly we have to keep using
>   it for the backwards-compatibility case, as you do, but I think there
>   are more appropriate places to put it. Sorting from most favorite to least
>   favorite, my list would be:
>         1. a new property in /cpus/
>         2. a new property each /cpus/cpu@... node.
>         3. the compatible property of the /cpus node
>         4. a top-level device node that gets turned into a platform device
>         5. a new property in the / node
>         6. a new property in the /chosen node
>         7. the compatible property in the / node

We already have some properties such as clocks and OPP in the cpu
nodes. Granted, those are probably not sufficient to bind against. The
current OPP binding has shown to be insufficient based on some of the
past proposals on how to handle various different scenarios:

- Different topologies of OPPs: single shared clock vs. independent
clock per core vs. shared clock per cluster; different OPP per cluster
- Support for turbo modes
- Other per OPP settings: transition latencies, disabled status, etc.?

I don't want to see band-aids that only fix one problem here and this
series is included. We need to define a better way to define OPPs and
deprecate the existing binding. I think we probably need something
with a node per OPP so we can add new properties. These can have a
compatible property including something generic for purposes of
matching. So something like this:

opp@?? {
  compatible = "highbank-opp", "generic-cpu-opp";
  clocks = <&clk-controller 0>;
  clock-frequency = <1000000000>;
  opp-supply = <&cpu-supply>;
  voltage-uV = <1000000>;
  turbo-mode;
  status = "disabled";
};

I've left how to map cpus and clusters with OPPs as an exercise for
the reader. :)

> - Implementation-wise, I don't think it's helpful to have a global function
>   that registers a platform device to be consumed by the device driver. I'd
>   rather just see a module_init function in each driver that rather than
>   registering a platform_driver scans the DT properties. This is only really
>   necessary when not using DT (omap2, omap3, davinci, loongson) or when
>   passing additional resources or platform_data (kirkwood, but that can
>   look up the "marvell,orion-system-controller" node if necessary).
>   My preferred solution would be to eventually remove the platform_device
>   registration for all DT users. If a driver needs a platform device pointer
>   internally, it can use platform_create_bundle(), but that's probably not
>   even necessary.

This is essentially undoing what has been the general direction for
cpufreq drivers. Not saying that is wrong, but we should have
consistent direction here.

Rob
