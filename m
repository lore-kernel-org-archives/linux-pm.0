From: Len Brown <lenb@kernel.org>
Subject: [PATCH 76/76] ACPI throttling: fix endian bug in
 acpi_read_throttling_status()
Date: Fri, 30 Mar 2012 06:14:19 -0400
Message-ID: <4d809bff31637fd865000cc9a36f6a101f372754.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

Using a u64 here creates an endian bug.  We store a u32 number in the
top byte which is a larger number than intended on big endian systems.
There is no reason to use a 64 bit data type here, I guess it was just
an oversight.

I removed the initialization to zero as well.  It's needed with a u64
but with a u32, the variable gets initialized properly inside the call
to acpi_os_read_port().

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 605a295..1d02b7b 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -769,7 +769,7 @@ static int acpi_read_throttling_status(struct acpi_processor *pr,
 					u64 *value)
 {
 	u32 bit_width, bit_offset;
-	u64 ptc_value;
+	u32 ptc_value;
 	u64 ptc_mask;
 	struct acpi_processor_throttling *throttling;
 	int ret = -1;
@@ -777,12 +777,11 @@ static int acpi_read_throttling_status(struct acpi_processor *pr,
 	throttling = &pr->throttling;
 	switch (throttling->status_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
-		ptc_value = 0;
 		bit_width = throttling->status_register.bit_width;
 		bit_offset = throttling->status_register.bit_offset;
 
 		acpi_os_read_port((acpi_io_address) throttling->status_register.
-				  address, (u32 *) &ptc_value,
+				  address, &ptc_value,
 				  (u32) (bit_width + bit_offset));
 		ptc_mask = (1 << bit_width) - 1;
 		*value = (u64) ((ptc_value >> bit_offset) & ptc_mask);
-- 
1.7.10.rc2.19.gfae9d
