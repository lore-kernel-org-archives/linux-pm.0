From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/14] PNPACPI: Simplify disabled resource
	registration
Date: Sun, 06 Nov 2011 23:11:55 -0500
Message-ID: <18fd470a48396c8795ba7256c5973e92ffa25cb3.1320636776.git.len.brown@intel.com>
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
Cc: Witold Szczeponik <Witold.Szczeponik@gmx.net>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Witold Szczeponik <Witold.Szczeponik@gmx.net>

The attached patch simplifies 29df8d8f8702f0f53c1375015f09f04bc8d023c1.  As
the "pnp_xxx" structs are not designed to cope with IORESOURCE_DISABLED, and
hence no code can test for this value, setting this value is actually a "no op"
and can be skipped altogether.  It is sufficient to remove the checks for
"empty" resources and continue processing.

The patch is applied against 3.1.

Signed-off-by: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c |   62 +++++++++------------------------------
 1 files changed, 15 insertions(+), 47 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index bbf3edd..5be4a39 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -509,15 +509,12 @@ static __init void pnpacpi_parse_dma_option(struct pnp_dev *dev,
 					    struct acpi_resource_dma *p)
 {
 	int i;
-	unsigned char map = 0, flags = 0;
-
-	if (p->channel_count == 0)
-		flags |= IORESOURCE_DISABLED;
+	unsigned char map = 0, flags;
 
 	for (i = 0; i < p->channel_count; i++)
 		map |= 1 << p->channels[i];
 
-	flags |= dma_flags(dev, p->type, p->bus_master, p->transfer);
+	flags = dma_flags(dev, p->type, p->bus_master, p->transfer);
 	pnp_register_dma_resource(dev, option_flags, map, flags);
 }
 
@@ -527,17 +524,14 @@ static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
 {
 	int i;
 	pnp_irq_mask_t map;
-	unsigned char flags = 0;
-
-	if (p->interrupt_count == 0)
-		flags |= IORESOURCE_DISABLED;
+	unsigned char flags;
 
 	bitmap_zero(map.bits, PNP_IRQ_NR);
 	for (i = 0; i < p->interrupt_count; i++)
 		if (p->interrupts[i])
 			__set_bit(p->interrupts[i], map.bits);
 
-	flags |= irq_flags(p->triggering, p->polarity, p->sharable);
+	flags = irq_flags(p->triggering, p->polarity, p->sharable);
 	pnp_register_irq_resource(dev, option_flags, &map, flags);
 }
 
@@ -547,10 +541,7 @@ static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
 {
 	int i;
 	pnp_irq_mask_t map;
-	unsigned char flags = 0;
-
-	if (p->interrupt_count == 0)
-		flags |= IORESOURCE_DISABLED;
+	unsigned char flags;
 
 	bitmap_zero(map.bits, PNP_IRQ_NR);
 	for (i = 0; i < p->interrupt_count; i++) {
@@ -564,7 +555,7 @@ static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
 		}
 	}
 
-	flags |= irq_flags(p->triggering, p->polarity, p->sharable);
+	flags = irq_flags(p->triggering, p->polarity, p->sharable);
 	pnp_register_irq_resource(dev, option_flags, &map, flags);
 }
 
