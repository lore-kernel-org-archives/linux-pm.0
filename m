From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/4] ACPI Hibernation: Use ACPI hardware
	signature
Date: Fri, 9 May 2008 17:27:39 +0200
Message-ID: <200805091727.40905.rjw__20927.0860920244$1210347094$gmane$org@sisk.pl>
References: <200805062331.39454.rjw@sisk.pl> <200805071428.02613.rjw@sisk.pl>
	<20080507210438.GD18516@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080507210438.GD18516@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 7 of May 2008, Pavel Machek wrote:
> Hi!

Hi,

> > > > +static int __init acpi_s4_nosigcheck(char *str)
> > > > +{
> > > > +	nosigcheck = true;
> > > > +	return 1;
> > > > +}
> > > > +__setup("acpi_s4_nosigcheck", acpi_s4_nosigcheck);
> > > > +
> > > 
> > > Needs a patch to Documentation/ , too.
> > 
> > Yes, thanks.
> > 
> > > > +	/* Check the hardware signature */
> > > > +	if (facs && s4_hardware_signature != facs->hardware_signature)
> > > 
> > > do you need && !nosigcheck here ?
> > 
> > No, facs is NULL if !nosigcheck.
> 
> Aha, ook. You can add my ACK when you add the Documentation/.

Corrected patch is appended.

Thanks,
Rafael

---
From: Shaohua Li <shaohua.li@intel.com>

ACPI defines a hardware signature. BIOS calculates the signature
according to hardware configure, if hardware changes, the signature
will change, in this case, S4 resume should fail.

[rjw: The kernel command line switch acpi_s4_nosigcheck is added for
systems on which this mechanism is broken.]

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/kernel-parameters.txt |    5 +++++
 drivers/acpi/sleep/main.c           |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -255,6 +255,17 @@ static struct dmi_system_id __initdata a
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
+static unsigned long s4_hardware_signature;
+static struct acpi_table_facs *facs;
+static bool nosigcheck;
+
+static int __init acpi_s4_nosigcheck(char *str)
+{
+	nosigcheck = true;
+	return 1;
+}
+__setup("acpi_s4_nosigcheck", acpi_s4_nosigcheck);
+
 static int acpi_hibernation_begin(void)
 {
 	acpi_target_sleep_state = ACPI_STATE_S4;
@@ -301,6 +312,12 @@ static void acpi_hibernation_leave(void)
 	acpi_enable();
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
+	/* Check the hardware signature */
+	if (facs && s4_hardware_signature != facs->hardware_signature) {
+		printk(KERN_EMERG "ACPI: Hardware changed while hibernated, "
+			"cannot resume!\n");
+		panic("ACPI S4 hardware signature mismatch");
+	}
 }
 
 static void acpi_hibernation_finish(void)
@@ -501,6 +518,13 @@ int __init acpi_sleep_init(void)
 		hibernation_set_ops(&acpi_hibernation_ops);
 		sleep_states[ACPI_STATE_S4] = 1;
 		printk(" S4");
+		if (!nosigcheck) {
+			acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+				(struct acpi_table_header **)&facs);
+			if (facs)
+				s4_hardware_signature =
+					facs->hardware_signature;
+		}
 	}
 #endif
 	status = acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -152,6 +152,11 @@ and is between 256 and 4096 characters. 
 			s3_beep is for debugging; it makes the PC's speaker beep
 			as soon as the kernel's real-mode entry point is called.
 
+	acpi_s4_nosigcheck [HW,ACPI] S4 hardware signature
+			ACPI will ignore the S4 hardware signature
+			default: The hardware signature is checked during
+			         resume from S4.
+
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
 
