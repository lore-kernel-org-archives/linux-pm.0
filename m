From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 1/6] acpi/cppc: Ensure only supported CPPC sysfs entries are
 created
Date: Fri, 22 Mar 2019 20:25:58 +0000
Message-ID: <c7fe67527a77fed160a09939b1f11dbc417f4287.1553285718.git.Janakarajan.Natarajan@amd.com>
References: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
List-Id: linux-pm@vger.kernel.org

Add attributes for registers that are supported by the platform. This preve=
nts
unsupported optional registers from having sysfs entries created.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 70 ++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1b207fca1420..66fad270376c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -179,22 +179,8 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj=
,
 }
 define_one_cppc_ro(feedback_ctrs);
=20
-static struct attribute *cppc_attrs[] =3D {
-	&feedback_ctrs.attr,
-	&reference_perf.attr,
-	&wraparound_time.attr,
-	&highest_perf.attr,
-	&lowest_perf.attr,
-	&lowest_nonlinear_perf.attr,
-	&nominal_perf.attr,
-	&nominal_freq.attr,
-	&lowest_freq.attr,
-	NULL
-};
-
 static struct kobj_type cppc_ktype =3D {
 	.sysfs_ops =3D &kobj_sysfs_ops,
-	.default_attrs =3D cppc_attrs,
 };
=20
 static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
@@ -709,6 +695,57 @@ static bool is_cppc_supported(int revision, int num_en=
t)
  *	}
  */
=20
+int set_cppc_attrs(struct cpc_desc *cpc, int entries)
+{
+	static struct attribute **cppc_attrs;
+	int i, attr_i =3D 0;
+
+	/* Extra for feedback_ctrs to be exposed via sysfs */
+	cppc_attrs =3D kcalloc(entries + 1, sizeof(*cppc_attrs), GFP_KERNEL);
+	if (!cppc_attrs)
+		return -ENOMEM;
+
+	for (i =3D 0; i < MAX_CPC_REG_ENT && attr_i < entries; i++) {
+		if (!CPC_SUPPORTED(&cpc->cpc_regs[i]))
+			continue;
+
+		switch (i) {
+		case HIGHEST_PERF:
+			cppc_attrs[attr_i++] =3D &highest_perf.attr;
+			break;
+		case NOMINAL_PERF:
+			cppc_attrs[attr_i++] =3D &nominal_perf.attr;
+			break;
+		case LOW_NON_LINEAR_PERF:
+			cppc_attrs[attr_i++] =3D &lowest_nonlinear_perf.attr;
+			break;
+		case LOWEST_PERF:
+			cppc_attrs[attr_i++] =3D &lowest_perf.attr;
+			break;
+		case NOMINAL_FREQ:
+			cppc_attrs[attr_i++] =3D &nominal_freq.attr;
+			break;
+		case LOWEST_FREQ:
+			cppc_attrs[attr_i++] =3D &lowest_freq.attr;
+			break;
+		case REFERENCE_PERF:
+			cppc_attrs[attr_i++] =3D &reference_perf.attr;
+			break;
+		case CTR_WRAP_TIME:
+			cppc_attrs[attr_i++] =3D &wraparound_time.attr;
+			break;
+		}
+	}
+
+	/* Set feedback_ctr sysfs entry */
+	cppc_attrs[attr_i] =3D &feedback_ctrs.attr;
+
+	/* Set kobj_type member */
+	cppc_ktype.default_attrs =3D cppc_attrs;
+
+	return 0;
+}
+
 /**
  * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
  * @pr: Ptr to acpi_processor containing this CPUs logical Id.
@@ -863,6 +900,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *p=
r)
 	/* Plug PSD data into this CPUs CPC descriptor. */
 	per_cpu(cpc_desc_ptr, pr->id) =3D cpc_ptr;
=20
+	ret =3D set_cppc_attrs(cpc_ptr, num_ent - 2);
+	if (ret)
+		goto out_free;
+
 	ret =3D kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
 			"acpi_cppc");
 	if (ret) {
@@ -924,6 +965,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr=
)
 			iounmap(addr);
 	}
=20
+	kfree(cppc_ktype.default_attrs);
 	kobject_put(&cpc_ptr->kobj);
 	kfree(cpc_ptr);
 }
--=20
2.17.1
