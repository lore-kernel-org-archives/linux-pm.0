From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 0/2] new cpumask for hotpluggable CPUs
Date: Tue,  9 Aug 2011 18:33:25 -0700
Message-ID: <1312940007-26069-1-git-send-email-mturquette__13837.2445399456$1312940243$gmane$org@ti.com>
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
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

This patch series introduces a new cpumask which tracks CPUs that
support hotplugging.  The purpose of this patch series is to provide a
simple method for kernel code to know which CPUs can be hotplugged and
which ones cannot.  Potential users of this code might be a thermal
mitigation technique which uses hotplug to lower temperature, or a power
capping mechanism which uses hotplug to lower power consumption.

All the of usual cpumask helper functions are created for this new mask.
The second patch in this series simply sets the bit for elligible CPUs
while they are being registered.  The cpumask itself is static after
boot and should not change (like the possbile mask).

Mike Turquette (2):
  cpumask: introduce cpumask for hotpluggable CPUs
  cpu: update cpu_hotpluggable_mask in register_cpu

 drivers/base/cpu.c      |    4 +++-
 include/linux/cpumask.h |   27 ++++++++++++++++++++++-----
 kernel/cpu.c            |   18 ++++++++++++++++++
 3 files changed, 43 insertions(+), 6 deletions(-)

-- 
1.7.4.1
