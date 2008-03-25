From: Oliver Neukum <oliver@neukum.org>
Subject: Re:
	=?utf-8?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_new_top?=
	=?utf-8?q?_level_suspend=09and_hibernation_callbacks_=28rev=2E_2?=
	=?utf-8?q?=29?=
Date: Tue, 25 Mar 2008 14:15:08 +0100
Message-ID: <200803251415.09088.oliver__47229.2462517091$1206451078$gmane$org@neukum.org>
References: <200803210101.04706.rjw@sisk.pl>
	<200803251049.27696.oliver@neukum.org>
	<200803251406.16741.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803251406.16741.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

QW0gRGllbnN0YWcsIDI1LiBNw6RyeiAyMDA4IDE0OjA2OjE1IHNjaHJpZWIgUmFmYWVsIEouIFd5
c29ja2k6Cj4gT24gVHVlc2RheSwgMjUgb2YgTWFyY2ggMjAwOCwgT2xpdmVyIE5ldWt1bSB3cm90
ZToKPiA+IEFtIEZyZWl0YWcsIDIxLiBNw6RyeiAyMDA4IDAxOjIxOjAzIHNjaHJpZWIgSm9oYW5u
ZXMgQmVyZzoKPiA+ID4gPiArICogQWxsIG9mIHRoZSBhYm92ZSBjYWxsYmFja3MsIGV4Y2VwdCBm
b3IgQGNvbXBsZXRlKCksIHJldHVybiBlcnJvciBjb2Rlcy4KPiA+ID4gPiArICogSG93ZXZlciwg
dGhlIGVycm9yIGNvZGVzIHJldHVybmVkIGJ5IHRoZSByZXN1bWUgb3BlcmF0aW9ucywgQHJlc3Vt
ZSgpLAo+ID4gPiA+ICsgKiBAdGhhdygpLCBhbmQgQHJlc3RvcmUoKSwgYXJlIG9ubHkgcHJpbnRl
ZCBpbiB0aGUgc3lzdGVtIGxvZ3MsIHNpbmNlIHRoZSBQTQo+ID4gPiA+ICsgKiBjb3JlIGNhbm5v
dCBkbyBhbnl0aGluZyBlbHNlIGFib3V0IHRoZW0uCj4gPiA+IAo+ID4gPiBXaHkgYm90aGVyIGFu
ZCBub3QganVzdCBtYWtlIHRoZW0gcmV0dXJuIHZvaWQsIHRoZSBlcnJvciBwcmludGluZyBjYW4K
PiA+ID4gbW9zdCBsaWtlbHkgYmUgZG9uZSBtdWNoIG11Y2ggYmV0dGVyIGluIHRoZSBjYWxsYmFj
ayBzaW5jZSB0aGF0IHBvc3NpYmx5Cj4gPiA+IGhhcyBpbmZvcm1hdGlvbiBvbiB3aHkgaXQgZmFp
bGVkLgo+ID4gCj4gPiBBIGRldmljZSB0aGF0IGNhbm5vdCB3YWtlIHVwIGlzIHVudXNhYmxlLiBT
aG91bGRuJ3QgdGhlIHBtIGNvcmUgZGlzY29ubmVjdCgpCj4gPiBzdWNoIGEgZGV2aWNlPwo+IAo+
IFdlbGwsIGlmIC0+cmVzdW1lKCkgcmV0dXJucyBhbiBlcnJvciwgdGhlIGRyaXZlciBhbHJlYWR5
IGtub3dzIHRoZXJlJ3MgYQo+IHByb2JsZW0gYW5kIGl0IGNhbiBhY3QgdXBvbiB0aGF0LCBhdCBs
ZWFzdCBpbiBwcmluY2lwbGUuCgpUaGVuIHdoeSByZXR1cm4gYW4gZXJyb3I/IElmIGEgZHJpdmVy
IHJldHVybnMgYW4gZXJyb3IgSSB3b3VsZCBhc3N1bWUgdGhhdAp0byBpbmRpY2F0ZSBhbiBpcnJl
Y292ZXJhYmxlIGVycm9yLgoKPiBIb3dldmVyLCB0aGUgUE0gY29yZSBwcm9iYWJseSBzaG91bGRu
J3QgdHJ5IHRvIHJlc3VtZSB0aGUgY2hpbGRyZW4gb2YgYSBmYWlsaW5nCj4gZGV2aWNlLiAgQWxz
bywgaWYgLT5yZXN1bWVfbm9pcnEoKSBmYWlscywgaXQgcHJvYmFibHkgaXMgbm90IGEgZ29vZCBp
ZGVhIHRvCj4gY2FsbCAtPnJlc3VtZSgpIGFuZCAtPmNvbXBsZXRlKCkgZm9yIHRoZSBzYW1lIGRl
dmljZSBhbmQgZm9yIGl0J3MgY2hpbGRyZW4uCgpFeGFjdGx5LiBCdXQgd2UgbmVlZCB0byBkZWZp
bmUgd2hhdCBoYXBwZW5zIGluIHRoZXNlIGNhc2VzLiBJZiB3ZSBzaW1wbHkKaWdub3JlIHRoZSBl
cnJvcnMsIHRoZSBkcml2ZXJzIG11c3QgYmUgYWJsZSB0byBkZWFsIHdpdGggSU8gdG8gaGFsZiBz
dXNwZW5kZWQKZGV2aWNlcy4KCglSZWdhcmRzCgkJT2xpdmVyCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4
LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
