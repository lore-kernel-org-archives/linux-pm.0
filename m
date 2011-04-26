From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
 with device-specific OPPs
Date: Tue, 26 Apr 2011 13:54:30 -0700
Message-ID: <20110426205430.GA20381@suse.de>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<20110426132224.GC13597@suse.de>
	<BANLkTi=VFPZinH+1x0xBTP9o_s6+2gsA7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=VFPZinH+1x0xBTP9o_s6+2gsA7w@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Jiejing.Zhang " <kzjeef@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

T24gVHVlLCBBcHIgMjYsIDIwMTEgYXQgMTA6NDU6MThQTSArMDgwMCwgSmllamluZy5aaGFuZyAg
d3JvdGU6Cj4gSGkgR3JlZywKPiAKPiBJIHRoaW5rIERWRlMgaGVyZSBtZWFucyDigJxEeW5hbWlj
IHZvbHRhZ2UgYW5kIGZyZXF1ZW5jeSBzY2FsaW5n4oCdLMKgIHJlZmVyaW5nIHRoZQo+IGZpcnN0
IGdvb2dsZSdzIHJlc3VsdDoKCk9rLCBpZiBzbywgcGxlYXNlIHNwZWxsIGl0IG91dC4KCkFsc28s
IGRvbid0IHVzZSAnZHZmcycgYXMgYSBwcmVmaXggaW4gdGhlIGtlcm5lbCwgdG9vIG1hbnkgb3Ro
ZXIgcGVvcGxlCndpbGwgdGhpbmsgaXQgaXMgYSBmaWxlc3lzdGVtLiAgSG93IGFib3V0ICJkeW52
b2x0Ij8KCk9yIGFueXRoaW5nIGVsc2UsIGp1c3Qgbm8gJ2ZzJyBpbiB0aGUgbmFtZSBvdGhlcndp
c2UgY29uZnVzaW9uIHdpbGwKcmVpZ24uCgo+IGEgZHluYW1pYyB2b2x0YWdlIGFuZCBmcmVxdWVu
Y3kgc2NhbGluZyAoRFZGUykgKnRlY2huaXF1ZSB0aGF0IG1pbmltaXplcyB0aGUKPiB0b3RhbCBz
eXN0ZW0gZW5lcmd5IGNvbnN1bXB0aW9uIGZvciBwZXJmb3JtaW5nIGEgdGFzayB3aGlsZSBzYXRp
c2Z5aW5nCj4gYSBnaXZlbiBleGVjdXRpb24gdGltZSBjb25zdHJhaW50LiBXZSBmaXJzdCBzaG93
IHRoYXQgaW4gb3JkZXIgdG8KPiBndWFyYW50ZWUgbWluaW11bSBlbmVyZ3kgZm9yIHRhc2sgZXhl
Y3V0aW9uIGJ5IHVzaW5nIERWRlMgaXQgaXMKPiBlc3NlbnRpYWwgdG8gZGl2aWRlIHRoZSBzeXN0
ZW0gcG93ZXIgaW50byBhY3RpdmUgYW5kIHN0YW5kYnkgcG93ZXIKPiBjb21wb25lbnRzLiBOZXh0
LCB3ZSBwcmVzZW50IGEgbmV3IERWRlMgdGVjaG5pcXVlLCB3aGljaCBjb25zaWRlcnMgbm90Cj4g
b25seSB0aGUgYWN0aXZlIHBvd2VyLCBidXQgYWxzbyB0aGUgc3RhbmRieSBjb21wb25lbnQgb2Yg
dGhlIHN5c3RlbQo+IHBvd2VyLgoKUGxlYXNlIHB1dCB0aGlzIGluIHRoZSBjaGFuZ2Vsb2cgZW50
cnksIHlvdSBuZWVkIHRvIGV4cGxhaW4gaXQgdG8gdGhvc2UKb2YgdXMgd2hvIGhhdmUgbmV2ZXIg
c2VlbiBpdC4KCnRoYW5rcywKCmdyZWcgay1oCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtcG0=
