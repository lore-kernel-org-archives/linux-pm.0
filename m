From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [PATCH 0/8]
	Suspend block api (version 8)
Date: Wed, 2 Jun 2010 11:05:18 -0700
Message-ID: <AANLkTikXy__71nBNW0EFbyL_qNf0nQ68pW9KymWlTk7L__8699.67037947408$1275501995$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201006010005.19554.rjw@sisk.pl>
	<20100601090023.788cabf4@notabene.brown>
	<201006010232.20263.rjw@sisk.pl>
	<20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100602180614.729246ea@notabene.brown>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Neil Brown <neilb@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCBKdW4gMiwgMjAxMCBhdCAxOjA2IEFNLCBOZWlsIEJyb3duIDxuZWlsYkBzdXNlLmRl
PiB3cm90ZToKPiBPbiBXZWQsIDIgSnVuIDIwMTAgMDA6MDU6MTQgLTA3MDAKPiBBcnZlIEhqw7hu
bmV2w6VnIDxhcnZlQGFuZHJvaWQuY29tPiB3cm90ZToKPj4gPiBUaGUgdXNlci1zcGFjZSBzdXNw
ZW5kIGRhZW1vbiBhdm9pZHMgbG9zaW5nIHdha2UtZXZlbnRzIGJ5IHVzaW5nCj4+ID4gZmNudGwo
Rl9PV05FUikgdG8gZW5zdXJlIGl0IGdldHMgYSBzaWduYWwgd2hlbmV2ZXIgYW55IGltcG9ydGFu
dCB3YWtlLWV2ZW50Cj4+ID4gaXMgcmVhZHkgdG8gYmUgcmVhZCBieSB1c2VyLXNwYWNlLiDCoFRo
aXMgbWF5IGludm9sdmU6Cj4+ID4gwqAtIHRoZSBvbmUgZGFlbW9uIHByb2Nlc3NpbmcgYWxsIHdh
a2UgZXZlbnRzCj4+Cj4+IFdha2UgdXAgZXZlbnRzIGFyZSBub3QgYWxsIHByb2Nlc3NlZCBieSBv
bmUgZGFlbW9uLgo+Cj4gTm90IHdpdGggeW91ciBjdXJyZW50IHVzZXItc3BhY2UgY29kZSwgbm8u
IMKgQXJlIHlvdSBzYXlpbmcgdGhhdCB5b3UgYXJlIG5vdAo+IG9wZW4gdG8gYW55IHNpZ25pZmlj
YW50IGNoYW5nZSBpbiB0aGUgQW5kcm9pZCB1c2VyLXNwYWNlIGNvZGU/IMKgVGhhdCB3b3VsZAo+
IG1ha2UgdGhlIHNpdHVhdGlvbiBhIGxvdCBoYXJkZXIgdG8gcmVzb2x2ZS4KClRoZXJlIGFyZSBt
YW55IHdha2V1cCBldmVudHMgcG9zc2libGUgaW4gYSB0eXBpY2FsIHN5c3RlbSAtLQprZXlwcmVz
c2VzIG9yIG90aGVyIGlucHV0IGV2ZW50cywgbmV0d29yayB0cmFmZmljLCB0ZWxlcGhvbnkgZXZl
bnRzLAptZWRpYSBldmVudHMgKGZpbGwgYXVkaW8gYnVmZmVyLCBmaWxsIHZpZGVvIGRlY29kZXIg
YnVmZmVyLCBldGMpLCBhbmQKSSB0aGluayByZXF1aXJpbmcgdGhhdCBhbGwgd2FrZXVwIGV2ZW50
IHByb2Nlc3NpbmcgYm90dGxlbmVjayB0aHJvdWdoCmEgc2luZ2xlIHVzZXJzcGFjZSBwcm9jZXNz
IGlzIG5vbi1vcHRpbWFsIGhlcmUuCgpUaGUgY3VycmVudCBzdXNwZW5kLWJsb2NrZXIgcHJvcG9z
YWwgYWxyZWFkeSBpbnZvbHZlcyB1c2Vyc3BhY2UKY2hhbmdlcyAoaXQncyBkaWZmZXJlbnQgdGhh
biBvdXIgZXhpc3Rpbmcgd2FrZWxvY2sgaW50ZXJmYWNlKSwgYW5kCndlJ3JlIGNlcnRhaW5seSBu
b3Qgb3Bwb3NlZCB0byBhbnkvYWxsIHVzZXJzcGFjZSBjaGFuZ2VzIG9uIHByaW5jaXBsZSwKYnV0
IG9uIHRoZSBvdGhlciBoYW5kIHdlJ3JlIG5vdCBpbnRlcmVzdGVkIGluIHNpZ25pZmljYW50IHJl
d29ya3Mgb2YKdXNlcnNwYWNlIHVubGVzcyB0aGV5IGFjdHVhbGx5IGltcHJvdmUgdGhlIHNpdHVh
dGlvbiBzb21laG93LiAgSSB0aGluawpib3R0bGVuZWNraW5nIGV2ZW50cyB0aHJvdWdoIGEgY2Vu
dHJhbCBkYWVtb24gd291bGQgcmVwcmVzZW50IGEgc3RlcApiYWNrd2FyZHMuCgpCcmlhbgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWls
aW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
