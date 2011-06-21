From: jean.pihet@newoldbits.com
Subject: [RFC/PATCH 0/2] PM QoS: add a per-device wake-up latency
	constraint class
Date: Tue, 21 Jun 2011 15:16:09 +0200
Message-ID: <1308662171-22337-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lis>
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

This patch set is in an RFC state, for review and comments.

In order to implement the new class in PM QoS the following changes have been made:

1. Add a new PM QoS class for device wake-up constraints (PM_QOS_DEV_WAKEUP_LATENCY).
Due to the per-device nature of the new class the constraints lists are stored inside the device dev_pm_info struct instead of the internal per-class constraints lists.
The new class is only available from kernel drivers and so is not exported to user space.

2. Make the pm_qos_add_request API more generic by using a struct pm_qos_parameters parameter. This allows easy extension in the future.

3. Upon a change of the strongest constraint a notification chain mechanism is used to take action on the system. This is the proposed way to have PM QoS and the platform dependant code to interact with each other. This patch set does not include the implementation of the platform callback functions, more to come soon.
The notification mechanism now passes the constraint request struct ptr in order for the notifier callback to have access to the full set of constraint data, e.g. the struct device ptr.

4. Update the pm_qos_add_request callers to the generic API

5. Minor clean-ups and rename of struct fields

Questions:
1. How to retrieve the device ptr from a given device driver in order to add a constraint on it?
2. The device struct has been extended with the power domain information. Can this be used to apply the constraints on power domains, as proposed by [1]?

On-going developments, patches in preparation:
1. replace the OMAP proposed implementation [1] by the generic PM QoS API
2. implement the notification callbacks in the OMAP platform code, in order to take actions on the power domains next power states
3. validate the constraints framework on OMAP3&4

[1] http://marc.info/?l=linux-omap&m=130451613408148&w=2

Based on the master branch of the linux-omap git tree (3.0.0-rc3). Compile tested only using OMAP and x86 generic defconfigs.

Jean Pihet (2):
  PM: add a per-device wake-up latency constraints plist
  PM: extend PM QoS with per-device wake-up constraints

 drivers/base/power/main.c              |    1 +
 drivers/media/video/via-camera.c       |    5 +-
 drivers/net/e1000e/netdev.c            |    9 ++-
 drivers/net/wireless/ipw2x00/ipw2100.c |    6 +-
 include/linux/pm.h                     |    2 +
 include/linux/pm_qos_params.h          |   40 ++++++----
 kernel/pm_qos_params.c                 |  139 ++++++++++++++++++--------------
 sound/core/pcm_native.c                |    8 ++-
 8 files changed, 128 insertions(+), 82 deletions(-)

-- 
1.7.4.1
