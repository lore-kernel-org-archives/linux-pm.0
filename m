From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [PATCH 3/9] PM: suspend_block: Abort task freezing
 if a suspend_blocker is active.
Date: Fri, 08 May 2009 11:06:42 +1000
Message-ID: <1241744802.19600.244.camel@nigel-laptop>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
	<1241583529-5092-4-git-send-email-arve@android.com>
	<20090505195753.GE1379@ucw.cz>
	<d6200be20905061851y12b07d59t11b43d74a07aad3b@mail.gmail.com>
	<20090507104143.GB6132@elf.ucw.cz>
	<d6200be20905071649h2d3a57c8h1c1cd72d4bea4d31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20905071649h2d3a57c8h1c1cd72d4bea4d31@mail.gmail.com>
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
Cc: u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

SGkuCgpPbiBUaHUsIDIwMDktMDUtMDcgYXQgMTY6NDkgLTA3MDAsIEFydmUgSGrDuG5uZXbDpWcg
d3JvdGU6Cj4gT24gVGh1LCBNYXkgNywgMjAwOSBhdCAzOjQxIEFNLCBQYXZlbCBNYWNoZWsgPHBh
dmVsQHVjdy5jej4gd3JvdGU6Cj4gPiBJZiB0aGUgY29kZSBydW5zIGZvciAyMCBzZWNvbmRzLCBp
dCBpcyBhIGJ1ZyB0byBiZSBmaXhlZC4KPiAKPiBUaGUgY29kZSBnaXZlcyB1cCBhZnRlciAyMCBz
ZWNvbmRzLCBpdCBkb2VzIG5vdCBub3JtYWxseSBydW4gZm9yIDIwCj4gc2Vjb25kcy4gSXQgaXMg
YXJndWFibHkgYSBidWcgdGhhdCBpdCBnaXZlcyB1cCBhZnRlciAyMCBzZWNvbmRzIHNpbmNlCj4g
dGhlIHRpbWUgcmVxdWlyZWQgdG8gZnJlZXplIGFsbCB0aGUgdGhyZWFkcyBncm93cyB3aXRoIHRo
ZSBudW1iZXIgb2YKPiB0aHJlYWRzIHRoYXQgYXJlIHJ1bm5pbmcuIEl0IGNvdWxkIHN0aWxsIGJl
IG1ha2luZyBwcm9ncmVzcyBhZnRlciAyMAo+IHNlY29uZHMuIFNpbmNlIHRoZSB0aW1lIHJlcXVp
cmVkIHRvIGZyZWV6ZSBhbGwgdGFza3MgaXMgdGhlIG51bWJlciBvZgo+IHRhc2tzIHRpbWVzIHRo
ZSB0aW1lIGl0IHRha2VzIHRvIGludGVycnVwdCBlYWNoIHRhc2sgdGhlcmUgaXMgbm8gd2F5Cj4g
dG8gZW5zdXJlIHRoYXQgdGhlIHRpbWUgcmVxdWlyZWQgaXMgaW5zaWduaWZpY2FudC4gSWYgd2Ug
ZG8gbm90IGFib3J0Cj4gdGFzayBmcmVlemluZyB3aGVuIHRoZXJlIGlzIGEgd2FrZXVwIGV2ZW50
LCB0aGVuIHRoZSB3b3JzdCBjYXNlIHdha2V1cAo+IGxhdGVuY3kgaXMgZ3VhcmFudGllZCB0byBi
ZSB3b3JzZSB0aGFuIHRoZSB3b3JzdCBjYXNlIGxhdGVuY3kgZm9yIGFueQo+IG90aGVyIHVuaW50
ZXJydXB0aWJsZSBrZXJuZWwgY2FsbC4KCkkgYWdyZWUgd2l0aCBQYXZlbCBoZXJlLiBJZiBmcmVl
emluZyB0YWtlcyAyMCBzZWNvbmRzLCBzb21ldGhpbmcgaXMKd3JvbmcuIChSZW1lbWJlciB0aGF0
IG1vc3QgdGFza3Mgd2lsbCBub3QgYmUgcnVubmluZywgYW5kIHdpbGwgdGhlcmVmb3JlCnJlc3Bv
bmQgdG8gdGhlIHBzZXVkby1zaWduYWwgYW5kIGZyZWV6ZSBpbW1lZGlhdGVseSkuCgpJbiBmYWN0
LCBJJ2QgZ28gZnVydGhlci4gSW4gdGhlIHRob3VzYW5kcyBvZiB0aW1lcyBJJ3ZlIHJ1biB0aGUg
ZnJlZXplcgpvdmVyIHRoZSB5ZWFycywgaXQgaGFzIG5ldmVyIHRha2VuIG1vcmUgdGhhbiAxIHNl
Y29uZCAtIGxldCBhbG9uZSAyMCAtCndoZW4gZnJlZXppbmcgaGFzIGJlZW4gc3VjY2Vzc2Z1bC4g
QSBkZWxheSBvZiAyMCBzZWNvbmRzIHdhcyBtb3JlCnJlbGV2YW50IHdoZW4gdGhlIHZhbHVlIGlu
Y2x1ZGVkIHRoZSB0aW1lIGZvciBzeW5jaW5nIGRhdGEgdG8gZGlzay4KClJlZ2FyZHMsCgpOaWdl
bAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
cG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
