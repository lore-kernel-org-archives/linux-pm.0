From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch] hibernation: utilize ACPI hardware signature
Date: Fri, 04 Jan 2008 13:41:31 +0800
Message-ID: <1199425291.20053.2.camel__34420.8591305234$1199425371$gmane$org@sli10-desk.sh.intel.com>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
	<200801021505.39789.rjw@sisk.pl>
	<1199338595.1642.3.camel@sli10-desk.sh.intel.com>
	<200801031804.30947.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801031804.30947.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org


On Fri, 2008-01-04 at 01:04 +0800, Rafael J. Wysocki wrote:
> On Thursday, 3 of January 2008, Shaohua Li wrote:
> >
> > On Wed, 2008-01-02 at 22:05 +0800, Rafael J. Wysocki wrote:
> > > On Wednesday, 2 of January 2008, Shaohua Li wrote:
> > > > ACPI defines a hardware signature. BIOS calculates the signature
> > > > according to hardware configure, if hardware changes, the
> signature
> > > will
> > > > change, in this case, S4 resume should fail.
> > >
> > > The idea is fine, but I'd prefer to do that in a more
> straightforward
> > > way.
> > > Namely, we can just:
> > > * write the signature into a variable in, for example,
> > >   acpi_hibernation_prepare() (then, the "old" signature value will
> be
> > >   automatically saved in the image)
> > > * compare it with a the "new" value read from the BIOS in
> > >   acpi_hibernation_leave() and panic if there's a mismatch
> > > * add a configuration option to disable this behavior (just in
> case)
> > > This way we can avoid modifying the entire generic interface to
> add
> > > the feature
> > > specific to ACPI.
> > it would be better we do the check in boot kernel.
> Franky, I think we should also check in the image kernel, in case the
> boot
> one doesn't support ACPI as I said.
Ok, makes sense. I changed to check the signature in .higberation_leave

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/sleep/main.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: linux/drivers/acpi/sleep/main.c
===================================================================
--- linux.orig/drivers/acpi/sleep/main.c	2008-01-03 13:37:08.000000000 +0800
+++ linux/drivers/acpi/sleep/main.c	2008-01-04 13:36:10.000000000 +0800
@@ -256,6 +256,17 @@ static int acpi_hibernation_enter(void)
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
+static unsigned long s4_hardware_signature;
+static struct acpi_table_facs *facs;
+static int nosigcheck;
+
+static int __init acpi_s4_nosigcheck(char *str)
+{
+	nosigcheck = 1;
+	return 1;
+}
+__setup("acpi_s4_nosigcheck", acpi_s4_nosigcheck);
+
 static void acpi_hibernation_leave(void)
 {
 	/*
@@ -263,6 +274,11 @@ static void acpi_hibernation_leave(void)
 	 * enable it here.
 	 */
 	acpi_enable();
+	if (facs && s4_hardware_signature != facs->hardware_signature) {
+		printk(KERN_EMERG"PM: Hardware changed in the S4 circle, can't resume\n");
+		if (!nosigcheck)
+			panic("S4 resume error");
+	}
 }
 
 static void acpi_hibernation_finish(void)
@@ -449,6 +465,10 @@ int __init acpi_sleep_init(void)
 		sleep_states[ACPI_STATE_S4] = 1;
 		printk(" S4");
 	}
+	acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+		(struct acpi_table_header **)&facs);
+	if (facs)
+		s4_hardware_signature = facs->hardware_signature;
 #endif
 	status = acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
 	if (ACPI_SUCCESS(status)) {