@@ -574,11 +565,8 @@ static __init void pnpacpi_parse_port_option(struct pnp_dev *dev,
 {
 	unsigned char flags = 0;
 
-	if (io->address_length == 0)
-		flags |= IORESOURCE_DISABLED;
-
 	if (io->io_decode == ACPI_DECODE_16)
-		flags |= IORESOURCE_IO_16BIT_ADDR;
+		flags = IORESOURCE_IO_16BIT_ADDR;
 	pnp_register_port_resource(dev, option_flags, io->minimum, io->maximum,
 				   io->alignment, io->address_length, flags);
 }
@@ -587,13 +575,8 @@ static __init void pnpacpi_parse_fixed_port_option(struct pnp_dev *dev,
 					unsigned int option_flags,
 					struct acpi_resource_fixed_io *io)
 {
-	unsigned char flags = 0;
-
-	if (io->address_length == 0)
-		flags |= IORESOURCE_DISABLED;
-
 	pnp_register_port_resource(dev, option_flags, io->address, io->address,
-				   0, io->address_length, flags | IORESOURCE_IO_FIXED);
+				   0, io->address_length, IORESOURCE_IO_FIXED);
 }
 
 static __init void pnpacpi_parse_mem24_option(struct pnp_dev *dev,
@@ -602,11 +585,8 @@ static __init void pnpacpi_parse_mem24_option(struct pnp_dev *dev,
 {
 	unsigned char flags = 0;
 
-	if (p->address_length == 0)
-		flags |= IORESOURCE_DISABLED;
-
 	if (p->write_protect == ACPI_READ_WRITE_MEMORY)
-		flags |= IORESOURCE_MEM_WRITEABLE;
+		flags = IORESOURCE_MEM_WRITEABLE;
 	pnp_register_mem_resource(dev, option_flags, p->minimum, p->maximum,
 				  p->alignment, p->address_length, flags);
 }
@@ -617,11 +597,8 @@ static __init void pnpacpi_parse_mem32_option(struct pnp_dev *dev,
 {
 	unsigned char flags = 0;
 
-	if (p->address_length == 0)
-		flags |= IORESOURCE_DISABLED;
-
 	if (p->write_protect == ACPI_READ_WRITE_MEMORY)
-		flags |= IORESOURCE_MEM_WRITEABLE;
+		flags = IORESOURCE_MEM_WRITEABLE;
 	pnp_register_mem_resource(dev, option_flags, p->minimum, p->maximum,
 				  p->alignment, p->address_length, flags);
 }
@@ -632,11 +609,8 @@ static __init void pnpacpi_parse_fixed_mem32_option(struct pnp_dev *dev,
 {
 	unsigned char flags = 0;
 
-	if (p->address_length == 0)
-		flags |= IORESOURCE_DISABLED;
-
 	if (p->write_protect == ACPI_READ_WRITE_MEMORY)
-		flags |= IORESOURCE_MEM_WRITEABLE;
+		flags = IORESOURCE_MEM_WRITEABLE;
 	pnp_register_mem_resource(dev, option_flags, p->address, p->address,
 				  0, p->address_length, flags);
 }
@@ -656,19 +630,16 @@ static __init void pnpacpi_parse_address_option(struct pnp_dev *dev,
 		return;
 	}
 
-	if (p->address_length == 0)
-		flags |= IORESOURCE_DISABLED;
-
 	if (p->resource_type == ACPI_MEMORY_RANGE) {
 		if (p->info.mem.write_protect == ACPI_READ_WRITE_MEMORY)
-			flags |= IORESOURCE_MEM_WRITEABLE;
+			flags = IORESOURCE_MEM_WRITEABLE;
 		pnp_register_mem_resource(dev, option_flags, p->minimum,
 					  p->minimum, 0, p->address_length,
 					  flags);
 	} else if (p->resource_type == ACPI_IO_RANGE)
 		pnp_register_port_resource(dev, option_flags, p->minimum,
 					   p->minimum, 0, p->address_length,
-					   flags | IORESOURCE_IO_FIXED);
+					   IORESOURCE_IO_FIXED);
 }
 
 static __init void pnpacpi_parse_ext_address_option(struct pnp_dev *dev,
@@ -678,19 +649,16 @@ static __init void pnpacpi_parse_ext_address_option(struct pnp_dev *dev,
 	struct acpi_resource_extended_address64 *p = &r->data.ext_address64;
 	unsigned char flags = 0;
 
-	if (p->address_length == 0)
-		flags |= IORESOURCE_DISABLED;
-
 	if (p->resource_type == ACPI_MEMORY_RANGE) {
 		if (p->info.mem.write_protect == ACPI_READ_WRITE_MEMORY)
-			flags |= IORESOURCE_MEM_WRITEABLE;
+			flags = IORESOURCE_MEM_WRITEABLE;
 		pnp_register_mem_resource(dev, option_flags, p->minimum,
 					  p->minimum, 0, p->address_length,
 					  flags);
 	} else if (p->resource_type == ACPI_IO_RANGE)
 		pnp_register_port_resource(dev, option_flags, p->minimum,
 					   p->minimum, 0, p->address_length,
-					   flags | IORESOURCE_IO_FIXED);
+					   IORESOURCE_IO_FIXED);
 }
 
 struct acpipnp_parse_option_s {
-- 
1.7.7.rc0.72.g4b5ea
