From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/05] PM: Runtime PM v13 for Platform Devices
	20090807
Date: Fri, 07 Aug 2009 16:33:15 +0900
Message-ID: <20090807073315.22479.89012.sendpatchset@rx1.opensource.se>
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

PM: Runtime PM v13 for Platform Devices 20090807

[PATCH 01/05] PM: Runtime PM v13 - add dev_pm_ops helpers
[PATCH 02/05] PM: Runtime PM v13 - let bus-less devices succeed
[PATCH 03/05] PM: Runtime PM v13 - add debug printouts
[PATCH 04/05] PM: Runtime PM v13 - CONFIG_PM_SLEEP=n support
[PATCH 05/05] PM: Runtime PM v13 - platform device bus support

These patches contain architecture independent changes for Runtime PM
and are meant to be applied on top of: 
"PM: Introduce core framework for run-time PM of I/O devices (rev. 13)"
by Rafael J. Wysocki.

Last week patches for v11 were posted, and since then the main change is
the updated and included platform device bus patch.

I would like to see at least part of this series rolled in to a future
Runtime PM release (v14?) or if not then some feedback on how to 
integrate the generic platform bus code with the Runtime PM code in
a better way. My Runtime PM implementation for SuperH Mobile builds on
top of this, so at least [01/05], [02/05] and [05/05] are needed.

Please see each individual patch for more information. Thank you!

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/base/core.c          |    3 +
 drivers/base/platform.c      |   48 +++++++++++++++++++++++++------
 drivers/base/power/main.c    |    2 -
 drivers/base/power/runtime.c |   65 ++++++++++++++++++++++--------------------
 include/linux/pm_runtime.h   |   19 ++++++++++++
 5 files changed, 96 insertions(+), 41 deletions(-)
