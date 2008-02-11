From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 2/2] tc1100-wmi - Fail gracefully if ACPI is
	disabled
Date: Mon, 11 Feb 2008 19:55:45 +0000
Message-ID: <200802111955.46199.carlos__46437.2594994076$1202771749$gmane$org@strangeworlds.co.uk>
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

tc1100-wmi - Fail gracefully if ACPI is disabled

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

 drivers/misc/tc1100-wmi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/drivers/misc/tc1100-wmi.c b/drivers/misc/tc1100-wmi.c
index f25e4c9..cb8f79f 100644
--- a/drivers/misc/tc1100-wmi.c
+++ b/drivers/misc/tc1100-wmi.c
@@ -263,6 +263,9 @@ static int __init tc1100_init(void)
 {
 	int result = 0;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	if (!wmi_has_guid(GUID))
 		return -ENODEV;
 
