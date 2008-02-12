From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] acer-wmi - Fail gracefully if ACPI is
	disabled
Date: Mon, 11 Feb 2008 20:41:42 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802112038360.2920__32150.9180394516$1202791418$gmane$org@woody.linux-foundation.org>
References: <200802080145.16774.lenb@kernel.org>
	<20080211091743.GA16459@elte.hu>
	<200802111923.31736.carlos@strangeworlds.co.uk>
	<200802111955.04562.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802111955.04562.carlos@strangeworlds.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org



On Mon, 11 Feb 2008, Carlos Corbacho wrote:
> 
> WMI drivers, like their ACPI counterparts, should also check if ACPI is
> disabled or not, and bail out if so, otherwise we cause a crash.

Shouldn't "wmi_has_guid()" just return false if ACPI isn't enabled, and 
the drivers should just then always give up?

The proper way to get there would seem to be to just do this instead..

We should *not* add some random ACPI workarounds to individual drivers, we 
should just make the wmi subsystem so robust that nobody *cares* if acpi 
exists or is enabled on that machine.

		Linus

---
 drivers/acpi/wmi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index 36b84ab..457ed3d 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -673,11 +673,11 @@ static int __init acpi_wmi_init(void)
 {
 	acpi_status result;
 
+	INIT_LIST_HEAD(&wmi_blocks.list);
+
 	if (acpi_disabled)
 		return -ENODEV;
 
-	INIT_LIST_HEAD(&wmi_blocks.list);
-
 	result = acpi_bus_register_driver(&acpi_wmi_driver);
 
 	if (result < 0) {
