From: Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [PATCH 1/2] USB / Hub: Do not call
 device_set_wakeup_capable() under spinlock
Date: Mon, 7 Feb 2011 19:10:18 +0900
Message-ID: <AANLkTim7Q==ndSRDjAFF+tgRFqFory3Q9nJBPEQKuEEo__35786.3086661839$1297073465$gmane$org@mail.gmail.com>
References: <201102061519.11360.rjw@sisk.pl> <201102062106.29712.rjw@sisk.pl>
	<201102062107.49909.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102062107.49909.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBGZWIgNywgMjAxMSBhdCA1OjA3IEFNLCBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHNp
c2sucGw+IHdyb3RlOgo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIDxyandAc2lzay5wbD4KPgo+
IEEgc3Vic2VxdWVudCBwYXRjaCB3aWxsIG1vZGlmeSBkZXZpY2Vfc2V0X3dha2V1cF9jYXBhYmxl
KCkgaW4gc3VjaAo+IGEgd2F5IHRoYXQgaXQgd2lsbCBjYWxsIGZ1bmN0aW9ucyB3aGljaCBtYXkg
c2xlZXAgYW5kIHRoZXJlZm9yZSBpdAo+IHNob3VsZG4ndCBiZSBjYWxsZWQgdW5kZXIgc3Bpbmxv
Y2tzLiDCoEluIHByZXBhcmF0aW9uIGZvciB0aGF0LCBtb2RpZnkKPiB1c2Jfc2V0X2RldmljZV9z
dGF0ZSgpIHRvIGF2b2lkIGNhbGxpbmcgZGV2aWNlX3NldF93YWtldXBfY2FwYWJsZSgpCj4gdW5k
ZXIgZGV2aWNlX3N0YXRlX2xvY2suCj4KPiBTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2Nr
aSA8cmp3QHNpc2sucGw+Cj4gQWNrZWQtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQHN1
c2UuZGU+CgpSZXBvcnRlZC1ieTogTWluY2hhbiBLaW0gPG1pbmNoYW4ua2ltQGdtYWlsLmNvbT4K
VGVzdGVkLWJ5OiBNaW5jaGFuIEtpbSA8bWluY2hhbi5raW1AZ21haWwuY29tPgoKLS0gCktpbmQg
cmVnYXJkcywKTWluY2hhbiBLaW0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1wbQ==
