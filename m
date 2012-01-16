From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Mon, 16 Jan 2012 08:59:53 +0200
Message-ID: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
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
List-Id: linux-pm@vger.kernel.org

[did not reach linux-pm as I sent to wrong address, sorry for
duplicates]

The inspiration for this patch series is the N9 CPU frequency boost
upon input events:

http://www.spinics.net/lists/cpufreq/msg00667.html

and the related changes in git://codeaurora.org/kernel/msm.git tree.
Those patches modify the ondemand cpufreq governor. This patch series
adds minimum and maximum CPU frequency as PM QoS parameters and
modifies the cpufreq core to enforce the PM QoS limits. There is also
an example module for boosting the frequency upon input events.

I've been testing these changes against Ubuntu 3.2 kernel on a Dell
E6420 with the ACPI cpufreq driver. The patches are against
linux-next/master, compile tested against it.

V2:
* split min and max to separate commits
* handle PM QoS min above max as max
* handle PM QoS max below min as min

	--Antti

Alex Frid (1):
  PM QoS: Simplify PM QoS expansion/merge

Antti P Miettinen (7):
  PM QoS: Add CPU frequency minimum as PM QoS param
  cpufreq: Export user_policy min/max
  cpufreq: Preserve sysfs min/max request
  cpufreq: Enforce PM QoS minimum limit
  input: CPU frequency booster
  PM QoS: Add CPU frequency maximum as PM QoS param
  cpufreq: Enforce PM QoS maximum frequency

 drivers/cpufreq/cpufreq.c     |   59 +++++++++++++-
 drivers/input/Kconfig         |    9 ++
 drivers/input/Makefile        |    1 +
 drivers/input/input-cfboost.c |  174 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_qos.h        |   19 ++++-
 kernel/power/qos.c            |   55 ++++++++++----
 6 files changed, 295 insertions(+), 22 deletions(-)
 create mode 100644 drivers/input/input-cfboost.c

-- 
1.7.4.1
