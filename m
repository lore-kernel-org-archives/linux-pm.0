From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/4] x86: use common aperfmperf_khz_on_cpu() to calculate
 KHz using APERF/MPERF
Date: Sat, 24 Jun 2017 01:03:49 -0400
Message-ID: <CAJvTdKmhbNvvxaiyhx7Q1Hncd75pWqmUonySSYVHGD_8cC9yUA@mail.gmail.com>
References: <1497668594-9266-1-git-send-email-lenb@kernel.org>
 <aba8474c690306eb708d4737d0b63c5ca448d019.1497665794.git.len.brown@intel.com> <alpine.DEB.2.20.1706201207170.1869@nanos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a113e43caba43e40552ada457"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1706201207170.1869@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, X86 ML <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

--001a113e43caba43e40552ada457
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 20, 2017 at 6:15 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 16 Jun 2017, Len Brown wrote:
>> +#include <linux/jiffies.h>
>> +#include <linux/math64.h>
>> +#include <linux/percpu.h>
>> +#include <linux/smp.h>
>> +
>> +struct aperfmperf_sample {
>> +     unsigned int khz;
>> +     unsigned long jiffies;
>> +     u64 aperf;
>> +     u64 mperf;
>
> Nit. Please write these in tabular fashion:
>         unsigned        int khz;
>         unsigned long   jiffies;
>         u64             aperf;
>         u64             mperf;

sure, no problem -- I agreed that looks better.

But it seems there is some inconsistency about this style nit --
even in this directory.  If there is consensus going forward,
would it make sense for coding-style.rst and checkpatch.pl
to squawk about this, so you don't have to?


>> +};
>> +
>> +static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
>> +
>> +/*
>> + * aperfmperf_snapshot_khz()
>> + * On the current CPU, snapshot APERF, MPERF, and jiffies
>> + * unless we already did it within 10ms
>> + * calculate kHz, save snapshot
>> + */
>> +static void aperfmperf_snapshot_khz(void *dummy)
>> +{
>> +     u64 aperf, aperf_delta;
>> +     u64 mperf, mperf_delta;
>> +     struct aperfmperf_sample *s = &get_cpu_var(samples);
>
> This is invoked via a smp function call, so you want
>
>      this_cpu_ptr(samples)
>
> here.

done. thanks!

>> +     /* Don't bother re-computing within 10 ms */
>> +     if (time_before(jiffies, s->jiffies + HZ/100))
>> +             goto out;
>
> That way you can spare the gotos and simply return

happy to remove the gotos, thanks!

>> index a5ce0bbe..cfc6220 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -883,6 +883,19 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
>>  }
>>  #endif
>>
>> +#ifdef CONFIG_X86
>> +extern unsigned int aperfmperf_khz_on_cpu(unsigned int cpu);
>> +static inline unsigned int arch_freq_get_on_cpu(int cpu)

> ... having cpu as int and unsigned int is not really consistent.

True.  the SMP code uses int cpu, while cpufreq_policy.cpu is an unsigned int.
I'll use "int cpu".

> Please don't add arch specific crap in general headers.
>
> The simple way to avoid that is to have a weak function and have an arch
> override for it. If that does not work because the cpufreq stuff must be
> built as a module, then you still can avoid CONFIG_X86 and have something
> like CONFIG_ARCH_HAS_FOO.

Thanks -- this is not modular code, and so yes, __weak works -- hadn't
had occasion to use it before...
Attached is the incremental diff responding to your comments, in case
that is convenient.
I'll re-send this series with this patch updated in a sec.

thanks,
Len Brown, Intel Open Source Technology Center

