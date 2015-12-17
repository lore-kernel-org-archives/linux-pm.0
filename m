From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 0/3] thermal: rework core to improve userspace interaction
Date: Thu, 17 Dec 2015 11:13:26 -0800
Message-ID: <1450379609-7826-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello Rui, linux-pm

Changelog:
V1 -> V2: Fixes patch 2, and added Srivinas reviewed by on patch 1.

Please consider these three patches in the thermal core to improve
the interaction with userspace.

The first is already in its second version. It avoids reconfiguring
monitor period. Now the thermal core configures the monitor only
after handling all trip points.

The second is about improving emul_temp. The background here is to
allow using emul_temp, even if the thermal zone is not fully setup,
with a missing .get_temp().

The third is to improve hot trip points handling. Hot trip points
are described as notification entry points. However, we do very
little on them. This patch adds a uevent to propagate the event
to userspace. Today, we rely on thermal zone driver. I believe
having the same message coming on every thermal zone makes more
sense. However, I did not remove the .notify() callback, and it
should behave the same.

Eduardo Valentin (3):
  thermal: setup monitor only once after handling trips
  thermal: rework core to allow emul_temp to be treated as regular temp
  thermal: improve hot trip handling

 drivers/thermal/thermal_core.c | 96 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 18 deletions(-)

-- 
2.5.0
