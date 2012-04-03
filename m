From: "Luck, Tony: <tony.luck@intel.com>"@mail.linuxfoundation.org
Subject: [PATCH] Use safe_halt() rather than halt() in
	acpi_idle_play_deay()
Date: Tue, 03 Apr 2012 09:37:28 -0700
Message-ID: <4f7b27487632dad07@agluck-desktop.sc.intel.com>
References: <4F79EBAA.7040602@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4F79EBAA.7040602@amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Boris Ostrovsky <boris.ostrovsky@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

ACPI code is shared by arch/x86 and arch/ia64. ia64 doesn't provide a plain
"halt()" function.  Use safe_halt() instead.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

E-mail discussion indicated this would be OK. Please check on x86
before applying.

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index b3447f6..f3decb3 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -786,7 +786,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 	while (1) {
 
 		if (cx->entry_method == ACPI_CSTATE_HALT)
-			halt();
+			safe_halt();
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
 			inb(cx->address);
 			/* See comment in acpi_idle_do_entry() */
