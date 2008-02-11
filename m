From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 1/2] acer-wmi - Fail gracefully if ACPI is
	disabled
Date: Mon, 11 Feb 2008 19:55:03 +0000
Message-ID: <200802111955.04562.carlos__46650.1475465067$1202771383$gmane$org@strangeworlds.co.uk>
References: <200802080145.16774.lenb@kernel.org>
	<20080211091743.GA16459@elte.hu>
	<200802111923.31736.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802111923.31736.carlos@strangeworlds.co.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

acer-wmi - Fail gracefully if ACPI is disabled

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

WMI drivers, like their ACPI counterparts, should also check if ACPI is
disabled or not, and bail out if so, otherwise we cause a crash.

Spotted by Ingo Molnar.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Len Brown <lenb@kernel.org>
---

 drivers/misc/acer-wmi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index d7aea93..6e81027 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -1029,6 +1029,9 @@ static int __init acer_wmi_init(void)
 {
 	int err;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	printk(ACER_INFO "Acer Laptop ACPI-WMI Extras version %s\n",
 			ACER_WMI_VERSION);
 
