From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Wed, 26 May 2010 23:57:28 +0200
Message-ID: <201005262357.28933.rjw__29521.6998937123$1274912160$gmane$org@sisk.pl>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<1274482015-30899-3-git-send-email-arve@android.com>
	<1274863428.5882.4860.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274863428.5882.4860.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

T24gV2VkbmVzZGF5IDI2IE1heSAyMDEwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToKPiBPbiBGcmks
IDIwMTAtMDUtMjEgYXQgMTU6NDYgLTA3MDAsIEFydmUgSGrDuG5uZXbDpWcgd3JvdGU6Cj4gPiAr
VG8gY3JlYXRlIGEgc3VzcGVuZCBibG9ja2VyIGZyb20gdXNlciBzcGFjZSwgb3BlbiB0aGUgc3Vz
cGVuZF9ibG9ja2VyCj4gPiBzcGVjaWFsCj4gPiArZGV2aWNlIGZpbGU6Cj4gPiArCj4gPiArICAg
IGZkID0gb3BlbigiL2Rldi9zdXNwZW5kX2Jsb2NrZXIiLCBPX1JEV1IgfCBPX0NMT0VYRUMpOwo+
ID4gKwo+ID4gK3RoZW4gb3B0aW9uYWxseSBjYWxsOgo+ID4gKwo+ID4gKyAgICBpb2N0bChmZCwg
U1VTUEVORF9CTE9DS0VSX0lPQ1RMX1NFVF9OQU1FKHN0cmxlbihuYW1lKSksIG5hbWUpOwo+ID4g
Kwo+ID4gK1RvIGFjdGl2YXRlIHRoZSBzdXNwZW5kIGJsb2NrZXIgY2FsbDoKPiA+ICsKPiA+ICsg
ICAgaW9jdGwoZmQsIFNVU1BFTkRfQkxPQ0tFUl9JT0NUTF9CTE9DSyk7Cj4gPiArCj4gPiArVG8g
ZGVhY3RpdmF0ZSBpdCBjYWxsOgo+ID4gKwo+ID4gKyAgICBpb2N0bChmZCwgU1VTUEVORF9CTE9D
S0VSX0lPQ1RMX1VOQkxPQ0spOwo+ID4gKwo+ID4gK1RvIGRlc3Ryb3kgdGhlIHN1c3BlbmQgYmxv
Y2tlciwgY2xvc2UgdGhlIGRldmljZToKPiA+ICsKPiA+ICsgICAgY2xvc2UoZmQpOwo+IAo+IFVy
Z2gsIHBsZWFzZSBsZXQgdGhlIG9wZW4oKSBiZSBCTE9DSywgdGhlIGNsb3NlKCkgYmUgVU5CTE9D
SywgYW5kIGtlZXAKPiB0aGUgU0VUX05BTUUgdGhpbmcgaWYgeW91IHJlYWxseSBjYXJlLgoKU0VU
X05BTUUgd291bGRuJ3Qgc2VydmUgYW55IHB1cnBvc2UgaW4gdGhhdCBjYXNlLgoKVGhpcyB3aG9s
ZSB0aGluZyBpcyByZWxhdGVkIHRvIHRoZSBzdGF0aXN0aWNzIHBhcnQsIHdoaWNoIEFydmUgc2F5
cyBpcwplc3NlbnRpYWwgdG8gaGltLiAgSGUgd2FudHMgdG8gY29sbGVjdCBzdGF0aXN0aWNzIGZv
ciBlYWNoIHN1c3BlbmQgYmxvY2tlcgphY3RpdmF0ZWQgYW5kIGRlYWN0aXZhdGVkIHNvIHRoYXQg
aGUgY2FuIHRlbGwgd2hvJ3MgY2F1c2luZyBwcm9ibGVtcyBieQpibG9ja2luZyBzdXNwZW5kIHRv
byBvZnRlbi4gIFRoZSBuYW1lIGFsc28gaXMgYSBwYXJ0IG9mIHRoaXMuCgpJbiBmYWN0LCB3aXRo
b3V0IHRoZSBzdGF0aXN0aWNzIHBhcnQgdGhlIHdob2xlIHRoaW5nIG1pZ2h0IGJlIGltcGxlbWVu
dGVkCmFzIGEgc2luZ2xlIHJlZmVyZW5jZSBjb3VudGVyIHN1Y2ggdGhhdCBzdXNwZW5kIHdvdWxk
IGhhcHBlbiB3aGVuIGl0IHdlbnQgZG93bgp0byB6ZXJvLgoKVGhhbmtzLApSYWZhZWwKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGlu
ZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
