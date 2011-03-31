From: Aakash Goenka <aakash.goenka@gmail.com>
Subject: [PATCH] x86: kernel: acpi : Fix style problems in boot.c
Date: Thu, 31 Mar 2011 23:17:34 +0530
Message-ID: <AANLkTinW8t5aj6wgFz8O4-XiTJSWSXe06iDYaiHar3b-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0897189854551201322=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============0897189854551201322==
Content-Type: multipart/alternative; boundary=0015174c3e00718dd5049fcae370

--0015174c3e00718dd5049fcae370
Content-Type: text/plain; charset=ISO-8859-1

 Fixes most style errors and warnings.
 Signed-off-by: Aakash Goenka <aakash.goenka@gmail.com>

---
 arch/x86/kernel/acpi/boot.c |   83
+++++++++++++++++++++----------------------
 1 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 9a966c5..b9bb13a 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -83,7 +83,7 @@ static u64 acpi_lapic_addr __initdata =
APIC_DEFAULT_PHYS_BASE;
 #endif

 /*
--------------------------------------------------------------------------
-                              Boot-time Configuration
+                Boot-time Configuration

--------------------------------------------------------------------------
*/

 /*
@@ -106,11 +106,9 @@ static unsigned int gsi_to_irq(unsigned int gsi)
     unsigned int irq = gsi + NR_IRQS_LEGACY;
     unsigned int i;

-    for (i = 0; i < NR_IRQS_LEGACY; i++) {
-        if (isa_irq_to_gsi[i] == gsi) {
+    for (i = 0; i < NR_IRQS_LEGACY; i++)
+        if (isa_irq_to_gsi[i] == gsi)
             return i;
-        }
-    }

     /* Provide an identity mapping of gsi == irq
      * except on truly weird platforms that have
@@ -245,7 +243,7 @@ acpi_parse_x2apic(struct acpi_subtable_header *header,
const unsigned long end)
 }

 static int __init
-acpi_parse_lapic(struct acpi_subtable_header * header, const unsigned long
end)
+acpi_parse_lapic(struct acpi_subtable_header *header, const unsigned long
end)
 {
     struct acpi_madt_local_apic *processor = NULL;

@@ -288,7 +286,7 @@ acpi_parse_sapic(struct acpi_subtable_header *header,
const unsigned long end)
 }

 static int __init
-acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
+acpi_parse_lapic_addr_ovr(struct acpi_subtable_header *header,
               const unsigned long end)
 {
     struct acpi_madt_local_apic_override *lapic_addr_ovr = NULL;
@@ -323,7 +321,8 @@ acpi_parse_x2apic_nmi(struct acpi_subtable_header
*header,
 }

 static int __init
-acpi_parse_lapic_nmi(struct acpi_subtable_header * header, const unsigned
long end)
+acpi_parse_lapic_nmi(struct acpi_subtable_header *header,
+             const unsigned long end)
 {
     struct acpi_madt_local_apic_nmi *lapic_nmi = NULL;

@@ -345,7 +344,7 @@ acpi_parse_lapic_nmi(struct acpi_subtable_header *
header, const unsigned long e
 #ifdef CONFIG_X86_IO_APIC

 static int __init
-acpi_parse_ioapic(struct acpi_subtable_header * header, const unsigned long
end)
+acpi_parse_ioapic(struct acpi_subtable_header *header, const unsigned long
end)
 {
     struct acpi_madt_io_apic *ioapic = NULL;

@@ -365,7 +364,8 @@ acpi_parse_ioapic(struct acpi_subtable_header * header,
const unsigned long end)
 /*
  * Parse Interrupt Source Override for the ACPI SCI
  */
-static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16 polarity, u16
trigger, u32 gsi)
+static void __init acpi_sci_ioapic_setup(u8 bus_irq,
+                     u16 polarity, u16 trigger, u32 gsi)
 {
     if (trigger == 0)    /* compatible SCI trigger is level */
         trigger = 3;
@@ -396,7 +396,7 @@ static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16
polarity, u16 trigger,
 }

 static int __init
-acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
+acpi_parse_int_src_ovr(struct acpi_subtable_header *header,
                const unsigned long end)
 {
     struct acpi_madt_interrupt_override *intsrc = NULL;
@@ -410,8 +410,10 @@ acpi_parse_int_src_ovr(struct acpi_subtable_header *
header,

     if (intsrc->source_irq == acpi_gbl_FADT.sci_interrupt) {
         acpi_sci_ioapic_setup(intsrc->source_irq,
-                      intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
-                      (intsrc->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2,
+                      intsrc->inti_flags &
+                      ACPI_MADT_POLARITY_MASK,
+                      (intsrc->inti_flags &
+                      ACPI_MADT_TRIGGER_MASK) >> 2,
                       intsrc->global_irq);
         return 0;
     }
@@ -421,7 +423,8 @@ acpi_parse_int_src_ovr(struct acpi_subtable_header *
header,
             printk(PREFIX "BIOS IRQ0 pin2 override ignored.\n");
             return 0;
         }
-        if (acpi_fix_pin2_polarity && (intsrc->inti_flags &
ACPI_MADT_POLARITY_MASK)) {
+        if (acpi_fix_pin2_polarity &&
+            (intsrc->inti_flags & ACPI_MADT_POLARITY_MASK)) {
             intsrc->inti_flags &= ~ACPI_MADT_POLARITY_MASK;
             printk(PREFIX "BIOS IRQ0 pin2 override: forcing polarity to
high active.\n");
         }
@@ -429,14 +432,16 @@ acpi_parse_int_src_ovr(struct acpi_subtable_header *
header,

     mp_override_legacy_irq(intsrc->source_irq,
                 intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
-                (intsrc->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2,
+                (intsrc->inti_flags &
+                ACPI_MADT_TRIGGER_MASK) >> 2,
                 intsrc->global_irq);

     return 0;
 }

 static int __init
-acpi_parse_nmi_src(struct acpi_subtable_header * header, const unsigned
long end)
+acpi_parse_nmi_src(struct acpi_subtable_header *header,
+           const unsigned long end)
 {
     struct acpi_madt_nmi_source *nmi_src = NULL;

@@ -652,7 +657,7 @@ static int __cpuinit _acpi_map_lsapic(acpi_handle
handle, int *pcpu)
      */
     cpumask_andnot(new_map, cpu_present_mask, tmp_map);
     if (cpumask_empty(new_map)) {
-        printk ("Unable to map lapic to logical cpu number\n");
+        printk(KERN_WARNING PREFIX "Unable to map lapic to logical cpu
number\n");
         retval = -EINVAL;
         goto free_new_map;
     }
@@ -686,9 +691,8 @@ int acpi_unmap_lsapic(int cpu)
     set_cpu_present(cpu, false);
     num_processors--;

-    return (0);
+    return 0;
 }
-
 EXPORT_SYMBOL(acpi_unmap_lsapic);
 #endif                /* CONFIG_ACPI_HOTPLUG_CPU */

@@ -697,7 +701,6 @@ int acpi_register_ioapic(acpi_handle handle, u64
phys_addr, u32 gsi_base)
     /* TBD */
     return -EINVAL;
 }
-
 EXPORT_SYMBOL(acpi_register_ioapic);

 int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
@@ -705,7 +708,6 @@ int acpi_unregister_ioapic(acpi_handle handle, u32
gsi_base)
     /* TBD */
     return -EINVAL;
 }
-
 EXPORT_SYMBOL(acpi_unregister_ioapic);

 static int __init acpi_parse_sbf(struct acpi_table_header *table)
@@ -726,7 +728,7 @@ static int __init acpi_parse_sbf(struct
acpi_table_header *table)
 #ifdef CONFIG_HPET_TIMER
 #include <asm/hpet.h>

-static struct __initdata resource *hpet_res;
+static struct __initdata resource * hpet_res;

 static int __init acpi_parse_hpet(struct acpi_table_header *table)
 {
@@ -833,7 +835,7 @@ static int __init acpi_parse_fadt(struct
acpi_table_header *table)
          * "X" fields are optional extensions to the original V1.0
          * fields, so we must selectively expand V1.0 fields if the
          * corresponding X field is zero.
-          */
+         */
         if (!pmtmr_ioport)
             pmtmr_ioport = acpi_gbl_FADT.pm_timer_block;
     } else {
@@ -926,7 +928,8 @@ static int __init acpi_parse_madt_lapic_entries(void)
         acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI,
                   acpi_parse_x2apic_nmi, 0);
     count =
-        acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI,
acpi_parse_lapic_nmi, 0);
+        acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI,
+                  acpi_parse_lapic_nmi, 0);
     if (count < 0 || x2count < 0) {
         printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
         /* TBD: Cleanup to allow fallback to MPS */
@@ -983,7 +986,7 @@ void __init mp_config_acpi_legacy_irqs(void)
     int i;
     struct mpc_intsrc mp_irq;

-#if defined (CONFIG_MCA) || defined (CONFIG_EISA)
+#if defined(CONFIG_MCA) || defined(CONFIG_EISA)
     /*
      * Fabricate the legacy ISA bus (bus #31).
      */
@@ -1170,8 +1173,8 @@ static int __init acpi_parse_madt_ioapic_entries(void)
     }

     count =
-        acpi_table_parse_madt(ACPI_MADT_TYPE_INTERRUPT_OVERRIDE,
acpi_parse_int_src_ovr,
-                  nr_irqs);
+        acpi_table_parse_madt(ACPI_MADT_TYPE_INTERRUPT_OVERRIDE,
+                  acpi_parse_int_src_ovr, nr_irqs);
     if (count < 0) {
         printk(KERN_ERR PREFIX
                "Error parsing interrupt source overrides entry\n");
@@ -1269,10 +1272,10 @@ static void __init acpi_process_madt(void)
         }
     } else {
         /*
-          * ACPI found no MADT, and so ACPI wants UP PIC mode.
-          * In the event an MPS table was found, forget it.
-          * Boot with "acpi=off" to use MPS on such a system.
-          */
+         * ACPI found no MADT, and so ACPI wants UP PIC mode.
+         * In the event an MPS table was found, forget it.
+         * Boot with "acpi=off" to use MPS on such a system.
+         */
         if (smp_found_config) {
             printk(KERN_WARNING PREFIX
                 "No APIC-table, disabling MPS\n");
@@ -1496,7 +1499,7 @@ void __init acpi_boot_table_init(void)
      * If acpi_disabled, bail out
      */
     if (acpi_disabled)
-        return;
+        return;

     /*
      * Initialize the ACPI boot-time table parser.
@@ -1575,26 +1578,22 @@ static int __init parse_acpi(char *arg)
         return -EINVAL;

     /* "acpi=off" disables both ACPI table parsing and interpreter */
-    if (strcmp(arg, "off") == 0) {
+    if (strcmp(arg, "off") == 0)
         disable_acpi();
-    }
     /* acpi=force to over-ride black-list */
     else if (strcmp(arg, "force") == 0) {
         acpi_force = 1;
         acpi_disabled = 0;
     }
     /* acpi=strict disables out-of-spec workarounds */
-    else if (strcmp(arg, "strict") == 0) {
+    else if (strcmp(arg, "strict") == 0)
         acpi_strict = 1;
-    }
     /* acpi=rsdt use RSDT instead of XSDT */
-    else if (strcmp(arg, "rsdt") == 0) {
+    else if (strcmp(arg, "rsdt") == 0)
         acpi_rsdt_forced = 1;
-    }
     /* "acpi=noirq" disables ACPI interrupt routing */
-    else if (strcmp(arg, "noirq") == 0) {
+    else if (strcmp(arg, "noirq") == 0)
         acpi_noirq_set();
-    }
     /* "acpi=copy_dsdt" copys DSDT */
     else if (strcmp(arg, "copy_dsdt") == 0) {
         acpi_gbl_copy_dsdt_locally = 1;
@@ -1674,7 +1673,7 @@ int __acpi_acquire_global_lock(unsigned int *lock)
         old = *lock;
         new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
         val = cmpxchg(lock, old, new);
-    } while (unlikely (val != old));
+    } while (unlikely(val != old));
     return (new < 3) ? -1 : 0;
 }

@@ -1685,6 +1684,6 @@ int __acpi_release_global_lock(unsigned int *lock)
         old = *lock;
         new = old & ~0x3;
         val = cmpxchg(lock, old, new);
-    } while (unlikely (val != old));
+    } while (unlikely(val != old));
     return old & 0x1;
 }
