From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/2] cpufreq support for the big.LITTLE switcher
Date: Thu, 31 Oct 2013 04:01:13 +0530
Message-ID: <CAKohpom-Oo81U_J5sC8qG7uzjW=yRJLvAPDpNyV6Sst7uw=hag@mail.gmail.com>
References: <1383162281-24204-1-git-send-email-nicolas.pitre@linaro.org>
	<7822477.lBueQHUY4E@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b33ce860f693404e9fce430
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <7822477.lBueQHUY4E@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Dave P Martin <dave.martin@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>
List-Id: linux-pm@vger.kernel.org

--047d7b33ce860f693404e9fce430
Content-Type: text/plain; charset=ISO-8859-1

On 31 October 2013 03:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Queued up for 3.13, thanks!

Hmm.. thanks for applying this but there was a minor bug here which
is fixed by below commit.. You don't really need to merge this with
the original commit and so can go as a separate commit..

Attached for applying.. Tested by Nico.

--------x------------------x-------------

Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu Oct 31 03:45:42 2013 +0530

    cpufreq: arm_big_little: Call routine instead of passing its address

    In bL_cpufreq_init() we need to fill per-cpu cpu_last_req_freq
with the current
    frequency of cpu. Instead of calling the function we passed its
address to this
    routine by mistake earlier. Lets fix it by calling the routine instead.

    Tested-by: Nicolas Pitre <nico@linaro.org>
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 2b2a44a..ee66449 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -461,7 +461,8 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
                policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;

        if (is_bL_switching_enabled())
-               per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate;
+               per_cpu(cpu_last_req_freq, policy->cpu) =
+                       clk_get_cpu_rate(policy->cpu);

        dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
        return 0;

--047d7b33ce860f693404e9fce430
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-cpufreq-arm_big_little-Call-routine-instead-of-passi.patch"
Content-Disposition: attachment;
	filename="0001-cpufreq-arm_big_little-Call-routine-instead-of-passi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hnf51zo80

RnJvbSA4OGMwZmZhZWMxZGYwZjBlYzI0ZDA5NTE1OTQ1OWQyNTU0NzgwZDlkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8ODhjMGZmYWVjMWRmMGYwZWMyNGQwOTUxNTk0NTlk
MjU1NDc4MGQ5ZC4xMzgzMTcyMDgzLmdpdC52aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRnJvbTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRGF0ZTogVGh1LCAzMSBPY3Qg
MjAxMyAwMzo0NTo0MiArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIGNwdWZyZXE6IGFybV9iaWdfbGl0
dGxlOiBDYWxsIHJvdXRpbmUgaW5zdGVhZCBvZiBwYXNzaW5nIGl0cwogYWRkcmVzcwoKSW4gYkxf
Y3B1ZnJlcV9pbml0KCkgd2UgbmVlZCB0byBmaWxsIHBlci1jcHUgY3B1X2xhc3RfcmVxX2ZyZXEg
d2l0aCB0aGUgY3VycmVudApmcmVxdWVuY3kgb2YgY3B1LiBJbnN0ZWFkIG9mIGNhbGxpbmcgdGhl
IGZ1bmN0aW9uIHdlIHBhc3NlZCBpdHMgYWRkcmVzcyB0byB0aGlzCnJvdXRpbmUgYnkgbWlzdGFr
ZSBlYXJsaWVyLiBMZXRzIGZpeCBpdCBieSBjYWxsaW5nIHRoZSByb3V0aW5lIGluc3RlYWQuCgpU
ZXN0ZWQtYnk6IE5pY29sYXMgUGl0cmUgPG5pY29AbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2NwdWZy
ZXEvYXJtX2JpZ19saXR0bGUuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FybV9iaWdf
bGl0dGxlLmMgYi9kcml2ZXJzL2NwdWZyZXEvYXJtX2JpZ19saXR0bGUuYwppbmRleCAyYjJhNDRh
Li5lZTY2NDQ5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NwdWZyZXEvYXJtX2JpZ19saXR0bGUuYwor
KysgYi9kcml2ZXJzL2NwdWZyZXEvYXJtX2JpZ19saXR0bGUuYwpAQCAtNDYxLDcgKzQ2MSw4IEBA
IHN0YXRpYyBpbnQgYkxfY3B1ZnJlcV9pbml0KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5
KQogCQlwb2xpY3ktPmNwdWluZm8udHJhbnNpdGlvbl9sYXRlbmN5ID0gQ1BVRlJFUV9FVEVSTkFM
OwogCiAJaWYgKGlzX2JMX3N3aXRjaGluZ19lbmFibGVkKCkpCi0JCXBlcl9jcHUoY3B1X2xhc3Rf
cmVxX2ZyZXEsIHBvbGljeS0+Y3B1KSA9IGNsa19nZXRfY3B1X3JhdGU7CisJCXBlcl9jcHUoY3B1
X2xhc3RfcmVxX2ZyZXEsIHBvbGljeS0+Y3B1KSA9CisJCQljbGtfZ2V0X2NwdV9yYXRlKHBvbGlj
eS0+Y3B1KTsKIAogCWRldl9pbmZvKGNwdV9kZXYsICIlczogQ1BVICVkIGluaXRpYWxpemVkXG4i
LCBfX2Z1bmNfXywgcG9saWN5LT5jcHUpOwogCXJldHVybiAwOwotLSAKMS43LjEyLnJjMi4xOC5n
NjFiNDcyZQoK
--047d7b33ce860f693404e9fce430--
