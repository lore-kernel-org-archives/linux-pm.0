From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/11] Various ACPI patches for 2.6.38
Date: Thu, 6 Jan 2011 23:31:16 +0100
Message-ID: <201101062331.17079.rjw__6602.38522473282$1294354023$gmane$org@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

In this series there are several ACPI patches I'd like to go into 2.6.38.
Some of them have been posted to linux-acpi already, some others are new.

[1/11] - Fix global lock acquisition (this patch is the same as
         https://patchwork.kernel.org/patch/435861/).

[2/11] - Prevent /proc/acpi/wakeup from enabling multiple devices to
         wake up simultaneously (this patch is the same as
         https://patchwork.kernel.org/patch/436351/).

[3/11] - Make the button driver use standard device wakeup flags
         (same as https://patchwork.kernel.org/patch/436321/).

[4/11] - Drop special ACPI wakeup flags that aren't necessary any more
         (same as https://patchwork.kernel.org/patch/436341/).

[5/11] - Use pm_wakeup_event() to report wakeup events from ACPI buttons
         (same as https://patchwork.kernel.org/patch/436331/).

[6/11] - Blacklist Averatec box requiring acpi_sleep=nonvs (new patch).

[7/11] - Rename acpi_power_off_device() (new patch).

[8/11] - Check status of power resources under mutexes (new patch).

[9/11] - Avoid printing messages about missing _PRW methods unnecessarily
         (new, fixes a glitch introduced by one of the recent regression fixes,
         -stable material).

[10/11] - Remove the wake_capable flag which isn't really useful (new patch).

[11/11] - Refresh battery information on 0x81 notification and during resume
          (new patch, based on the Matthew's battery patch we discussed some
          time ago).

Please consider for applying.

[NOTE: This series doesn't contain patches that depend on the latest ACPICA
 update and fix/modify changes made by it.]

Thanks,
Rafael
