From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 7/7] PM: Asynchronous suspend and resume
	of i8042
Date: Wed, 19 Aug 2009 01:40:26 +0200
Message-ID: <200908190140.26730.rjw__13998.1046355844$1250638916$gmane$org@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl>
	<1250579010.5351.69.camel@rzhang-dt>
	<200908182157.53283.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908182157.53283.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

T24gVHVlc2RheSAxOCBBdWd1c3QgMjAwOSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6Cj4gT24g
VHVlc2RheSAxOCBBdWd1c3QgMjAwOSwgWmhhbmcgUnVpIHdyb3RlOgo+ID4gT24gTW9uLCAyMDA5
LTA4LTE3IGF0IDA4OjIxICswODAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToKPiA+ID4gU2V0
IGFzeW5jX3N1c3BlbmQgZm9yIGk4MDQyLgo+ID4gPiAKPiA+IGl0J3MgdGhlIHBzbW91c2UgcmVz
ZXQgdGhhdCB0YWtlcyB0aGUgMC40IHNlY29uZHMgZHVyaW5nIHN1c3BlbmQuCj4gPiDvu79zbyB3
ZSBzaG91bGQgY2FsbCBkZXZpY2VfZW5hYmxlX2FzeW5jX3N1c3BlbmQgZm9yIHRoZSBwc21vdXNl
IHNlcmlvCj4gPiBkZXZpY2UgaW4gcHNtb3VzZS1iYXNlLmMKPiA+IAo+ID4gT3IgaW52b2tpbmcg
ZGV2aWNlX2VuYWJsZV9hc3luY19zdXNwZW5kIGZvciBldmVyeSBzZXJpbyBkZXZpY2UgaW4KPiA+
IHNlcmlvLmMsIGFzIHRoZSBrZXlib2FyZCBhbHNvIHRha2VzIGFib3V0IDAuMnMgdG8gc3VzcGVu
ZC4KPiAKPiBZZXMgd2UgY2FuIGRvIHRoYXQuICBJJ2xsIHRlc3QgdGhhdCBsYXRlciB0b2RheS4K
ClRoZSBhcHBlbmRlZCBwYXRjaCBhcHBlYXJzIHRvIHdvcmsgb24gbXkgdGVzdCBib3guCgpUaGFu
a3MsClJhZmFlbAoKLS0tClNldCBhc3luY19zdXNwZW5kIGZvciBzZXJpbyBpbnB1dCBkZXZpY2Vz
LgoKLS0tCiBkcml2ZXJzL2lucHV0L3NlcmlvL3NlcmlvLmMgfCAgICAxICsKIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQoKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL2lucHV0L3Nlcmlv
L3NlcmlvLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9pbnB1dC9zZXJp
by9zZXJpby5jCisrKyBsaW51eC0yLjYvZHJpdmVycy9pbnB1dC9zZXJpby9zZXJpby5jCkBAIC01
NzYsNiArNTc2LDcgQEAgc3RhdGljIHZvaWQgc2VyaW9fYWRkX3BvcnQoc3RydWN0IHNlcmlvIAog
CQkJcHJpbnRrKEtFUk5fRVJSCiAJCQkJInNlcmlvOiBzeXNmc19jcmVhdGVfZ3JvdXAoKSBmYWls
ZWQgZm9yICVzICglcyksIGVycm9yOiAlZFxuIiwKIAkJCQlzZXJpby0+cGh5cywgc2VyaW8tPm5h
bWUsIGVycm9yKTsKKwkJZGV2aWNlX2VuYWJsZV9hc3luY19zdXNwZW5kKCZzZXJpby0+ZGV2LCB0
cnVlKTsKIAl9CiB9CiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1wbQ==
