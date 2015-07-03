From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3 0/4] scheduler-driven cpu frequency selection
Date: Fri, 3 Jul 2015 11:57:47 +0200
Message-ID: <CAKfTPtDuUL_n-fCEmC1=Pn9ARGyEQttZ+F0=6L+L17+Z9fVZWQ@mail.gmail.com>
References: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c353e6c65c180519f59767
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:35989 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594AbbGCJ6J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 05:58:09 -0400
Received: by lagc2 with SMTP id c2so79220316lag.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2015 02:58:07 -0700 (PDT)
In-Reply-To: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Rik van Riel <riel@redhat.com>, Mike Galbraith <efault@gmx.de>, Nicolas Pitre <nicolas.pitre@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Amit Kucheria <amit.kucheria@linaro.org>, Juri Lelli <juri.lelli@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, ashwin.chaugule@linaro.org, Alex Shi <alex.shi@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, abelvesa@gmail.com, pebolle@tiscali.nl, Michael Turquette <mturquette@linaro.org>

--001a11c353e6c65c180519f59767
Content-Type: text/plain; charset=UTF-8

Hi Mike,

I have tried to evaluate the performance and the power consumption of
the various policy that we have in the kernel to manage the DVFS of
cpus including your sched-dvfs proposal. For this purpose, i have used
rt-app and a script that are available here:
https://git.linaro.org/power/rt-app.git/shortlog/refs/heads/master.
The script is in the directory:
doc/examples/cpufreq_governor_efficiency/
For evaluating the performance of DVFS policy, I use rt-app to run a
simple sequence that alternates run phase and sleep phase. The run
phase is done by looping a defined number of time on a function that
burns cycles (The number of loop is calibrated to be equivalent to a
specified duration at max frequency of the cpu). At the end of the
test, we know how many time is needed by each policy to run the same
pattern and we can compare policies. I have also done some power
consumption measurement so we can compare both the
performance/responsiveness and power consumption (the power figure
only reflects the power consumption of the A53 cluster).

The test has been done on cortex-A53 platofrm so i have ported the
frequency invariance patch [1/4] on arm64 (attached to the email for
reference)

The performance figures has been normalized; so 100% means as fast as
the performance governor that always use the max frequency and 0%
means as slow as the powersave governor that always uses the min
frequency. The power consumption figures have been normalized vs the
performance governor power consumption. For all governor i have used
the default parameters which means a sampling rate of 10ms and a
sampling_down_factor of 1 for ondemand and a sampling rate of 200ms
for conservative governor

              performance   powersave     ondemand      sched
conservative
run/sleep     perf  energy  perf  energy  perf  energy  perf  energy
perf  energy
50ms/1000ms   100%  100%      0%   34%     95%   62%     49%   35%     72%   33%
100ms/1000ms  100%  100%      0%   41%     98%   78%     69%   41%     92%   45%
200ms/1000ms  100%  100%      0%   51%     98%   78%     86%   62%     93%   62%
400ms/1000ms  100%  100%      0%   55%     99%   83%     93%   63%     99%   77%
1000ms/100ms  100%  100%      0%   74%     99%   100%    96%   97%     99%   99%

We can see that the responsiveness of the sched governor is not that
good for short running duration but this can probably can be explained
with the responsiveness of the load tracking which needs around 75ms
to reach 80% of max usage. there are several proposal to add the
blocked tasks in the usage of a cpu, this can may be improved the
responsiveness for some pattern.

Regards,
Vincent

