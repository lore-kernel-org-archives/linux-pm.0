From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 02:49:16 -0700
Message-ID: <AANLkTinyVDKriOrSAVV36vwC8Uy26F5WFoNJBv19va5c__4408.26736526123$1274867490$gmane$org@mail.gmail.com>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005242049.18920.rjw@sisk.pl>
	<87wrusvrqe.fsf@deeprootsystems.com>
	<201005250138.16293.rjw@sisk.pl> <1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274867106.5882.5090.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCBNYXkgMjYsIDIwMTAgYXQgMjo0NSBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPiBPbiBXZWQsIDIwMTAtMDUtMjYgYXQgMDI6NDEgLTA3MDAs
IEFydmUgSGrDuG5uZXbDpWcgd3JvdGU6Cj4+IE9uIFdlZCwgTWF5IDI2LCAyMDEwIGF0IDE6NDcg
QU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4+ID4gT24g
VHVlLCAyMDEwLTA1LTI1IGF0IDAxOjM4ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToK
Pj4gPj4gPiBUaGlzIG9mIGNvdXJzZSB3aWxsIGxlYWQgdG8gYSBzY2F0dGVyaW5nIG9mIHN1c3Bl
bmQgYmxvY2tlcnMgaW50byBhbnkKPj4gPj4gPiBkcml2ZXJzL3N1YnN5c3RlbXMgY29uc2lkZXJl
ZCAidXNlZnVsIiwgd2hpY2ggYnkgbG9va2luZyB0aHJvdWdoIGN1cnJlbnQKPj4gPj4gPiBBbmRy
b2lkIGtlcm5lbHMgaXMgbWFueSBvZiB0aGVtLgo+PiA+Pgo+PiA+PiBUaGF0IGRlcGVuZHMgb24g
dGhlIG1haW50YWluZXJzIG9mIHRoZXNlIHN1YnN5c3RlbXMsIHdobyBzdGlsbCBoYXZlIHRoZSBw
b3dlcgo+PiA+PiB0byByZWplY3QgcmVxdWVzdGVkIGNoYW5nZXMuCj4+ID4KPj4gPiBTbyBhcyBh
IHNjaGVkdWxlciBtYWludGFpbmVyIEknbSBnb2luZyB0byBtZXJnZSBhIHBhdGNoIHRoYXQgZG9l
cyBhCj4+ID4gc3VzcGVuZF9ibG9ja2VyIHdoZW4gdGhlIHJ1bnF1ZXVlJ3MgYXJlbid0IGVtcHR5
Li4uIGhvdyBhYm91dCB0aGF0Pwo+PiA+Cj4+Cj4+IEkgZG9uJ3Qga25vdyBpZiB5b3UgYXJlIHNl
cmlvdXMsIHNpbmNlIHRoZSBhbGwgdGhlIHJ1bnF1ZXVlcyBhcmUgbmV2ZXIKPj4gZW1wdHkgd2hp
bGUgc3VzcGVuZGluZywgdGhpcyB3b3VsZCBkaXNhYmxlIG9wcG9ydHVuaXN0aWMgc3VzcGVuZAo+
PiBhbHRvZ2V0aGVyLgo+Cj4gU28gd2h5IGFnYWluIHdhcyB0aGlzIHN1Y2ggYSBncmVhdCBzY2hl
bWU/IEdvIGZpeCB5b3VyIHVzZXJzcGFjZSB0byBub3QKPiBub3QgcnVuIHdoZW4gbm90IG5lZWRl
ZC4KCgpUaGFua3MgZm9yIHlvdXIgY29uc3RydWN0aXZlIGZlZWRiYWNrLgoKQnJpYW4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGlu
ZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
