From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 0/4] thermal sys: couple of fixes and cleanups
Date: Tue, 12 Jun 2012 16:25:15 +0300
Message-ID: <1339507519-14434-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rui.zhang@intel.com, durgadoss.r@intel.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello Rui and thermal folks,

Here is a couple of fixes and cleanups on the thermal_sys.c.

One important change is the netlink channel, which I am proposing
to have the zone id in each message. Rui, do you know if this could
cause a breakage on userspace applications?

All best,

Eduardo Valentin (4):
  thermal: Use thermal zone device id in netlink messages
  thermal: remove unnecessary include
  thermal: cleanup: use dev_* helper functions
  thermal sys: check for invalid trip setup when registering thermal
    device

 Documentation/thermal/sysfs-api.txt |    5 +++--
 drivers/thermal/thermal_sys.c       |   23 ++++++++++++++++-------
 include/linux/thermal.h             |    6 ++++--
 3 files changed, 23 insertions(+), 11 deletions(-)

-- 
1.7.7.1.488.ge8e1c
