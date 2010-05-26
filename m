From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Wed, 26 May 2010 10:43:48 +0200
Message-ID: <1274863428.5882.4860.camel__23297.4764462144$1274863791$gmane$org@twins>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<1274482015-30899-2-git-send-email-arve@android.com>
	<1274482015-30899-3-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274482015-30899-3-git-send-email-arve@android.com>
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

T24gRnJpLCAyMDEwLTA1LTIxIGF0IDE1OjQ2IC0wNzAwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+ICtUbyBjcmVhdGUgYSBzdXNwZW5kIGJsb2NrZXIgZnJvbSB1c2VyIHNwYWNlLCBvcGVuIHRo
ZSBzdXNwZW5kX2Jsb2NrZXIKPiBzcGVjaWFsCj4gK2RldmljZSBmaWxlOgo+ICsKPiArICAgIGZk
ID0gb3BlbigiL2Rldi9zdXNwZW5kX2Jsb2NrZXIiLCBPX1JEV1IgfCBPX0NMT0VYRUMpOwo+ICsK
PiArdGhlbiBvcHRpb25hbGx5IGNhbGw6Cj4gKwo+ICsgICAgaW9jdGwoZmQsIFNVU1BFTkRfQkxP
Q0tFUl9JT0NUTF9TRVRfTkFNRShzdHJsZW4obmFtZSkpLCBuYW1lKTsKPiArCj4gK1RvIGFjdGl2
YXRlIHRoZSBzdXNwZW5kIGJsb2NrZXIgY2FsbDoKPiArCj4gKyAgICBpb2N0bChmZCwgU1VTUEVO
RF9CTE9DS0VSX0lPQ1RMX0JMT0NLKTsKPiArCj4gK1RvIGRlYWN0aXZhdGUgaXQgY2FsbDoKPiAr
Cj4gKyAgICBpb2N0bChmZCwgU1VTUEVORF9CTE9DS0VSX0lPQ1RMX1VOQkxPQ0spOwo+ICsKPiAr
VG8gZGVzdHJveSB0aGUgc3VzcGVuZCBibG9ja2VyLCBjbG9zZSB0aGUgZGV2aWNlOgo+ICsKPiAr
ICAgIGNsb3NlKGZkKTsKClVyZ2gsIHBsZWFzZSBsZXQgdGhlIG9wZW4oKSBiZSBCTE9DSywgdGhl
IGNsb3NlKCkgYmUgVU5CTE9DSywgYW5kIGtlZXAKdGhlIFNFVF9OQU1FIHRoaW5nIGlmIHlvdSBy
ZWFsbHkgY2FyZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtcG0=
