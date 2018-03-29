From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 9/9] drm/i915/execlists: Report GPU
 rendering as IO activity to cpufreq.
Date: Thu, 29 Mar 2018 02:20:26 +0100
Message-ID: <152228642670.16812.5630080119968691321@mail.alporthouse.com>
References: <20180328063845.4884-1-currojerez@riseup.net>
 <20180328063845.4884-10-currojerez@riseup.net>
 <152222417278.10679.15949311520002257163@mail.alporthouse.com>
 <87muysowrz.fsf@riseup.net>
 <152226481977.10679.15243453393086412220@mail.alporthouse.com>
 <152227918019.10679.9470023556595388428@mail.alporthouse.com>
 <874lkzpvqw.fsf@riseup.net>
 <152228529761.16812.1704657375621461360@mail.alporthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <152228529761.16812.1704657375621461360@mail.alporthouse.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Francisco Jerez <currojerez@riseup.net>, linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Eero Tamminen <eero.t.tamminen@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

UXVvdGluZyBDaHJpcyBXaWxzb24gKDIwMTgtMDMtMjkgMDI6MDE6MzcpCj4gUXVvdGluZyBGcmFu
Y2lzY28gSmVyZXogKDIwMTgtMDMtMjkgMDE6MzI6MDcpCj4gPiBDaHJpcyBXaWxzb24gPGNocmlz
QGNocmlzLXdpbHNvbi5jby51az4gd3JpdGVzOgo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGVsc2UKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGV4ZWNsaXN0c19lbmQoZXhlY2xpc3RzKTsKPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgfSBlbHNlIHsKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3J0X3Nl
dChwb3J0LCBwb3J0X3BhY2socnEsIGNvdW50KSk7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIH0KPiA+ID4KPiA+IAo+ID4gSXNuJ3QgdGhlcmUgYW4gImV4ZWNsaXN0c19jbGVhcl9hY3Rp
dmUoZXhlY2xpc3RzLAo+ID4gRVhFQ0xJU1RTX0FDVElWRV9VU0VSKTsiIGNhbGwgaW4geW91ciB0
cmVlIGEgZmV3IGxpbmVzIGJlbG93IHRoYXQgaXMgbm93Cj4gPiByZWR1bmRhbnQ/Cj4gCj4gVGhp
cyBpcyBvbmx5IGhhbGYgdGhlIHBhdGNoIHRvIHNob3cgdGhlIGdpc3QuIDopCgpBIG1vcmUgY29u
Y3JldGUgc2tldGNoLApodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvMjEz
NTk0LwotQ2hyaXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4
Cg==
