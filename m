From: jean.pihet@newoldbits.com
Subject: [PATCH 0/2] tools, perf: new power trace API
Date: Wed,  5 Jan 2011 19:49:00 +0100
Message-ID: <1294253342-29056-1-git-send-email-j-pihet__49512.6367117793$1294253447$gmane$org@ti.com>
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
To: mingo@elte.hu, trenn@suse.de, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org
Cc: linux-perf-users@vger.kernel.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Provides:
. calls to machine_suspend trace point,
. API Documentation

The OMAP specific changes will be submitted separately on
the linux-omap ML because:
- the OMAP changes need to be rebased on the latest linux-omap 2.6.37 tree,
- more feedback is needed from the linux-omap folks.

Jean Pihet (2):
  perf: add calls to suspend trace point
  tools, perf: Documentation for the power events API

 Documentation/trace/events-power.txt |   90 ++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c               |    3 +
 2 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/trace/events-power.txt

-- 
1.7.2.3
