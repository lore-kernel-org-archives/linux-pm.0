From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH V2 3/3] cpufreq: add suspend/resume support in Armada
 37xx DVFS driver
Date: Tue, 24 Apr 2018 11:10:46 +0200
Message-ID: <20180424111046.704637d3@xps13>
References: <cover.1524549644.git.viresh.kumar@linaro.org>
 <4ca19364ff10083c3912ce428207c3f713f973b9.1524549644.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4ca19364ff10083c3912ce428207c3f713f973b9.1524549644.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

SGkgVmlyZXNoLAoKT24gVHVlLCAyNCBBcHIgMjAxOCAxMTozNzozNiArMDUzMCwgVmlyZXNoIEt1
bWFyCjx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4gd3JvdGU6Cgo+IEZyb206IE1pcXVlbCBSYXlu
YWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+Cj4gCj4gQWRkIHN1c3BlbmQvcmVzdW1lIGhv
b2tzIGluIEFybWFkYSAzN3h4IERWRlMgZHJpdmVyIHRvIGhhbmRsZSBTMlJBTQo+IG9wZXJhdGlv
bnMuIEFzIHRoZXJlIGlzIGN1cnJlbnRseSBubyAnZHJpdmVyJyBzdHJ1Y3R1cmUsIGNyZWF0ZSBv
bmUKPiB0byBzdG9yZSBib3RoIHRoZSByZWdtYXAgYW5kIHRoZSByZWdpc3RlciB2YWx1ZXMgZHVy
aW5nIHN1c3BlbmQKPiBvcGVyYXRpb24uCj4gCj4gQSBzeXNjb3JlX29wcyBpcyB1c2VkIHRvIGV4
cG9ydCB0aGUgc3VzcGVuZC9yZXN1bWUgaG9va3MuCgpJIHRoaW5rIHlvdSBjYW4gcmVtb3ZlIHRo
aXMgbGluZSB0b28gc2luY2UgdGhlcmUgaXMgbm8gbW9yZSBzeXNjb3JlX29wcy4KCj4gCj4gU2ln
bmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4KPiBT
aWduZWQtb2ZmLWJ5OiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPgoKUmVn
YXJkcywKTWlxdcOobAoKLS0gCk1pcXVlbCBSYXluYWwsIEJvb3RsaW4gKGZvcm1lcmx5IEZyZWUg
RWxlY3Ryb25zKQpFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nCmh0dHBzOi8v
Ym9vdGxpbi5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
