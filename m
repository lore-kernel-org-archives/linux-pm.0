From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 09:43:43 +0200
Message-ID: <1275032623.32462.30.camel__41099.1701916375$1275044759$gmane$org@laptop>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	<20100527181433.GG3543@srcf.ucam.org>
	<20100527200313.5c532f2f@lxorguk.ukuu.org.uk>
	<201005280110.17075.rjw@sisk.pl>
	<20100528005045.6ea5feba@lxorguk.ukuu.org.uk>
	<AANLkTimqvMuMpB5E3tj58OtlRc-7mVaec-9EHAegywg7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimqvMuMpB5E3tj58OtlRc-7mVaec-9EHAegywg7@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCAyMDEwLTA1LTI3IGF0IDE3OjQ1IC0wNzAwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+IFdoYXQgaGFwcGVucyBpZiB0aGUgdXNlciBwcmVzc2VzIHRoZSBidXR0b24gcmlnaHQgYmVm
b3JlIHlvdSBzZXQgUW9TCj4gb2YgJ3VzZXIgYXBwcycgdG8gIFFTX05PTkU/Cj4gVG8gbWUgaXQg
bG9va3MgbGlrZSB0aGlzIHNvbHV0aW9uIHdvdWxkIHJlc3VsdCBpbiB0aGlzIHNlcXVlbmNlIHdo
aWNoCj4gbWF5IGlnbm9yZSB0aGUgYnV0dG9uIHByZXNzOgo+ICAgICAgICAgQnV0dG9uIHB1c2hl
ZAo+ICAgICAgICAgQnV0dG9uIGRyaXZlciBzZXRzIFFvUyBvZiBhcHAgaXQgd2FrZXMgdG8gUVNf
QUJPVkVTVVNQRU5ECj4gICAgICAgICBTZXQgUW9TIG9mICd1c2VyIGFwcHMnIHRvIFFTX05PTkUg
CgpJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBjaGFuZ2UgYXBwIFFvUyBwYXJhbWV0ZXJzLCBidXQg
Y2hhbmdlIHNlcnZpY2UKcHJvdmlkZXIgcGFyYW1ldGVycy4KCkZvciBpbnN0YW5jZSwgc3VwcG9z
ZSB0aGUgZmlsZXN5c3RlbS1JTyBRb1MgaGFzIDMgbGV2ZWxzOiAKICBIaWdoLCBOb3JtYWwgYW5k
IElkbGUuCgpUaGVuIGlmIHdlIGFzc2lnbiBJZGxlIHRvIHVwZGF0ZWRiLCB3ZSdsbCBzZXJ2aWNl
IGl0IGFzIGxvbmcgYXMgdGhlCmZpbGVzeXN0ZW0tc2VydmVyIFFvUyBoYXMgYSBoaWdoZXIgbGV2
ZWwgKEhpZ2ggYW5kIE5vcm1hbCkuIFdoZW4gd2UKY2hhbmdlIHRoZSBmaWxlc3lzdGVtLXNlcnZl
cycgUW9TIHRvIGlkbGUsIGl0IGZpbmRzIHRoZXJlIGlzIG5vdGhpbmcgdG8Ka2VlcCBpdCBzZXJ2
aWNpbmcgc3R1ZmYgYW5kIGl0J2xsIGJsb2NrIHBlbmRpbmcgcmVxdWVzdHMsIHVwZGF0ZWRiIHN0
b3BzCmJlaW5nIHJ1bm5hYmxlIGFuZCB3ZSdyZSBnb29kLgoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgt
cG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
