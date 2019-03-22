From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 4/6] acpi/cppc: Add macros to define a R/W sysfs entry for
 CPPC registers
Date: Fri, 22 Mar 2019 20:26:10 +0000
Message-ID: <c0db0c87b76a8ef08c3ab33b3341cf73c9fa8d20.1553285718.git.Janakarajan.Natarajan@amd.com>
References: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "Ghannam, Yazen" <Yazen.Ghannam@amd.com>, "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
List-Id: linux-pm@vger.kernel.org

From: Yazen Ghannam <Yazen.Ghannam@amd.com>

Some CPPC registers can be used to configure the platform. To enable this,
create macros to define the show, store routines and create sysfs entries
with R/W permission.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index e81c19316628..7cb23b369fc7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -134,6 +134,10 @@ struct cppc_attr {
 static struct cppc_attr _name =3D			\
 __ATTR(_name, 0444, show_##_name, NULL)
=20
+#define define_one_cppc_rw(_name)		\
+static struct cppc_attr _name =3D			\
+__ATTR(_name, 0644, show_##_name, store_##_name)
+
 #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
=20
 #define show_cppc_data(access_fn, struct_name, member_name)		\
@@ -156,6 +160,33 @@ __ATTR(_name, 0444, show_##_name, NULL)
 	show_cppc_data(access_fn, struct_name, member_name)		\
 	define_one_cppc_ro(member_name)
=20
+#define store_cppc_data(struct_name, member_name, reg_idx)		\
+	static ssize_t store_##member_name(struct kobject *kobj,	\
+					   struct attribute *attr,	\
+					   const char *c, ssize_t count)\
+	{								\
+		struct cpc_desc *cpc_ptr =3D to_cpc_desc(kobj);		\
+		struct struct_name st_name =3D {0};			\
+		u32 val;						\
+		int ret;						\
+									\
+		ret =3D kstrtou32(c, 0, &val);				\
+		if (ret)						\
+			return ret;					\
+									\
+		st_name.member_name =3D val;				\
+									\
+		ret =3D cppc_set_reg(cpc_ptr->cpu_id, &st_name, reg_idx);	\
+		if (ret)						\
+			return ret;					\
+									\
+		return count;						\
+	}								\
+
+#define store_cppc_data_rw(struct_name, member_name, reg_idx)		\
+	store_cppc_data(struct_name, member_name, reg_idx)		\
+	define_one_cppc_rw(member_name)
+
 show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
 show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
 show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
--=20
2.17.1
