From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/5] acpi_idle: delete bogus data from
	cpuidle_state.power_usage
Date: Tue, 26 Oct 2010 17:07:32 -0400
Message-ID: <0f3f164d9794f57d8afb033819f508a486c1304d.1288127069.git.len.brown@intel.com>
References: <1288127254-3306-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1288127254-3306-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8381cc3d8a9cc6c80f65bf60863c776651f245c.1288127069.git.len.brown@intel.com>
References: <c8381cc3d8a9cc6c80f65bf60863c776651f245c.1288127069.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The mW data in this field comes from AML _CST,
which was typed in by a BIOS writer, and is thus
considered unreliable.

Linux does not use it for making any decisions.
We do display it in sysfs where somebody might
read it and assume it is meaningful, so delete it.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f4428e8..07a8bb6 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1013,7 +1013,6 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
 		state->exit_latency = cx->latency;
 		state->target_residency = cx->latency * latency_factor;
-		state->power_usage = cx->power;
 
 		state->flags = 0;
 		switch (cx->type) {
-- 
1.7.3.2.90.gd4c43
