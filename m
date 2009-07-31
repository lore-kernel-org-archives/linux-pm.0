From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/04] PM: Runtime PM v11 patches 20090731
Date: Fri, 31 Jul 2009 21:26:39 +0900
Message-ID: <20090731122639.31004.95390.sendpatchset@rx1.opensource.se>
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
To: linux-pm@lists.linux-foundation.org
Cc: gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

PM: Runtime PM v11 patches 20090731

[PATCH 01/04] PM: Runtime PM v11 - add dev_pm_ops helpers
[PATCH 02/04] PM: Runtime PM v11 - let bus-less devices succeed
[PATCH 03/04] PM: Runtime PM v11 - add debug printouts
[PATCH 04/04] PM: Runtime PM v11 - CONFIG_PM_SLEEP=n support

These patches contain architecture independent changes for
Runtime PM and are meant to be applied on top of: 
"PM: Introduce core framework for run-time PM of I/O devices (rev. 11)"
by Rafael J. Wysocki.

Patch 01 + 03 are very straightforward and would be useful to have
upstream from the perspective of a Runtime PM bus developer.

Patch 02 + 04 try to address some problems I ran into while hacking
on the Runtime PM platform bus code for SuperH. There may be better
ways to solve those issues.

Please see each individual patch for more information. Thanks!

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/base/core.c          |    3 ++
 drivers/base/power/main.c    |    3 --
 drivers/base/power/runtime.c |   55 ++++++++++++++++++++++++++----------------
 include/linux/pm_runtime.h   |   19 ++++++++++++++
 4 files changed, 57 insertions(+), 23 deletions(-)
