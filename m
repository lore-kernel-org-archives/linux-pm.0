From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] PCI: add prefetch quirk to work around
 Asus/Nvidia suspend issues
Date: Mon, 3 Sep 2018 15:12:09 +0300
Message-ID: <20180903121209.GC2283@lahna.fi.intel.com>
References: <20180831073057.14626-1-drake@endlessm.com>
 <20180831191225.GA43106@bhelgaas-glaptop.roam.corp.google.com>
 <CAD8Lp45CKCHxTg91zF9bWztqbAwLzgAUpNEHQ6ouKu2PkJT8SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD8Lp45CKCHxTg91zF9bWztqbAwLzgAUpNEHQ6ouKu2PkJT8SQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Cc: Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Jon Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBTZXAgMDMsIDIwMTggYXQgMDQ6NTY6MzJQTSArMDgwMCwgRGFuaWVsIERyYWtlIHdy
b3RlOgo+IE9uIFNhdCwgU2VwIDEsIDIwMTggYXQgMzoxMiBBTSwgQmpvcm4gSGVsZ2FhcyA8aGVs
Z2Fhc0BrZXJuZWwub3JnPiB3cm90ZToKPiA+IElmIHRydWUsIHRoaXMgc291bmRzIGxpa2Ugc29t
ZSBzb3J0IG9mIGVycmF0dW0sIHNvIGl0IHdvdWxkIGJlIGdvb2QgdG8KPiA+IGdldCBzb21lIGlu
cHV0IGZyb20gSW50ZWwsIGFuZCBJIGNjJ2QgYSBmZXcgSW50ZWwgZm9sa3MuCj4gCj4gWWVzLCBp
dCB3b3VsZCBiZSBncmVhdCB0byBnZXQgdGhlaXIgaW5wdXQuCgpXZSBoYXZlIHNlZW4gb25lIHNp
bWlsYXIgaXNzdWUgd2l0aCBMUFNTIGRldmljZXMgd2hlbiBCSU9TIGFzc2lnbnMKZGV2aWNlIEJB
UnMgYWJvdmUgNEcgKHdoaWNoIGlzIG5vdCB0aGUgY2FzZSBoZXJlKSBhbmQgaXQgdHVybmVkIG91
dCB0bwpiZSBtaXNjb25maWd1cmVkIE1UUlIgcmVnaXN0ZXIgb3Igc29tZXRoaW5nIGxpa2UgdGhh
dC4gSXQgbWF5IG5vdCBiZQpyZWxhdGVkIGF0IGFsbCBidXQgaXQgY291bGQgYmUgd29ydGggYSB0
cnkgdG8gZHVtcCBvdXQgTVRSUiByZWdpc3RlcnMgb2YKb25lIG9mIHRoZSBhZmZlY3RlZCBzeXN0
ZW1zIGFuZCBzZWUgaWYgdGhlIG1lbW9yeSBhcmVhcyBhcmUgbGlzdGVkIHRoZXJlCihhbmQgaWYg
dGhlIGF0dHJpYnV0ZXMgYXJlIHNvbWVob3cgd3JvbmcgaWYgZm91bmQpLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpOb3V2ZWF1IG1haWxpbmcgbGlzdApO
b3V2ZWF1QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL25vdXZlYXUK
