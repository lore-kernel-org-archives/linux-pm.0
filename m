From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [RFC 5/8] regulator: anatop: fix min dropout for bypass mode
Date: Tue, 28 Mar 2017 14:52:46 +0300
Message-ID: <1490701966.3546.24.camel@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <cd944a7223cfe68788c299082a5f262e8bea2136.1490199005.git.leonard.crestez@nxp.com>
 <20170324125438.5wy3r2mr3g5eaxvy@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170324125438.5wy3r2mr3g5eaxvy@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

T24gRnJpLCAyMDE3LTAzLTI0IGF0IDEyOjU0ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOgo+IE9u
IFdlZCwgTWFyIDIyLCAyMDE3IGF0IDA2OjUzOjA3UE0gKzAyMDAsIExlb25hcmQgQ3Jlc3RleiB3
cm90ZToKPiA+ICsJaWYgKGFuYXRvcF9yZWctPmJ5cGFzcykKPiA+ICsJCWFuYXRvcF9yZWctPnJk
ZXNjLm1pbl9kcm9wb3V0X3VWID0gMDsKPiA+ICsJZWxzZQo+ID4gKwkJYW5hdG9wX3JlZy0+cmRl
c2MubWluX2Ryb3BvdXRfdVYgPSBMRE9fTUlOX0RST1BPVVRfVVY7Cj4gTm8sIHRoaXMgaXMgY29t
cGxldGVseSBicm9rZW4gLSB5b3UgY2FuJ3QgZXhwZWN0IHRvIHJhbmRvbWx5IGNoYW5nZSBodGhl
Cj4gcmVndWxhdG9yIGRlc2NyaXB0aW9uIGF0IHJ1bnRpbWUgYmVoaW5kIHRoZSBiYWNrIG9mIHRo
ZSBmcmFtZXdvcmsgYW5kCj4gZXhwZWN0IHRoaW5ncyB0byB3b3JrLsKgwqBJZiB0aGVyZSBpcyBh
IG5lZWQgdG8gZG8gdGhpcyB3ZSBuZWVkIGFuCj4gaW50ZXJmYWNlIGZvciBnZXR0aW5nIHRoZSBj
dXJyZW50IHZhbHVlIGFuZCBhIHdheSB0byBub3RpZnkgb2YgY2hhbmdlcy4KPiAKPiBUaGF0IHNh
aWQgSSB3b3VsZCBub3QgZXhwZWN0IHRoZSBkcm9wb3V0IHZvbHRhZ2UgdG8gYmUgY29uc2lkZXJl
ZCBhdAo+IGFsbCB3aGVuIHRoZSByZWd1bGF0b3IgaXMgYnlwYXNzZWQsIHNpbmNlIHRoZSByZWd1
bGF0b3IgaXMgbm90Cj4gcmVndWxhdGluZyBpdCBkb2Vzbid0IG5lZWQgYW55IGhlYWRyb29tLgoK
SXQncyBhIG1vcmUgY29tcGxleCBzb2x1dGlvbiBidXQgdGhpcyBjb3VsZCBiZSBoYW5kbGVkIGlu
IHRoZSBjb3JlIGluc3RlYWQuCkJhc2ljYWxseSB0aGUgY29yZSB3b3VsZCB0cmVhdCBtaW5fZHJv
cG91dF91ViBhcyB6ZXJvIGlmIHRoZSByZWd1bGF0b3IgaXMKY3VycmVudGx5IGluIGJ5cGFzcyBt
b2RlLgoKSW4gdGhlb3J5IGEgZnVuY3Rpb24gY291bGQgYmUgYWRkZWQgaW4gcmVndWxhdG9yX29w
cyB0byBhc2sgYSByZWd1bGF0b3IgZHJpdmVyCndoYXQgcmVxdWlyZW1lbnRzIGl0IGhhcyBmb3Ig
aXRzIHN1cHBseSBidXQgdGhpcyBkb2VzIG5vdCBzZWVtIG5lY2Vzc2FyeS4KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
