From: Brian Swetland <swetland@google.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 15:16:51 -0700
Message-ID: <AANLkTikCCeMG=DAQ04xqkvqH9tngBWyBA5VQTD4_15xU__25274.0811127753$1281048322$gmane$org@mail.gmail.com>
References: <alpine.DEB.2.00.1008041620010.6545@asgard.lang.hm>
	<20100804233013.GN24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041643490.6545@asgard.lang.hm>
	<20100805001716.GO24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041722060.6545@asgard.lang.hm>
	<20100805004802.GP24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008042208350.25170@asgard.lang.hm>
	<20100805151211.GA10080@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008050832010.25170@asgard.lang.hm>
	<AANLkTi=Yyyc-hOPbkJtsnKCVzncnFq8DPnonmyckekwm@mail.gmail.com>
	<20100805203102.GN2447@linux.vnet.ibm.com>
	<AANLkTimaaLSwVusJ=w5-QptoauBnHH0JvCvmWUr0y+KD@mail.gmail.com>
	<alpine.DEB.2.00.1008051453450.30632@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008051453450.30632@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: kevin granade <kevin.granade@gmail.com>, peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCBBdWcgNSwgMjAxMCBhdCAzOjA5IFBNLCAgPGRhdmlkQGxhbmcuaG0+IHdyb3RlOgo+
PiBPb3BzLCB5ZWEgdGhhdCdzIGFjdHVhbGx5IGEgcmVhbGx5IGJhZCBleGFtcGxlLCB0aGF0J3Mg
cHJvYmFibHkKPj4gc29tZXRoaW5nIHRoYXQgd291bGQgYmUgaGFuZGxlZCBieSBsb3ctcG93ZXIg
c3RhdGVzLiDCoEkgdGhpbmsgdGhlCj4+IGluY29taW5nIHRleHQgbWVzc2FnZSBleGFtcGxlIGlz
IGEgZ29vZCBvbmUgdGhvdWdoLiDCoFRoZXJlIHNlZW1lZCB0bwo+PiBiZSBhIGZvY3VzIG9uIHVz
ZXItaW50ZXJhY3Rpb24gc2NhbGUgdGltZSBzY2FsZXMsIGFuZCBJIHdhbnRlZCB0bwo+PiBwb2lu
dCBvdXQgdGhhdCB0aGVyZSBhcmUgYWxzbyB2ZXJ5IHNob3J0IGR1cmF0aW9uIHRpbWUgc2NhbGVz
IHRvCj4+IGNvbnNpZGVyIGFzIHdlbGwuCj4KPiBnb29kIHBvaW50LCBidXQgSSBkbyB0aGluayB0
aGUgc2hvcnQgdGltZSBzY2FsZXMgYXJlIGxlc3MgY29tbW9uIHRoYW4gcGVvcGxlCj4gdGhpbmsu
Cj4KPiBJJ2QgbG92ZSB0byBnZXQgZ29vZCBleGFtcGxlcyBvZiB0aGVtCj4KPiBvbiBteSBpcGhv
bmUgd2hlbiBhIHRleHQgbWVzc2FnZSBhcnJpdmVzIHRoZSBwaG9uZSBkaXNwbGF5cyBhbiBhbGVy
dCBmb3IKPiB1c2VyLWludGVyYWN0aW9uIHRpbWVzIChpdCBldmVuIGxpZ2h0cyB0aGUgZGlzcGxh
eSB0byBzaG93IHdobyB0aGUgbWVzc2FnZQo+IGlzIGZyb20sIGFuZCBvcHRpb25hbGx5IGEgcHJl
dmlldyBvZiB0aGUgbWVzc2FnZSkKPgo+IHNvIHdoYXQgd291bGQgd2FrZSBhIHBob25lIHVwIGZy
b20gc3VzcGVuZCB3aGVyZSB0aGUgcGhvbmUgc2hvdWxkIGdvIGJhY2sgdG8KPiBzbGVlcCBpbiB1
bmRlciBhIHNlY29uZD8KCkhlcmUgYXJlIHNvbWUgcmVhbC13b3JsZCBleGFtcGxlcyBmcm9tIHNo
aXBwZWQgYW5kcm9pZCBkZXZpY2VzOgotIGJhdHRlcnkgZ2F1Z2luZyBoYXBwZW5zIGV2ZXJ5IDEw
IG1pbnV0ZXMsIG5lZWQgdG8gd2FrZSBsb25nIGVub3VnaAp0byBjaGF0dGVyIHdpdGggdGhlIDF3
IGludGVyZmFjZSBhbmQgbWFrZSBzdXJlIHRoZSBiYXR0ZXJ5IGlzIG5vdApleHBsb2RpbmcKLSBh
bHdheXMgb24gbWFpbC9pbS9jYWxlbmRhci9ldGMgc3luYyBvZnRlbiBoYXMgbmV0d29yayBldmVu
dHMgdGhhdApoYXBwZW4gZXZlcnkgNS0xMCBtaW51dGVzIHdoaWNoIGNhdXNlIGRldmljZXMgdG8g
YnJpZWZseSB3YWtlIHVwIGFuZApyZXR1cm4gdG8gc2xlZXAKLSBncHMgdHJhY2tlciBhcHAgbWln
aHQgd2FrZSBldmVyeSBjb3VwbGUgbWludXRlcyBvciBldmVyeSBuIGdwcwpldmVudHMgdG8gbG9n
IGxvY2F0aW9uCi0gbG93IHBvd2VyIGF1ZGlvIHN1YnN5c3RlbXMgY2FuIHdha2UgeW91IHVwIGV2
ZXJ5IDEtNCBzZWNvbmRzIChwY20pCm9yIDEtNCBtaW51dGVzIChtcDMpIHRvIGZldGNoIG1vcmUg
ZGF0YQoKQnJpYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1wbQ==
