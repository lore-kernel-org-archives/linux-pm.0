From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Wed, 26 May 2010 12:50:05 +0200
Message-ID: <1274871005.5882.5315.camel__17597.5412632853$1274871240$gmane$org@twins>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<1274482015-30899-2-git-send-email-arve@android.com>
	<1274482015-30899-3-git-send-email-arve@android.com>
	<1274863428.5882.4860.camel@twins>
	<AANLkTimTnzK1ByG2bE2gGjINxD_Pbvez7PFHo7Kzo9yk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimTnzK1ByG2bE2gGjINxD_Pbvez7PFHo7Kzo9yk@mail.gmail.com>
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
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCAyMDEwLTA1LTI2IGF0IDAzOjQ3IC0wNzAwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+IDIwMTAvNS8yNiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+Ogo+ID4g
T24gRnJpLCAyMDEwLTA1LTIxIGF0IDE1OjQ2IC0wNzAwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+ID4+ICtUbyBjcmVhdGUgYSBzdXNwZW5kIGJsb2NrZXIgZnJvbSB1c2VyIHNwYWNlLCBvcGVu
IHRoZSBzdXNwZW5kX2Jsb2NrZXIKPiA+PiBzcGVjaWFsCj4gPj4gK2RldmljZSBmaWxlOgo+ID4+
ICsKPiA+PiArICAgIGZkID0gb3BlbigiL2Rldi9zdXNwZW5kX2Jsb2NrZXIiLCBPX1JEV1IgfCBP
X0NMT0VYRUMpOwo+ID4+ICsKPiA+PiArdGhlbiBvcHRpb25hbGx5IGNhbGw6Cj4gPj4gKwo+ID4+
ICsgICAgaW9jdGwoZmQsIFNVU1BFTkRfQkxPQ0tFUl9JT0NUTF9TRVRfTkFNRShzdHJsZW4obmFt
ZSkpLCBuYW1lKTsKPiA+PiArCj4gPj4gK1RvIGFjdGl2YXRlIHRoZSBzdXNwZW5kIGJsb2NrZXIg
Y2FsbDoKPiA+PiArCj4gPj4gKyAgICBpb2N0bChmZCwgU1VTUEVORF9CTE9DS0VSX0lPQ1RMX0JM
T0NLKTsKPiA+PiArCj4gPj4gK1RvIGRlYWN0aXZhdGUgaXQgY2FsbDoKPiA+PiArCj4gPj4gKyAg
ICBpb2N0bChmZCwgU1VTUEVORF9CTE9DS0VSX0lPQ1RMX1VOQkxPQ0spOwo+ID4+ICsKPiA+PiAr
VG8gZGVzdHJveSB0aGUgc3VzcGVuZCBibG9ja2VyLCBjbG9zZSB0aGUgZGV2aWNlOgo+ID4+ICsK
PiA+PiArICAgIGNsb3NlKGZkKTsKPiA+Cj4gPiBVcmdoLCBwbGVhc2UgbGV0IHRoZSBvcGVuKCkg
YmUgQkxPQ0ssIHRoZSBjbG9zZSgpIGJlIFVOQkxPQ0ssIGFuZCBrZWVwCj4gPiB0aGUgU0VUX05B
TUUgdGhpbmcgaWYgeW91IHJlYWxseSBjYXJlLgo+ID4KPiAKPiBUaGF0IHdvdWxkIGJlIHZlcnkg
aW5lZmZpY2llbnQuCgpIb3cgc28/IEFueXdheSwgc2luY2UgeW91IGFkbWl0dGVkIHRoaXMgdGhp
bmcgaXNuJ3QgbmVlZGVkIGF0IGFsbCwgSSBzYXkKd2UgcmVtb3ZlIGl0IGFsdG9nZXRoZXIuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1h
aWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
