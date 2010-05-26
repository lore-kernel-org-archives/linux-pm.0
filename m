From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 10:42:22 +0200
Message-ID: <1274863342.5882.4850.camel__15026.6489749358$1274863491$gmane$org@twins>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
	<AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, tytso@mit.edu, Greg KH <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

T24gVHVlLCAyMDEwLTA1LTI1IGF0IDE1OjMzIC0wNzAwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+IFRoZSBiaWdnZXN0IHByb2JsZW0gaGVyZSBpcyBub3QgdGhhdCBpdCBpcyBoYXJkIHRvIGNo
YW5nZSBvdXIKPiB1c2VyLXNwYWNlLCBidXQgdGhhdCB0aGUgcHJvcG9zZWQgY2hhbmdlIGlzIGlu
ZmVyaW9yIHRvIHdoYXQgd2UgaGF2ZQo+IG5vdy4gSXQgZm9yY2VzIHVzIHRvIHBvbGwgdW50aWwg
YWxsIGRyaXZlcnMgc3RvcCBhYm9ydGluZyBzdXNwZW5kLiBPbgo+IG9uZSBoYW5kIHdlIGhhdmUg
cGVvcGxlIHRlbGxpbmcgdXMgdGhhdCBhbGwgY29kZSB0aGF0IHBvbGxzIGlzIGJyb2tlbgo+IGFu
ZCBtdXN0IGJlIGZpeGVkIChpbnN0ZWFkIG9mIHN1c3BlbmRpbmcgdG8gbGltaXQgdGhlIGRhbWFn
ZSksIGFuZCBvbgo+IHRoZSBvdGhlciBoYW5kIHdlIGhhdmUgcGVvcGxlIHN1Z2dlc3Rpbmcgd2Ug
aW1wbGVtZW50IG9wcG9ydHVuaXN0aWMKPiBzdXNwZW5kIGJ5IHBvbGxpbmcgZnJvbSB1c2VyLXNw
YWNlIHVudGlsIHN1c3BlbmQgc3VjY2VlZHMuIAoKTm8gaXQgZG9lcyBfbm90Xy4gWW91J3JlIHJl
YWxseSBub3QgZ2V0dGluZyB0aGF0IERtaXRyeSBpcyBwcm9wb3NpbmcuCgoKU28geW91ciBwcm9w
b3NhbCBpcyB0aGF0IHdoZW4gd2Ugd2FrZSB1c2Vyc3BhY2UsIGl0Cm9wZW5zIC9kZXYvc3VzcGVu
ZF9ibG9ja2VyIF9iZWZvcmVfIGl0IGNvbnN1bWVzIHdoYXRldmVyIGV2ZW50LCBjb25zdW1lcwp0
aGUgZXZlbnQsIGRlYWxzIHdpdGggdGhlIGV2ZW50LCB0aGVuIGNsb3NlcyB0aGUgc3VzcGVuZF9i
bG9ja2VyLiBUaGVuCnRoZSBrZXJuZWwsIHVwb24gcmVhY2hpbmcgYSAwIHN1c3BlbmRfYmxvY2tl
ciBjb3VudCwgd2lsbCB0cnkgdG8gc3VzcGVuZAphZ2Fpbi4KCgpXaGF0IERtaXRyeSBwcm9wb3Nl
cyBpcyB0aGF0LCB0aGUgYXBwIF9iZWZvcmVfIGl0IGNvbnN1bWVzIHRoZSBldmVudCwKcG9rZXMg
YXQgdGhpcyBzdXNwZW5kIG1hbmFnZXIsIGl0IGluY3JlYXNlcyBhIGJsb2NrZXIgY291bnQsIHRo
ZW4KY29uc3VtZXMgdGhlIGV2ZW50ICh0aGUga2VybmVsIHdpbGwgX25vdF8gYXV0by1zdXNwZW5k
KSwgaGFuZGxlcyBpdCBhbmQKdGhlbiBhZ2FpbiBwb2tlcyB0aGUgc3VzcGVuZCBtYW5hZ2VyLCB0
aGlzIHRpbWUgZGVjcmVhc2luZyB0aGUgYmxvY2tlcgpjb3VudC4KClRoZSBzdXNwZW5kIG1hbmFn
ZXIgd2lsbCwgdXBvbiByZWFjaGluZyBhIDAgYmxvY2sgY291bnQsIHN1c3BlbmQgdGhlCm1hY2hp
bmUuIElmIHRoYXQgZmFpbHMsIGl0IG1lYW5zIHRoZXJlJ3Mgc29tZXRoaW5nIHRvIGRvLCBhbiBh
cHAgd2lsbAppbmMsIHdvcmssIGRlYyBpdHMgY291bnQsIGFuZCBpdCB3aWxsIHRyeSBhZ2FpbiBv
bmNlIGl0IHJlYWNoZXMgMCBhZ2Fpbi4KClRoZXJlIGlzIG5vIHBvbGxpbmcgd2hhdC1zby1ldmVy
IGluIHRoaXMgbW9kZWwuCgpUaGUgb25seSB0aGluZyBpcyB0aGF0IHRoZSBrZXJuZWwgd2lsbCBu
b3QgdHJ5IHRvIGF1dG8tc3VzcGVuZCBhbmQgdGhlcmUKaXMgbm8gdXNlci1zcGFjZSBzdXNwZW5k
IGJsb2NrZXIgQVBJLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXBt
