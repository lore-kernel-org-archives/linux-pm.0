From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch update 2 fix] PM: Introduce core framework
 for run-time PM of I/O devices
Date: Mon, 22 Jun 2009 06:49:15 -0700
Message-ID: <20090622064915.741154a7__6443.66077981449$1245678588$gmane$org@infradead.org>
References: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org>
	<Pine.LNX.4.44L0.0906201010590.12994-100000@netrider.rowland.org>
	<aec7e5c30906212320v3e3e991fyd028d005675f1e25@mail.gmail.com>
	<20090621234324.06fda564@infradead.org>
	<aec7e5c30906220027v63c88e8aj32950a8d84558cce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30906220027v63c88e8aj32950a8d84558cce@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCAyMiBKdW4gMjAwOSAxNjoyNzoyOSArMDkwMApNYWdudXMgRGFtbSA8bWFnbnVzLmRh
bW1AZ21haWwuY29tPiB3cm90ZToKCj4gT24gTW9uLCBKdW4gMjIsIDIwMDkgYXQgMzo0MyBQTSwg
QXJqYW4gdmFuIGRlCj4gVmVuPGFyamFuQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+ID4gT24gTW9u
LCAyMiBKdW4gMjAwOSAxNToyMDo0MyArMDkwMAo+ID4gTWFnbnVzIERhbW0gPG1hZ251cy5kYW1t
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4+IE9uIFNhdCwgSnVuIDIwLCAyMDA5IGF0IDExOjMw
IFBNLCBBbGFuCj4gPj4gU3Rlcm48c3Rlcm5Acm93bGFuZC5oYXJ2YXJkLmVkdT4gd3JvdGU6Cj4g
Pj4gPiBTb21lIG1vcmUgdGhvdWdodHMuLi4KPiA+PiA+Cj4gPj4gPiBNYWdudXMsIHlvdSBtaWdo
dCBoYXZlIHNvbWUgaW5zaWdodHMgaGVyZS4gwqBJdCBvY2N1cnJlZCB0byBtZQo+ID4+ID4gdGhh
dCBzb21lIGRldmljZXMgY2FuIHN3aXRjaCBwb3dlciBsZXZlbHMgdmVyeSBxdWlja2x5LCBhbmQg
dGhlCj4gPj4gPiBkcml2ZXJzIG1pZ2h0IHRoZXJlZm9yZSB3YW50IHRoZSBydW50aW1lIHN1c3Bl
bmQgYW5kIHJlc3VtZQo+ID4+ID4gbWV0aG9kcyB0byBiZSBjYWxsZWQgYXMgc29vbiBhcyBwb3Nz
aWJsZSwgZXZlbiBpbiBpbnRlcnJ1cHQKPiA+PiA+IGNvbnRleHQuCj4gPj4KPiA+PiBJJ2QgbGlr
ZSB0byBjYWxsIHBtX3JlcXVlc3Rfc3VzcGVuZCgpIGZyb20gaW50ZXJydXB0IGNvbnRleHQuIEkK
PiA+PiBkb24ndAo+ID4KPiA+IHRoZXJlIGFyZSBzb21lIHJlYWxseSBzdHJvbmcgcmVhc29ucyB0
byBhdCBsZWFzdCBiZSBhYmxlIHRvIGNhbGwgdGhlCj4gPiByZXN1bWUgZnVuY3Rpb24gZnJvbSBh
biBpbnRlcnJ1cHQgaGFuZGxlci4uLi4gc2hhcmVkIGludGVycnVwdHMgYXJlCj4gPiBvbmUgb2Yg
dGhlbS4KPiAKPiBJIHN1cHBvc2UgeW91IG1lYW4gdGhhdCB5b3UgbmVlZCB0byByZXN1bWUgdGhl
IGhhcmR3YXJlIGRldmljZSBiZWZvcmUKPiB5b3UgY2FuIGNoZWNrIGlmIGl0IGhhcyBhIHBlbmRp
bmcgaW50ZXJydXB0IHNvdXJjZT8gSWYgc28gdGhlbiB5b3UKPiBhbHNvIG1lYW4gdGhhdCBzdXNw
ZW5kZWQgaGFyZHdhcmUgZGV2aWNlcyBtYXkgZ2VuZXJhdGUgaW50ZXJydXB0cywgbm8/Cgp5ZXMg
YW5kIG5vLiBGb3IgdGhlIHNoYXJlZCBpbnRlcnJ1cHQgY2FzZS4uIG5vLgpidXQgeWVzIGZvciB0
aGUgaHcgSSBoYXZlIGluIG1pbmQgKGFuZCBvbiBteSBkZXNrIDstKSB0aGF0IGNhbiBoYXBwZW4K
YXMgd2VsbCBmcm9tIHRoZSBkZXZpY2UgaXRzZWxmLgoKLS0gCkFyamFuIHZhbiBkZSBWZW4gCUlu
dGVsIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudHJlCkZvciBkZXZlbG9wbWVudCwgZGlzY3Vz
c2lvbiBhbmQgdGlwcyBmb3IgcG93ZXIgc2F2aW5ncywgCnZpc2l0IGh0dHA6Ly93d3cubGVzc3dh
dHRzLm9yZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LXBt
