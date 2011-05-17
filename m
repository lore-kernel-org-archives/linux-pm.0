From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 3/3] PM / DEVFREQ: add sysfs interface
	(including user tickling)
Date: Tue, 17 May 2011 14:04:52 +0900
Message-ID: <BANLkTik__9G-DuSsT_kAc69d+5g8xcVyFg__29866.229723166$1305608749$gmane$org@mail.gmail.com>
References: <1305100723-29161-1-git-send-email-myungjoo.ham@samsung.com>
	<1305100723-29161-3-git-send-email-myungjoo.ham@samsung.com>
	<20110511225540.GA3492@suse.de>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110511225540.GA3492@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCBNYXkgMTIsIDIwMTEgYXQgNzo1NSBBTSwgR3JlZyBLSCA8Z3JlZ2toQHN1c2UuZGU+
IHdyb3RlOgo+IE9uIFdlZCwgTWF5IDExLCAyMDExIGF0IDA0OjU4OjQzUE0gKzA5MDAsIE15dW5n
Sm9vIEhhbSB3cm90ZToKPj4gMS4gU3lzdGVtLXdpZGUgc3lzZnMgaW50ZXJmYWNlCj4+IC0gdGlj
a2xlX2FsbCDCoFI6IG51bWJlciBvZiB0aWNrbGVfYWxsIGV4ZWN1dGlvbgo+PiDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBXOiB0aWNrbGUgYWxsIGRldmZyZXEgZGV2aWNlcwo+PiAtIG1pbl9pbnRlcnZh
bCDCoCDCoCDCoCDCoFI6IGRldmZyZXEgbW9uaXRvcmluZyBiYXNlIGludGVydmFsIGluIG1zCj4+
IC0gbW9uaXRvcmluZyDCoFI6IHNob3dzIHdoZXRoZXIgZGV2ZnJlcSBtb25pdG9yaW5nIGlzIGFj
dGl2ZSBvcgo+PiDCoCBub3QuCj4+Cj4+IDIuIERldmljZSBzcGVjaWZpYyBzeXNmcyBpbnRlcmZh
Y2UKPj4gLSB0aWNrbGUgwqAgwqAgwqBSOiBudW1iZXIgb2YgdGlja2xlIGV4ZWN1dGlvbiBmb3Ig
dGhlIGRldmljZQo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCBXOiB0aWNrbGUgdGhlIGRldmljZQo+
Cj4gQW55IHN5c2ZzIGZpbGUgY2hhbmdlL2FkZGl0aW9uL3JlbW92YWwgbmVlZHMgdG8gaGF2ZSBh
Cj4gRG9jdW1lbnRhdGlvbi9BQkkvIGVudHJ5IGFzIHdlbGwuIMKgUGxlYXNlIGFkZCB0aGF0IHRv
IHRoaXMgcGF0Y2ggaW5zdGVhZAo+IG9mIGJ1cnlpbmcgaXQgaW4gdGhlIGNoYW5nZWxvZyBlbnRy
eSwgd2hlcmUgbm8gb25lIHdpbGwgYmUgYWJsZSB0byBmaW5kCj4gaXQgaW4gdGhlIGZ1dHVyZS4K
Pgo+IHRoYW5rcywKPgo+IGdyZWcgay1oCj4KClN1cmUsIEknbGwgYWRkIERvY3VtZW50YXRpb24v
QUJJL3Rlc3RpbmcvKiBlbnRyaWVzLgoKSG93ZXZlciwgd291bGQgaXQgYmUgYXBwcm9wcmlhdGUg
Zm9yICIxLiBTeXN0ZW0td2lkZSBzeXNmcyBpbnRlcmZhY2UiCnRvIGJlIGluICJzeXNmcy1jbGFz
cy1wb3dlciIgYW5kIGZvciAiMi4gRGV2aWNlIHNwZWNpZmljIHN5c2ZzCmludGVyZmFjZSIgdG8g
YmUgaW4gInN5c2ZzLWRldmljZXMtZGV2ZnJlcSI/CgpTeXN0ZW0td2lkZSBzeXNmcyBpbnRlcmZh
Y2UgaXMgaW4gL3N5cy9jbGFzcy9wb3dlci9kZXZmcmVxLyogYW5kCkRldmljZSBzcGVjaWZpYyBz
eXNmcyBpbnRlcmZhY2UgaXMgaW4gL3N5cy8uLi5ERVZJQ0UuLi4vZGV2ZnJlcS8qIC4KClRoYW5r
IHlvdS4KCgotIE15dW5nSm9vCi0tIApNeXVuZ0pvbyBIYW0gKO2VqOuqheyjvCksIFBoLkQuCk1v
YmlsZSBTb2Z0d2FyZSBQbGF0Zm9ybSBMYWIsCkRpZ2l0YWwgTWVkaWEgYW5kIENvbW11bmljYXRp
b25zIChETUMpIEJ1c2luZXNzClNhbXN1bmcgRWxlY3Ryb25pY3MKY2VsbDogODItMTAtNjcxNC0y
ODU4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
