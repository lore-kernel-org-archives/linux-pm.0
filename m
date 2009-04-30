From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [PATCH 8/9] PM: suspend_block: Add timeout support.
Date: Fri, 01 May 2009 01:57:28 +0200
Message-ID: <49FA3AE8.7060501@gandalf.sssup.it>
References: <1241061008-31134-1-git-send-email-arve@android.com>	<1241061008-31134-2-git-send-email-arve@android.com>	<1241061008-31134-3-git-send-email-arve@android.com>	<1241061008-31134-4-git-send-email-arve@android.com>	<1241061008-31134-5-git-send-email-arve@android.com>	<1241061008-31134-6-git-send-email-arve@android.com>	<1241061008-31134-7-git-send-email-arve@android.com>	<1241061008-31134-8-git-send-email-arve@android.com>	<1241061008-31134-9-git-send-email-arve@android.com>
	<49FA39CF.3000007@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49FA39CF.3000007@gandalf.sssup.it>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

TWljaGFlbCBUcmltYXJjaGkgd3JvdGU6Cj4gSGksCj4KPiBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+Cj4gW3NuaXBdCj4gICAKPj4gQWRkIHN1c3BlbmRfYmxvY2tfdGltZW91dCB0byBibG9jayBz
dXNwZW5kIGZvciBhIGxpbWl0ZWQgdGltZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQXJ2ZSBIasO4
bm5ldsOlZyA8YXJ2ZUBhbmRyb2lkLmNvbT4KPj4gLS0tCj4+ICtzdGF0aWMgREVGSU5FX1RJTUVS
KGV4cGlyZV90aW1lciwgZXhwaXJlX3N1c3BlbmRfYmxvY2tlcnMsIDAsIDApOwo+PiArCj4+ICtz
dGF0aWMgdm9pZCB1cGRhdGVfc3VzcGVuZChzdHJ1Y3Qgc3VzcGVuZF9ibG9ja2VyICpibG9ja2Vy
LCBsb25nIG1heF90aW1lb3V0KQo+PiArewo+PiArCWlmIChtYXhfdGltZW91dCA+IDApIHsKPj4g
KwkJaWYgKGRlYnVnX21hc2sgJiBERUJVR19FWFBJUkUpCj4+ICsJCQlwcl9pbmZvKCJzdXNwZW5k
X2Jsb2NrZXI6ICVzLCBzdGFydCBleHBpcmUgdGltZXIsICIKPj4gKwkJCQkiJWxkXG4iLCBibG9j
a2VyLT5uYW1lLCBtYXhfdGltZW91dCk7Cj4+ICsJCW1vZF90aW1lcigmZXhwaXJlX3RpbWVyLCBq
aWZmaWVzICsgbWF4X3RpbWVvdXQpOwo+PiArCX0gZWxzZSB7Cj4+ICsJCWlmIChkZWxfdGltZXIo
JmV4cGlyZV90aW1lcikpCj4+ICsJCQlpZiAoZGVidWdfbWFzayAmIERFQlVHX0VYUElSRSkKPj4g
KwkJCQlwcl9pbmZvKCJzdXNwZW5kX2Jsb2NrZXI6ICVzLCBzdG9wIGV4cGlyZSAiCj4+ICsJCQkJ
CSJ0aW1lclxuIiwgYmxvY2tlci0+bmFtZSk7Cj4+ICsJCWlmIChtYXhfdGltZW91dCA9PSAwKQo+
PiAgIAo+PiAgICAgCj4gU28gdGhlIG1heF90aW1lb3V0IGNhbiBiZSBuZWdhdGl2ZT8KPiAgIAoK
CXVwZGF0ZV9zbGVlcF93YWl0X3N0YXRzX2xvY2tlZChmYWxzZSk7CisJdXBkYXRlX3N1c3BlbmQo
YmxvY2tlciwgaGFzX3RpbWVvdXQgPworCQkJbWF4X3N1c3BlbmRfYmxvY2tlcl90aW1lb3V0X2xv
Y2tlZCgpIDogLTEpOwogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmxpc3RfbG9jaywgaXJxZmxh
Z3MpOwoKT2sgc29ycnkgbWF5YmUgaW4gdGhpcyBjYWxsLi4uIEkgd3JpdGUgdG8gZmFzdCB0aGUg
ZW1haWwgOigKCj4+ICsKPj4gICAgIAo+IE1pY2hhZWwKPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGxpbnV4LXBtIG1haWxpbmcgbGlzdAo+IGxpbnV4
LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gaHR0cHM6Ly9saXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBtCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgt
cG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
