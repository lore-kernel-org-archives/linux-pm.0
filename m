From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [RFC 1/2] PM / Domains: Power on domain early during system resume
Date: Thu, 30 Oct 2014 12:01:35 +0100
Message-ID: <54521A8F.5070808@samsung.com>
References: <1414072090-11293-1-git-send-email-k.kozlowski@samsung.com>
 <1414072090-11293-2-git-send-email-k.kozlowski@samsung.com>
 <7hk33iahvu.fsf@deeprootsystems.com> <1414654594.5114.8.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-reply-to: <1414654594.5114.8.camel@AMDC1943>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kevin Hilman <khilman@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

T24gMTAvMzAvMjAxNCAwODozNiBBTSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToKPiBPbiDF
m3JvLCAyMDE0LTEwLTI5IGF0IDEwOjQ2IC0wNzAwLCBLZXZpbiBIaWxtYW4gd3JvdGU6Cj4+IEty
enlzenRvZiBLb3psb3dza2kgPGsua296bG93c2tpQHNhbXN1bmcuY29tPiB3cml0ZXM6Cj4+Cj4+
PiBXaGVuIHJlc3VtaW5nIHRoZSBzeXN0ZW0gdGhlIHBvd2VyIGRvbWFpbiBoYXMgdG8gYmUgcG93
ZXJlZCBvbiBlYXJseSBzbwo+Pj4gYW55IHJ1bnRpbWUgUE0gYXdhcmUgZGV2aWNlcyBjb3VsZCBy
ZXN1bWUuCj4+Pgo+Pj4gVGhpcyBmaXhlcyBmb2xsb3dpbmcgc2NlbmFyaW8gcmVwcm9kdWNlZCBv
biBFeHlub3MgRFJNOgo+Pj4gMS4gUG93ZXIgZG9tYWluIGlzIG9mZiBiZWZvcmUgc3VzcGVuZGlu
ZyB0aGUgc3lzdGVtLgo+Pj4gMi4gU3lzdGVtIGlzIHN1c3BlbmRlZCB0byBSQU0uCj4+PiAzLiBS
ZXN1bWluZyBzdGFydHMuIFRoZSBFeHlub3MgRFJNIGRyaXZlciByZXN1bWUgY2FsbGJhY2sgaXMg
Y2FsbGVkLgo+Pj4gNC4gVGhlIEV4eW5vcyBEUk0gZHJpdmVyIGNhbGxzIGRybV9oZWxwZXJfcmVz
dW1lX2ZvcmNlX21vZGUgd2hpY2ggdHVybnMKPj4+ICAgIHRoZSBzY3JlZW4gb24gYnkgY2FsbGlu
ZyBleHlub3NfZHNpX2RwbXMgd2l0aCBEUk1fTU9ERV9EUE1TX09OLgo+PiBEdW1iIFE6IGlmIHRo
ZSBkZXZpY2UgKGFuZCBwb3dlciBkb21haW4pIHdlcmUgb2ZmIGJlZm9yZSAoYW5kIGR1cmluZykK
Pj4gc3VzcGVuZCwgd2h5IGFyZSB0aGV5IGJlaW5nIHJlc3VtZWQ/Cj4+Cj4+IFNob3VsZG4ndCB0
aGUgcmVzdW1lIHBhdGggcmVzdG9yZSB0aGluZ3MgdG8gdGhlIHNhbWUgc3RhdGUgdGhleSB3ZXJl
Cj4+IGJlZm9yZSBzdXNwZW5kPwo+IE9uZSBjb3VsZCBleHBlY3QgdGhhdC4uLiBidXQgdGhlIEV4
eW5vcyBEUk0gZHJpdmVyIGJlaGF2ZXMgZGlmZmVyZW50bHkKPiAoYW5kIHNvbWUgb3RoZXIgZHJp
dmVycyBhbHNvKS4gSW4gcmVzdW1lIG1ldGhvZCBpdCBjYWxscwo+IGRybV9oZWxwZXJfcmVzdW1l
X2ZvcmNlX21vZGUoKSB3aGljaCBmb3JjZXMgcmVzdG9yaW5nIG1vZGUgc2V0dGluZwo+IGNvbmZp
Z3VyYXRpb24uIEFwcGFyZW50bHkgc2V0dGluZyBhIG1vZGUgbmVlZHMgRFBNUyBvbjoKPiBzdGF0
aWMgdm9pZCBleHlub3NfZHJtX2NydGNfY29tbWl0KHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKPiB7
Cj4gCS4uLgo+IAlleHlub3NfZHJtX2NydGNfZHBtcyhjcnRjLCBEUk1fTU9ERV9EUE1TX09OKTsK
PiAJLi4uCj4KPiBUaGUgcHJldmlvdXMgRFBNUyBzdGF0dXMgKHN0YXR1cyBkdXJpbmcgc3VzcGVu
ZCkgaXMgY29tcGxldGVseSBpZ25vcmVkCj4gaGVyZS4KClN1c3BlbmQgY2FsbGJhY2sgc3dpdGNo
ZXMgb2ZmIGFsbCBjb25uZWN0b3JzICh0aHVzIGFsbCBvdGhlciBkZXZzIGluCnRoZWlyIHBpcGVs
aW5lKSBieSBjYWxsaW5nIGRwbXNfb2ZmLAppbiByZXN0b3JlIGNhbGxiYWNrIGFsbCBkZXZzIGFy
ZSByZXN0b3JlZCB0byB0aGVpciBwcmV2aW91cyBzdGF0ZSBieQpjYWxsaW5nIGFwcHJvcHJpYXRl
IGRwbXMuClNvIEkgZ3Vlc3MgZHJtX2hlbHBlcl9yZXN1bWVfZm9yY2VfbW9kZSgpIGNhbGwgYXQg
dGhlIGVuZCBvZiByZXN1bWUgaXMKaW5jb3JyZWN0LgpPbiB0aGUgb3RoZXIgc2lkZSBpdCBpcyBw
cmVzZW50IGluIG1hbnkgb3RoZXIgZHJpdmVycywgc28gSSBhbSBhbHNvCmxpdHRsZSBiaXQgY29u
ZnVzZWQuCgpSZWdhcmRzCkFuZHJ6ZWoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2RyaS1kZXZlbAo=
