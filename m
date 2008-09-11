From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC 0/5] device wakeup event support v2
Date: Thu, 11 Sep 2008 14:30:37 +0800
Message-ID: <20080911063037.698427944__45468.8011938289$1221115339$gmane$org@sli10-desk.sh.intel.com>
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
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This series add device wakeup event detection support. This is the base to
implement runtime device suspend/resume, though we don't support it now.
But David said USB is approaching to this. See this bugzilla
http://bugzilla.kernel.org/show_bug.cgi?id=6892 for detail.

changes v1 -> v2:
1. scan pci bridge for PME. Current implementation is just doing scan if target device is a bridge
2. move device_receive_wakeup_event() call to pci, and provide an API (pci_handle_wakeup_event()) for non-ACPI & non-PCIe platform
3. fixed a lot of coding style issues

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
-- 
