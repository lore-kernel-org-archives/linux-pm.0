From: James Hogan <james@albanarts.com>
Subject: [PATCH 0/2] pm_trace: Add locking and add sysfs attr for
	rechecking dev hash.
Date: Sat, 9 Oct 2010 23:34:27 +0100
Message-ID: <201010092334.27808.james__28998.5649790198$1286896486$gmane$org@albanarts.com>
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
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, markgross <markgross@thegnar.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

A fix and an improvement to the pm_trace code.

The improvement allows finding out via sysfs which device was last traced when 
the device is part of a kernel module (which means it doesn't get printed on 
next boot since it isn't loaded yet).

Unsure as always about what to name stuff, so comments most welcome.

James Hogan (2):
  pm_trace: Lock pm device list mutex.
  pm_trace: Add sysfs attr for rechecking dev hash.

 Documentation/power/s2ram.txt |    7 +++++++
 drivers/base/power/trace.c    |   32 +++++++++++++++++++++++++++++++-
 include/linux/resume-trace.h  |    2 ++
 kernel/power/main.c           |   18 ++++++++++++++++++
 4 files changed, 58 insertions(+), 1 deletions(-)

-- 
1.7.2.3
