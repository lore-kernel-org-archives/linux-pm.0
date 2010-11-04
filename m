From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 4/4] PERF: fix power:cpu_idle double end
	events
Date: Thu, 4 Nov 2010 09:57:35 +0100
Message-ID: <201011040957.35611.trenn__39126.2912577533$1288861129$gmane$org@suse.de>
References: <1288136605-10526-1-git-send-email-trenn@suse.de>
	<201010271742.04545.trenn@suse.de>
	<1288599088.2712.47.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1288599088.2712.47.camel@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Robert =?utf-8?q?Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>
Cc: jean.pihet@newoldbits.com, linux-trace-users@vger.kernel.org, mingo@elte.hu, linux-omap@vger.kernel.org, arjan@linux.intel.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

SGkgUm9iZXJ0LAoKT24gTW9uZGF5IDAxIE5vdmVtYmVyIDIwMTAgMDk6MTE6MjggUm9iZXJ0IFNj
aMO2bmUgd3JvdGU6Cj4gQW0gTWl0dHdvY2gsIGRlbiAyNy4xMC4yMDEwLCAxNzo0MiArMDIwMCBz
Y2hyaWViIFRob21hcyBSZW5uaW5nZXI6Cj4gCj4gPiBSb2JlcnQ6IEkgZXhwZWN0IHlvdSB0ZXN0
ZWQgdGhpcyBvbiBhIG1hY2hpbmUgd2l0aCBubyBjcHVpZGxlCj4gPiBkcml2ZXIgcmVnaXN0ZXJl
ZD8KPiAKPiBZb3UncmUgcmlnaHQsIHRoZXJlIHdhcyBubyBpZGxlIGRyaXZlciwgYnV0IHRoZSBp
ZGxlIHByb2Nlc3MgZnJvbQo+IHByb2Nlc3NfNjQuYyB3aGljaCBjYWxsZWQgdGhlIGlkbGUgcm91
dGluZS4KPiBJIHJlcG9ydGVkIG15IHRob3VnaHRzIG9uIHRoaXMgb24gMTR0aCBvZiBNYXkgdGhp
cyB5ZWFyIDIwMTAsIG1vc3RseQo+IGNsYWltaW5nIGZvciBhIHN0YW5kYXJkIG9uIHdoZXJlIHRv
IHJlcG9ydCB0aGVzZSBldmVudHMuCj4gCj4gWW91J3JlIGFsc28gbWlzc2luZyB0aGUgb3RoZXIg
aWRsZSByb3V0aW5lcyBmcm9tIHg4Ni9rZXJuZWwvcHJvY2Vzcy5jCj4gbXdhaXRfaWRsZV93aXRo
X2hpbnRzIGFuZCBtd2FpdF9pZGxlIG9ubHkgdGhyb3cgc3RhcnQgZXZlbnRzLCBzbyB0aGV5Cj4g
c2hvdWxkIGJlaGF2ZSBsaWtlIGRlZmF1bHRfaWRsZS4gcG9sbF9pZGxlIG9uIHRoZSBvdGhlciBo
YW5kIHJlcG9ydHMKPiB0aGUgZW5kIGV2ZW50IGl0c2VsZi4KSSBhZGRlZCB5b3UgdG8gQ0Mgb2Yg
YSBwYXRjaCB0aGF0IGZpeGVzIHRoZSBpc3N1ZSAoYW5kIGFsbCBvdGhlciBkb3VibGUgCm9yIG1p
c3NpbmcgKGZvciBhY3BpX2lkbGUgZHJpdmVyKSBldmVudHMpIGluIGEgbmljZSBnZW5lcmljIHdh
eS4KSXQgbmVlZHMgZnVydGhlciB1c2Vyc3BhY2UgYWRqdXN0aW5ncyBhbmQgSSBzdGlsbCB3YWl0
IGZvciB0aGlzCnNlcGFyYXRlIHBhdGNoIHNlcmllcyB0byBnbyBpbnRvIHNvbWUgYnJhbmNoLgoK
VGhhbmtzLAoKICAgVGhvbWFzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1wbQ==
