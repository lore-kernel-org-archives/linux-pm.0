From: James Hogan <james@albanarts.com>
Subject: [PATCH v2 1/2] pm_trace: Lock pm device list mutex.
Date: Sun, 10 Oct 2010 02:05:01 +0100
Message-ID: <201010100205.01528.james__42839.4165392548$1286896506$gmane$org@albanarts.com>
References: <201010100202.01605.james@albanarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010100202.01605.james@albanarts.com>
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
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, markgross <markgross@thegnar.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Lock the pm device list mutex using device_pm_lock() and
device_pm_unlock() around the list iteration in show_dev_hash().

show_dev_hash() was reverse iterating dpm_list without first locking the
mutex that the functions in drivers/base/power/main.c lock. I assume
this was unintentional since there is no comment suggesting why the lock
might not be necessary.

Signed-off-by: James Hogan <james@albanarts.com>
---
 drivers/base/power/trace.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index 0a1a2c4..17e24e3 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -188,8 +188,10 @@ static int show_file_hash(unsigned int value)
 static int show_dev_hash(unsigned int value)
 {
 	int match = 0;
-	struct list_head *entry = dpm_list.prev;
+	struct list_head *entry;
 
+	device_pm_lock();
+	entry = dpm_list.prev;
 	while (entry != &dpm_list) {
 		struct device * dev = to_device(entry);
 		unsigned int hash = hash_string(DEVSEED, dev_name(dev), DEVHASH);
@@ -199,6 +201,7 @@ static int show_dev_hash(unsigned int value)
 		}
 		entry = entry->prev;
 	}
+	device_pm_unlock();
 	return match;
 }
 
-- 
1.7.2.3
