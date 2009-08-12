From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/01] PM: Runtime PM v15 for Platform Devices
	20090812
Date: Wed, 12 Aug 2009 19:08:53 +0900
Message-ID: <20090812100853.26365.57240.sendpatchset@rx1.opensource.se>
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

PM: Runtime PM v15 for Platform Devices 20090812

[PATCH 01/01] PM: Runtime PM v15 - Platform Device Bus Support

This is the only remaining patch needed to allow architecture code
to implement Runtime PM of platform devices. Should be applied on top of: 
"PM: Introduce core framework for run-time PM of I/O devices (rev. 15)"
by Rafael J. Wysocki.

This patch is needed by the SuperH Mobile Runtime PM implementation.
Please let me know if you want me to rework the patch somehow. Thanks!

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/base/platform.c |   45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)
