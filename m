From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 0/12] generic thermal layer enhancement
Date: Mon, 11 Jun 2012 11:19:11 +0800
Message-ID: <1339384751.1492.153.camel@rui.sh.intel.com>
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
To: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, all,

this patch set is made to enhance the current generic thermal layer.
It fixes several gaps discussed in
http://marc.info/?l=linux-acpi&m=133836783425764&w=2
and introduces a simple arbitrator to fix the "one cooling devices
referenced by multiple trip points in multiple thermal zones" problem.
 
The whole idea is
1) make sure we have multiple cooling states for both active cooling and
   passive cooling devices. (patch 1,2,3)
2) remove passive specific requirement, aka, tc1/tc2, and
   introduce .get_trend() instead, for both active and passive cooling
   algorithm. (patch 4,5)
3) introduce new function thermal_zone_trip_update(), this contains the
   code for the general cooling algorithm. (patch 6)
4) rename some thermal structures. Use thermal_instance instead of
   thermal_cooling_device_instance, as this structure is used to
   describe the behavior of a certain cooling device for a certain trip
   point in a certain thermal zone.
   thermal_zone_device has a list of all the thermal instances in this
   thermal zone so that it can update them when the temperature changes.
   thermal_cooling_device has a list of all the thermal instances for
   this cooling device so that it can make decision which cooling state
   should be in when the temperature changes. (patch 7,8,9,10)
5) introduce a simple arbitrator. (patch 11)
   When temperature changes, we update a thermal zone in two stages,
   a) thermal_zone_trip_point() is the general cooling algorithm to
      update the thermal instances in the thermal zone device
   b) thermal_zone_do_update() is the arbitrator for the cooling device
      to choose the deepest cooling state required to enter.
6) unify the code for both passive and active cooling.

TODO, add locking mechanism. I know this is important but as this patch
set changes the thermal layer a lot, I just want to make sure I'm in the
right direction before going on.

BTW, in theory, they should make no change to the behavior of the
current generic thermal layer users. But I have just done the build
test.

Any comments are welcome.

thanks,
rui

--------------------------------------------------------------------
 drivers/acpi/thermal.c                   |   76 +++++++--
 drivers/platform/x86/acerhdf.c           |    4 +-
 drivers/platform/x86/intel_mid_thermal.c |    2 +-
 drivers/thermal/spear_thermal.c          |    2 +-
 drivers/thermal/thermal_sys.c            |  293
++++++++++++++++++------------
 include/linux/thermal.h                  |   22 ++-
 7 files changed, 271 insertions(+), 148 deletions(-)
