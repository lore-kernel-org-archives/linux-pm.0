From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
	=?utf-8?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_new_top?=
	=?utf-8?q?_level_suspend=09and_hibernation_callbacks_=28rev=2E_2?=
	=?utf-8?q?=29?=
Date: Tue, 25 Mar 2008 14:06:15 +0100
Message-ID: <200803251406.16741.rjw__9453.34689827195$1206450753$gmane$org@sisk.pl>
References: <200803210101.04706.rjw@sisk.pl>
	<1206058863.16475.165.camel@johannes.berg>
	<200803251049.27696.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803251049.27696.oliver@neukum.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T24gVHVlc2RheSwgMjUgb2YgTWFyY2ggMjAwOCwgT2xpdmVyIE5ldWt1bSB3cm90ZToKPiBBbSBG
cmVpdGFnLCAyMS4gTcOkcnogMjAwOCAwMToyMTowMyBzY2hyaWViIEpvaGFubmVzIEJlcmc6Cj4g
PiA+ICsgKiBBbGwgb2YgdGhlIGFib3ZlIGNhbGxiYWNrcywgZXhjZXB0IGZvciBAY29tcGxldGUo
KSwgcmV0dXJuIGVycm9yIGNvZGVzLgo+ID4gPiArICogSG93ZXZlciwgdGhlIGVycm9yIGNvZGVz
IHJldHVybmVkIGJ5IHRoZSByZXN1bWUgb3BlcmF0aW9ucywgQHJlc3VtZSgpLAo+ID4gPiArICog
QHRoYXcoKSwgYW5kIEByZXN0b3JlKCksIGFyZSBvbmx5IHByaW50ZWQgaW4gdGhlIHN5c3RlbSBs
b2dzLCBzaW5jZSB0aGUgUE0KPiA+ID4gKyAqIGNvcmUgY2Fubm90IGRvIGFueXRoaW5nIGVsc2Ug
YWJvdXQgdGhlbS4KPiA+IAo+ID4gV2h5IGJvdGhlciBhbmQgbm90IGp1c3QgbWFrZSB0aGVtIHJl
dHVybiB2b2lkLCB0aGUgZXJyb3IgcHJpbnRpbmcgY2FuCj4gPiBtb3N0IGxpa2VseSBiZSBkb25l
IG11Y2ggbXVjaCBiZXR0ZXIgaW4gdGhlIGNhbGxiYWNrIHNpbmNlIHRoYXQgcG9zc2libHkKPiA+
IGhhcyBpbmZvcm1hdGlvbiBvbiB3aHkgaXQgZmFpbGVkLgo+IAo+IEEgZGV2aWNlIHRoYXQgY2Fu
bm90IHdha2UgdXAgaXMgdW51c2FibGUuIFNob3VsZG4ndCB0aGUgcG0gY29yZSBkaXNjb25uZWN0
KCkKPiBzdWNoIGEgZGV2aWNlPwoKV2VsbCwgaWYgLT5yZXN1bWUoKSByZXR1cm5zIGFuIGVycm9y
LCB0aGUgZHJpdmVyIGFscmVhZHkga25vd3MgdGhlcmUncyBhCnByb2JsZW0gYW5kIGl0IGNhbiBh
Y3QgdXBvbiB0aGF0LCBhdCBsZWFzdCBpbiBwcmluY2lwbGUuCgpIb3dldmVyLCB0aGUgUE0gY29y
ZSBwcm9iYWJseSBzaG91bGRuJ3QgdHJ5IHRvIHJlc3VtZSB0aGUgY2hpbGRyZW4gb2YgYSBmYWls
aW5nCmRldmljZS4gIEFsc28sIGlmIC0+cmVzdW1lX25vaXJxKCkgZmFpbHMsIGl0IHByb2JhYmx5
IGlzIG5vdCBhIGdvb2QgaWRlYSB0bwpjYWxsIC0+cmVzdW1lKCkgYW5kIC0+Y29tcGxldGUoKSBm
b3IgdGhlIHNhbWUgZGV2aWNlIGFuZCBmb3IgaXQncyBjaGlsZHJlbi4KClRoYW5rcywKUmFmYWVs
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBt
IG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