On 27 June 2015 at 01:53, Michael Turquette <mturquette@baylibre.com> wrote:
> This series addresses the comments from v2 and rearranges the code to
> separate the bits that are safe to merge from the bits that are not. In
> particular the simplified governor no longer implements any policy of
> its own. That code is migrated to fair.c and marked as RFC. The
> capacity-selection code in fair.c (patch #4) is a placeholder and can be
> replaced by something more sophisticated, and it illustrates the use of
> the new governor api's for anyone that wants to play around with
> crafting a new policy.
>
> Patch #1 is a re-post from Morten, as it is the only dependency these
> patches have on his EAS series. Please consider merging patches #2 and
> #3 if they do not appear too controversial. Without enabling the feature
> in Kconfig will be no impact on existing code.
>
> Michael Turquette (3):
>   cpufreq: introduce cpufreq_driver_might_sleep
>   sched: scheduler-driven cpu frequency selection
>   [RFC] sched: cfs: cpu frequency scaling policy
>
> Morten Rasmussen (1):
>   arm: Frequency invariant scheduler load-tracking support
>
>  arch/arm/include/asm/topology.h |   7 +
>  arch/arm/kernel/smp.c           |  53 ++++++-
>  arch/arm/kernel/topology.c      |  17 +++
>  drivers/cpufreq/Kconfig         |  24 ++++
>  drivers/cpufreq/cpufreq.c       |   6 +
>  include/linux/cpufreq.h         |  12 ++
>  kernel/sched/Makefile           |   1 +
>  kernel/sched/cpufreq_sched.c    | 308 ++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c             |  41 ++++++
>  kernel/sched/sched.h            |   8 ++
>  10 files changed, 475 insertions(+), 2 deletions(-)
>  create mode 100644 kernel/sched/cpufreq_sched.c
>
> --
> 1.9.1
>

--001a11c353e6c65c180519f59767
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-arm64-Frequency-invariant-scheduler-load-tracking-su.patch"
Content-Disposition: attachment;
	filename="0001-arm64-Frequency-invariant-scheduler-load-tracking-su.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ibng057d0

RnJvbSAxYmU0YTFlMTI2Y2RiMWI0N2I0ZDhhNWRkMTU2ZjhiY2EwNDcxNWMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWaW5jZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5h
cm8ub3JnPgpEYXRlOiBGcmksIDMgSnVsIDIwMTUgMTA6MDI6NTMgKzAyMDAKU3ViamVjdDogW1BB
VENIXSBhcm02NDogRnJlcXVlbmN5IGludmFyaWFudCBzY2hlZHVsZXIgbG9hZC10cmFja2luZyBz
dXBwb3J0CgpJbXBsZW1lbnRzIGFyY2gtc3BlY2lmaWMgZnVuY3Rpb24gdG8gcHJvdmlkZSB0aGUg
c2NoZWR1bGVyIHdpdGggYQpmcmVxdWVuY3kgc2NhbGluZyBjb3JyZWN0aW9uIGZhY3RvciBmb3Ig
bW9yZSBhY2N1cmF0ZSBsb2FkLXRyYWNraW5nLgoKVGhpcyBwYXRjaCBpcyBiYXNlZCBvbiB0aGUg
aW1wbGVtZW50YXRpb24gdGhhdCBoYXMgYmVlbiBkb25lIGZvciBhcm0gYXJjaApieSBNb3J0ZW4g
UmFzbXVzc2VuIDxtb3J0ZW4ucmFzbXVzc2VuQGFybS5jb20+CgpTaWduZWQtb2ZmLWJ5OiBWaW5j
ZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPgotLS0KIGFyY2gvYXJtNjQv
aW5jbHVkZS9hc20vdG9wb2xvZ3kuaCB8IDExICsrKysrKwogYXJjaC9hcm02NC9rZXJuZWwvc21w
LmMgICAgICAgICAgIHwgODAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiBhcmNoL2FybTY0L2tlcm5lbC90b3BvbG9neS5jICAgICAgfCAxOSArKysrKysrKysrCiAzIGZp
bGVzIGNoYW5nZWQsIDExMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9p
bmNsdWRlL2FzbS90b3BvbG9neS5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS90b3BvbG9neS5o
CmluZGV4IDdlYmNkMzEuLjg4NzgzNWEgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9h
c20vdG9wb2xvZ3kuaAorKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmgKQEAg
LTI0LDYgKzI0LDE3IEBAIHZvaWQgaW5pdF9jcHVfdG9wb2xvZ3kodm9pZCk7CiB2b2lkIHN0b3Jl
X2NwdV90b3BvbG9neSh1bnNpZ25lZCBpbnQgY3B1aWQpOwogY29uc3Qgc3RydWN0IGNwdW1hc2sg
KmNwdV9jb3JlZ3JvdXBfbWFzayhpbnQgY3B1KTsKIAorI2lmZGVmIENPTkZJR19DUFVfRlJFUQor
CisjZGVmaW5lIGFyY2hfc2NhbGVfZnJlcV9jYXBhY2l0eSBhcm02NF9hcmNoX3NjYWxlX2ZyZXFf
Y2FwYWNpdHkKK3N0cnVjdCBzY2hlZF9kb21haW47CitleHRlcm4gdW5zaWduZWQgbG9uZyBhcm02
NF9hcmNoX3NjYWxlX2ZyZXFfY2FwYWNpdHkoc3RydWN0IHNjaGVkX2RvbWFpbiAqc2QsCisJCQkJ
aW50IGNwdSk7CisKK0RFQ0xBUkVfUEVSX0NQVShhdG9taWNfbG9uZ190LCBjcHVfZnJlcV9jYXBh
Y2l0eSk7CisKKyNlbmRpZiAvKiBDT05GSUdfQ1BVX0ZSRVEgKi8KKwogI2Vsc2UKIAogc3RhdGlj
IGlubGluZSB2b2lkIGluaXRfY3B1X3RvcG9sb2d5KHZvaWQpIHsgfQpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9rZXJuZWwvc21wLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9zbXAuYwppbmRleCAzMjhi
OGNlLi40NWI4OGNiIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9zbXAuYworKysgYi9h
cmNoL2FybTY0L2tlcm5lbC9zbXAuYwpAQCAtMzQsNiArMzQsNyBAQAogI2luY2x1ZGUgPGxpbnV4
L3BlcmNwdS5oPgogI2luY2x1ZGUgPGxpbnV4L2Nsb2NrY2hpcHMuaD4KICNpbmNsdWRlIDxsaW51
eC9jb21wbGV0aW9uLmg+CisjaW5jbHVkZSA8bGludXgvY3B1ZnJlcS5oPgogI2luY2x1ZGUgPGxp
bnV4L29mLmg+CiAjaW5jbHVkZSA8bGludXgvaXJxX3dvcmsuaD4KIApAQCAtNjU2LDMgKzY1Nyw4
MiBAQCBpbnQgc2V0dXBfcHJvZmlsaW5nX3RpbWVyKHVuc2lnbmVkIGludCBtdWx0aXBsaWVyKQog
ewogCXJldHVybiAtRUlOVkFMOwogfQorCisjaWZkZWYgQ09ORklHX0NQVV9GUkVRCisKK3N0YXRp
YyBERUZJTkVfUEVSX0NQVShhdG9taWNfbG9uZ190LCBjcHVfbWF4X2ZyZXEpOworREVGSU5FX1BF
Ul9DUFUoYXRvbWljX2xvbmdfdCwgY3B1X2ZyZXFfY2FwYWNpdHkpOworCisvKgorICogU2NoZWR1
bGVyIGxvYWQtdHJhY2tpbmcgc2NhbGUtaW52YXJpYW5jZQorICoKKyAqIFByb3ZpZGVzIHRoZSBz
Y2hlZHVsZXIgd2l0aCBhIHNjYWxlLWludmFyaWFuY2UgY29ycmVjdGlvbiBmYWN0b3IgdGhhdAor
ICogY29tcGVuc2F0ZXMgZm9yIGZyZXF1ZW5jeSBzY2FsaW5nIHRocm91Z2ggYXJjaF9zY2FsZV9m
cmVxX2NhcGFjaXR5KCkKKyAqIChpbXBsZW1lbnRlZCBpbiB0b3BvbG9neS5jKS4KKyAqLworc3Rh
dGljIGlubGluZQordm9pZCBzY2FsZV9mcmVxX2NhcGFjaXR5KGludCBjcHUsIHVuc2lnbmVkIGxv
bmcgY3VyciwgdW5zaWduZWQgbG9uZyBtYXgpCit7CisJdW5zaWduZWQgbG9uZyBjYXBhY2l0eTsK
KworCWlmICghbWF4KQorCQlyZXR1cm47CisKKwljYXBhY2l0eSA9IChjdXJyIDw8IFNDSEVEX0NB
UEFDSVRZX1NISUZUKSAvIG1heDsKKwlhdG9taWNfbG9uZ19zZXQoJnBlcl9jcHUoY3B1X2ZyZXFf
Y2FwYWNpdHksIGNwdSksIGNhcGFjaXR5KTsKK30KKworc3RhdGljIGludCBjcHVmcmVxX2NhbGxi
YWNrKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsCisJCQkJCXVuc2lnbmVkIGxvbmcgdmFsLCB2
b2lkICpkYXRhKQoreworCXN0cnVjdCBjcHVmcmVxX2ZyZXFzICpmcmVxID0gZGF0YTsKKwlpbnQg
Y3B1ID0gZnJlcS0+Y3B1OworCXVuc2lnbmVkIGxvbmcgbWF4ID0gYXRvbWljX2xvbmdfcmVhZCgm
cGVyX2NwdShjcHVfbWF4X2ZyZXEsIGNwdSkpOworCisJaWYgKGZyZXEtPmZsYWdzICYgQ1BVRlJF
UV9DT05TVF9MT09QUykKKwkJcmV0dXJuIE5PVElGWV9PSzsKKworCXNjYWxlX2ZyZXFfY2FwYWNp
dHkoY3B1LCBmcmVxLT5uZXcsIG1heCk7CisKKwlyZXR1cm4gTk9USUZZX09LOworfQorCitzdGF0
aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIGNwdWZyZXFfbm90aWZpZXIgPSB7CisJLm5vdGlmaWVy
X2NhbGwgID0gY3B1ZnJlcV9jYWxsYmFjaywKK307CisKK3N0YXRpYyBpbnQgY3B1ZnJlcV9wb2xp
Y3lfY2FsbGJhY2soc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwKKwkJCQkJCXVuc2lnbmVkIGxv
bmcgdmFsLCB2b2lkICpkYXRhKQoreworCXN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5ID0g
ZGF0YTsKKwlpbnQgaTsKKworCWlmICh2YWwgIT0gQ1BVRlJFUV9OT1RJRlkpCisJCXJldHVybiBO
T1RJRllfT0s7CisKKwlmb3JfZWFjaF9jcHUoaSwgcG9saWN5LT5jcHVzKSB7CisJCXNjYWxlX2Zy
ZXFfY2FwYWNpdHkoaSwgcG9saWN5LT5jdXIsIHBvbGljeS0+bWF4KTsKKwkJYXRvbWljX2xvbmdf
c2V0KCZwZXJfY3B1KGNwdV9tYXhfZnJlcSwgaSksIHBvbGljeS0+bWF4KTsKKwl9CisKKwlyZXR1
cm4gTk9USUZZX09LOworfQorCitzdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIGNwdWZyZXFf
cG9saWN5X25vdGlmaWVyID0geworCS5ub3RpZmllcl9jYWxsCT0gY3B1ZnJlcV9wb2xpY3lfY2Fs
bGJhY2ssCit9OworCitzdGF0aWMgaW50IF9faW5pdCByZWdpc3Rlcl9jcHVmcmVxX25vdGlmaWVy
KHZvaWQpCit7CisJaW50IHJldDsKKworCXJldCA9IGNwdWZyZXFfcmVnaXN0ZXJfbm90aWZpZXIo
JmNwdWZyZXFfbm90aWZpZXIsCisJCQkJCQlDUFVGUkVRX1RSQU5TSVRJT05fTk9USUZJRVIpOwor
CWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwlyZXR1cm4gY3B1ZnJlcV9yZWdpc3Rlcl9ub3Rp
ZmllcigmY3B1ZnJlcV9wb2xpY3lfbm90aWZpZXIsCisJCQkJCQlDUFVGUkVRX1BPTElDWV9OT1RJ
RklFUik7Cit9Citjb3JlX2luaXRjYWxsKHJlZ2lzdGVyX2NwdWZyZXFfbm90aWZpZXIpOworI2Vu
ZGlmCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5lbC90b3BvbG9neS5jIGIvYXJjaC9hcm02
NC9rZXJuZWwvdG9wb2xvZ3kuYwppbmRleCBmY2I4ZjdiLi42Mzg3ZjY1IDEwMDY0NAotLS0gYS9h
cmNoL2FybTY0L2tlcm5lbC90b3BvbG9neS5jCisrKyBiL2FyY2gvYXJtNjQva2VybmVsL3RvcG9s
b2d5LmMKQEAgLTIwMCw2ICsyMDAsMjUgQEAgc3RhdGljIGludCBfX2luaXQgcGFyc2VfZHRfdG9w
b2xvZ3kodm9pZCkKIAlyZXR1cm4gcmV0OwogfQogCisjaWZkZWYgQ09ORklHX0NQVV9GUkVRCisv
KgorICogU2NoZWR1bGVyIGxvYWQtdHJhY2tpbmcgc2NhbGUtaW52YXJpYW5jZQorICoKKyAqIFBy
b3ZpZGVzIHRoZSBzY2hlZHVsZXIgd2l0aCBhIHNjYWxlLWludmFyaWFuY2UgY29ycmVjdGlvbiBm
YWN0b3IgdGhhdAorICogY29tcGVuc2F0ZXMgZm9yIGZyZXF1ZW5jeSBzY2FsaW5nIChhcmNoX3Nj
YWxlX2ZyZXFfY2FwYWNpdHkoKSkuIFRoZSBzY2FsaW5nCisgKiBmYWN0b3IgaXMgdXBkYXRlZCBp
biBzbXAuYworICovCit1bnNpZ25lZCBsb25nIGFybTY0X2FyY2hfc2NhbGVfZnJlcV9jYXBhY2l0
eShzdHJ1Y3Qgc2NoZWRfZG9tYWluICpzZCwgaW50IGNwdSkKK3sKKwl1bnNpZ25lZCBsb25nIGN1
cnIgPSBhdG9taWNfbG9uZ19yZWFkKCZwZXJfY3B1KGNwdV9mcmVxX2NhcGFjaXR5LCBjcHUpKTsK
KworCWlmICghY3VycikKKwkJcmV0dXJuIFNDSEVEX0NBUEFDSVRZX1NDQUxFOworCisJcmV0dXJu
IGN1cnI7Cit9CisjZW5kaWYKKwogLyoKICAqIGNwdSB0b3BvbG9neSB0YWJsZQogICovCi0tIAox
LjkuMQoK
--001a11c353e6c65c180519f59767--
