From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [PATCH 0/8]
	Suspend block api (version 8)
Date: Thu, 3 Jun 2010 10:26:58 -0700
Message-ID: <AANLkTinbLQNRyDC2PRUwoVXMF16RLHa2xZl3gJr-ftgB__21314.9654599421$1275586152$gmane$org@mail.gmail.com>
References: <20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
	<AANLkTikXy__71nBNW0EFbyL_qNf0nQ68pW9KymWlTk7L@mail.gmail.com>
	<20100603060444.GF11311@gvim.org>
	<AANLkTilml9GM2GmJhlB39oqDk6oPnLSSfiQAinpCpAbt@mail.gmail.com>
	<20100603133646.GF15595@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100603133646.GF15595@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCBKdW4gMywgMjAxMCBhdCA2OjM2IEFNLCBtYXJrIGdyb3NzIDw2NDBlOTkyMEBnbWFp
bC5jb20+IHdyb3RlOgo+IE9uIFdlZCwgSnVuIDAyLCAyMDEwIGF0IDExOjEyOjM5UE0gLTA3MDAs
IEJyaWFuIFN3ZXRsYW5kIHdyb3RlOgo+PiBPbiBXZWQsIEp1biAyLCAyMDEwIGF0IDExOjA0IFBN
LCBtYXJrIGdyb3NzIDw2NDBlOTkyMEBnbWFpbC5jb20+IHdyb3RlOgo+PiA+Pgo+PiA+PiBUaGVy
ZSBhcmUgbWFueSB3YWtldXAgZXZlbnRzIHBvc3NpYmxlIGluIGEgdHlwaWNhbCBzeXN0ZW0gLS0K
Pj4gPj4ga2V5cHJlc3NlcyBvciBvdGhlciBpbnB1dCBldmVudHMsIG5ldHdvcmsgdHJhZmZpYywg
dGVsZXBob255IGV2ZW50cywKPj4gPj4gbWVkaWEgZXZlbnRzIChmaWxsIGF1ZGlvIGJ1ZmZlciwg
ZmlsbCB2aWRlbyBkZWNvZGVyIGJ1ZmZlciwgZXRjKSwgYW5kCj4+ID4+IEkgdGhpbmsgcmVxdWly
aW5nIHRoYXQgYWxsIHdha2V1cCBldmVudCBwcm9jZXNzaW5nIGJvdHRsZW5lY2sgdGhyb3VnaAo+
PiA+PiBhIHNpbmdsZSB1c2Vyc3BhY2UgcHJvY2VzcyBpcyBub24tb3B0aW1hbCBoZXJlLgo+PiA+
Cj4+ID4gVW0gZG9lc24ndCB0aGUgYW5kcm9pZCBmcmFtZXdvcmsgYm90dGxlbmVjayB0aGUgdXNl
ciBtb2RlIGxvY2sKPj4gPiBwcm9jZXNzaW5nIHRocm91Z2ggdGhlIHBvd2VybWFuYWdlciBhbmQg
YW55IHdha2UgdXAgZXZlbnQgcHJvY2Vzc2luZwo+PiA+IGV2ZW50dWFsbHkgaGFzIHRvIGdyYWIg
YSBsb2NrIHRocm91Z2ggdGhpcyBib3R0bGVuZWNrIGFueXdheT8KPj4KPj4gRm9yICJoaWdoIGxl
dmVsIiBmcmFtZXdvcmsvYXBwbGljYXRpb24gbGV2ZWwgd2FrZWxvY2tzLCB5ZXMsIGJ1dCBsb3dl
cgo+PiBsZXZlbCBjb21wb25lbnRzIGJlbmVhdGggdGhlIGphdmEgYXBpIGxheWVyIHVzZSB0aGUg
a2VybmVsIGludGVyZmFjZQo+PiBkaXJlY3RseS4KPj4KPiBPaC4gwqBJIHRob3VnaHQgZXZlcnl0
aGluZyB3ZW50IHRocm91Z2gKPiBoYXJkd2FyZS9saWJoYXJkd2FyZV9sZWdhY3kvcG93ZXIvcG93
ZXIuYwo+IHdobyBlbHNlIGlzIGhpdHRpbmcgL3N5cy9wb3dlci8qIGluIHRoZSBhbmRyb2lkIHVz
ZXIgbW9kZSB0aGVuPwoKSSBiZWxpZXZlIGV2ZXJ5dGhpbmcgZG9lcyAtLSB0aGF0J3MgdGhlIHRo
aW4gd3JhcHBlciBhcm91bmQgdGhlIGtlcm5lbAppbnRlcmZhY2UgKHdoaWNoIHdpbGwgaGF2ZSB0
byBjaGFuZ2Ugc2xpZ2h0bHkgdG8gbWVldCB0aGUKc3VzcGVuZF9ibG9ja2VyIGRldmljZS9mZCB2
cyB3YWtlbG9jayBwcm9jL3N5cyBpbnRlcmZhY2UsIGV0YyksIHdoaWNoCmlzIHVzZWQgYnkgdGhl
IHBvd2VybWFuYWdlciBzZXJ2aWNlLCB0aGUgUklMLCBhbmQgYW55IG90aGVyIGxvdyBsZXZlbApj
b2RlLiAgQXQgdGhlIEFwcC9TZXJ2aWNlIGxldmVsLCB3YWtlbG9ja3MgYXJlIHByb3ZpZGVkIGJ5
IGEgamF2YQpsZXZlbCBBUEkgdGhhdCBpcyBhIHJlbW90ZSBpbnRlcmZhY2UgdG8gdGhlIHBvd2Vy
bWFuYWdlci4KCkJyaWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtcG0=