--001a113e43caba43e40552ada457
Content-Type: text/plain; charset="US-ASCII"; name="git.diff"
Content-Disposition: attachment; filename="git.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j4atki3c0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvYXBlcmZtcGVyZi5jIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9hcGVyZm1wZXJmLmMKaW5kZXggNWNjZjYzYS4uZDg2OWM4NiAxMDA2NDQKLS0t
IGEvYXJjaC94ODYva2VybmVsL2NwdS9hcGVyZm1wZXJmLmMKKysrIGIvYXJjaC94ODYva2VybmVs
L2NwdS9hcGVyZm1wZXJmLmMKQEAgLTE0LDEwICsxNCwxMCBAQAogI2luY2x1ZGUgPGxpbnV4L3Nt
cC5oPgogCiBzdHJ1Y3QgYXBlcmZtcGVyZl9zYW1wbGUgewotCXVuc2lnbmVkIGludCBraHo7Ci0J
dW5zaWduZWQgbG9uZyBqaWZmaWVzOwotCXU2NCBhcGVyZjsKLQl1NjQgbXBlcmY7CisJdW5zaWdu
ZWQgaW50CWtoejsKKwl1bnNpZ25lZCBsb25nCWppZmZpZXM7CisJdTY0CWFwZXJmOworCXU2NAlt
cGVyZjsKIH07CiAKIHN0YXRpYyBERUZJTkVfUEVSX0NQVShzdHJ1Y3QgYXBlcmZtcGVyZl9zYW1w
bGUsIHNhbXBsZXMpOwpAQCAtMzIsMTEgKzMyLDExIEBAIHN0YXRpYyB2b2lkIGFwZXJmbXBlcmZf
c25hcHNob3Rfa2h6KHZvaWQgKmR1bW15KQogewogCXU2NCBhcGVyZiwgYXBlcmZfZGVsdGE7CiAJ
dTY0IG1wZXJmLCBtcGVyZl9kZWx0YTsKLQlzdHJ1Y3QgYXBlcmZtcGVyZl9zYW1wbGUgKnMgPSAm
Z2V0X2NwdV92YXIoc2FtcGxlcyk7CisJc3RydWN0IGFwZXJmbXBlcmZfc2FtcGxlICpzID0gdGhp
c19jcHVfcHRyKCZzYW1wbGVzKTsKIAogCS8qIERvbid0IGJvdGhlciByZS1jb21wdXRpbmcgd2l0
aGluIDEwIG1zICovCiAJaWYgKHRpbWVfYmVmb3JlKGppZmZpZXMsIHMtPmppZmZpZXMgKyBIWi8x
MDApKQotCQlnb3RvIG91dDsKKwkJcmV0dXJuOwogCiAJcmRtc3JsKE1TUl9JQTMyX0FQRVJGLCBh
cGVyZik7CiAJcmRtc3JsKE1TUl9JQTMyX01QRVJGLCBtcGVyZik7CkBAIC00OSw3ICs0OSw3IEBA
IHN0YXRpYyB2b2lkIGFwZXJmbXBlcmZfc25hcHNob3Rfa2h6KHZvaWQgKmR1bW15KQogCSAqIGlu
Y3JlbWVudHMgZmFzdGVyIHRoYW4gd2UgY2FuIHJlYWQgaXQuCiAJICovCiAJaWYgKG1wZXJmX2Rl
bHRhID09IDApCi0JCWdvdG8gb3V0OworCQlyZXR1cm47CiAKIAkvKgogCSAqIGlmIChjcHVfa2h6
ICogYXBlcmZfZGVsdGEpIGZpdHMgaW50byBVTExPTkdfTUFYLCB0aGVuCkBAIC02MywxMiArNjMs
OSBAQCBzdGF0aWMgdm9pZCBhcGVyZm1wZXJmX3NuYXBzaG90X2toeih2b2lkICpkdW1teSkKIAlz
LT5qaWZmaWVzID0gamlmZmllczsKIAlzLT5hcGVyZiA9IGFwZXJmOwogCXMtPm1wZXJmID0gbXBl
cmY7Ci0KLW91dDoKLQlwdXRfY3B1X3ZhcihzYW1wbGVzKTsKIH0KIAotdW5zaWduZWQgaW50IGFw
ZXJmbXBlcmZfa2h6X29uX2NwdSh1bnNpZ25lZCBpbnQgY3B1KQordW5zaWduZWQgaW50IGFyY2hf
ZnJlcV9nZXRfb25fY3B1KGludCBjcHUpCiB7CiAJaWYgKCFjcHVfa2h6KQogCQlyZXR1cm4gMDsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEv
Y3B1ZnJlcS5jCmluZGV4IGE2NjdmYWMuLjZlNzQyNGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3B1
ZnJlcS9jcHVmcmVxLmMKKysrIGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYwpAQCAtNjMyLDYg
KzYzMiwxMSBAQCBzaG93X29uZShjcHVpbmZvX3RyYW5zaXRpb25fbGF0ZW5jeSwgY3B1aW5mby50
cmFuc2l0aW9uX2xhdGVuY3kpOwogc2hvd19vbmUoc2NhbGluZ19taW5fZnJlcSwgbWluKTsKIHNo
b3dfb25lKHNjYWxpbmdfbWF4X2ZyZXEsIG1heCk7CiAKK19fd2VhayB1bnNpZ25lZCBpbnQgYXJj
aF9mcmVxX2dldF9vbl9jcHUoaW50IGNwdSkKK3sKKwlyZXR1cm4gMDsKK30KKwogc3RhdGljIHNz
aXplX3Qgc2hvd19zY2FsaW5nX2N1cl9mcmVxKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5
LCBjaGFyICpidWYpCiB7CiAJc3NpemVfdCByZXQ7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2NwdWZyZXEuaCBiL2luY2x1ZGUvbGludXgvY3B1ZnJlcS5oCmluZGV4IGNmYzYyMjAuLjkwNTEx
N2IgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvY3B1ZnJlcS5oCisrKyBiL2luY2x1ZGUvbGlu
dXgvY3B1ZnJlcS5oCkBAIC04ODMsMTggKzg4Myw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBwb2xp
Y3lfaGFzX2Jvb3N0X2ZyZXEoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpCiB9CiAjZW5k
aWYKIAotI2lmZGVmIENPTkZJR19YODYKLWV4dGVybiB1bnNpZ25lZCBpbnQgYXBlcmZtcGVyZl9r
aHpfb25fY3B1KHVuc2lnbmVkIGludCBjcHUpOwotc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQg
YXJjaF9mcmVxX2dldF9vbl9jcHUoaW50IGNwdSkKLXsKLQlyZXR1cm4gYXBlcmZtcGVyZl9raHpf
b25fY3B1KGNwdSk7Ci19Ci0jZWxzZQotc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgYXJjaF9m
cmVxX2dldF9vbl9jcHUoaW50IGNwdSkKLXsKLQlyZXR1cm4gMDsKLX0KLSNlbmRpZgorZXh0ZXJu
IHVuc2lnbmVkIGludCBhcmNoX2ZyZXFfZ2V0X29uX2NwdShpbnQgY3B1KTsKIAogLyogdGhlIGZv
bGxvd2luZyBhcmUgcmVhbGx5IHJlYWxseSBvcHRpb25hbCAqLwogZXh0ZXJuIHN0cnVjdCBmcmVx
X2F0dHIgY3B1ZnJlcV9mcmVxX2F0dHJfc2NhbGluZ19hdmFpbGFibGVfZnJlcXM7Cg==
--001a113e43caba43e40552ada457--
