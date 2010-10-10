From: James Hogan <james@albanarts.com>
Subject: [PATCH v2 0/2] pm_trace: Add locking and add sysfs attr
	for rechecking dev hash.
Date: Sun, 10 Oct 2010 02:02:00 +0100
Message-ID: <201010100202.01605.james__7380.57203493572$1286896502$gmane$org@albanarts.com>
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
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, markgross <markgross@thegnar.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

A fix and an improvement to the pm_trace code.

The improvement allows finding out via sysfs which device was last traced when
the device is part of a kernel module (which means it doesn't get printed on
next boot since it isn't loaded yet).

Changes in v2:
- renamed sysfs attr pm_trace_dev_hash to pm_trace_dev_match
- renamed snprint_trace_dev_hash to show_trace_dev_match
- added comment in show_trace_dev_match referring to the fact that multiple
  devices could match the hash and they all need printing out
- added documentation to Documentation/ABI/testing/sysfs-power
- minor rewording in Documentation/power/s2ram.txt

James Hogan (2):
  pm_trace: Lock pm device list mutex.
  pm_trace: Add sysfs attr for rechecking dev hash.

 Documentation/ABI/testing/sysfs-power |   29 ++++++++++++++++++++++++++
 Documentation/power/s2ram.txt         |    7 ++++++
 drivers/base/power/trace.c            |   36 ++++++++++++++++++++++++++++++++-
 include/linux/resume-trace.h          |    2 +
 kernel/power/main.c                   |   18 ++++++++++++++++
 5 files changed, 91 insertions(+), 1 deletions(-)

-- 
1.7.2.3
