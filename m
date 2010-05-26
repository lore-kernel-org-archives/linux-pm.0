From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 12:49:30 +0200
Message-ID: <1274870970.5882.5311.camel__36443.879249464$1274871107$gmane$org@twins>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<87wrusvrqe.fsf@deeprootsystems.com> <201005250138.16293.rjw@sisk.pl>
	<1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
	<AANLkTiksR3YozbBH0Iv5kNsQkEGKCH1APCvn_s6LkjV9@mail.gmail.com>
	<1274868593.5882.5185.camel@twins>
	<AANLkTinuxCbeBmxIR7b_1OtrqQYJCamiDZJbnNTih1Fb@mail.gmail.com>
	<1274869966.5882.5262.camel@twins>
	<AANLkTikRMBkoFxgaKsxMJ2lOMomTXpiHJDk3rVt0EtwM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikRMBkoFxgaKsxMJ2lOMomTXpiHJDk3rVt0EtwM@mail.gmail.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCAyMDEwLTA1LTI2IGF0IDAzOjQwIC0wNzAwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+IDIwMTAvNS8yNiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+Ogo+ID4g
T24gV2VkLCAyMDEwLTA1LTI2IGF0IDAzOjI1IC0wNzAwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+ID4KPiA+PiBhbmQgb24gc3lzdGVtcyB3aGVyZSB0aGUKPiA+PiBzYW1lIHBvd2VyIHN0YXRl
IGNhbiBiZSB1c2VkIGZyb20gaWRsZSBhbmQgc3VzcGVuZCwgd2UgdXNlIHN1c3BlbmQgc28KPiA+
PiB3ZSBjYW4gc3RheSBpbiB0aGUgbG93IHBvd2VyIHN0YXRlIGZvciBtaW51dGVzIHRvIGhvdXJz
IGluc3RlYWQgb2YKPiA+PiBtaWxsaXNlY29uZHMgdG8gc2Vjb25kcy4KPiA+Cj4gPiBTbyBkb24n
dCB5b3UgdGhpbmsgd29ya2luZyBvbiBtYWtpbmcgaXQgcG9zc2libGUgZm9yIHN5c3RlbXMgdG8g
YmUgaWRsZQo+ID4gX3RoYXRfIGxvbmcgd291bGQgaW1wcm92ZSB0aGluZ3MgZm9yIGV2ZXJ5Ym9k
eT8gYXMgb3Bwb3NlZCB0byB0aGlzCj4gPiBhdXRvLXN1c3BlbmQgd2hpY2ggb25seSBpbXByb3Zl
cyBtYXR0ZXJzIGZvciB0aG9zZSB0aGF0IChjYW4pIHVzZSBpdD8KPiAKPiBJJ20gbm90IHByZXZl
bnRpbmcgYW55b25lIGZyb20gd29ya2luZyBvbiBpbXByb3ZpbmcgdGhpcy4gQ3VycmVudGx5Cj4g
Ym90aCB0aGUga2VybmVsIGFuZCBvdXIgdXNlci1zcGFjZSBjb2RlIHBvbGxzIHdheSB0b28gbXVj
aC4gSSBkb24ndAo+IHRoaW5rIGl0IGlzIHJlYXNvbmFibGUgdG8gZGVtYW5kIHRoYXQgbm8gb25l
IHNob3VsZCBydW4gYW55IHVzZXItc3BhY2UKPiBjb2RlIHdpdGggcGVyaW9kaWMgdGltZXJzIHdo
ZW4gd2UgaGF2ZSBub3QgZXZlbiBmaXhlZCB0aGUga2VybmVsIHRvCj4gbm90IGRvIHRoaXMuCgpB
bGwgSSdtIHNheWluZyBpcyB0aGF0IG1lcmdpbmcgYSBzdG9wLWdhcCBtZWFzdXJlIHdpbGwgZGVj
cmVhc2UgdGhlCnVyZ2VuY3kgYW5kIHRodXMgdGhlIHRpbWUgc3BlbmQgZml4aW5nIHRoZSBhY3R1
YWwgaXNzdWVzIHdoaWxlIGFkZGluZwp0aGUgYnVyZGVuIG9mIG1haW50YWluaW5nIHRoaXMgc3Rv
cC1nYXAgbWVhc3VyZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1wbQ==
