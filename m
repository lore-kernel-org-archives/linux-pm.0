From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC][RFT][PATCH] ACPI: Protection from suspending
 in the middle of EC transaction
Date: Mon, 01 Feb 2010 13:22:55 +0300
Message-ID: <4B66AB7F.7050908__19972.5528750152$1265019828$gmane$org@suse.de>
References: <201001310029.48717.rjw@sisk.pl>
	<9b2b86521001310611m339862afw73410dc7eb5692c8@mail.gmail.com>
	<1264957760.7264.3.camel@maxim-laptop>
	<20100201094643.GB8740@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100201094643.GB8740@khazad-dum.debian.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Jenkins <sourcejedi.lkml@googlemail.com>
List-Id: linux-pm@vger.kernel.org

SGVucmlxdWUgZGUgTW9yYWVzIEhvbHNjaHVoINC/0LjRiNC10YI6Cj4gT24gU3VuLCAzMSBKYW4g
MjAxMCwgTWF4aW0gTGV2aXRza3kgd3JvdGU6Cj4+IFVuZm9ydHVuYXRlbHksIHRoaXMgcGF0Y2gg
ZXZlbiBjYXVzZXMgcmVncmVzc2lvbnMgb24gbXkgbm90ZWJvb2sgKGl0Cj4+IHN1cnZpdmUgNjMg
aGliZXJuYXRlIGN5Y2xlcyksIGJ1dCBub3cgSSBiYXR0ZXJ5IGRyaXZlciByZXBvcnRzICdiYXR0
ZXJ5Cj4+IGFic2VudCcsIGJhY2tsaWdodCBkcml2ZXIgcmVwb3J0cyAwIGJyaWdodG5lc3MsIGJ1
dCByZWxvYWQgaGVscGVkLgo+IAo+IC4uLgo+IAo+PiBJIHRoaW5rIHRoYXQgbm90IG9ubHkgX1BU
UyBhbnMgX1dBSyBhcmUgcHJvYmxlbWF0aWMuIFdoYXQgYWJvdXQgb3RoZXIKPj4gQUNQSSBkcml2
ZXJzIHRoYXQgc3RhcnQgYWNjZXNzaW5nIHRoZSBFQyBiZWZvcmUgaXQgaXMgcmVzdW1lZD8KPj4g
SSB0aGluayB0aGF0IHRoZXNlIGNhdXNlIHRoZSBwcm9ibGVtcyBJIG9ic2VydmUuCj4gCj4gQUNQ
SSBkcml2ZXJzIG1pZ2h0IGFjY2VzcyB0aGUgRUMgKGV2ZW4gaW5kaXJlY3RseSwgdGhyb3VnaCB0
aGUgRFNEVCkuICBBbmQKPiBwbGF0Zm9ybSBkcml2ZXJzIGRvIG9mdGVuIGFjY2VzcyB0aGUgRUMg
Ym90aCBhdCBzdXNwZW5kIGFuZCByZXN1bWUgdGltZS4KQWN0dWFsbHksIG9ubHkgU0JTIGFuZCB0
aGlua3BhZC1hY3BpIGFjY2VzcyBFQyBkaXJlY3RseS4gQWxsIG90aGVycyBnbyB0aHJvdWdoCkRT
RFQgZm9yIGFjY2Vzcy4gU3RpbGwsIHN0b3BwaW5nIEVDIGluIC5zdXNwZW5kIGlzIHRvbyBlYXJs
eSwgSU1ITy4uLgo+IAo+IFRoaXMgbmVlZHMgc29tZSBzb3J0IG9mIHN0cm9uZyBvcmRlcmluZywg
dGhlIEVDIG11c3Qgc3VzcGVuZCBsYXN0LCBhbmQKPiByZXN1bWUgZmlyc3QgKGFzIHNlZW4gYnkg
YW55IEFDUEkgYW5kIEFDUEktYXdhcmUgZHJpdmVycyBzdWNoIGFzIGxpYmF0YSwKPiBzb21lIHBs
YXRmb3JtIGRyaXZlcnMsIGV0YykuICBJZiBFQyBpbnRlcnJ1cHRzIGFyZSBhIHByb2JsZW0sIG1h
eWJlIGl0IGNhbgo+IGJlIGtpY2tlZCB0byBwb2xsIG1vZGUgZm9yIHRoZSBzdXNwZW5kL3Jlc3Vt
ZSB0cmFuc2l0aW9uPwpJdCdzIHRoaXMgd2F5IGFscmVhZHkgZm9yIGFib3V0IGEgeWVhciBub3cu
Li4gVGhlIHByb2JsZW0gaXMgdGhhdCBFQyBkcml2ZXIgbWlnaHQgYmUgCnN0b3BwZWQgaW4gbWlk
ZGxlIG9mIHRoZSB0cmFuc2FjdGlvbiwgdGh1cyBsZWF2aW5nIEVDIGluIHVua25vd24gc3RhdGUg
Zm9yIEJJT1Mgb3IgCnN3aXRjaC1vdmVyIGtlcm5lbC4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
