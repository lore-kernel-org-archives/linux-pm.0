From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 16:04:21 -0700
Message-ID: <AANLkTim5PZdKvH2HsDXtpzIPTNbVC54C4Y_YwbNVuypk__6735.48804265938$1274137621$gmane$org@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
	<87r5laa4oc.fsf@deeprootsystems.com>
	<AANLkTilL90pYVlquvMDAEPHj_AraEi9Qzk-0tTjw9Bkx@mail.gmail.com>
	<AANLkTil7358FHTlFZ0LqwymkiZZ-7An0HlaOTVhTkpgW@mail.gmail.com>
	<87mxvyt9xz.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87mxvyt9xz.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Len Brown <len.brown@intel.com>, Wu Fengguang <fengguang.wu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, tytso@mit.edu, Linus Walleij <linus.walleij@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-omap@vger.kernel.org, Daniel Walker <dwalker@codeaurora.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBNYXkgMTcsIDIwMTAgYXQgMzo1NSBQTSwgS2V2aW4gSGlsbWFuCjxraGlsbWFuQGRl
ZXByb290c3lzdGVtcy5jb20+IHdyb3RlOgo+Cj4gVGhlIGZ1bmRhbWVudGFsIHByb2JsZW0gaXMg
b25lIG9mIGlkbGVuZXNzLiDCoFdoYXQgd2Ugd2FudCBpcyB0aGUKPiBzeXN0ZW0gdG8gYmUgaWRs
ZSBpbiBvcmRlciB0byBoaXQgdGhlIGxvd2VzdCBwb3dlciBzdGF0ZXMuIMKgV2UgY2FuJ3QKPiBn
ZXQgdGhlcmUgYmVjYXVzZSB0aGUgc3lzdGVtIGlzIG5vdCB0cnVseSBpZGxlLgo+Cj4gU28sIHRo
ZXJlIGFyZSBiYXNpY2FsbHkgdHdvIHNvbHV0aW9uczoKPgo+IDEpIGZpbmQgYW5kIGZpeCB0aGUg
cHJvYmxlbSBzcG90cyBzbyB3ZSBjYW4gYmUgaWRsZSBtb3JlIG9mdGVuCj4gMikgYWRkIGEgbmV3
IGRlZmluaXRpb24gb2YgaWRsZSBzbyB3ZSBjYW4gYmUgaWRsZSBtb3JlIG9mdGVuCj4KPiBPcHBv
cnVudGlzdGljIHN1c3BlbmQgdGFrZXMgdGhlIHNlY29uZCBhcHByb2FjaCB3aGVyZSB0aGUgbmV3
Cj4gZGVmaW5pdGlvbiBvZiBpZGxlIGlzICJubyBzdXNwZW5kIGJsb2NrZXJzIGhlbGQuIgo+Cj4g
T2YgY291cnNlLCBJIGNsZWFybHkgcHJlZmVyIHRoZSBmb3JtZXIsIGJ1dCBpdCdzIGFsc28gYmVj
b21pbmcgY2xlYXIKPiB0aGF0IHNpbmNlIEknbSB0aGUgb25seSBvbmUgc3RpbGwgd2hpbmluZyBh
Ym91dCBpdCwgSSBtdXN0IGJlIHRvbyBtdWNoCj4gb2YgYW4gaWRlYWxpc3QgdG8ga2VlcCBob3Bp
bmcgZm9yIGl0LgoKSSdkIGxvdmUgdG8gc2VlIHRoZSBmb3JtZXIgd29yaywgYnV0IGl0IGlzIG5v
dCBzb21ldGhpbmcgdGhhdCBJIHRoaW5rCmlzIGdvaW5nIHRvIGJlIGZpeGVkIHJhcGlkbHkuICBJ
dCBwb3RlbnRpYWxseSBpbnZvbHZlcyBtYW55IGRpZmZlcmVudApzdWJzeXN0ZW1zLCBhbmQgc3Rp
bGwgcmVxdWlyZXMgc29tZSBuZWVkIGZvciBtYW5hZ2luZyBhcmJpdHJhcnkKdXNlcnNwYWNlIGFn
ZW50cyB3aGljaCBtYXkgaGF2ZSBub24taWRlYWwgYmVoYXZpb3JzIChpZiB3ZSdyZSBnb2luZyB0
bwpzb2x2ZSB0aGUgcHJvYmxlbSBmb3IgZ2VuZXJhbCBwdXJwb3NlIGRldmljZXMgdGhhdCBjYW4g
cnVuIGFyYml0cmFyeQp1c2VyLWluc3RhbGxlZCBzb2Z0d2FyZSkuICBJbmNyZW1lbnRhbCBpbXBy
b3ZlbWVudHMgYXJlIGdyZWF0IHRob3VnaAooZm9yIGV4YW1wbGUsIHRoYXQgd2UgY2FuIG5vdyBi
ZSBpbiBsb3dlc3QgcG93ZXIgaWRsZSBmb3IgcGVyaW9kcwpncmVhdGVyIHRoYW4gMiBzZWNvbmRz
IGR1ZSB0byB0aGUgY2hhbmdlIGluIC4zMikuCgpFdmVuIHdoZW4gb3BlcmF0aW5nIGluIG9wcG9y
dHVuaXN0aWMgc3VzcGVuZCwgaXQgaXMgc3RpbGwgYWR2YW50YWdlb3VzCmZvciBpZGxlIHRvIGJl
IGFzIGlkbGUgYXMgcG9zc2libGUgYW5kIHdlIHNob3VsZCBrZWVwIHdvcmtpbmcgdG93YXJkCnRo
YXQgZ29hbC4gIElmIHdlIGdldCB0byB0aGUgcG9pbnQgd2hlcmUgdGhlIHBvd2VyIGRpZmZlcmVu
Y2UgYmV0d2VlbgpzdXNwZW5kLWluLWlkbGUgYW5kIG9wcG9ydHVuaXN0aWMgc3VzcGVuZCBpcyB6
ZXJvLCB0aGVuIHdlIG5vIGxvbmdlcgpuZWVkIHRoZSBsYXR0ZXIuCgpJIGRvbid0IHRoaW5rIGFu
eWJvZHkgb24gdGhlIEdvb2dsZS9BbmRyb2lkIHNpZGUgaXMgYXJndWluZyB0aGF0IHdlCipzaG91
bGRuJ3QqIHB1cnN1ZSBkeW5hbWljIHBtIGFuZCBvdmVyYWxsIG1ha2luZyBpZGxlIG1vcmUgaWRs
ZSBtb3JlCm9mIHRoZSB0aW1lLiAgV2UncmUganVzdCBzYXlpbmcgdGhhdCBoZXJlIGFuZCBub3cg
d2UgYXJlIG5vdCBhdCB0aGUKaWRlYWwgYW5kIG9wcG9ydHVuaXN0aWMgc3VzcGVuZCBnYWlucyB1
cyByZWFsIHBvd2VyIHNhdmluZ3MgYW5kIGlzCnVzZWZ1bC4KCkJyaWFuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdAps
aW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
