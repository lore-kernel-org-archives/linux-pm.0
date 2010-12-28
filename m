From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] ACPI / PM: Use standard device wakeup
	facilities for ACPI wakeup devices
Date: Tue, 28 Dec 2010 16:25:36 +0100
Message-ID: <201012281625.36191.rjw__14076.1994560764$1293550462$gmane$org@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series of patches causes standard device wakeup facilities to be used
with ACPI wakeup devices, like buttons.

[1/4] - Modify /proc/acpi/wakeup not to enable multiple devices at a time to
        wake up the system from sleep states, even if they share a GPE.

[2/4] - Use standard device wakeup flags for handling ACPI wakeup devices.

[3/4] - Remove special ACPI wakeup flags.

[4/4] - Report wakeup events for ACPI buttons and lids.

The patches have been tested with Toshiba Portege R500.

Thanks,
Rafael
