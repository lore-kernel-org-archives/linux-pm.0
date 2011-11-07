From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/14] ACPI: Fix CONFIG_ACPI_DOCK=n compiler
	warning
Date: Sun, 06 Nov 2011 23:12:00 -0500
Message-ID: <c1056b42a87b59375f8f81a92ef029165f44fcce.1320636776.git.len.brown@intel.com>
References: <1320639124-16178-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1320639124-16178-1-git-send-email-lenb@kernel.org>
In-reply-to: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
References: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Bart Van Assche <bvanassche@acm.org>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

Recently the ACPI ops structs were constified but the inline version
of register_hotplug_dock_device() was overlooked (see also commit
9c8b04b, June 25 2011). Update the inline function
register_hotplug_dock_device() that is enabled with
CONFIG_ACPI_DOCK=n too. This patch fixes at least the following
compiler warnings:

drivers/ata/libata-acpi.c: In function .ata_acpi_associate.:
drivers/ata/libata-acpi.c:266:11: warning: passing argument 2 of .register_hotplug_dock_device. discards qualifiers from pointer target type
include/acpi/acpi_drivers.h:146:19: note: expected .struct acpi_dock_ops *. but argument is of type .const struct acpi_dock_ops *.
drivers/ata/libata-acpi.c:275:11: warning: passing argument 2 of .register_hotplug_dock_device. discards qualifiers from pointer target type
include/acpi/acpi_drivers.h:146:19: note: expected .struct acpi_dock_ops *. but argument is of type .const struct acpi_dock_ops *.

Cc: stable@vger.kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpi_drivers.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index e49c36d..bb145e4 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -144,7 +144,7 @@ static inline void unregister_dock_notifier(struct notifier_block *nb)
 {
 }
 static inline int register_hotplug_dock_device(acpi_handle handle,
-					       struct acpi_dock_ops *ops,
+					       const struct acpi_dock_ops *ops,
 					       void *context)
 {
 	return -ENODEV;
-- 
1.7.7.rc0.72.g4b5ea
