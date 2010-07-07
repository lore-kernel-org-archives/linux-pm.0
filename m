From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH 0/4] ACPI: Avoid executing _PRW twice for
	all devices
Date: Thu, 8 Jul 2010 00:41:38 +0200
Message-ID: <201007080041.38627.rjw__39693.6337733225$1278542988$gmane$org@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

The following patches have already been sent once and (except for [1/4]) they
have been in your test branch for some time, but they stopped applying after
the previous ACPICA changes were merged.  So, here they go again,
rebased on top of your test branch.

[1/4] - Fixes a test supposed to check if a GPE has a method or handler.

[2/4] - Drops the code walikng the namespace in search of _PRW and adds
        acpi_gpe_can_wake() so that the host OS can disable wakeup GPEs
        previously enabled unconditionally by the ACPICA initialization code.
        This basically reproduces the current behavior except that the GPEs
        are temporarily enabled befor
        acpi_bus_extract_wakeup_device_power_package()
        runs for all devices with _PRW referring to them.

[3/4] - Simplifies code in acpi_ev_initialize_gpe_block(), which only is a
        cosmetic thing, but worth doing IMO.

[4/4] - Changes acpi_gpe_wakeup() to return error code for the GPEs whose
        ACPI_GPE_CAN_WAKE flags are not set.

Please apply.

Rafael
