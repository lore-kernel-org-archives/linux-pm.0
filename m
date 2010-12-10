From: jean.pihet@newoldbits.com
Subject: [PATCH 0/3] perf, tools: new power trace API
Date: Fri, 10 Dec 2010 20:51:58 +0100
Message-ID: <1292010721-17426-1-git-send-email-j-pihet__41743.7888718725$1292010859$gmane$org@ti.com>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Provides:
. calls to machine_suspend trace point,
. OMAP support,
. API Documentation

Applies on top of Thomas's 8 latest power trace API patches, cf.
http://marc.info/?l=linux-kernel&m=129130827309354&w=2

Jean Pihet (3):
  perf: add calls to suspend trace point
  perf: add OMAP support for the new power events
  tools, perf: Documentation for the power events API

 Documentation/trace/events-power.txt |   90 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c         |    7 +++
 arch/arm/mach-omap2/powerdomain.c    |    3 +
 arch/arm/plat-omap/clock.c           |   13 ++++-
 kernel/power/suspend.c               |    3 +
 5 files changed, 113 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/trace/events-power.txt

-- 
1.7.2.3
