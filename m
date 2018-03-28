From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 9/9] drm/i915/execlists: Report GPU
 rendering as IO activity to cpufreq.
Date: Wed, 28 Mar 2018 20:20:19 +0100
Message-ID: <152226481977.10679.15243453393086412220@mail.alporthouse.com>
References: <20180328063845.4884-1-currojerez@riseup.net>
 <20180328063845.4884-10-currojerez@riseup.net>
 <152222417278.10679.15949311520002257163@mail.alporthouse.com>
 <87muysowrz.fsf@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <87muysowrz.fsf@riseup.net>
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

UXVvdGluZyBGcmFuY2lzY28gSmVyZXogKDIwMTgtMDMtMjggMTk6NTU6MTIpCj4gSGkgQ2hyaXMs
Cj4gCltzbmlwXQo+IFRoYXQgc2FpZCwgaXQgd291bGRuJ3QgaHVydCB0byBjYWxsIGVhY2ggb2Yg
dGhlbSBvbmNlIHBlciBzZXF1ZW5jZSBvZgo+IG92ZXJsYXBwaW5nIHJlcXVlc3RzLiAgRG8geW91
IHdhbnQgbWUgdG8gY2FsbCB0aGVtIGZyb20KPiBleGVjbGlzdHNfc2V0L2NsZWFyX2FjdGl2ZSgp
IHRoZW1zZWx2ZXMgd2hlbiBiaXQgPT0gRVhFQ0xJU1RTX0FDVElWRV9VU0VSLAo+IG9yIGF0IGVh
Y2ggY2FsbHNpdGUgb2YgZXhlY2xpc3RzX3NldC9jbGVhcl9hY3RpdmUoKT8gW3Bvc3NpYmx5IHBy
b3RlY3RlZAo+IHdpdGggYSBjaGVjayB0aGF0IGV4ZWNsaXN0c19pc19hY3RpdmUoRVhFQ0xJU1RT
X0FDVElWRV9VU0VSKSB3YXNuJ3QKPiBhbHJlYWR5IHRoZSBleHBlY3RlZCB2YWx1ZV0KCk5vLCBJ
IHdhcyB0aGlua2luZyBvZiBhZGRpbmcgYW4gZXhlY2xpc3RzX3N0YXJ0KCkvZXhlY2xpc3RzX3N0
b3AoKQpbbmFtaW5nIHN1Z2dlc3Rpb25zIHdlbGNvbWUsIGJlZ2luL2VuZD9dIHdoZXJlIHdlIGNv
dWxkIGhvb2sgYWRkaXRpb25hbApib29ra2VlcGluZyBpbnRvLgotQ2hyaXMKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlz
dApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
