From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [RFC PATCH  0/4] devfreq_cooling: let the driver supply the dynamic power every time we need it
Date: Fri, 26 Aug 2016 14:18:01 +0100
Message-ID: <20160826131805.14820-1-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39213 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbcHZNTY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Aug 2016 09:19:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, lukasz.luba@arm.com, javi.merino@arm.com, orjan.eide@arm.com

Hello,

This patchset introduces a new interface for devfreq cooling in thermal
framework. It supports direct call to driver's functions registered as
'get_dynamic_power' and 'power2state'.

The current implementation in the thermal devfreq cooling subsystem uses
precalculated power table for each device to make a decision about allowed
running state. When the driver registers itself to the thermal devfreq cooling
subsystem, the framework creates the power table. The table is then used by the
thermal subsystem to keep the device in the thermal envelope. The current
implementation uses a fixed assumption of the complexity of the logic in the
cooling_device and assumes power consumption varies directly in proportion to
the frequency/voltage

The proposed implementation provides the possibility to register a driver to
thermal devfreq cooling subsystem and use the driver's code during the
calculation of the power in runtime. You can still use precalculated power table
when the GET_DIRECT_DYNAMIC_POWER flag is not set (the new extension can
co-exist with the current implementation).

This idea meets the expectations of the devices which know better the power they
consume (and the power is not strictly related to OPP table entries (frequency,
voltage) (i.e. some parts/features of the device can be unused)).

The first patch is just for fixing some compiler warnings.
The second patch is the same as the one sent already to the linux-pm list which
adds passing the devfreq pointer to the driver functions
'get_static|dynamic_power'.
The third one implements the main change in the devfreq cooling subsystem.
The last one is a simple fix for an unnecessary check.

Regards,
Lukasz Luba


Javi Merino (1):
  devfreq_cooling: pass a pointer to devfreq in the power model
    callbacks

Lukasz Luba (3):
  devfreq_cooling: make the structs devfreq_cooling_xxx visible for all
  devfreq_cooling: let the driver supply the dynamic power every time we
    need it
  devfreq_cooling: fix unnecessary check of unsigned long value

 drivers/thermal/devfreq_cooling.c | 193 +++++++++++++++++++++++++++-----------
 include/linux/devfreq_cooling.h   |  34 +++++--
 2 files changed, 165 insertions(+), 62 deletions(-)

-- 
2.9.2

