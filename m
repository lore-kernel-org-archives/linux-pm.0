From: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Subject: [RFC PATCH 0/2] thermal: Add generic cpu cooling devices
	according to thermal framework
Date: Tue, 13 Dec 2011 20:43:14 +0530
Message-ID: <1323789196-4942-1-git-send-email-amit.kachhap__11552.2482469261$1323789226$gmane$org@linaro.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

PATCH 1)  [thermal: Add a new trip type to use cooling device instance number]
This patch adds a new trip type THERMAL_TRIP_STATE_ACTIVE which passes
cooling device instance number and may be helpful for cpufreq cooling devices
to take the correct cooling action.

PATCH 2)  [thermal: Add generic cpu cooling implementation]
This patch adds generic cpu cooling low level implementation through frequency
clipping and cpu hotplug. In future, other cpu related cooling devices may be
added here. An ACPI version of this already exists(drivers/acpi/processor_thermal.c).
But this will be useful for platforms like ARM using the generic thermal interface
along with the generic cpu cooling devices. The cooling device registration API's
return cooling device pointers which can be easily binded with the thermal zone
trip points.


Amit Daniel Kachhap (2):
  thermal: Add a new trip type to use cooling device instance number
  thermal: Add generic cpu cooling implementation

 Documentation/thermal/cpu-cooling-api.txt |   52 +++++
 Documentation/thermal/sysfs-api.txt       |    4 +-
 drivers/thermal/Kconfig                   |   11 +
 drivers/thermal/Makefile                  |    1 +
 drivers/thermal/cpu_cooling.c             |  302 +++++++++++++++++++++++++++++
 drivers/thermal/thermal_sys.c             |   27 +++-
 include/linux/cpu_cooling.h               |   45 +++++
 include/linux/thermal.h                   |    1 +
 8 files changed, 440 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/thermal/cpu-cooling-api.txt
 create mode 100644 drivers/thermal/cpu_cooling.c
 create mode 100644 include/linux/cpu_cooling.h
