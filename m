From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] x86: make sure wakeup code is below 1M -v2
Date: Thu, 12 Nov 2009 15:43:38 +0800
Message-ID: <1258011818.3802.16.camel__21588.9257415713$1258012092$gmane$org@localhost.localdomain>
References: <4AF7D820.5040503@kernel.org> <200911091315.13151.rjw@sisk.pl>
	<4AFA210B.3020207@kernel.org>
	<1257930767.31183.113.camel@localhost.localdomain>
	<4AFB0B02.4050306@kernel.org>
	<1257988632.31183.134.camel@localhost.localdomain>
	<4AFB7D21.6050004@kernel.org>
	<1257997072.3888.4.camel@localhost.localdomain>
	<4AFB9B60.7010009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4AFB9B60.7010009@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCAyMDA5LTExLTEyIGF0IDEzOjIxICswODAwLCBZaW5naGFpIEx1IHdyb3RlOgo+IHlr
emhhbyB3cm90ZToKPiA+IE9uIFRodSwgMjAwOS0xMS0xMiBhdCAxMToxMiArMDgwMCwgWWluZ2hh
aSBMdSB3cm90ZToKPiA+PiB5a3poYW8gd3JvdGU6Cj4gPj4+IE9uIFRodSwgMjAwOS0xMS0xMiBh
dCAwMzowNSArMDgwMCwgWWluZ2hhaSBMdSB3cm90ZToKPiA+Pj4+IHlremhhbyB3cm90ZToKPiA+
Pj4+PiBPbiBXZWQsIDIwMDktMTEtMTEgYXQgMTA6MjcgKzA4MDAsIFlpbmdoYWkgTHUgd3JvdGU6
Cj4gPj4+Pj4+IHRyeSB0byBmaW5kX2U4MjBfYXJlYS9yZXNlcnZlX2Vhcmx5LCBhbmQgY2FsbCBh
Y3BpX3Jlc2VydmVfbWVtb3J5IGVhcmx5Cj4gPj4+Pj4+Cj4gPj4+Pj4+IHRvIGdldCBhcmVhIGlz
IGJlbG93IDFNCj4gPj4+Pj4+Cj4gPj4+Pj4+IC12MjogY2hhbmdlIGZ1bmN0aW9uIG5hbWUgdG8g
YWNwaV9yZXNlcnZlX3dha2V1cF9tZW1vcnkgYWNjb3JkaW5nIHRvIFJhZmFlbAo+ID4+Pj4+IEl0
IHNlZW1zIHRoYXQgdGhlIGZ1bmN0aW9uIG9mIGZpbmRfZTgyMF9hcmVhIGlzIGNhbGxlZCBpbiBz
ZXZlcmFsCj4gPj4+Pj4gcGxhY2VzLgo+ID4+Pj4+ICAgID5Jbml0bWVtX2luaXQ6IGJvb3RtYXAg
PSBmaW5kX2U4MjBfYXJlYSgwLCBlbmRfcGZuPDxQQUdFX1NISUZULAo+ID4+Pj4+IGJvb3RtYXBf
c2l6ZSwgUEFHRV9TSVpFKTsKPiA+Pj4+PiAgICAKPiA+Pj4+PiBJZiB3ZSBhbHNvIGNhbGwgaXQg
aW4gdGhlIGFjcGlfcmVzZXJ2ZV93YWtldXBfbWVtb3J5LCBkbyB3ZSBnZXQgdGhlIHNhbWUKPiA+
Pj4+PiBiYXNlIGFkZHJlc3MgYXMgdGhhdCBvYnRhaW5lZCBpbiBpbml0bWVtX2luaXQ/Cj4gPj4+
PiBuby4gZmluZF9lODIwX2FyZWEgd2lsbCBjaGVjayB0aGUgcmVzZXJ2ZSByZXMgYXJyYXkgdGhh
dCBjb3VsZCBiZSB1cGRhdGVkIGJ5IHJlc2VydmVfZWFybHkuCj4gPj4+IEl0IHdpbGwgY2hlY2sg
dGhlIHJlc2VydmVkIHJlZ2lvbiBhcnJheSB3aGVuIGNhbGxpbmcgdGhlIGZ1bmN0aW9uIG9mCj4g
Pj4+IGZpbmRfZTgyMF9hcmVhLiAKPiA+Pj4gQnV0IGl0IHNlZW1zIHRoYXQgdGhlIGFycmF5IGlz
IG5vdCB1cGRhdGVkIHdoZW4gdGhlIGZpbmRfZTgyMF9hcmVhIGlzCj4gPj4+IGNhbGxlZCBpbiB0
aGUgZnVuY3Rpb24gb2YgaW5pdG1lbV9pbml0Lgo+ID4+IHJpZ2h0IGFmdGVyIHRoYXQgd2lsbCB1
c2UgcmVzZXJ2ZV9ib290bWVtIGZvciB0aG9zZSByYW5nZSBpbiBpbml0bWVtX2luaXQuCj4gPiBZ
ZXMuIFRoZSByZXNlcnZlX2Jvb3RtZW0gaXMgY2FsbGVkIGZvciB0aGUgcmFuZ2UgaW4gaW5pdG1l
bV9pbml0Lgo+ID4gQnV0IHRoZSByZXNlcnZlZF9lYXJseSBhcnJheSBpcyBub3QgdXBkYXRlZC4K
PiAKPiBpdCBpcyBub3QgbmVlZGVkIGFueW1vcmUgYmVjYXVzZSBib290bWVtIGZvciB0aGF0IG5v
ZGUgaXMgcmVhZHkgYXQgdGhhdCBwb2ludCwgY291bGQgdXNlIAo+IHJlc2VydmVfYm9vdG1lbV9u
b2RlIGRpcmVjdGx5LiBhbmQgYmVmb3JlIHRoYXQgZWFybHlfcmVzX3RvX2Jvb3RtZW0gd2lsbCBj
b252ZXJ0IHRoYXQgZWFybHkgcmVzb3VyY2UgdGhhdCAKPiBmYWxsIGludG8gdGhhdCBub2RlIHJh
bmdlIHRvIGJvb3RtZW0gcmVzZXJ2ZWQgdG9vLgo+IAo+IHBsZWFzZSBjaGVjayBjb2RlIHNldHVw
X25vZGVfYm9vdG1lbS9lYXJseV9ub2RlX21lbS9lYXJseV9yZXNfdG9fYm9vdG1lbSAuLi5hbmQg
cmVzZXJ2ZV9ib290bWVtX25vZGUuLi4KU29ycnkgdGhhdCBJIGRvbid0IG5vdGljZSB0aGF0IHRo
ZSBmdW5jdGlvbgpvZiDvu79hY3BpX3Jlc2VydmVfd2FrZXVwX21lbW9yeSBpcyBhbHNvIG1vdmVk
IGVhcmx5IGJlZm9yZSBpbml0aWFsaXppbmcKdGhlIGJvb3RtZW0gYWxsb2NhdG9yLgpJZiBzbywg
dGhlcmUgaXMgbm8gcHJvYmxlbS4KCnRoYW5rcy4KPiAKPiBZSAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4
LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
