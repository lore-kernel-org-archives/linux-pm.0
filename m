From: Len Brown <lenb@kernel.org>
Subject: [PATCH 42/76] ACPI: ec: Do request_region outside WARN()
Date: Fri, 30 Mar 2012 06:13:45 -0400
Message-ID: <d6795fe32da13bde39ea483e42799a22daa730b5.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
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
Cc: Andi Kleen <ak@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

WARN() is not supposed to have side effects, so move the request_regions
outside.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b19a18d..3268dcf 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -812,10 +812,10 @@ static int acpi_ec_add(struct acpi_device *device)
 		first_ec = ec;
 	device->driver_data = ec;
 
-	WARN(!request_region(ec->data_addr, 1, "EC data"),
-	     "Could not request EC data io port 0x%lx", ec->data_addr);
-	WARN(!request_region(ec->command_addr, 1, "EC cmd"),
-	     "Could not request EC cmd io port 0x%lx", ec->command_addr);
+	ret = !!request_region(ec->data_addr, 1, "EC data");
+	WARN(!ret, "Could not request EC data io port 0x%lx", ec->data_addr);
+	ret = !!request_region(ec->command_addr, 1, "EC cmd");
+	WARN(!ret, "Could not request EC cmd io port 0x%lx", ec->command_addr);
 
 	pr_info(PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx\n",
 			  ec->gpe, ec->command_addr, ec->data_addr);
-- 
1.7.10.rc2.19.gfae9d
