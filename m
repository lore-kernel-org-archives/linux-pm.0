From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: ignore_nice vs. ignore_nice_load
Date: Mon, 5 Aug 2013 12:31:40 +0530
Message-ID: <CAOh2x=kriqCRp9x+f5f5onDVoyfxVHSPDF5HrM_sFSsQ1ucktw@mail.gmail.com>
References: <51FC1935.5030702@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3071cd0c578a3704e32de1f0
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51FC1935.5030702@gmx.net>
Sender: cpufreq-owner@vger.kernel.org
To: Martin von Gagern <Martin.vGagern@gmx.net>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--20cf3071cd0c578a3704e32de1f0
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Aug 3, 2013 at 2:10 AM, Martin von Gagern
<Martin.vGagern@gmx.net> wrote:
> I just noticed that recently (apparently since 4d5dcc4211f9def4) the
> sysfs file that used to be called ignore_nice_load is now called
> ignore_nice. I don't know why this was renamed, but what has me
> worried even more is the fact that the documentation in
> Documentation/cpu-freq/governors.txt wasn't updated accordingly: it
> still talks about ignore_nice_load. It would be beter to synchronize
> these two again.

It was an unintentional change... And so we have a bug in our code
now.

> Investigating this issue, I also found that the file used to be called
> ignore_nice in the past, but at that point apparently had an inverted
> meaning. The node was renamed deliberately in 001893cda2f280ab when
> the semantics changed. I can't help but wonder whether anyone might
> now get confused with this old name popping up again, after all this
> time. Either name is fine by me, but I am surprised nevertheless.

Please try following patch (attached for applying).
@Rafael: This bug got introduced recently 3.10, so we may consider it
as a fix for 3.11?

------------x----------------x---------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 5 Aug 2013 12:28:02 +0530
Subject: [PATCH] cpufreq: rename ignore_nice as ignore_nice_load

This sysfs file was earlier called ignore_nice_load and by mistake was changed
to ignore_nice during this patch:

commit 4d5dcc4211f9def4281eafb54b8ed483862e8135
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed Mar 27 15:58:58 2013 +0000

    cpufreq: governor: Implement per policy instances of governors

Lets get it renamed back to its original name.

Reported-by: Martin von Gagern <Martin.vGagern@gmx.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 20 ++++++++++----------
 drivers/cpufreq/cpufreq_governor.c     |  8 ++++----
 drivers/cpufreq/cpufreq_governor.h     |  4 ++--
 drivers/cpufreq/cpufreq_ondemand.c     | 20 ++++++++++----------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c
b/drivers/cpufreq/cpufreq_conservative.c
index c400924..7f67a75 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -209,8 +209,8 @@ static ssize_t store_down_threshold(struct
dbs_data *dbs_data, const char *buf,
 	return count;
 }

