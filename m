From: Greg KH <greg@kroah.com>
Subject: Re: linux-next: suspend tree build warnings
Date: Wed, 19 Aug 2009 16:36:01 -0700
Message-ID: <20090819233601.GA2875__28029.1492156268$1250725390$gmane$org@kroah.com>
References: <20090819172419.2cf53008.sfr@canb.auug.org.au>
	<200908192338.03910.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908192338.03910.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-next@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, linux-media@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCBBdWcgMTksIDIwMDkgYXQgMTE6Mzg6MDNQTSArMDIwMCwgUmFmYWVsIEouIFd5c29j
a2kgd3JvdGU6Cj4gT24gV2VkbmVzZGF5IDE5IEF1Z3VzdCAyMDA5LCBTdGVwaGVuIFJvdGh3ZWxs
IHdyb3RlOgo+ID4gSGkgUmFmYWVsLAo+IAo+IEhpLAo+IAo+ID4gVG9kYXkncyBsaW51eC1uZXh0
IGJ1aWxkICh4ODZfNjQgYWxsbW9kY29uZmlnKSBwcm9kdWNlZCB0aGVzZSB3YXJuaW5nczoKPiA+
IAo+ID4gZHJpdmVycy9tZWRpYS9kdmIvZnJvbnRlbmRzL2RpYjcwMDBwLmM6IEluIGZ1bmN0aW9u
IOKAmGRpYjcwMDBwX2kyY19lbnVtZXJhdGlvbuKAmToKPiA+IGRyaXZlcnMvbWVkaWEvZHZiL2Zy
b250ZW5kcy9kaWI3MDAwcC5jOjEzMTU6IHdhcm5pbmc6IHRoZSBmcmFtZSBzaXplIG9mIDIyNTYg
Ynl0ZXMgaXMgbGFyZ2VyIHRoYW4gMjA0OCBieXRlcwo+ID4gZHJpdmVycy9tZWRpYS9kdmIvZnJv
bnRlbmRzL2RpYjMwMDBtYy5jOiBJbiBmdW5jdGlvbiDigJhkaWIzMDAwbWNfaTJjX2VudW1lcmF0
aW9u4oCZOgo+ID4gZHJpdmVycy9tZWRpYS9kdmIvZnJvbnRlbmRzL2RpYjMwMDBtYy5jOjg1Mzog
d2FybmluZzogdGhlIGZyYW1lIHNpemUgb2YgMjE2MCBieXRlcyBpcyBsYXJnZXIgdGhhbiAyMDQ4
IGJ5dGVzCj4gPiAKPiA+IEludHJvZHVjZWQgYnkgY29tbWl0IDk5MzA3OTU4Y2M5YzFiMGIyZTBk
YWQ0YmJlZmRhZmFmOWFjNWE2ODEgKCJQTToKPiA+IEludHJvZHVjZSBjb3JlIGZyYW1ld29yayBm
b3IgcnVuLXRpbWUgUE0gb2YgSS9PIGRldmljZXMgKHJldi4gMTcpIikuCj4gCj4gV2VsbC4KPiAK
PiBUaGlzIGNvbW1pdCBpbmNyZWFzZXMgdGhlIHNpemUgb2Ygc3RydWN0IGRldmljZSBxdWl0ZSBh
IGJpdCBhbmQgYm90aCBvZiB0aGUKPiBkcml2ZXJzIGFib3ZlIGNyZWF0ZSBhICJzdGF0ZSIgb2Jq
ZWN0IG9uIHRoZSBzdGFjayB0aGF0IGNvbnRhaW5zIHN0cnVjdCBkZXZpY2UKPiBhbW9uZyBvdGhl
ciB0aGluZ3MuCgpJY2suICBzdHJ1Y3QgZGV2aWNlIHNob3VsZCBfbmV2ZXJfIGJlIG9uIHRoZSBz
dGFjaywgd2h5IHdvdWxkIHRoaXMgY29kZQp3YW50IHRvIGRvIHN1Y2ggYSB0aGluZz8KCnRoYW5r
cywKCmdyZWcgay1oCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtcG0=
