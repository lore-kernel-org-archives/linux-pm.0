From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/9] GPU-bound energy efficiency
 improvements for the intel_pstate driver.
Date: Sat, 14 Apr 2018 11:49:43 +0200
Message-ID: <20180414094943.GU4064@hirez.programming.kicks-ass.net>
References: <87604ybssf.fsf@riseup.net>
 <1523416474.2700.2.camel@linux.intel.com>
 <87vacx7mh3.fsf@riseup.net> <87muy97lr0.fsf@riseup.net>
 <20180412085824.GX4082@hirez.programming.kicks-ass.net>
 <87r2nk46k1.fsf@riseup.net>
 <20180412193335.GA4330@worktop.programming.kicks-ass.net>
 <87a7u842tg.fsf@riseup.net>
 <20180413181537.GS4064@hirez.programming.kicks-ass.net>
 <87d0z21re4.fsf@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <87d0z21re4.fsf@riseup.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Francisco Jerez <currojerez@riseup.net>
Cc: intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eero Tamminen <eero.t.tamminen@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

T24gRnJpLCBBcHIgMTMsIDIwMTggYXQgMDY6NTc6MzlQTSAtMDcwMCwgRnJhbmNpc2NvIEplcmV6
IHdyb3RlOgo+IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JpdGVzOgo+
IAo+ID4gT24gVGh1LCBBcHIgMTIsIDIwMTggYXQgMTI6NTU6MzlQTSAtMDcwMCwgRnJhbmNpc2Nv
IEplcmV6IHdyb3RlOgo+ID4+IEFjdHVhbGx5IGFzc3VtaW5nIHRoYXQgYSBzaW5nbGUgZ2VvbWV0
cmljIGZlYXR1cmUgb2YgdGhlIHBvd2VyIGN1cnZlIGlzCj4gPj4ga25vd24gLS0gaXQgYmVpbmcg
Y29udmV4IGluIHRoZSBmcmVxdWVuY3kgcmFuZ2UgYWxsb3dlZCBieSB0aGUgcG9saWN5Cj4gPj4g
KHdoaWNoIGlzIGFsbW9zdCBhbHdheXMgdGhlIGNhc2UsIG5vdCBvbmx5IGZvciBJbnRlbCBDUFVz
KSwgdGhlIG9wdGltYWwKPiA+PiBmcmVxdWVuY3kgZm9yIGFuIElPLWJvdW5kIHdvcmtsb2FkIGlz
IGZ1bGx5IGluZGVwZW5kZW50IG9mIHRoZSBleGFjdAo+ID4+IHBvd2VyIGN1cnZlIC0tIEl0J3Mg
anVzdCB0aGUgbWluaW11bSBDUFUgZnJlcXVlbmN5IHRoYXQncyBhYmxlIHRvIGtlZXAKPiA+PiB0
aGUgYm90dGxlbmVja2luZyBJTyBkZXZpY2UgYXQgMTAwJSB1dGlsaXphdGlvbi4gCj4gPgo+ID4g
SSB0aGluayB0aGF0IGlzIGRpZmZpY3VsdCB0byBkZXRlcm1pbmUgd2l0aCB0aGUgaW5mb3JtYXRp
b24gYXQgaGFuZC4gV2UKPiA+IGhhdmUgbG9zdCBhbGwgZGV2aWNlIGluZm9ybWF0aW9uIGJ5IHRo
ZSB0aW1lIHdlIHJlYWNoIHRoZSBzY2hlZHVsZXIuCj4gCj4gSSBhc3N1bWUgeW91IG1lYW4gaXQn
cyBkaWZmaWN1bHQgdG8gdGVsbCB3aGV0aGVyIHRoZSB3b3JrbG9hZCBpcwo+IENQVS1ib3VuZCBv
ciBJTy1ib3VuZD8gIFllYWgsIGl0J3Mgbm9uLXRyaXZpYWwgdG8gZGV0ZXJtaW5lIHdoZXRoZXIg
dGhlCj4gc3lzdGVtIGlzIGJvdHRsZW5lY2tpbmcgb24gSU8sIGl0IHJlcXVpcmVzIGFkZGl0aW9u
YWwgaW5mcmFzdHJ1Y3R1cmUgdG8KPiBrZWVwIHRyYWNrIG9mIElPIHV0aWxpemF0aW9uICh0aGF0
J3MgdGhlIHB1cnBvc2Ugb2YgUEFUQ0ggMSksIGFuZCBldmVuCgpOb3RlIHRoYXQgSSd2ZSBub3Qg
YWN0dWFsbHkgc2VlbiBhbnkgb2YgeW91ciBwYXRjaGVzOyBJIGdvdCBDYydlZCBvbgpsYXRlci4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdm
eCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