-static ssize_t store_ignore_nice(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
+static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
+		const char *buf, size_t count)
 {
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int input, j;
@@ -223,10 +223,10 @@ static ssize_t store_ignore_nice(struct dbs_data
*dbs_data, const char *buf,
 	if (input > 1)
 		input = 1;

-	if (input == cs_tuners->ignore_nice) /* nothing to do */
+	if (input == cs_tuners->ignore_nice_load) /* nothing to do */
 		return count;

-	cs_tuners->ignore_nice = input;
+	cs_tuners->ignore_nice_load = input;

 	/* we need to re-evaluate prev_cpu_idle */
 	for_each_online_cpu(j) {
@@ -234,7 +234,7 @@ static ssize_t store_ignore_nice(struct dbs_data
*dbs_data, const char *buf,
 		dbs_info = &per_cpu(cs_cpu_dbs_info, j);
 		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
 					&dbs_info->cdbs.prev_cpu_wall, 0);
-		if (cs_tuners->ignore_nice)
+		if (cs_tuners->ignore_nice_load)
 			dbs_info->cdbs.prev_cpu_nice =
 				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 	}
@@ -267,7 +267,7 @@ show_store_one(cs, sampling_rate);
 show_store_one(cs, sampling_down_factor);
 show_store_one(cs, up_threshold);
 show_store_one(cs, down_threshold);
-show_store_one(cs, ignore_nice);
+show_store_one(cs, ignore_nice_load);
 show_store_one(cs, freq_step);
 declare_show_sampling_rate_min(cs);

@@ -275,7 +275,7 @@ gov_sys_pol_attr_rw(sampling_rate);
 gov_sys_pol_attr_rw(sampling_down_factor);
 gov_sys_pol_attr_rw(up_threshold);
 gov_sys_pol_attr_rw(down_threshold);
-gov_sys_pol_attr_rw(ignore_nice);
+gov_sys_pol_attr_rw(ignore_nice_load);
 gov_sys_pol_attr_rw(freq_step);
 gov_sys_pol_attr_ro(sampling_rate_min);

@@ -285,7 +285,7 @@ static struct attribute *dbs_attributes_gov_sys[] = {
 	&sampling_down_factor_gov_sys.attr,
 	&up_threshold_gov_sys.attr,
 	&down_threshold_gov_sys.attr,
-	&ignore_nice_gov_sys.attr,
+	&ignore_nice_load_gov_sys.attr,
 	&freq_step_gov_sys.attr,
 	NULL
 };
@@ -301,7 +301,7 @@ static struct attribute *dbs_attributes_gov_pol[] = {
 	&sampling_down_factor_gov_pol.attr,
 	&up_threshold_gov_pol.attr,
 	&down_threshold_gov_pol.attr,
-	&ignore_nice_gov_pol.attr,
+	&ignore_nice_load_gov_pol.attr,
 	&freq_step_gov_pol.attr,
 	NULL
 };
@@ -326,7 +326,7 @@ static int cs_init(struct dbs_data *dbs_data)
 	tuners->up_threshold = DEF_FREQUENCY_UP_THRESHOLD;
 	tuners->down_threshold = DEF_FREQUENCY_DOWN_THRESHOLD;
 	tuners->sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR;
-	tuners->ignore_nice = 0;
+	tuners->ignore_nice_load = 0;
 	tuners->freq_step = DEF_FREQUENCY_STEP;

 	dbs_data->tuners = tuners;
diff --git a/drivers/cpufreq/cpufreq_governor.c
b/drivers/cpufreq/cpufreq_governor.c
index 556064e..8742736 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -41,9 +41,9 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 	unsigned int j;

 	if (dbs_data->cdata->governor == GOV_ONDEMAND)
-		ignore_nice = od_tuners->ignore_nice;
+		ignore_nice = od_tuners->ignore_nice_load;
 	else
-		ignore_nice = cs_tuners->ignore_nice;
+		ignore_nice = cs_tuners->ignore_nice_load;

 	policy = cdbs->cur_policy;

@@ -284,12 +284,12 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		cs_tuners = dbs_data->tuners;
 		cs_dbs_info = dbs_data->cdata->get_cpu_dbs_info_s(cpu);
 		sampling_rate = cs_tuners->sampling_rate;
-		ignore_nice = cs_tuners->ignore_nice;
+		ignore_nice = cs_tuners->ignore_nice_load;
 	} else {
 		od_tuners = dbs_data->tuners;
 		od_dbs_info = dbs_data->cdata->get_cpu_dbs_info_s(cpu);
 		sampling_rate = od_tuners->sampling_rate;
-		ignore_nice = od_tuners->ignore_nice;
+		ignore_nice = od_tuners->ignore_nice_load;
 		od_ops = dbs_data->cdata->gov_ops;
 		io_busy = od_tuners->io_is_busy;
 	}
diff --git a/drivers/cpufreq/cpufreq_governor.h
b/drivers/cpufreq/cpufreq_governor.h
index 264e509..a02d78b 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -164,7 +164,7 @@ struct cs_cpu_dbs_info_s {

 /* Per policy Governers sysfs tunables */
 struct od_dbs_tuners {
-	unsigned int ignore_nice;
+	unsigned int ignore_nice_load;
 	unsigned int sampling_rate;
 	unsigned int sampling_down_factor;
 	unsigned int up_threshold;
@@ -173,7 +173,7 @@ struct od_dbs_tuners {
 };

 struct cs_dbs_tuners {
-	unsigned int ignore_nice;
+	unsigned int ignore_nice_load;
 	unsigned int sampling_rate;
 	unsigned int sampling_down_factor;
 	unsigned int up_threshold;
diff --git a/drivers/cpufreq/cpufreq_ondemand.c
b/drivers/cpufreq/cpufreq_ondemand.c
index 117278a..87f3305 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -372,8 +372,8 @@ static ssize_t store_sampling_down_factor(struct
dbs_data *dbs_data,
 	return count;
 }

-static ssize_t store_ignore_nice(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
+static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
+		const char *buf, size_t count)
 {
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	unsigned int input;
@@ -388,10 +388,10 @@ static ssize_t store_ignore_nice(struct dbs_data
*dbs_data, const char *buf,
 	if (input > 1)
 		input = 1;

-	if (input == od_tuners->ignore_nice) { /* nothing to do */
+	if (input == od_tuners->ignore_nice_load) { /* nothing to do */
 		return count;
 	}
-	od_tuners->ignore_nice = input;
+	od_tuners->ignore_nice_load = input;

 	/* we need to re-evaluate prev_cpu_idle */
 	for_each_online_cpu(j) {
@@ -399,7 +399,7 @@ static ssize_t store_ignore_nice(struct dbs_data
*dbs_data, const char *buf,
 		dbs_info = &per_cpu(od_cpu_dbs_info, j);
 		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
 			&dbs_info->cdbs.prev_cpu_wall, od_tuners->io_is_busy);
-		if (od_tuners->ignore_nice)
+		if (od_tuners->ignore_nice_load)
 			dbs_info->cdbs.prev_cpu_nice =
 				kcpustat_cpu(j).cpustat[CPUTIME_NICE];

@@ -430,7 +430,7 @@ show_store_one(od, sampling_rate);
 show_store_one(od, io_is_busy);
 show_store_one(od, up_threshold);
 show_store_one(od, sampling_down_factor);
-show_store_one(od, ignore_nice);
+show_store_one(od, ignore_nice_load);
 show_store_one(od, powersave_bias);
 declare_show_sampling_rate_min(od);

@@ -438,7 +438,7 @@ gov_sys_pol_attr_rw(sampling_rate);
 gov_sys_pol_attr_rw(io_is_busy);
 gov_sys_pol_attr_rw(up_threshold);
 gov_sys_pol_attr_rw(sampling_down_factor);
-gov_sys_pol_attr_rw(ignore_nice);
+gov_sys_pol_attr_rw(ignore_nice_load);
 gov_sys_pol_attr_rw(powersave_bias);
 gov_sys_pol_attr_ro(sampling_rate_min);

@@ -447,7 +447,7 @@ static struct attribute *dbs_attributes_gov_sys[] = {
 	&sampling_rate_gov_sys.attr,
 	&up_threshold_gov_sys.attr,
 	&sampling_down_factor_gov_sys.attr,
-	&ignore_nice_gov_sys.attr,
+	&ignore_nice_load_gov_sys.attr,
 	&powersave_bias_gov_sys.attr,
 	&io_is_busy_gov_sys.attr,
 	NULL
@@ -463,7 +463,7 @@ static struct attribute *dbs_attributes_gov_pol[] = {
 	&sampling_rate_gov_pol.attr,
 	&up_threshold_gov_pol.attr,
 	&sampling_down_factor_gov_pol.attr,
-	&ignore_nice_gov_pol.attr,
+	&ignore_nice_load_gov_pol.attr,
 	&powersave_bias_gov_pol.attr,
 	&io_is_busy_gov_pol.attr,
 	NULL
@@ -509,7 +509,7 @@ static int od_init(struct dbs_data *dbs_data)
 	}

 	tuners->sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR;
-	tuners->ignore_nice = 0;
+	tuners->ignore_nice_load = 0;
 	tuners->powersave_bias = default_powersave_bias;
 	tuners->io_is_busy = should_io_be_busy();

--20cf3071cd0c578a3704e32de1f0
Content-Type: application/octet-stream;
	name="0001-cpufreq-rename-ignore_nice-as-ignore_nice_load.patch"
Content-Disposition: attachment;
	filename="0001-cpufreq-rename-ignore_nice-as-ignore_nice_load.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hjzbxl2c0

RnJvbSBmZDI2MDk5MDFkZGExNTMyYmNmODYyMTRmNGM4YTY0Zjc0Njg2MzcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8ZmQyNjA5OTAxZGRhMTUzMmJjZjg2MjE0ZjRjOGE2
NGY3NDY4NjM3MC4xMzc1Njg1OTc5LmdpdC52aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRnJvbTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRGF0ZTogTW9uLCA1IEF1ZyAy
MDEzIDEyOjI4OjAyICswNTMwClN1YmplY3Q6IFtQQVRDSF0gY3B1ZnJlcTogcmVuYW1lIGlnbm9y
ZV9uaWNlIGFzIGlnbm9yZV9uaWNlX2xvYWQKClRoaXMgc3lzZnMgZmlsZSB3YXMgZWFybGllciBj
YWxsZWQgaWdub3JlX25pY2VfbG9hZCBhbmQgYnkgbWlzdGFrZSB3YXMgY2hhbmdlZAp0byBpZ25v
cmVfbmljZSBkdXJpbmcgdGhpcyBwYXRjaDoKCmNvbW1pdCA0ZDVkY2M0MjExZjlkZWY0MjgxZWFm
YjU0YjhlZDQ4Mzg2MmU4MTM1CkF1dGhvcjogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGlu
YXJvLm9yZz4KRGF0ZTogICBXZWQgTWFyIDI3IDE1OjU4OjU4IDIwMTMgKzAwMDAKCiAgICBjcHVm
cmVxOiBnb3Zlcm5vcjogSW1wbGVtZW50IHBlciBwb2xpY3kgaW5zdGFuY2VzIG9mIGdvdmVybm9y
cwoKTGV0cyBnZXQgaXQgcmVuYW1lZCBiYWNrIHRvIGl0cyBvcmlnaW5hbCBuYW1lLgoKUmVwb3J0
ZWQtYnk6IE1hcnRpbiB2b24gR2FnZXJuIDxNYXJ0aW4udkdhZ2VybkBnbXgubmV0PgpTaWduZWQt
b2ZmLWJ5OiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPgotLS0KIGRyaXZl
cnMvY3B1ZnJlcS9jcHVmcmVxX2NvbnNlcnZhdGl2ZS5jIHwgMjAgKysrKysrKysrKy0tLS0tLS0t
LS0KIGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxX2dvdmVybm9yLmMgICAgIHwgIDggKysrKy0tLS0K
IGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxX2dvdmVybm9yLmggICAgIHwgIDQgKystLQogZHJpdmVy
cy9jcHVmcmVxL2NwdWZyZXFfb25kZW1hbmQuYyAgICAgfCAyMCArKysrKysrKysrLS0tLS0tLS0t
LQogNCBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9jb25zZXJ2YXRpdmUuYyBiL2RyaXZl
cnMvY3B1ZnJlcS9jcHVmcmVxX2NvbnNlcnZhdGl2ZS5jCmluZGV4IGM0MDA5MjQuLjdmNjdhNzUg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxX2NvbnNlcnZhdGl2ZS5jCisrKyBi
L2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxX2NvbnNlcnZhdGl2ZS5jCkBAIC0yMDksOCArMjA5LDgg
QEAgc3RhdGljIHNzaXplX3Qgc3RvcmVfZG93bl90aHJlc2hvbGQoc3RydWN0IGRic19kYXRhICpk
YnNfZGF0YSwgY29uc3QgY2hhciAqYnVmLAogCXJldHVybiBjb3VudDsKIH0KIAotc3RhdGljIHNz
aXplX3Qgc3RvcmVfaWdub3JlX25pY2Uoc3RydWN0IGRic19kYXRhICpkYnNfZGF0YSwgY29uc3Qg
Y2hhciAqYnVmLAotCQlzaXplX3QgY291bnQpCitzdGF0aWMgc3NpemVfdCBzdG9yZV9pZ25vcmVf
bmljZV9sb2FkKHN0cnVjdCBkYnNfZGF0YSAqZGJzX2RhdGEsCisJCWNvbnN0IGNoYXIgKmJ1Ziwg
c2l6ZV90IGNvdW50KQogewogCXN0cnVjdCBjc19kYnNfdHVuZXJzICpjc190dW5lcnMgPSBkYnNf
ZGF0YS0+dHVuZXJzOwogCXVuc2lnbmVkIGludCBpbnB1dCwgajsKQEAgLTIyMywxMCArMjIzLDEw
IEBAIHN0YXRpYyBzc2l6ZV90IHN0b3JlX2lnbm9yZV9uaWNlKHN0cnVjdCBkYnNfZGF0YSAqZGJz
X2RhdGEsIGNvbnN0IGNoYXIgKmJ1ZiwKIAlpZiAoaW5wdXQgPiAxKQogCQlpbnB1dCA9IDE7CiAK
LQlpZiAoaW5wdXQgPT0gY3NfdHVuZXJzLT5pZ25vcmVfbmljZSkgLyogbm90aGluZyB0byBkbyAq
LworCWlmIChpbnB1dCA9PSBjc190dW5lcnMtPmlnbm9yZV9uaWNlX2xvYWQpIC8qIG5vdGhpbmcg
dG8gZG8gKi8KIAkJcmV0dXJuIGNvdW50OwogCi0JY3NfdHVuZXJzLT5pZ25vcmVfbmljZSA9IGlu
cHV0OworCWNzX3R1bmVycy0+aWdub3JlX25pY2VfbG9hZCA9IGlucHV0OwogCiAJLyogd2UgbmVl
ZCB0byByZS1ldmFsdWF0ZSBwcmV2X2NwdV9pZGxlICovCiAJZm9yX2VhY2hfb25saW5lX2NwdShq
KSB7CkBAIC0yMzQsNyArMjM0LDcgQEAgc3RhdGljIHNzaXplX3Qgc3RvcmVfaWdub3JlX25pY2Uo
c3RydWN0IGRic19kYXRhICpkYnNfZGF0YSwgY29uc3QgY2hhciAqYnVmLAogCQlkYnNfaW5mbyA9
ICZwZXJfY3B1KGNzX2NwdV9kYnNfaW5mbywgaik7CiAJCWRic19pbmZvLT5jZGJzLnByZXZfY3B1
X2lkbGUgPSBnZXRfY3B1X2lkbGVfdGltZShqLAogCQkJCQkmZGJzX2luZm8tPmNkYnMucHJldl9j
cHVfd2FsbCwgMCk7Ci0JCWlmIChjc190dW5lcnMtPmlnbm9yZV9uaWNlKQorCQlpZiAoY3NfdHVu
ZXJzLT5pZ25vcmVfbmljZV9sb2FkKQogCQkJZGJzX2luZm8tPmNkYnMucHJldl9jcHVfbmljZSA9
CiAJCQkJa2NwdXN0YXRfY3B1KGopLmNwdXN0YXRbQ1BVVElNRV9OSUNFXTsKIAl9CkBAIC0yNjcs
NyArMjY3LDcgQEAgc2hvd19zdG9yZV9vbmUoY3MsIHNhbXBsaW5nX3JhdGUpOwogc2hvd19zdG9y
ZV9vbmUoY3MsIHNhbXBsaW5nX2Rvd25fZmFjdG9yKTsKIHNob3dfc3RvcmVfb25lKGNzLCB1cF90
aHJlc2hvbGQpOwogc2hvd19zdG9yZV9vbmUoY3MsIGRvd25fdGhyZXNob2xkKTsKLXNob3dfc3Rv
cmVfb25lKGNzLCBpZ25vcmVfbmljZSk7CitzaG93X3N0b3JlX29uZShjcywgaWdub3JlX25pY2Vf
bG9hZCk7CiBzaG93X3N0b3JlX29uZShjcywgZnJlcV9zdGVwKTsKIGRlY2xhcmVfc2hvd19zYW1w
bGluZ19yYXRlX21pbihjcyk7CiAKQEAgLTI3NSw3ICsyNzUsNyBAQCBnb3Zfc3lzX3BvbF9hdHRy
X3J3KHNhbXBsaW5nX3JhdGUpOwogZ292X3N5c19wb2xfYXR0cl9ydyhzYW1wbGluZ19kb3duX2Zh
Y3Rvcik7CiBnb3Zfc3lzX3BvbF9hdHRyX3J3KHVwX3RocmVzaG9sZCk7CiBnb3Zfc3lzX3BvbF9h
dHRyX3J3KGRvd25fdGhyZXNob2xkKTsKLWdvdl9zeXNfcG9sX2F0dHJfcncoaWdub3JlX25pY2Up
OworZ292X3N5c19wb2xfYXR0cl9ydyhpZ25vcmVfbmljZV9sb2FkKTsKIGdvdl9zeXNfcG9sX2F0
dHJfcncoZnJlcV9zdGVwKTsKIGdvdl9zeXNfcG9sX2F0dHJfcm8oc2FtcGxpbmdfcmF0ZV9taW4p
OwogCkBAIC0yODUsNyArMjg1LDcgQEAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKmRic19hdHRy
aWJ1dGVzX2dvdl9zeXNbXSA9IHsKIAkmc2FtcGxpbmdfZG93bl9mYWN0b3JfZ292X3N5cy5hdHRy
LAogCSZ1cF90aHJlc2hvbGRfZ292X3N5cy5hdHRyLAogCSZkb3duX3RocmVzaG9sZF9nb3Zfc3lz
LmF0dHIsCi0JJmlnbm9yZV9uaWNlX2dvdl9zeXMuYXR0ciwKKwkmaWdub3JlX25pY2VfbG9hZF9n
b3Zfc3lzLmF0dHIsCiAJJmZyZXFfc3RlcF9nb3Zfc3lzLmF0dHIsCiAJTlVMTAogfTsKQEAgLTMw
MSw3ICszMDEsNyBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqZGJzX2F0dHJpYnV0ZXNfZ292
X3BvbFtdID0gewogCSZzYW1wbGluZ19kb3duX2ZhY3Rvcl9nb3ZfcG9sLmF0dHIsCiAJJnVwX3Ro
cmVzaG9sZF9nb3ZfcG9sLmF0dHIsCiAJJmRvd25fdGhyZXNob2xkX2dvdl9wb2wuYXR0ciwKLQkm
aWdub3JlX25pY2VfZ292X3BvbC5hdHRyLAorCSZpZ25vcmVfbmljZV9sb2FkX2dvdl9wb2wuYXR0
ciwKIAkmZnJlcV9zdGVwX2dvdl9wb2wuYXR0ciwKIAlOVUxMCiB9OwpAQCAtMzI2LDcgKzMyNiw3
IEBAIHN0YXRpYyBpbnQgY3NfaW5pdChzdHJ1Y3QgZGJzX2RhdGEgKmRic19kYXRhKQogCXR1bmVy
cy0+dXBfdGhyZXNob2xkID0gREVGX0ZSRVFVRU5DWV9VUF9USFJFU0hPTEQ7CiAJdHVuZXJzLT5k
b3duX3RocmVzaG9sZCA9IERFRl9GUkVRVUVOQ1lfRE9XTl9USFJFU0hPTEQ7CiAJdHVuZXJzLT5z
YW1wbGluZ19kb3duX2ZhY3RvciA9IERFRl9TQU1QTElOR19ET1dOX0ZBQ1RPUjsKLQl0dW5lcnMt
Pmlnbm9yZV9uaWNlID0gMDsKKwl0dW5lcnMtPmlnbm9yZV9uaWNlX2xvYWQgPSAwOwogCXR1bmVy
cy0+ZnJlcV9zdGVwID0gREVGX0ZSRVFVRU5DWV9TVEVQOwogCiAJZGJzX2RhdGEtPnR1bmVycyA9
IHR1bmVyczsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxX2dvdmVybm9yLmMg
Yi9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9nb3Zlcm5vci5jCmluZGV4IDU1NjA2NGUuLjg3NDI3
MzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxX2dvdmVybm9yLmMKKysrIGIv
ZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfZ292ZXJub3IuYwpAQCAtNDEsOSArNDEsOSBAQCB2b2lk
IGRic19jaGVja19jcHUoc3RydWN0IGRic19kYXRhICpkYnNfZGF0YSwgaW50IGNwdSkKIAl1bnNp
Z25lZCBpbnQgajsKIAogCWlmIChkYnNfZGF0YS0+Y2RhdGEtPmdvdmVybm9yID09IEdPVl9PTkRF
TUFORCkKLQkJaWdub3JlX25pY2UgPSBvZF90dW5lcnMtPmlnbm9yZV9uaWNlOworCQlpZ25vcmVf
bmljZSA9IG9kX3R1bmVycy0+aWdub3JlX25pY2VfbG9hZDsKIAllbHNlCi0JCWlnbm9yZV9uaWNl
ID0gY3NfdHVuZXJzLT5pZ25vcmVfbmljZTsKKwkJaWdub3JlX25pY2UgPSBjc190dW5lcnMtPmln
bm9yZV9uaWNlX2xvYWQ7CiAKIAlwb2xpY3kgPSBjZGJzLT5jdXJfcG9saWN5OwogCkBAIC0yODQs
MTIgKzI4NCwxMiBAQCBpbnQgY3B1ZnJlcV9nb3Zlcm5vcl9kYnMoc3RydWN0IGNwdWZyZXFfcG9s
aWN5ICpwb2xpY3ksCiAJCWNzX3R1bmVycyA9IGRic19kYXRhLT50dW5lcnM7CiAJCWNzX2Ric19p
bmZvID0gZGJzX2RhdGEtPmNkYXRhLT5nZXRfY3B1X2Ric19pbmZvX3MoY3B1KTsKIAkJc2FtcGxp
bmdfcmF0ZSA9IGNzX3R1bmVycy0+c2FtcGxpbmdfcmF0ZTsKLQkJaWdub3JlX25pY2UgPSBjc190
dW5lcnMtPmlnbm9yZV9uaWNlOworCQlpZ25vcmVfbmljZSA9IGNzX3R1bmVycy0+aWdub3JlX25p
Y2VfbG9hZDsKIAl9IGVsc2UgewogCQlvZF90dW5lcnMgPSBkYnNfZGF0YS0+dHVuZXJzOwogCQlv
ZF9kYnNfaW5mbyA9IGRic19kYXRhLT5jZGF0YS0+Z2V0X2NwdV9kYnNfaW5mb19zKGNwdSk7CiAJ
CXNhbXBsaW5nX3JhdGUgPSBvZF90dW5lcnMtPnNhbXBsaW5nX3JhdGU7Ci0JCWlnbm9yZV9uaWNl
ID0gb2RfdHVuZXJzLT5pZ25vcmVfbmljZTsKKwkJaWdub3JlX25pY2UgPSBvZF90dW5lcnMtPmln
bm9yZV9uaWNlX2xvYWQ7CiAJCW9kX29wcyA9IGRic19kYXRhLT5jZGF0YS0+Z292X29wczsKIAkJ
aW9fYnVzeSA9IG9kX3R1bmVycy0+aW9faXNfYnVzeTsKIAl9CmRpZmYgLS1naXQgYS9kcml2ZXJz
L2NwdWZyZXEvY3B1ZnJlcV9nb3Zlcm5vci5oIGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfZ292
ZXJub3IuaAppbmRleCAyNjRlNTA5Li5hMDJkNzhiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NwdWZy
ZXEvY3B1ZnJlcV9nb3Zlcm5vci5oCisrKyBiL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxX2dvdmVy
bm9yLmgKQEAgLTE2NCw3ICsxNjQsNyBAQCBzdHJ1Y3QgY3NfY3B1X2Ric19pbmZvX3MgewogCiAv
KiBQZXIgcG9saWN5IEdvdmVybmVycyBzeXNmcyB0dW5hYmxlcyAqLwogc3RydWN0IG9kX2Ric190
dW5lcnMgewotCXVuc2lnbmVkIGludCBpZ25vcmVfbmljZTsKKwl1bnNpZ25lZCBpbnQgaWdub3Jl
X25pY2VfbG9hZDsKIAl1bnNpZ25lZCBpbnQgc2FtcGxpbmdfcmF0ZTsKIAl1bnNpZ25lZCBpbnQg
c2FtcGxpbmdfZG93bl9mYWN0b3I7CiAJdW5zaWduZWQgaW50IHVwX3RocmVzaG9sZDsKQEAgLTE3
Myw3ICsxNzMsNyBAQCBzdHJ1Y3Qgb2RfZGJzX3R1bmVycyB7CiB9OwogCiBzdHJ1Y3QgY3NfZGJz
X3R1bmVycyB7Ci0JdW5zaWduZWQgaW50IGlnbm9yZV9uaWNlOworCXVuc2lnbmVkIGludCBpZ25v
cmVfbmljZV9sb2FkOwogCXVuc2lnbmVkIGludCBzYW1wbGluZ19yYXRlOwogCXVuc2lnbmVkIGlu
dCBzYW1wbGluZ19kb3duX2ZhY3RvcjsKIAl1bnNpZ25lZCBpbnQgdXBfdGhyZXNob2xkOwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfb25kZW1hbmQuYyBiL2RyaXZlcnMvY3B1
ZnJlcS9jcHVmcmVxX29uZGVtYW5kLmMKaW5kZXggMTE3Mjc4YS4uODdmMzMwNSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfb25kZW1hbmQuYworKysgYi9kcml2ZXJzL2NwdWZy
ZXEvY3B1ZnJlcV9vbmRlbWFuZC5jCkBAIC0zNzIsOCArMzcyLDggQEAgc3RhdGljIHNzaXplX3Qg
c3RvcmVfc2FtcGxpbmdfZG93bl9mYWN0b3Ioc3RydWN0IGRic19kYXRhICpkYnNfZGF0YSwKIAly
ZXR1cm4gY291bnQ7CiB9CiAKLXN0YXRpYyBzc2l6ZV90IHN0b3JlX2lnbm9yZV9uaWNlKHN0cnVj
dCBkYnNfZGF0YSAqZGJzX2RhdGEsIGNvbnN0IGNoYXIgKmJ1ZiwKLQkJc2l6ZV90IGNvdW50KQor
c3RhdGljIHNzaXplX3Qgc3RvcmVfaWdub3JlX25pY2VfbG9hZChzdHJ1Y3QgZGJzX2RhdGEgKmRi
c19kYXRhLAorCQljb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkKIHsKIAlzdHJ1Y3Qgb2Rf
ZGJzX3R1bmVycyAqb2RfdHVuZXJzID0gZGJzX2RhdGEtPnR1bmVyczsKIAl1bnNpZ25lZCBpbnQg
aW5wdXQ7CkBAIC0zODgsMTAgKzM4OCwxMCBAQCBzdGF0aWMgc3NpemVfdCBzdG9yZV9pZ25vcmVf
bmljZShzdHJ1Y3QgZGJzX2RhdGEgKmRic19kYXRhLCBjb25zdCBjaGFyICpidWYsCiAJaWYgKGlu
cHV0ID4gMSkKIAkJaW5wdXQgPSAxOwogCi0JaWYgKGlucHV0ID09IG9kX3R1bmVycy0+aWdub3Jl
X25pY2UpIHsgLyogbm90aGluZyB0byBkbyAqLworCWlmIChpbnB1dCA9PSBvZF90dW5lcnMtPmln
bm9yZV9uaWNlX2xvYWQpIHsgLyogbm90aGluZyB0byBkbyAqLwogCQlyZXR1cm4gY291bnQ7CiAJ
fQotCW9kX3R1bmVycy0+aWdub3JlX25pY2UgPSBpbnB1dDsKKwlvZF90dW5lcnMtPmlnbm9yZV9u
aWNlX2xvYWQgPSBpbnB1dDsKIAogCS8qIHdlIG5lZWQgdG8gcmUtZXZhbHVhdGUgcHJldl9jcHVf
aWRsZSAqLwogCWZvcl9lYWNoX29ubGluZV9jcHUoaikgewpAQCAtMzk5LDcgKzM5OSw3IEBAIHN0
YXRpYyBzc2l6ZV90IHN0b3JlX2lnbm9yZV9uaWNlKHN0cnVjdCBkYnNfZGF0YSAqZGJzX2RhdGEs
IGNvbnN0IGNoYXIgKmJ1ZiwKIAkJZGJzX2luZm8gPSAmcGVyX2NwdShvZF9jcHVfZGJzX2luZm8s
IGopOwogCQlkYnNfaW5mby0+Y2Ricy5wcmV2X2NwdV9pZGxlID0gZ2V0X2NwdV9pZGxlX3RpbWUo
aiwKIAkJCSZkYnNfaW5mby0+Y2Ricy5wcmV2X2NwdV93YWxsLCBvZF90dW5lcnMtPmlvX2lzX2J1
c3kpOwotCQlpZiAob2RfdHVuZXJzLT5pZ25vcmVfbmljZSkKKwkJaWYgKG9kX3R1bmVycy0+aWdu
b3JlX25pY2VfbG9hZCkKIAkJCWRic19pbmZvLT5jZGJzLnByZXZfY3B1X25pY2UgPQogCQkJCWtj
cHVzdGF0X2NwdShqKS5jcHVzdGF0W0NQVVRJTUVfTklDRV07CiAKQEAgLTQzMCw3ICs0MzAsNyBA
QCBzaG93X3N0b3JlX29uZShvZCwgc2FtcGxpbmdfcmF0ZSk7CiBzaG93X3N0b3JlX29uZShvZCwg
aW9faXNfYnVzeSk7CiBzaG93X3N0b3JlX29uZShvZCwgdXBfdGhyZXNob2xkKTsKIHNob3dfc3Rv
cmVfb25lKG9kLCBzYW1wbGluZ19kb3duX2ZhY3Rvcik7Ci1zaG93X3N0b3JlX29uZShvZCwgaWdu
b3JlX25pY2UpOworc2hvd19zdG9yZV9vbmUob2QsIGlnbm9yZV9uaWNlX2xvYWQpOwogc2hvd19z
dG9yZV9vbmUob2QsIHBvd2Vyc2F2ZV9iaWFzKTsKIGRlY2xhcmVfc2hvd19zYW1wbGluZ19yYXRl
X21pbihvZCk7CiAKQEAgLTQzOCw3ICs0MzgsNyBAQCBnb3Zfc3lzX3BvbF9hdHRyX3J3KHNhbXBs
aW5nX3JhdGUpOwogZ292X3N5c19wb2xfYXR0cl9ydyhpb19pc19idXN5KTsKIGdvdl9zeXNfcG9s
X2F0dHJfcncodXBfdGhyZXNob2xkKTsKIGdvdl9zeXNfcG9sX2F0dHJfcncoc2FtcGxpbmdfZG93
bl9mYWN0b3IpOwotZ292X3N5c19wb2xfYXR0cl9ydyhpZ25vcmVfbmljZSk7Citnb3Zfc3lzX3Bv
bF9hdHRyX3J3KGlnbm9yZV9uaWNlX2xvYWQpOwogZ292X3N5c19wb2xfYXR0cl9ydyhwb3dlcnNh
dmVfYmlhcyk7CiBnb3Zfc3lzX3BvbF9hdHRyX3JvKHNhbXBsaW5nX3JhdGVfbWluKTsKIApAQCAt
NDQ3LDcgKzQ0Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpkYnNfYXR0cmlidXRlc19n
b3Zfc3lzW10gPSB7CiAJJnNhbXBsaW5nX3JhdGVfZ292X3N5cy5hdHRyLAogCSZ1cF90aHJlc2hv
bGRfZ292X3N5cy5hdHRyLAogCSZzYW1wbGluZ19kb3duX2ZhY3Rvcl9nb3Zfc3lzLmF0dHIsCi0J
Jmlnbm9yZV9uaWNlX2dvdl9zeXMuYXR0ciwKKwkmaWdub3JlX25pY2VfbG9hZF9nb3Zfc3lzLmF0
dHIsCiAJJnBvd2Vyc2F2ZV9iaWFzX2dvdl9zeXMuYXR0ciwKIAkmaW9faXNfYnVzeV9nb3Zfc3lz
LmF0dHIsCiAJTlVMTApAQCAtNDYzLDcgKzQ2Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRl
ICpkYnNfYXR0cmlidXRlc19nb3ZfcG9sW10gPSB7CiAJJnNhbXBsaW5nX3JhdGVfZ292X3BvbC5h
dHRyLAogCSZ1cF90aHJlc2hvbGRfZ292X3BvbC5hdHRyLAogCSZzYW1wbGluZ19kb3duX2ZhY3Rv
cl9nb3ZfcG9sLmF0dHIsCi0JJmlnbm9yZV9uaWNlX2dvdl9wb2wuYXR0ciwKKwkmaWdub3JlX25p
Y2VfbG9hZF9nb3ZfcG9sLmF0dHIsCiAJJnBvd2Vyc2F2ZV9iaWFzX2dvdl9wb2wuYXR0ciwKIAkm
aW9faXNfYnVzeV9nb3ZfcG9sLmF0dHIsCiAJTlVMTApAQCAtNTA5LDcgKzUwOSw3IEBAIHN0YXRp
YyBpbnQgb2RfaW5pdChzdHJ1Y3QgZGJzX2RhdGEgKmRic19kYXRhKQogCX0KIAogCXR1bmVycy0+
c2FtcGxpbmdfZG93bl9mYWN0b3IgPSBERUZfU0FNUExJTkdfRE9XTl9GQUNUT1I7Ci0JdHVuZXJz
LT5pZ25vcmVfbmljZSA9IDA7CisJdHVuZXJzLT5pZ25vcmVfbmljZV9sb2FkID0gMDsKIAl0dW5l
cnMtPnBvd2Vyc2F2ZV9iaWFzID0gZGVmYXVsdF9wb3dlcnNhdmVfYmlhczsKIAl0dW5lcnMtPmlv
X2lzX2J1c3kgPSBzaG91bGRfaW9fYmVfYnVzeSgpOwogCi0tIAoxLjcuMTIucmMyLjE4Lmc2MWI0
NzJlCgo=
--20cf3071cd0c578a3704e32de1f0--