-- 
1.7.0.4

--0015174c3e00718dd5049fcae370
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=A0Fixes most style errors and warnings.<br>=A0Signed-off-by: Aakash Goenka=
 &lt;<a href=3D"mailto:aakash.goenka@gmail.com">aakash.goenka@gmail.com</a>=
&gt;<br><br>---<br>=A0arch/x86/kernel/acpi/boot.c |=A0=A0 83 ++++++++++++++=
+++++++----------------------<br>
=A01 files changed, 41 insertions(+), 42 deletions(-)<br><br>diff --git a/a=
rch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c<br>index 9a966c5..=
b9bb13a 100644<br>--- a/arch/x86/kernel/acpi/boot.c<br>+++ b/arch/x86/kerne=
l/acpi/boot.c<br>
@@ -83,7 +83,7 @@ static u64 acpi_lapic_addr __initdata =3D APIC_DEFAULT_PH=
YS_BASE;<br>=A0#endif<br>=A0<br>=A0/* -------------------------------------=
-------------------------------------<br>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Boot-time Configurat=
ion<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Boot-time Configuration<br>=A0=A0=
=A0 -----------------------------------------------------------------------=
--- */<br>=A0<br>=A0/*<br>@@ -106,11 +106,9 @@ static unsigned int gsi_to_i=
rq(unsigned int gsi)<br>=A0=A0=A0=A0 unsigned int irq =3D gsi + NR_IRQS_LEG=
ACY;<br>
=A0=A0=A0=A0 unsigned int i;<br>=A0<br>-=A0=A0=A0 for (i =3D 0; i &lt; NR_I=
RQS_LEGACY; i++) {<br>-=A0=A0=A0 =A0=A0=A0 if (isa_irq_to_gsi[i] =3D=3D gsi=
) {<br>+=A0=A0=A0 for (i =3D 0; i &lt; NR_IRQS_LEGACY; i++)<br>+=A0=A0=A0 =
=A0=A0=A0 if (isa_irq_to_gsi[i] =3D=3D gsi)<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 return i;<br>
-=A0=A0=A0 =A0=A0=A0 }<br>-=A0=A0=A0 }<br>=A0<br>=A0=A0=A0=A0 /* Provide an=
 identity mapping of gsi =3D=3D irq<br>=A0=A0=A0=A0 =A0* except on truly we=
ird platforms that have<br>@@ -245,7 +243,7 @@ acpi_parse_x2apic(struct acp=
i_subtable_header *header, const unsigned long end)<br>
=A0}<br>=A0<br>=A0static int __init<br>-acpi_parse_lapic(struct acpi_subtab=
le_header * header, const unsigned long end)<br>+acpi_parse_lapic(struct ac=
pi_subtable_header *header, const unsigned long end)<br>=A0{<br>=A0=A0=A0=
=A0 struct acpi_madt_local_apic *processor =3D NULL;<br>
=A0<br>@@ -288,7 +286,7 @@ acpi_parse_sapic(struct acpi_subtable_header *he=
ader, const unsigned long end)<br>=A0}<br>=A0<br>=A0static int __init<br>-a=
cpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,<br>+acpi_par=
se_lapic_addr_ovr(struct acpi_subtable_header *header,<br>
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 const unsigned long end)<br>=A0{<br>=
=A0=A0=A0=A0 struct acpi_madt_local_apic_override *lapic_addr_ovr =3D NULL;=
<br>@@ -323,7 +321,8 @@ acpi_parse_x2apic_nmi(struct acpi_subtable_header *=
header,<br>=A0}<br>=A0<br>=A0static int __init<br>
-acpi_parse_lapic_nmi(struct acpi_subtable_header * header, const unsigned =
long end)<br>+acpi_parse_lapic_nmi(struct acpi_subtable_header *header,<br>=
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0 const unsigned long end)<br>=A0{<br>=A0=
=A0=A0=A0 struct acpi_madt_local_apic_nmi *lapic_nmi =3D NULL;<br>
=A0<br>@@ -345,7 +344,7 @@ acpi_parse_lapic_nmi(struct acpi_subtable_header=
 * header, const unsigned long e<br>=A0#ifdef CONFIG_X86_IO_APIC<br>=A0<br>=
=A0static int __init<br>-acpi_parse_ioapic(struct acpi_subtable_header * he=
ader, const unsigned long end)<br>
+acpi_parse_ioapic(struct acpi_subtable_header *header, const unsigned long=
 end)<br>=A0{<br>=A0=A0=A0=A0 struct acpi_madt_io_apic *ioapic =3D NULL;<br=
>=A0<br>@@ -365,7 +364,8 @@ acpi_parse_ioapic(struct acpi_subtable_header *=
 header, const unsigned long end)<br>
=A0/*<br>=A0 * Parse Interrupt Source Override for the ACPI SCI<br>=A0 */<b=
r>-static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16 polarity, u16 t=
rigger, u32 gsi)<br>+static void __init acpi_sci_ioapic_setup(u8 bus_irq,<b=
r>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0u16 polarity, u16 tri=
gger, u32 gsi)<br>=A0{<br>=A0=A0=A0=A0 if (trigger =3D=3D 0)=A0=A0=A0 /* co=
mpatible SCI trigger is level */<br>=A0=A0=A0=A0 =A0=A0=A0 trigger =3D 3;<b=
r>@@ -396,7 +396,7 @@ static void __init acpi_sci_ioapic_setup(u8 bus_irq, =
u16 polarity, u16 trigger,<br>
=A0}<br>=A0<br>=A0static int __init<br>-acpi_parse_int_src_ovr(struct acpi_=
subtable_header * header,<br>+acpi_parse_int_src_ovr(struct acpi_subtable_h=
eader *header,<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 const unsigned =
long end)<br>=A0{<br>=A0=A0=A0=A0 struct acpi_madt_interrupt_override *ints=
rc =3D NULL;<br>
@@ -410,8 +410,10 @@ acpi_parse_int_src_ovr(struct acpi_subtable_header * h=
eader,<br>=A0<br>=A0=A0=A0=A0 if (intsrc-&gt;source_irq =3D=3D acpi_gbl_FAD=
T.sci_interrupt) {<br>=A0=A0=A0=A0 =A0=A0=A0 acpi_sci_ioapic_setup(intsrc-&=
gt;source_irq,<br>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0 =
intsrc-&gt;inti_flags &amp; ACPI_MADT_POLARITY_MASK,<br>
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0 (intsrc-&gt;inti_f=
lags &amp; ACPI_MADT_TRIGGER_MASK) &gt;&gt; 2,<br>+=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0 intsrc-&gt;inti_flags &amp;<br>+=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0 ACPI_MADT_POLARITY_MASK,<br>+=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0 (intsrc-&gt;inti_fl=
ags &amp;<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0 ACPI_MADT_TRIGGER_=
MASK) &gt;&gt; 2,<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
=A0=A0 intsrc-&gt;global_irq);<br>=A0=A0=A0=A0 =A0=A0=A0 return 0;<br>=A0=
=A0=A0=A0 }<br>@@ -421,7 +423,8 @@ acpi_parse_int_src_ovr(struct acpi_subta=
ble_header * header,<br>
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 printk(PREFIX &quot;BIOS IRQ0 pin2 overrid=
e ignored.\n&quot;);<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return 0;<br>=A0=
=A0=A0=A0 =A0=A0=A0 }<br>-=A0=A0=A0 =A0=A0=A0 if (acpi_fix_pin2_polarity &a=
mp;&amp; (intsrc-&gt;inti_flags &amp; ACPI_MADT_POLARITY_MASK)) {<br>
+=A0=A0=A0 =A0=A0=A0 if (acpi_fix_pin2_polarity &amp;&amp;<br>+=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 (intsrc-&gt;inti_flags &amp; ACPI_MADT_POLARITY_MASK)) =
{<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 intsrc-&gt;inti_flags &amp;=3D ~ACPI_=
MADT_POLARITY_MASK;<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 printk(PREFIX &quot=
;BIOS IRQ0 pin2 override: forcing polarity to high active.\n&quot;);<br>
=A0=A0=A0=A0 =A0=A0=A0 }<br>@@ -429,14 +432,16 @@ acpi_parse_int_src_ovr(st=
ruct acpi_subtable_header * header,<br>=A0<br>=A0=A0=A0=A0 mp_override_lega=
cy_irq(intsrc-&gt;source_irq,<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 intsrc-&gt;inti_flags &amp; ACPI_MADT_POLARITY_MASK,<br>
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 (intsrc-&gt;inti_flags &amp; ACPI_=
MADT_TRIGGER_MASK) &gt;&gt; 2,<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
(intsrc-&gt;inti_flags &amp;<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 AC=
PI_MADT_TRIGGER_MASK) &gt;&gt; 2,<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 intsrc-&gt;global_irq);<br>
=A0<br>=A0=A0=A0=A0 return 0;<br>=A0}<br>=A0<br>=A0static int __init<br>-ac=
pi_parse_nmi_src(struct acpi_subtable_header * header, const unsigned long =
end)<br>+acpi_parse_nmi_src(struct acpi_subtable_header *header,<br>+=A0=A0=
=A0 =A0=A0=A0 =A0=A0 const unsigned long end)<br>
=A0{<br>=A0=A0=A0=A0 struct acpi_madt_nmi_source *nmi_src =3D NULL;<br>=A0<=
br>@@ -652,7 +657,7 @@ static int __cpuinit _acpi_map_lsapic(acpi_handle ha=
ndle, int *pcpu)<br>=A0=A0=A0=A0 =A0*/<br>=A0=A0=A0=A0 cpumask_andnot(new_m=
ap, cpu_present_mask, tmp_map);<br>
=A0=A0=A0=A0 if (cpumask_empty(new_map)) {<br>-=A0=A0=A0 =A0=A0=A0 printk (=
&quot;Unable to map lapic to logical cpu number\n&quot;);<br>+=A0=A0=A0 =A0=
=A0=A0 printk(KERN_WARNING PREFIX &quot;Unable to map lapic to logical cpu =
number\n&quot;);<br>=A0=A0=A0=A0 =A0=A0=A0 retval =3D -EINVAL;<br>
=A0=A0=A0=A0 =A0=A0=A0 goto free_new_map;<br>=A0=A0=A0=A0 }<br>@@ -686,9 +6=
91,8 @@ int acpi_unmap_lsapic(int cpu)<br>=A0=A0=A0=A0 set_cpu_present(cpu,=
 false);<br>=A0=A0=A0=A0 num_processors--;<br>=A0<br>-=A0=A0=A0 return (0);=
<br>+=A0=A0=A0 return 0;<br>=A0}<br>-<br>=A0EXPORT_SYMBOL(acpi_unmap_lsapic=
);<br>
=A0#endif=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* CONFIG_ACPI_HOTPLUG_CPU=
 */<br>=A0<br>@@ -697,7 +701,6 @@ int acpi_register_ioapic(acpi_handle hand=
le, u64 phys_addr, u32 gsi_base)<br>=A0=A0=A0=A0 /* TBD */<br>=A0=A0=A0=A0 =
return -EINVAL;<br>=A0}<br>-<br>=A0EXPORT_SYMBOL(acpi_register_ioapic);<br>
=A0<br>=A0int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)<br>@=
@ -705,7 +708,6 @@ int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_b=
ase)<br>=A0=A0=A0=A0 /* TBD */<br>=A0=A0=A0=A0 return -EINVAL;<br>=A0}<br>-=
<br>=A0EXPORT_SYMBOL(acpi_unregister_ioapic);<br>
=A0<br>=A0static int __init acpi_parse_sbf(struct acpi_table_header *table)=
<br>@@ -726,7 +728,7 @@ static int __init acpi_parse_sbf(struct acpi_table_=
header *table)<br>=A0#ifdef CONFIG_HPET_TIMER<br>=A0#include &lt;asm/hpet.h=
&gt;<br>
=A0<br>-static struct __initdata resource *hpet_res;<br>+static struct __in=
itdata resource * hpet_res;<br>=A0<br>=A0static int __init acpi_parse_hpet(=
struct acpi_table_header *table)<br>=A0{<br>@@ -833,7 +835,7 @@ static int =
__init acpi_parse_fadt(struct acpi_table_header *table)<br>
=A0=A0=A0=A0 =A0=A0=A0 =A0* &quot;X&quot; fields are optional extensions to=
 the original V1.0<br>=A0=A0=A0=A0 =A0=A0=A0 =A0* fields, so we must select=
ively expand V1.0 fields if the<br>=A0=A0=A0=A0 =A0=A0=A0 =A0* correspondin=
g X field is zero.<br>-=A0=A0=A0 =A0=A0=A0=A0 =A0*/<br>+=A0=A0=A0 =A0=A0=A0=
 =A0*/<br>
=A0=A0=A0=A0 =A0=A0=A0 if (!pmtmr_ioport)<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 pmtmr_ioport =3D acpi_gbl_FADT.pm_timer_block;<br>=A0=A0=A0=A0 } else {=
<br>@@ -926,7 +928,8 @@ static int __init acpi_parse_madt_lapic_entries(voi=
d)<br>=A0=A0=A0=A0 =A0=A0=A0 acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2A=
PIC_NMI,<br>
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 acpi_parse_x2apic_nmi, 0);<b=
r>=A0=A0=A0=A0 count =3D<br>-=A0=A0=A0 =A0=A0=A0 acpi_table_parse_madt(ACPI=
_MADT_TYPE_LOCAL_APIC_NMI, acpi_parse_lapic_nmi, 0);<br>+=A0=A0=A0 =A0=A0=
=A0 acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 acpi_parse_lapic_nmi, 0);<br>=
=A0=A0=A0=A0 if (count &lt; 0 || x2count &lt; 0) {<br>=A0=A0=A0=A0 =A0=A0=
=A0 printk(KERN_ERR PREFIX &quot;Error parsing LAPIC NMI entry\n&quot;);<br=
>=A0=A0=A0=A0 =A0=A0=A0 /* TBD: Cleanup to allow fallback to MPS */<br>
@@ -983,7 +986,7 @@ void __init mp_config_acpi_legacy_irqs(void)<br>=A0=A0=
=A0=A0 int i;<br>=A0=A0=A0=A0 struct mpc_intsrc mp_irq;<br>=A0<br>-#if defi=
ned (CONFIG_MCA) || defined (CONFIG_EISA)<br>+#if defined(CONFIG_MCA) || de=
fined(CONFIG_EISA)<br>
=A0=A0=A0=A0 /*<br>=A0=A0=A0=A0 =A0* Fabricate the legacy ISA bus (bus #31)=
.<br>=A0=A0=A0=A0 =A0*/<br>@@ -1170,8 +1173,8 @@ static int __init acpi_par=
se_madt_ioapic_entries(void)<br>=A0=A0=A0=A0 }<br>=A0<br>=A0=A0=A0=A0 count=
 =3D<br>-=A0=A0=A0 =A0=A0=A0 acpi_table_parse_madt(ACPI_MADT_TYPE_INTERRUPT=
_OVERRIDE, acpi_parse_int_src_ovr,<br>
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 nr_irqs);<br>+=A0=A0=A0 =A0=A0=
=A0 acpi_table_parse_madt(ACPI_MADT_TYPE_INTERRUPT_OVERRIDE,<br>+=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 acpi_parse_int_src_ovr, nr_irqs);<br>=A0=
=A0=A0=A0 if (count &lt; 0) {<br>=A0=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR PRE=
FIX<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 &quot;Error parsing interr=
upt source overrides entry\n&quot;);<br>
@@ -1269,10 +1272,10 @@ static void __init acpi_process_madt(void)<br>=A0=
=A0=A0=A0 =A0=A0=A0 }<br>=A0=A0=A0=A0 } else {<br>=A0=A0=A0=A0 =A0=A0=A0 /*=
<br>- =A0=A0=A0 =A0=A0=A0 =A0* ACPI found no MADT, and so ACPI wants UP PIC=
 mode.<br>- =A0=A0=A0 =A0=A0=A0 =A0* In the event an MPS table was found, f=
orget it.<br>
- =A0=A0=A0 =A0=A0=A0 =A0* Boot with &quot;acpi=3Doff&quot; to use MPS on s=
uch a system.<br>- =A0=A0=A0 =A0=A0=A0 =A0*/<br>+=A0=A0=A0 =A0=A0=A0 =A0* A=
CPI found no MADT, and so ACPI wants UP PIC mode.<br>+=A0=A0=A0 =A0=A0=A0 =
=A0* In the event an MPS table was found, forget it.<br>
+=A0=A0=A0 =A0=A0=A0 =A0* Boot with &quot;acpi=3Doff&quot; to use MPS on su=
ch a system.<br>+=A0=A0=A0 =A0=A0=A0 =A0*/<br>=A0=A0=A0=A0 =A0=A0=A0 if (sm=
p_found_config) {<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 printk(KERN_WARNING P=
REFIX<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 &quot;No APIC-table, di=
sabling MPS\n&quot;);<br>
@@ -1496,7 +1499,7 @@ void __init acpi_boot_table_init(void)<br>=A0=A0=A0=
=A0 =A0* If acpi_disabled, bail out<br>=A0=A0=A0=A0 =A0*/<br>=A0=A0=A0=A0 i=
f (acpi_disabled)<br>-=A0=A0=A0 =A0=A0=A0 return; <br>+=A0=A0=A0 =A0=A0=A0 =
return;<br>=A0<br>=A0=A0=A0=A0 /*<br>=A0=A0=A0=A0 =A0* Initialize the ACPI =
boot-time table parser.<br>
@@ -1575,26 +1578,22 @@ static int __init parse_acpi(char *arg)<br>=A0=A0=
=A0=A0 =A0=A0=A0 return -EINVAL;<br>=A0<br>=A0=A0=A0=A0 /* &quot;acpi=3Doff=
&quot; disables both ACPI table parsing and interpreter */<br>-=A0=A0=A0 if=
 (strcmp(arg, &quot;off&quot;) =3D=3D 0) {<br>
+=A0=A0=A0 if (strcmp(arg, &quot;off&quot;) =3D=3D 0)<br>=A0=A0=A0=A0 =A0=
=A0=A0 disable_acpi();<br>-=A0=A0=A0 }<br>=A0=A0=A0=A0 /* acpi=3Dforce to o=
ver-ride black-list */<br>=A0=A0=A0=A0 else if (strcmp(arg, &quot;force&quo=
t;) =3D=3D 0) {<br>=A0=A0=A0=A0 =A0=A0=A0 acpi_force =3D 1;<br>=A0=A0=A0=A0=
 =A0=A0=A0 acpi_disabled =3D 0;<br>
=A0=A0=A0=A0 }<br>=A0=A0=A0=A0 /* acpi=3Dstrict disables out-of-spec workar=
ounds */<br>-=A0=A0=A0 else if (strcmp(arg, &quot;strict&quot;) =3D=3D 0) {=
<br>+=A0=A0=A0 else if (strcmp(arg, &quot;strict&quot;) =3D=3D 0)<br>=A0=A0=
=A0=A0 =A0=A0=A0 acpi_strict =3D 1;<br>-=A0=A0=A0 }<br>=A0=A0=A0=A0 /* acpi=
=3Drsdt use RSDT instead of XSDT */<br>
-=A0=A0=A0 else if (strcmp(arg, &quot;rsdt&quot;) =3D=3D 0) {<br>+=A0=A0=A0=
 else if (strcmp(arg, &quot;rsdt&quot;) =3D=3D 0)<br>=A0=A0=A0=A0 =A0=A0=A0=
 acpi_rsdt_forced =3D 1;<br>-=A0=A0=A0 }<br>=A0=A0=A0=A0 /* &quot;acpi=3Dno=
irq&quot; disables ACPI interrupt routing */<br>
-=A0=A0=A0 else if (strcmp(arg, &quot;noirq&quot;) =3D=3D 0) {<br>+=A0=A0=
=A0 else if (strcmp(arg, &quot;noirq&quot;) =3D=3D 0)<br>=A0=A0=A0=A0 =A0=
=A0=A0 acpi_noirq_set();<br>-=A0=A0=A0 }<br>=A0=A0=A0=A0 /* &quot;acpi=3Dco=
py_dsdt&quot; copys DSDT */<br>=A0=A0=A0=A0 else if (strcmp(arg, &quot;copy=
_dsdt&quot;) =3D=3D 0) {<br>
=A0=A0=A0=A0 =A0=A0=A0 acpi_gbl_copy_dsdt_locally =3D 1;<br>@@ -1674,7 +167=
3,7 @@ int __acpi_acquire_global_lock(unsigned int *lock)<br>=A0=A0=A0=A0 =
=A0=A0=A0 old =3D *lock;<br>=A0=A0=A0=A0 =A0=A0=A0 new =3D (((old &amp; ~0x=
3) + 2) + ((old &gt;&gt; 1) &amp; 0x1));<br>=A0=A0=A0=A0 =A0=A0=A0 val =3D =
cmpxchg(lock, old, new);<br>
-=A0=A0=A0 } while (unlikely (val !=3D old));<br>+=A0=A0=A0 } while (unlike=
ly(val !=3D old));<br>=A0=A0=A0=A0 return (new &lt; 3) ? -1 : 0;<br>=A0}<br=
>=A0<br>@@ -1685,6 +1684,6 @@ int __acpi_release_global_lock(unsigned int *=
lock)<br>=A0=A0=A0=A0 =A0=A0=A0 old =3D *lock;<br>
=A0=A0=A0=A0 =A0=A0=A0 new =3D old &amp; ~0x3;<br>=A0=A0=A0=A0 =A0=A0=A0 va=
l =3D cmpxchg(lock, old, new);<br>-=A0=A0=A0 } while (unlikely (val !=3D ol=
d));<br>+=A0=A0=A0 } while (unlikely(val !=3D old));<br>=A0=A0=A0=A0 return=
 old &amp; 0x1;<br>=A0}<br>-- <br>1.7.0.4<br><br>

--0015174c3e00718dd5049fcae370--

--===============0897189854551201322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0897189854551201322==--
