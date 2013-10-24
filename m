From: adrian <adrian.huang@hp.com>
Subject: Re: [PATCH 1/1] cpufreq: intel_pstate: skip the driver if ACPI has
 power mgmt option
Date: Thu, 24 Oct 2013 21:23:08 +0800
Message-ID: <1382620988.6298.2.camel@adrian-F6S>
References: <1382333227-28231-1-git-send-email-adrian.huang@hp.com>
	 <5265503B.7000804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5265503B.7000804@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linda.knippers@hp.com
List-Id: linux-pm@vger.kernel.org

Thanks, Dirk. The patch has been modified accordingly.=20

Signed-off-by: Adrian Huang <adrian.huang@hp.com>
---
 drivers/cpufreq/intel_pstate.c | 80 ++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pst=
ate.c
index badf620..8c00394 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -26,6 +26,8 @@
 #include <linux/fs.h>
 #include <linux/debugfs.h>
 #include <trace/events/power.h>
+#include <linux/acpi.h>
+#include <acpi/processor.h>
=20
 #include <asm/div64.h>
 #include <asm/msr.h>
@@ -129,6 +131,18 @@ static struct perf_limits limits =3D {
 	.max_sysfs_pct =3D 100,
 };
=20
+struct hw_vendor_info {
+	u16  valid;
+	char oem_id[ACPI_OEM_ID_SIZE];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
+};
+
+/* Hardware vendor-specific info that has its own power management mod=
es */
+static struct hw_vendor_info vendor_info[] =3D {
+	{1, "HP    ", "ProLiant"},
+	{0, "", ""},
+};
+
 static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
 			int deadband, int integral) {
 	pid->setpoint =3D setpoint;
@@ -700,6 +714,63 @@ static int intel_pstate_msrs_not_valid(void)
=20
 	return 0;
 }
+
+static bool intel_pstate_no_acpi_pss(void)
+{
+	struct acpi_processor *pr;
+	union acpi_object *pss =3D NULL;
+	int i;
+
+	for_each_possible_cpu(i) {
+
+		pr =3D per_cpu(processors, i);
+
+		if (pr) {
+			struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER,
+							NULL };
+
+			if (ACPI_SUCCESS(acpi_evaluate_object(pr->handle,
+						"_PSS", NULL, &buffer))) {
+
+				pss =3D buffer.pointer;
+
+				if (pss && pss->type =3D=3D ACPI_TYPE_PACKAGE) {
+					kfree(buffer.pointer);
+					return false;
+				}
+
+				kfree(buffer.pointer);
+			}
+		}
+	}
+
+	return true;
+}
+
+static bool intel_pstate_platform_pwr_mgmt_exists(void)
+{
+	struct acpi_table_header hdr;
+	struct hw_vendor_info *v_info;
+
+	if (acpi_get_table_header(ACPI_SIG_FADT, 0, &hdr) =3D=3D AE_OK) {
+		for (v_info =3D vendor_info; v_info->valid; v_info++) {
+			/*
+			 * Check if the hardware/platform is in the
+			 * predefined vendor data.
+			 */
+			if (!strncmp(hdr.oem_id, v_info->oem_id,
+				     ACPI_OEM_ID_SIZE) &&
+			    !strncmp(hdr.oem_table_id, v_info->oem_table_id,
+				     ACPI_OEM_TABLE_ID_SIZE)) {
+				if (intel_pstate_no_acpi_pss())
+					return true;
+			}
+		}
+	}
+
+	return false;
+}
+
 static int __init intel_pstate_init(void)
 {
 	int cpu, rc =3D 0;
@@ -708,6 +779,15 @@ static int __init intel_pstate_init(void)
 	if (no_load)
 		return -ENODEV;
=20
+	if (!acpi_disabled) {
+		/*
+		 * Check if the platform has its own power management modes.
+		 * If so, the pstate cpufreq driver will be ignored.
+		 */
+		if (intel_pstate_platform_pwr_mgmt_exists())
+			return -ENODEV;
+	}
+
 	id =3D x86_match_cpu(intel_pstate_cpu_ids);
 	if (!id)
 		return -ENODEV;
--=20
1.8.1.2


=E6=96=BC =E4=B8=80=EF=BC=8C2013-10-21 =E6=96=BC 09:03 -0700=EF=BC=8CDi=
rk Brandewie =E6=8F=90=E5=88=B0=EF=BC=9A=20
> On 10/20/2013 10:27 PM, Adrian Huang wrote:
> >   static int __init intel_pstate_init(void)
> >   {
> >   	int cpu, rc =3D 0;
> > @@ -708,6 +779,15 @@ static int __init intel_pstate_init(void)
> >   	if (no_load)
> >   		return -ENODEV;
> >
> > +	if (!acpi_disabled) {
> > +		/*
> > +		 * Check if the platform has its own power management modes.
> > +		 * If so, the pstate cpufreq driver will be ignored.
> > +		 */
> > +		if (intel_pstate_platform_pwr_mgmt_exists())
> > +			return 0;
>=20
> Please return -ENODEV here instead of 0
>=20
> > +	}
> > +
> >   	id =3D x86_match_cpu(intel_pstate_cpu_ids);
> >   	if (!id)
> >   		return -ENODEV;
> >
>=20


