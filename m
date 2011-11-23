From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/6] OMAP3: cpuidle: next C-state decision
	depends on the PM QoS MPU and CORE constraints
Date: Wed, 23 Nov 2011 11:43:49 -0800
Message-ID: <877h2qbp56.fsf__44411.9401429363$1322500062$gmane$org@ti.com>
References: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
	<1319032263-22699-5-git-send-email-j-pihet@ti.com>
	<877h2y30a5.fsf@ti.com>
	<CAORVsuV5bV-p0kxhh8g4T076Dg3Mj89X_=4E+BpCSTdLiUmNZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAORVsuV5bV-p0kxhh8g4T076Dg3Mj89X_=4E+BpCSTdLiUmNZA@mail.gmail.com>
	(Jean Pihet's message of "Tue, 22 Nov 2011 20:54:14 +0100")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

SmVhbiBQaWhldCA8amVhbi5waWhldEBuZXdvbGRiaXRzLmNvbT4gd3JpdGVzOgoKPiBPbiBUaHUs
IE5vdiAxNywgMjAxMSBhdCAxMDoyOSBQTSwgS2V2aW4gSGlsbWFuIDxraGlsbWFuQHRpLmNvbT4g
d3JvdGU6Cj4+IGplYW4ucGloZXRAbmV3b2xkYml0cy5jb20gd3JpdGVzOgo+Pgo+Pj4gRnJvbTog
SmVhbiBQaWhldCA8ai1waWhldEB0aS5jb20+Cj4+Pgo+Pj4gVGhlIE1QVSBsYXRlbmN5IGZpZ3Vy
ZXMgZm9yIGNwdWlkbGUgaW5jbHVkZSB0aGUgTVBVIGl0c2VsZiBhbmQgYWxzbwo+Pj4gdGhlIHBl
cmlwaGVyYWxzIG5lZWRlZCBmb3IgdGhlIE1QVSB0byBleGVjdXRlIGluc3RydWN0aW9ucyAoZS5n
Lgo+Pj4gbWFpbiBtZW1vcnksIGNhY2hlcywgSVJRIGNvbnRyb2xsZXIsIE1NVSBldGMpLiBPbiBP
TUFQMyB0aG9zZQo+Pj4gcGVyaXBoZXJhbHMgYmVsb25nIHRvIHRoZSBNUFUgYW5kIENPUkUgcG93
ZXIgZG9tYWlucyBhbmQgc28gdGhlCj4+PiBjcHVpZGxlIEMtc3RhdGVzIGFyZSBhIGNvbWJpbmF0
aW9uIG9mIE1QVSBhbmQgQ09SRSBzdGF0ZXMuCj4+Pgo+Pj4gVGhpcyBwYXRjaCBpbXBsZW1lbnRz
IHRoZSByZWxhdGlvbiBiZXR3ZWVuIHRoZSBjcHVpZGxlIGFuZCBwZXItCj4+PiBkZXZpY2UgUE0g
UW9TIGZyYW1ld29ya3MgaW4gdGhlIE9NQVAzIHNwZWNpZmljIGlkbGUgY2FsbGJhY2tzLgo+Pj4K
Pj4+IFRoZSBjaG9zZW4gQy1zdGF0ZSBzaGFsbCBzYXRpc2Z5IHRoZSBmb2xsb3dpbmcgY29uZGl0
aW9uczoKPj4+IMKgLiB0aGUgJ3ZhbGlkJyBmaWVsZCBpcyBlbmFibGVkLAo+Pj4gwqAuIGl0IHNh
dGlzZmllcyB0aGUgZW5hYmxlX29mZl9tb2RlIGZsYWcsCj4+Cj4+IE5vdCBkaXJlY3RseSByZWxh
dGVkIHRvIHRoaXMgcGF0Y2gsIGJ1dCBpcyB0aGVyZSBhbnkgcmVhc29uIHRvIGtlZXAgdGhlCj4+
ICdlbmFibGVfb2ZmX21vZGUnIGZsYWcgYWZ0ZXIgdGhpcyBzZXJpZXM/Cj4gZW5hYmxlX29mZl9t
b2RlIGNvdWxkIGJlIHJlbW92ZWQgY29tcGxldGVseSBhZnRlciB0aGlzIHNlcmllcyB1bmxlc3MK
PiB0aGVyZSBpcyBhIG5lZWQgdG8gcHJldmVudCBPRkYgbW9kZSBmb3IgZGVidWcgcmVhc29ucy4K
CkdyZWF0LgoKRm9yIGRlYnVnIHJlYXNvbnMsIHdlIGNhbiBqdXN0IGFzIGVhc2lseSBzZXQgY29u
c3RyYWludHMgdG8gcHJldmVudCBvZmYKbW9kZSwgc28gSSB3b3VsZCBsaWtlIHRvIHNlZSBpdCBk
aXNhcHBlYXIuCgpLZXZpbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXBt
