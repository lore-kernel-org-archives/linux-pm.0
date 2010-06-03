From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [PATCH 0/8]
	Suspend block api (version 8)
Date: Wed, 2 Jun 2010 23:43:06 -0700
Message-ID: <AANLkTikuf6bKVHoGRTjrM_2kPtZqUM6J76Z0hNUQxT_3__8257.79745723612$1275547607$gmane$org@mail.gmail.com>
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
	<AANLkTikXy__71nBNW0EFbyL_qNf0nQ68pW9KymWlTk7L@mail.gmail.com>
	<20100603163307.721b1c23@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100603163307.721b1c23@notabene.brown>
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

T24gV2VkLCBKdW4gMiwgMjAxMCBhdCAxMTozMyBQTSwgTmVpbCBCcm93biA8bmVpbGJAc3VzZS5k
ZT4gd3JvdGU6Cj4+Cj4+IFRoZSBjdXJyZW50IHN1c3BlbmQtYmxvY2tlciBwcm9wb3NhbCBhbHJl
YWR5IGludm9sdmVzIHVzZXJzcGFjZQo+PiBjaGFuZ2VzIChpdCdzIGRpZmZlcmVudCB0aGFuIG91
ciBleGlzdGluZyB3YWtlbG9jayBpbnRlcmZhY2UpLCBhbmQKPj4gd2UncmUgY2VydGFpbmx5IG5v
dCBvcHBvc2VkIHRvIGFueS9hbGwgdXNlcnNwYWNlIGNoYW5nZXMgb24gcHJpbmNpcGxlLAo+PiBi
dXQgb24gdGhlIG90aGVyIGhhbmQgd2UncmUgbm90IGludGVyZXN0ZWQgaW4gc2lnbmlmaWNhbnQg
cmV3b3JrcyBvZgo+PiB1c2Vyc3BhY2UgdW5sZXNzIHRoZXkgYWN0dWFsbHkgaW1wcm92ZSB0aGUg
c2l0dWF0aW9uIHNvbWVob3cuIMKgSSB0aGluawo+PiBib3R0bGVuZWNraW5nIGV2ZW50cyB0aHJv
dWdoIGEgY2VudHJhbCBkYWVtb24gd291bGQgcmVwcmVzZW50IGEgc3RlcAo+PiBiYWNrd2FyZHMu
Cj4KPiBJIGd1ZXNzIGl0IGJlY29tZXMgYW4gcXVlc3Rpb24gb2YgZWNvbm9taWNzIGZvciB5b3Ug
dGhlbi4gwqBEb2VzIHRoZSBjb3N0IG9mCj4gd2hhdGV2ZXIgdXNlci1zcGFjZSBjaGFuZ2VzIGFy
ZSByZXF1aXJlZCBleGNlZWQgdGhlIHZhbHVlIG9mIHVzaW5nIGFuIHVwc3RyZWFtCj4ga2VybmVs
PyDCoEJvdGggdGhlIGNvc3QgYW5kIHRoZSB2YWx1ZSB3b3VsZCBiZSB2ZXJ5IGhhcmQgdG8gZXN0
aW1hdGUgaW4KPiBhZHZhbmNlLiDCoEkgZG9uJ3QgZW52eSB5b3UgdGhlIGRlY2lzaW9uLi4uCgpX
ZWxsLCBhdCB0aGlzIHBvaW50IHdlJ3ZlIGludmVzdGVkIG1vcmUgZW5naW5lZXJpbmcgaG91cnMg
aW4gdGhlCnZhcmlvdXMgcmV3cml0ZXMgb2YgdGhpcyAoc2luZ2xlKSBwYXRjaHNldCBhbmQgZGlz
Y3Vzc2lvbiBhcm91bmQgaXQKdGhhbiB3ZSBoYXZlIHNwZW50IG9uIHJlYmFzaW5nIG91ciB0cmVl
cyBvbiByb3VnaGx5IGV2ZXJ5IG90aGVyCm1haW5saW5lIHJlbGVhc2Ugc2luY2UgMi42LjE2IG9y
IHNvLCBhY3Jvc3MgZml2ZSB5ZWFycyBvZiBBbmRyb2lkCmRldmVsb3BtZW50LiAgV2UgdGhpbmsg
dGhlcmUncyBzb21lIGdvb2QgdmFsdWUgdG8gYmUgaGFkIChhbGwgdGhlCnVzdWFsIHJlYXNvbnMp
IGJ5IGhlYWRpbmcgdXBzdHJlYW0sIHNvIHdlJ3JlIHN0aWxsIGRpc2N1c3NpbmcgdGhlc2UKcGF0
Y2hlcyBhbmQgZXhwbG9yaW5nIGFsdGVybmF0aXZlcywgYnV0IHllcywgZnJvbSBvbmUgd2F5IG9m
IGxvb2tpbmcKYXQgaXQsIGl0J2QgY2VydGFpbmx5IGJlIGNoZWFwZXIgdG8ganVzdCBrZWVwIG1h
aW50YWluaW5nIG91ciBvd24KdHJlZXMuCgpCcmlhbgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
