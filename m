From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Wed, 26 May 2010 13:06:25 +0200
Message-ID: <1274871985.5882.5373.camel__25250.2916534015$1274872041$gmane$org@twins>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<1274482015-30899-2-git-send-email-arve@android.com>
	<1274482015-30899-3-git-send-email-arve@android.com>
	<1274863428.5882.4860.camel@twins>
	<AANLkTimTnzK1ByG2bE2gGjINxD_Pbvez7PFHo7Kzo9yk@mail.gmail.com>
	<20100526125136.53f2dc82@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526125136.53f2dc82@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCAyMDEwLTA1LTI2IGF0IDEyOjUxICswMjAwLCBGbG9yaWFuIE1pY2tsZXIgd3JvdGU6
Cj4gT24gV2VkLCAyNiBNYXkgMjAxMCAwMzo0NzoyNyAtMDcwMAo+IEFydmUgSGrDuG5uZXbDpWcg
PGFydmVAYW5kcm9pZC5jb20+IHdyb3RlOgo+IAo+ID4gMjAxMC81LzI2IFBldGVyIFppamxzdHJh
IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz46Cj4gPiA+IE9uIEZyaSwgMjAxMC0wNS0yMSBhdCAxNTo0
NiAtMDcwMCwgQXJ2ZSBIasO4bm5ldsOlZyB3cm90ZToKPiA+ID4+ICtUbyBjcmVhdGUgYSBzdXNw
ZW5kIGJsb2NrZXIgZnJvbSB1c2VyIHNwYWNlLCBvcGVuIHRoZSBzdXNwZW5kX2Jsb2NrZXIKPiA+
ID4+IHNwZWNpYWwKPiA+ID4+ICtkZXZpY2UgZmlsZToKPiA+ID4+ICsKPiA+ID4+ICsgICAgZmQg
PSBvcGVuKCIvZGV2L3N1c3BlbmRfYmxvY2tlciIsIE9fUkRXUiB8IE9fQ0xPRVhFQyk7Cj4gPiA+
PiArCj4gPiA+PiArdGhlbiBvcHRpb25hbGx5IGNhbGw6Cj4gPiA+PiArCj4gPiA+PiArICAgIGlv
Y3RsKGZkLCBTVVNQRU5EX0JMT0NLRVJfSU9DVExfU0VUX05BTUUoc3RybGVuKG5hbWUpKSwgbmFt
ZSk7Cj4gPiA+PiArCj4gPiA+PiArVG8gYWN0aXZhdGUgdGhlIHN1c3BlbmQgYmxvY2tlciBjYWxs
Ogo+ID4gPj4gKwo+ID4gPj4gKyAgICBpb2N0bChmZCwgU1VTUEVORF9CTE9DS0VSX0lPQ1RMX0JM
T0NLKTsKPiA+ID4+ICsKPiA+ID4+ICtUbyBkZWFjdGl2YXRlIGl0IGNhbGw6Cj4gPiA+PiArCj4g
PiA+PiArICAgIGlvY3RsKGZkLCBTVVNQRU5EX0JMT0NLRVJfSU9DVExfVU5CTE9DSyk7Cj4gPiA+
PiArCj4gPiA+PiArVG8gZGVzdHJveSB0aGUgc3VzcGVuZCBibG9ja2VyLCBjbG9zZSB0aGUgZGV2
aWNlOgo+ID4gPj4gKwo+ID4gPj4gKyAgICBjbG9zZShmZCk7Cj4gPiA+Cj4gPiA+IFVyZ2gsIHBs
ZWFzZSBsZXQgdGhlIG9wZW4oKSBiZSBCTE9DSywgdGhlIGNsb3NlKCkgYmUgVU5CTE9DSywgYW5k
IGtlZXAKPiA+ID4gdGhlIFNFVF9OQU1FIHRoaW5nIGlmIHlvdSByZWFsbHkgY2FyZS4KPiA+ID4K
PiA+IAo+ID4gVGhhdCB3b3VsZCBiZSB2ZXJ5IGluZWZmaWNpZW50Lgo+ID4gCj4gCj4gQWxzbyBJ
IHRoaW5rIGl0IGlzIGludGVuZGVkIHRvIGVuZm9yY2UgbmFtZWQgc3VzcGVuZCBibG9ja2Vycy4g
KEZvcgo+IGRlYnVnZ2luZy9hY2NvdW50aW5nIHB1cnBvc2VzKS4KCkkgZG9uJ3QgdGhpbmsgdGhl
IGNvZGUgYXMgcHJvcG9zZWQgbWFuZGF0ZXMgeW91IFNFVF9OQU1FLCBhbmQgSSBkaWRuJ3QKcHJv
cG9zZSBraWxsaW5nIHRoYXQgb2ZmLCB5b3UgY2FuIHN0aWxsIFNFVF9OQU1FIGFmdGVyIHlvdSBv
cGVuKCkgYW5kCmFjcXVpcmUgdGhlIHRoaW5nLgoKQW55d2F5LCB0aGUgd2hvbGUgcG9pbnQgaXMg
bW9vdCBzaW5jZSBpdHMgc2ltcGx5IG5vdCBuZWVkZWQgYXQgYWxsLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGlu
dXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
