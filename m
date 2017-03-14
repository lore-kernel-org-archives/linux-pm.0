From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v3] devfreq_cooling: let the driver supply the real power every time we need it
Date: Tue, 14 Mar 2017 13:06:13 +0000
Message-ID: <20170314130616.7711-1-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbdCNNGs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Mar 2017 09:06:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: chris.diamand@arm.com, lukasz.luba@arm.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com

Hi,

This patchset introduces a new interface for devfreq cooling in thermal
framework. The previous version of the patch can be seen here [1].
I have simplified the implementation and introduced resource utilization
scaling factor.

The current implementation in the thermal devfreq cooling subsystem uses
pre-calculated power table for each device to make a decision about allowed
running state. When the driver registers itself to the thermal devfreq cooling
subsystem, the framework creates the power table.
The power table is then used by the thermal subsystem to keep
the device in the thermal envelope.
In the previous implementation the pre-calculated device's power
table was scaled by current 'utilization'
('busy_time' and 'total_time' taken from devfreq 'last_status').

This idea meets the expectations of the devices which know better the actual
power that they consume (thanks to power counters). When some
parts/features of the device are not used the power value might be lower,
while the frequency and utilization are the same.

The proposed implementation provides possibility to register a driver to
thermal devfreq cooling subsystem and use the driver's code during the 
calculation of the power in runtime.

The device driver can still use pre-calculated power table when these new 
functions are not provided (the new extension can co-exist with old 
implementation).

The first patch contains some refactoring for getting the voltage,
the second implements the new feature, the third one changes trace function.
Patchset is based on v4.11-rc2.

Changes
v3:
- use new OPP interface (no need to lock rcu)
v2 [2]: 
- removed 'flags' and power2state function,
- split into a few patches,
- simplified the logic of the new interface,
- added resource utilization scaling factor,
v1 [1]:
- basic implementation

Best Regards,
Lukasz Luba

[1] https://marc.info/?l=linux-pm&m=147395070729989&w=2
[2] http://marc.info/?l=linux-pm&m=148587920122854&w=2

Lukasz Luba (3):
  thermal: devfreq_cooling: refactor code and add get_voltage function
  thermal: devfreq_cooling: add new interface for direct power read
  trace: thermal: add another parameter *power to the tracing function

 drivers/thermal/devfreq_cooling.c | 117 ++++++++++++++++++++++++++++----------
 include/linux/devfreq_cooling.h   |  17 ++++++
 include/trace/events/thermal.h    |  11 ++--
 3 files changed, 110 insertions(+), 35 deletions(-)

-- 
2.9.2
