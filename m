From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/7] Add CPU Frequency scaling support on Armada 37xx
Date: Thu, 7 Dec 2017 22:19:07 +0100
Message-ID: <CAJZ5v0jA9sQNtLsfGSj5Yvbac8Hp8TkU+ReKc4KEsgDmKz7UMg@mail.gmail.com>
References: <20171207135616.23670-1-gregory.clement@free-electrons.com>
 <88999738.5axjmjKUcc@aspire.rjw.lan> <87r2s6s9mj.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34991 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752570AbdLGVTI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Dec 2017 16:19:08 -0500
In-Reply-To: <87r2s6s9mj.fsf@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta

On Thu, Dec 7, 2017 at 6:58 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Rafael,
>
>  On jeu., d=C3=A9c. 07 2017, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrot=
e:
>
>> On Thursday, December 7, 2017 2:56:09 PM CET Gregory CLEMENT wrote:
>>> Hi,
>>>
>>> This is the second version of a series adding the CPU Frequency
>>> support on Armada 37xx using DVFS. It is based on the initial work of
>>> Evan Wang and Victor Gu.
>>>
>>> The main change since the first version was a bug fixed in the
>>> "cpufreq: Add DVFS support for Armada 37xx" patch which was preventing
>>> to register the opp. An other noticeable change is the 4th patch which
>>> is new adding the use of dev_pm_opp_remove and removing an comment
>>> became wrong. The other changes are described in the change log.
>>>
>>> DVFS control is done by a set of registers from the North Bridge Power
>>> Management block. The binding for this block is documented in patch 1.
>>>
>>> While adding a new cpufreq driver I found that the Kconfig and
>>> Makefile were no more in order, so it is fixed by patch 2 and 3.
>>>
>>> The 5th patch is just about updating the MAINTAINERS file with the new
>>> driver.
>>>
>>> The next patch is the real purpose of the series. The main goal of
>>> this driver is to setup the CPU load level in the hardware to
>>> associate them to CPU frequencies and register a standard cpufreq
>>> driver. Note that the hardware also capable of doing AVS (Adaptive
>>> Voltage Scaling), by associating a voltage on each level beside the
>>> CPU frequency. However, this support is not yet ready, so it is not
>>> part of this series.
>>>
>>> Finally, the last patch is for arm-soc the arm-soc subsystem through
>>> mvebu and update the device tree to support the CPU frequency scaling.
>>>
>>> An update on the CPU clock driver is needed in order to take into
>>> account the DVFS setting. It's the purpose of an other series already
>>> sent, but is no dependencies between the series (for building or at
>>> runtime).
>>>
>>> Thanks,
>>>
>>> Gregory
>>>
>>> Changelog:
>>>
>>> v1 -> v2:
>>>
>>>  - using syscon instead of nb_pm for the binding of the North bridge
>>>    power management unit: reported by Rob Herring
>>>
>>>  - fix sorting inside the big LITTLE section for the Kconfig: reported
>>>    by Viresh Kumar
>>>
>>>  - fix the bogus freq calculation in armada37xx_cpufreq_driver_init,
>>>    bug reported by Andre Heider
>>>
>>>  - use dev_pm_opp_remove() on the previous opp if dev_pm_opp_add()
>>>    failed, reported by Viresh Kumar
>>>
>>>  - add the Tested-by flag from Andre Heider on "cpufreq: Add DVFS
>>>    support for Armada 37xx" patch
>>>
>>> Gregory CLEMENT (7):
>>>   dt-bindings: marvell: Add documentation for the North Bridge PM on
>>>     Armada 37xx
>>>   cpufreq: ARM: sort the Kconfig menu
>>>   cpufreq: sort the drivers in ARM part
>>>   cpufreq: mvebu: Use dev_pm_opp_remove()
>>>   MAINTAINERS: add new entries for Armada 37xx cpufreq driver
>>>   cpufreq: Add DVFS support for Armada 37xx
>>>   arm64: dts: marvell: armada-37xx: add nodes allowing cpufreq support
>>>
>>>  .../bindings/arm/marvell/armada-37xx.txt           |  19 ++
>>>  MAINTAINERS                                        |   1 +
>>>  arch/arm64/boot/dts/marvell/armada-372x.dtsi       |   1 +
>>>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   7 +
>>>  drivers/cpufreq/Kconfig.arm                        |  89 ++++----
>>>  drivers/cpufreq/Makefile                           |   9 +-
>>>  drivers/cpufreq/armada-37xx-cpufreq.c              | 241 +++++++++++++=
++++++++
>>>  drivers/cpufreq/mvebu-cpufreq.c                    |  11 +-
>>>  8 files changed, 327 insertions(+), 51 deletions(-)
>>>  create mode 100644 drivers/cpufreq/armada-37xx-cpufreq.c
>>
>> I'd like you to split patches [2-3/7] off this series as they aren't
>> exactly related to the other changes in it.
>
> Actually the patch 6 depend on patch 2 and 3. To be more precise they
> modify the same area inside the files drivers/cpufreq/Kconfig.arm and
> drivers/cpufreq/Makefile.
>
> So if I move them in an other series then there could be some merge
> conflicts.

That's fine.  Merge conflicts are not a big issue to me.
