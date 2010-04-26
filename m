From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 5/9] PM: suspend_block: Add debugfs file
Date: Sun, 25 Apr 2010 23:24:46 -0700
Message-ID: <p2xa55d774e1004252324i4dca8cc3y1ffacec838c436f8__27582.6536737897$1272263160$gmane$org@mail.gmail.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<20100423135853.478af057.randy.dunlap@oracle.com>
	<20100425181517.GA22676@kroah.com> <4BD49D9D.7020004@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BD49D9D.7020004@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

T24gU3VuLCBBcHIgMjUsIDIwMTAgYXQgMTI6NTMgUE0sIFJhbmR5IER1bmxhcCA8cmFuZHkuZHVu
bGFwQG9yYWNsZS5jb20+IHdyb3RlOgo+IE9uIDA0LzI1LzEwIDExOjE1LCBHcmVnIEtIIHdyb3Rl
Ogo+PiBPbiBGcmksIEFwciAyMywgMjAxMCBhdCAwMTo1ODo1M1BNIC0wNzAwLCBSYW5keSBEdW5s
YXAgd3JvdGU6Cj4+PiBPbiBUaHUsIDIyIEFwciAyMDEwIDE4OjA4OjU0IC0wNzAwIEFydmUgSGo/
bm5ldj9nIHdyb3RlOgo+Pj4KPj4+PiBSZXBvcnQgYWN0aXZlIGFuZCBpbmFjdGl2ZSBzdXNwZW5k
IGJsb2NrZXJzIGluCj4+Pj4gL3N5cy9rZXJuZWwvZGVidWcvc3VzcGVuZF9ibG9ja2Vycy4KPj4+
Cj4+Pgo+Pj4gVGhpcyBsb29rcyBtb3JlIGxpa2UgdXNlciBpbnRlcmZhY2UgaW5mb3JtYXRpb24g
dGhhbiBpdCBkb2VzIGRlYnVnIGluZm9ybWF0aW9uLgo+Pj4gSWYgdGhhdCdzIGNvcnJlY3QsIGl0
IHNob3VsZG4ndCBiZSBpbiBkZWJ1Z2ZzLgo+Pgo+PiBJdCdzIGRlYnVnLWxpa2UgaW5mb3JtYXRp
b24sIGFuZCBoYXMgbW9yZSB0aGFuIG9uZSB2YWx1ZSBwZXIgZmlsZSwgc28KPj4gZGVidWdmcyBz
ZWVtcyBsaWtlIHRoZSBwcm9wZXIgcGxhY2UgZm9yIGl0LiDCoEkgaGF2ZSBubyBvYmplY3Rpb24g
dG8gaXQKPj4gZ29pbmcgdGhlcmUuCj4KPiBJIGhhdmUgbm8gb2JqZWN0aW9uIGlmIGl0IHJlYWxs
eSBpcyBkZWJ1ZyBpbmZvLCBidXQgSSdtIG5vdCBjb252aW5jZWQKPiBvZiB0aGF0IHlldC4KCk91
ciBtb3N0IGNvbW1vbiB1c2Ugb2YgdGhpcyBpbmZvcm1hdGlvbiBpcyB0byBjYXB0dXJlIGl0IGlu
IGJ1Z3JlcG9ydHMKKGFsb25nIHdpdGggcHJvY2VzcyBsaXN0cywgc3lzdGVtL3JhZGlvIGxvZ3Ms
IG1lbW9yeSBzdGF0cywgZXRjKSBhcwpvbmUgYWRkaXRpb25hbCBwaWVjZSBvZiBkYXRhIHVzZWQg
dG8gZGlhZ25vc2UgYSBtaXNiZWhhdmluZyBkZXZpY2UKKG1vc3QgY29tbW9ubHkgdG8gYW5zd2Vy
IHRoZSAid2h5IGRvZXMgdGhlIGJhdHRlcnkgc2VlbSB0byBiZSBkcmFpbmluZwp0b28gcXVpY2ts
eT8iIHF1ZXN0aW9uKS4KCkJyaWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtcG0=
