From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] x86, acpi: Handle lapic/x2apic entries in MADT
Date: Wed, 26 Aug 2015 12:42:50 +0100
Message-ID: <20150826114250.GA11863@red-moon>
References: <20150802134014.380415cd@arm.com>
 <1438626365-23709-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1438626365-23709-2-git-send-email-lukasz.anaczkowski@intel.com>
 <C1C2579D7BE026428F81F41198ADB17237863E88@irsmsx110.ger.corp.intel.com>
 <55DD9838.20505@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55DD9838.20505@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On Wed, Aug 26, 2015 at 11:43:04AM +0100, Marc Zyngier wrote:
> Hi Lukasz,
> 
> On 26/08/15 08:04, Anaczkowski, Lukasz wrote:
> > On Monday, August 3, 2015 8:26 PM
> > Lukasz Anaczkowski <lukasz.anaczkowski@intel.com> wrote:
> > 
> >> v2: Fixed ARM64 syntax error
> > 
> > Hi Marc,
> > 
> > Does this patch look ok now?

No it does not, it seems to break arm64, I put together a fix
below. I do not think the way you handle the count increment
in acpi_parse_entries() is correct anyway, since you increment
it only if max_entries != 0, which changes mainline behaviour.

Thanks,
Lorenzo

-- >8 --

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index d98b866..ca5591d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1101,7 +1101,7 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 				   sizeof(struct acpi_table_madt),
 				   table, &gic_proc, 1, 0);
-	if (count <= 0) {
+	if (gic_proc.count <= 0) {
 		pr_err("No valid GICC entries exist\n");
 		return -EINVAL;
 	}
@@ -1117,7 +1117,7 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 				   sizeof(struct acpi_table_madt),
 				   table, &gic_proc, 1, 0);
-	if (count <= 0) {
+	if (gic_proc.count <= 0) {
 		pr_err("No valid GICD entries exist\n");
 		return -EINVAL;
 	} else if (count > 1) {
-- 
2.2.1

