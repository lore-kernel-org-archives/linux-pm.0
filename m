From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5] ACPI / PM: Fixes and simplifications
Date: Fri, 2 Jul 2010 00:10:13 +0200
Message-ID: <201007020010.13755.rjw__7132.53099606863$1278022670$gmane$org@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

The following patches fix a few bugs in the ACPI platform suspend/hibernate
code and simplify it quite a bit.

[1/5] - Fixes a theoretical issue in acpi_suspend_begin() related to the NVS saving.

[2/5] - Moves acpi_enable_wakeup_device() to acpi_sleep_prepare(), so that it
        can be merged with acpi_enable_wakeup_device_prep().

[3/5] - Merges acpi_enable_wakeup_device() and acpi_enable_wakeup_device_prep()
        and drops some unnecessary code.

[4/5] - Gets rid of some code duplication in drivers/acpi/sleep.c.

[5/5] - Drops an unnecessary routine from drivers/acpi/sleep.c.

Please apply.

Rafael
