From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 2/6] acpi/cppc: Modify show_cppc_data macro
Date: Fri, 22 Mar 2019 20:26:00 +0000
Message-ID: <5b049c67394c96a21f561399e577ff5dbf1fa0a4.1553285718.git.Janakarajan.Natarajan@amd.com>
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

The show_cppc_data macro implicity uses define_one_cppc_ro. This will
prevent the creation of an attribute with read and write permissions.

Create a separate macro that defines a show attribute and creates
a read-only sysfs entry. This is in preparation for adding a macro
to create sysfs entries with read+write permission.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved out into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 66fad270376c..9daeb0b034d5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -151,17 +151,20 @@ __ATTR(_name, 0444, show_##_name, NULL)
 		return scnprintf(buf, PAGE_SIZE, "%llu\n",		\
 				(u64)st_name.member_name);		\
 	}								\
+
+#define show_cppc_data_ro(access_fn, struct_name, member_name)		\
+	show_cppc_data(access_fn, struct_name, member_name)		\
 	define_one_cppc_ro(member_name)
=20
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_per=
f);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
=20
-show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
-show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
+show_cppc_data_ro(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
+show_cppc_data_ro(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
=20
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct attribute *attr, char *buf)
--=20
2.17.1
