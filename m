From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 12:06:24 +0200
Message-ID: <1274868384.5882.5169.camel__49279.1081233465$1274868486$gmane$org@twins>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
	<AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
	<1274863342.5882.4850.camel@twins>
	<20100526112303.3fef15a4@schatten.dmk.lab>
	<1274866402.5882.5051.camel@twins>
	<AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, tytso@mit.edu, Greg KH <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCAyMDEwLTA1LTI2IGF0IDAyOjU0IC0wNzAwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+IAo+IEknbSBub3Qgc3VyZSB3aGF0IHlvdSBhcmUgcHJvcG9zaW5nIHRoYXQgd2UgdXNlIGlu
c3RlYWQuIEJvdGgKPiB1c2VyLXNwYWNlIGFuZCBrZXJuZWwgY29kZSBuZWVkcyB0byBibG9jayBz
dXNwZW5kLiBJZiB3ZSBkb24ndCBoYXZlCj4gc3VzcGVuZCBibG9ja2VycyBpbiB0aGUga2VybmVs
IHRoZW4gdXNlci1zcGFjZSBuZWVkcyB0byBwb2xsIHdoZW4gYQo+IGRyaXZlciBibG9ja3Mgc3Vz
cGVuZCBieSByZXR1cm5pbmcgYW4gZXJyb3IgZnJvbSBpdHMgc3VzcGVuZCBob29rLiAKCkluIHBh
cnRpY3VsYXIgSSdtIHN1Z2dlc3RpbmcgeW91IGRpdGNoIHRoZSAvZGV2L3N1c3BlbmRfYmxvY2sg
dGhpbmcuCgpXaXRoIGEgc2luZ2xlIHN1c3BlbmQgbWFuYWdlciBwcm9jZXNzIHRoYXQgbWFuYWdl
cyB0aGUgc3VzcGVuZCBzdGF0ZSB5b3UKY2FuIGFjaGlldmUgdGhlIHNhbWUgZ29hbC4KCldoZW4g
dGhlIHN1c3BlbmQgbWFuYWdlciBoYXMgYSAhMCBidXN5LXRhc2sgY291bnQsIGl0IGVuc3VyZXMg
dGhlIGtlcm5lbAp3b24ndCBhdXRvLXN1c3BlbmQsIHdoZW4gaXQgYWdhaW4gcmVhY2hlcyBhIDAg
YnVzeS10YXNrIGNvdW50LCBpdApyZS1pbnN0YXRlcyB0aGUgYXV0by1zdXNwZW5kIGZlYXR1cmUu
CgpUaGF0J3MgcHJldHR5IG11Y2ggd2hhdCB0aGF0IGRldmljZSB3b3VsZCBkbyB0b28uCgpJZGVh
bGx5IHdlIHdvdWxkIG5vdCBkbyB0aGUgYXV0by1zdXNwZW5kIHRoaW5nIGF0IGFsbCBhbmQgaGF2
ZQpydW50aW1lLVBNIGltcHJvdmVkLiBOb3QgcnVubmluZyBhcHBzIHdoZW4gdGhleSBleHBlY3Qg
dG8gcnVuIGlzIGxpa2UKdGhlIHdvcmxkIHR1cm5lZCB1cHNpZGUgZG93bi4KCidFdmlsJyBhcHBz
IGNvdWxkIGFsd2F5cyByZXBvcnQgdGhlbXNlbHZlcyBhcyBibG9ja2VyIGFueXdheS4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGlu
ZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
