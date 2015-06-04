From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V7 0/3] OPP: Introduce OPP (V2) bindings
Date: Thu,  4 Jun 2015 21:50:30 +0530
Message-ID: <cover.1433434659.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35360 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbbFDQUo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 12:20:44 -0400
Received: by pdbnf5 with SMTP id nf5so34104568pdb.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2015 09:20:43 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

V6->V7:
- s/opp-supply/cpu-supply (Stephen B)

V5->V6:
- Acks/RBY from Rob and Nishanth added
- Lots of rewording suggested by Nishanth
- OPP Descriptor node is named OPP Table node now and so 'opp' is
  replaced by 'opp_table' in examples, as suggested by Nishanth.
- OPP entries are named as 'oppX' instead of 'entry*' as suggested by
  Nishanth.
- Phandles to slow and fast OPPs in 2/3 are named appropriately.

V4->V5:
- opp-microamp fixed and rewritten as per Mark's suggestions.
- shared-opp renamed as opp-shared, as that's the convention for other
  properties.
- Dropped "[V4 3/3] OPP: Add 'opp-next' in operating-points-v2 bindings"
  as that was NAK'd by Mike T..
- Added [V5 3/3] based on Nishanth's suggestions.
- Added an example for 2/3, multiple OPP nodes.
- Other minor formatting..
- Existing binding: "operating-points" isn't deprecated now as platforms
  looking for simple bindings should be allowed to use them.
- opp-khz is changed to opp-hz, examples updated.
- turbo-mode explained

V3->V4:
- Dropped code changes as we are still concerned about bindings.
- separated out into three patches, some of which might be NAK'd. :)
- The first patch presents basic OPP stuff that was reviewed earlier. It
  also has support for multiple regulators, with values for both current
  and voltage.
- Second patch is based on a special concern that Stephen had about
  multiple OPP tables, one of which the parsing code will select at
  runtime.
- Third one separates out 'opp-next' or Intermediate freq support as
  Mike T. had few concerns over it. He wanted the clock driver to take
  care of this and so do not want it to be passed by DT and used by
  cpufreq. Also, there were concerns like the platform may not want to
  choose intermediate frequency as a target frequency for longer runs,
  which wasn't prevented in earlier bindings.  And so it is kept
  separate to be NAK'd quietly, without much disturbances.

  ---------------x-------------------x------------------------

Current OPP (Operating performance point) device tree bindings have been
insufficient due to the inflexible nature of the original bindings. Over
time, we have realized that Operating Performance Point definitions and
usage is varied depending on the SoC and a "single size (just frequency,
voltage) fits all" model which the original bindings attempted and
failed.

The proposed next generation of the bindings addresses by providing a
expandable binding for OPPs and introduces the following common
shortcomings seen with the original bindings:

- Getting clock/voltage/current rails sharing information between CPUs.
  Shared by all cores vs independent clock per core vs shared clock per
  cluster.

- Support for specifying current levels along with voltages.

- Support for multiple regulators.

- Support for turbo modes.

- Other per OPP settings: transition latencies, disabled status, etc.?

- Expandability of OPPs in future.

This patchset introduces new bindings "operating-points-v2" to get these
problems solved. Refer to the bindings for more details.

We now have multiple versions of OPP binding and only one of them should
be used per device.


Viresh Kumar (3):
  OPP: Add new bindings to address shortcomings of existing bindings
  OPP: Allow multiple OPP tables to be passed via DT
  OPP: Add binding for 'opp-suspend'

 Documentation/devicetree/bindings/power/opp.txt | 439 +++++++++++++++++++++++-
 1 file changed, 435 insertions(+), 4 deletions(-)

-- 
2.4.0

