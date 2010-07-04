From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] ACPI / ACPICA: Avoid executing _PRW twice
	for all devices
Date: Mon, 5 Jul 2010 00:56:22 +0200
Message-ID: <201007050056.22705.rjw__10113.2725169466$1278284701$gmane$org@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, "Moore,
	Robert" <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Following our recent IRC discussion I thought I'd bite the bullet and prepare
a patch to remove the execution of _PRW from ACPICA and there it goes.

The series is on top of the patch I sent a couple of days ago:
https://patchwork.kernel.org/patch/110076/

[1/3] - Drops the code to walk the namespace in search of _PRW and adds
        acpi_gpe_can_wake() so that the host OS can disable wakeup GPEs
        previously enabled unconditionally by the ACPICA initialization code.
        This basically reproduces the current behavior except that the GPEs
        are temporarily enabled before acpi_bus_extract_wakeup_device_power_package()
        runs for all devices with _PRW referring to them.

[2/3] - Simplifies code in acpi_ev_initialize_gpe_block(), which only is a
        cosmetic thing, but worth doing IMO.

[3/3] - Changes acpi_gpe_wakeup() to return error code for the GPEs whose
        ACPI_GPE_CAN_WAKE flags are not set.

Please apply.

Rafael
