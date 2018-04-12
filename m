From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/9] GPU-bound energy efficiency
 improvements for the intel_pstate driver.
Date: Thu, 12 Apr 2018 21:33:35 +0200
Message-ID: <20180412193335.GA4330@worktop.programming.kicks-ass.net>
References: <20180328063845.4884-1-currojerez@riseup.net>
 <87604ybssf.fsf@riseup.net>
 <1523416474.2700.2.camel@linux.intel.com>
 <87vacx7mh3.fsf@riseup.net> <87muy97lr0.fsf@riseup.net>
 <20180412085824.GX4082@hirez.programming.kicks-ass.net>
 <87r2nk46k1.fsf@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <87r2nk46k1.fsf@riseup.net>
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

T24gVGh1LCBBcHIgMTIsIDIwMTggYXQgMTE6MzQ6NTRBTSAtMDcwMCwgRnJhbmNpc2NvIEplcmV6
IHdyb3RlOgo+IFRoZSByZWFzb24gZm9yIHRoZSBlbmVyZ3kgZWZmaWNpZW5jeSBwcm9ibGVtIG9m
IGlvd2FpdCBib29zdGluZyBpcwo+IHByZWNpc2VseSB0aGUgZ3JlYXRlciBvc2NpbGxhdGlvbiBi
ZXR3ZWVuIHR1cmJvIGFuZCBpZGxlLiAgU2F5IHRoYXQKPiBpb3dhaXQgYm9vc3QgaW5jcmVhc2Vz
IHRoZSBmcmVxdWVuY3kgYnkgYSBmYWN0b3IgYWxwaGEgcmVsYXRpdmUgdG8gdGhlCj4gb3B0aW1h
bCBmcmVxdWVuY3kgZjAgKGluIHRlcm1zIG9mIGVuZXJneSBlZmZpY2llbmN5KSByZXF1aXJlZCB0
byBleGVjdXRlCj4gc29tZSBJTy1ib3VuZCB3b3JrbG9hZC4gIFRoaXMgd2lsbCBjYXVzZSB0aGUg
Q1BVIHRvIGJlIGJ1c3kgZm9yIGEKPiBmcmFjdGlvbiBvZiB0aGUgdGltZSBpdCB3YXMgYnVzeSBv
cmlnaW5hbGx5LCBhcHByb3hpbWF0ZWx5IHQxID0gdDAgLwo+IGFscGhhLCB3aGljaCBpbmRlZWQg
ZGl2aWRlcyB0aGUgb3ZlcmFsbCBlbmVyZ3kgdXNhZ2UgYnkgYSBmYWN0b3IgYWxwaGEsCj4gYnV0
IGF0IHRoZSBzYW1lIHRpbWUgbXVsdGlwbGllcyB0aGUgaW5zdGFudGFuZW91cyBwb3dlciBjb25z
dW1wdGlvbgo+IHdoaWxlIGJ1c3kgYnkgYSBmYWN0b3IgcG90ZW50aWFsbHkgbXVjaCBncmVhdGVy
IHRoYW4gYWxwaGEsIHNpbmNlIHRoZQo+IENQVSdzIHBvd2VyIGN1cnZlIGlzIGxhcmdlbHkgbm9u
LWxpbmVhciwgYW5kIGluIGZhY3QgYXBwcm94aW1hdGVseQo+IGNvbnZleCB3aXRoaW4gdGhlIGZy
ZXF1ZW5jeSByYW5nZSBhbGxvd2VkIGJ5IHRoZSBwb2xpY3ksIHNvIHlvdSBnZXQgYW4KPiBhdmVy
YWdlIGVuZXJneSB1c2FnZSBwb3NzaWJseSBtdWNoIGdyZWF0ZXIgdGhhbiB0aGUgb3B0aW1hbC4K
CkFoLCBidXQgd2UgZG9uJ3QgKHlldCkgaGF2ZSB0aGUgKG5vcm1hbGl6ZWQpIHBvd2VyIGN1cnZl
cywgc28gd2UgY2Fubm90Cm1ha2UgdGhhdCBjYWxsLgoKT25jZSB3ZSBoYXZlIHRoZSB2YXJpb3Vz
IGVuZXJneS9PUFAgbnVtYmVycyByZXF1aXJlZCBmb3IgRUFTIHdlIGNhbgpjb21wdXRlIHRoZSBv
cHRpbWFsLiBJIHRoaW5rIHN1Y2ggd2FzIGV2ZW4gbWVudGlvbmVkIGluIHRoZSB0aHJlYWQgSQpy
ZWZlcnJlZCBlYXJsaWVyLgoKVW50aWwgc3VjaCB0aW1lOyB3ZSBib29zdCB0byBtYXggZm9yIGxh
Y2sgb2YgYSBiZXR0ZXIgb3B0aW9uLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9pbnRlbC1nZngK
