From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: TEGRA: Set policy->cpus from driver->init()
Date: Fri, 1 Feb 2013 12:11:06 +0530
Message-ID: <CAKohpon_-DcW_rjN1AnjWDfGxzR0zYjnpgyHZtwyAO66Y8+myA@mail.gmail.com>
References: <1bf82454ab1f16b13212548d7c9605067c8b7a0d.1359700705.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8fb201ac2e9be404d4a40787
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:44673 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab3BAGlI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Feb 2013 01:41:08 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so3732916obb.28
        for <linux-pm@vger.kernel.org>; Thu, 31 Jan 2013 22:41:07 -0800 (PST)
In-Reply-To: <1bf82454ab1f16b13212548d7c9605067c8b7a0d.1359700705.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@nvidia.com>

--e89a8fb201ac2e9be404d4a40787
Content-Type: text/plain; charset=ISO-8859-1

On 1 February 2013 12:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> For multicore SoC's, with cores sharing clock line, we are required to set
> policy->cpus and policy->related_cpus with mask of cpus.
>
> With following patch, we need to set policy->cpus with mask of all possible cpus
> and policy->related_cpus would be filled automatically by the cpufreq core.
>
> commit 4948b355e90080cd5ec1e91189f65a01e4186ef2
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Tue Jan 29 14:39:08 2013 +0000
>
>     cpufreq: Simplify cpufreq_add_dev()
>
> Current Tegra driver fills only ->related_cpus and not ->cpus, which looks to be
> incorrect. Lets fix it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Stephen Warren <swarren@nvidia.com>

ARM mail servers are broken, please find patch attached.

--e89a8fb201ac2e9be404d4a40787
Content-Type: application/octet-stream;
	name="0001-cpufreq-TEGRA-Set-policy-cpus-from-driver-init.patch"
Content-Disposition: attachment;
	filename="0001-cpufreq-TEGRA-Set-policy-cpus-from-driver-init.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hcmysb0y0

RnJvbSAxYmY4MjQ1NGFiMWYxNmIxMzIxMjU0OGQ3Yzk2MDUwNjdjOGI3YTBkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8MWJmODI0NTRhYjFmMTZiMTMyMTI1NDhkN2M5NjA1
MDY3YzhiN2EwZC4xMzU5NzAwNzA1LmdpdC52aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRnJvbTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRGF0ZTogRnJpLCAxIEZlYiAy
MDEzIDExOjIxOjQ5ICswNTMwClN1YmplY3Q6IFtQQVRDSCAxLzNdIGNwdWZyZXE6IFRFR1JBOiBT
ZXQgcG9saWN5LT5jcHVzIGZyb20gZHJpdmVyLT5pbml0KCkKCkZvciBtdWx0aWNvcmUgU29DJ3Ms
IHdpdGggY29yZXMgc2hhcmluZyBjbG9jayBsaW5lLCB3ZSBhcmUgcmVxdWlyZWQgdG8gc2V0CnBv
bGljeS0+Y3B1cyBhbmQgcG9saWN5LT5yZWxhdGVkX2NwdXMgd2l0aCBtYXNrIG9mIGNwdXMuCgpX
aXRoIGZvbGxvd2luZyBwYXRjaCwgd2UgbmVlZCB0byBzZXQgcG9saWN5LT5jcHVzIHdpdGggbWFz
ayBvZiBhbGwgcG9zc2libGUgY3B1cwphbmQgcG9saWN5LT5yZWxhdGVkX2NwdXMgd291bGQgYmUg
ZmlsbGVkIGF1dG9tYXRpY2FsbHkgYnkgdGhlIGNwdWZyZXEgY29yZS4KCmNvbW1pdCA0OTQ4YjM1
NWU5MDA4MGNkNWVjMWU5MTE4OWY2NWEwMWU0MTg2ZWYyCkF1dGhvcjogVmlyZXNoIEt1bWFyIDx2
aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRGF0ZTogICBUdWUgSmFuIDI5IDE0OjM5OjA4IDIwMTMg
KzAwMDAKCiAgICBjcHVmcmVxOiBTaW1wbGlmeSBjcHVmcmVxX2FkZF9kZXYoKQoKQ3VycmVudCBU
ZWdyYSBkcml2ZXIgZmlsbHMgb25seSAtPnJlbGF0ZWRfY3B1cyBhbmQgbm90IC0+Y3B1cywgd2hp
Y2ggbG9va3MgdG8gYmUKaW5jb3JyZWN0LiBMZXRzIGZpeCBpdC4KClNpZ25lZC1vZmYtYnk6IFZp
cmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+CkNjOiBTdGVwaGVuIFdhcnJlbiA8
c3dhcnJlbkBudmlkaWEuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtdGVncmEvY3B1LXRlZ3JhLmMg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXRlZ3JhL2NwdS10ZWdyYS5jIGIvYXJjaC9hcm0vbWFj
aC10ZWdyYS9jcHUtdGVncmEuYwppbmRleCBhNzRkM2M3Li5lN2RkY2IyIDEwMDY0NAotLS0gYS9h
cmNoL2FybS9tYWNoLXRlZ3JhL2NwdS10ZWdyYS5jCisrKyBiL2FyY2gvYXJtL21hY2gtdGVncmEv
Y3B1LXRlZ3JhLmMKQEAgLTI0NCw3ICsyNDQsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX2NwdV9pbml0
KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQogCXBvbGljeS0+Y3B1aW5mby50cmFuc2l0
aW9uX2xhdGVuY3kgPSAzMDAgKiAxMDAwOwogCiAJcG9saWN5LT5zaGFyZWRfdHlwZSA9IENQVUZS
RVFfU0hBUkVEX1RZUEVfQUxMOwotCWNwdW1hc2tfY29weShwb2xpY3ktPnJlbGF0ZWRfY3B1cywg
Y3B1X3Bvc3NpYmxlX21hc2spOworCWNwdW1hc2tfY29weShwb2xpY3ktPmNwdXMsIGNwdV9wb3Nz
aWJsZV9tYXNrKTsKIAogCWlmIChwb2xpY3ktPmNwdSA9PSAwKQogCQlyZWdpc3Rlcl9wbV9ub3Rp
ZmllcigmdGVncmFfY3B1X3BtX25vdGlmaWVyKTsKLS0gCjEuNy4xMi5yYzIuMTguZzYxYjQ3MmUK
Cg==
--e89a8fb201ac2e9be404d4a40787--
