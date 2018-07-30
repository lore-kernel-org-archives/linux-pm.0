From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 01/23] thermal: armada: add a function that sanitizes
 the thermal zone name
Date: Mon, 30 Jul 2018 08:16:21 +0200
Message-ID: <6c9315c1-7768-d1c3-bbed-770e56d115d4@linaro.org>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-2-miquel.raynal@bootlin.com>
 <84f97022-a470-f314-ee75-e5afb733bea5@linaro.org>
 <20180727135230.3c7102c7@xps13>
 <f1d7e8bd-329f-0c9d-c296-0afbe871058f@linaro.org>
 <20180729212744.31cf0747@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180729212744.31cf0747@xps13>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

T24gMjkvMDcvMjAxOCAyMToyNywgTWlxdWVsIFJheW5hbCB3cm90ZToKPiBIaSBEYW5pZWwsCgpb
IC4uLiBdCgo+IFRoYXQncyBleGFjdGx5IHdoYXQgaXMgZG9uZSBsYXRlciBpbiB0aGUgc2VyaWVz
IGFjdHVhbGx5LCBidXQgZm9yIERUCj4gYmFja3dhcmQgY29tcGF0aWJpbGl0eSBhbmQgaW4gb3Jk
ZXIgdG8gY29udGludWUgYWRkaW5nIGZlYXR1cmUgdG8gdGhpcwo+IGRyaXZlciwgd2UgbXVzdCBl
bnN1cmUgdGhlcmUgd29uJ3QgYmUgYW55IGRyYXdiYWNrIGZvciBwZW9wbGUgdXNpbmcgb2xkCj4g
RFQgd2l0aCBkZXByZWNhdGVkIHRoZXJtYWwgcmVwcmVzZW50YXRpb24uCj4gCj4gCj4gVGhhbmtz
IGZvciByZXZpZXdpbmcsIGlmIHlvdSBkb24ndCBtaW5kIEkgY291bGQgY29weSB5b3UgaW4gZnV0
dXJlCj4gY2hhbmdlcz8gCgpZZXMsIHN1cmUuCgo+IFVuZm9ydHVuYXRlbHkgZm9yIHRoaXMgc2Vy
aWVzIGl0J3MgYWxyZWFkeSBiZWVuIGFwcGxpZWQgYW5kIEkKPiB3b3VsZCBsaWtlIG5vdCB0byBk
byBhbnkgZGVlcCBjaGFuZ2VzIGJlZm9yZSBpdCdzIG1lcmdlZCwgYnV0IGZvciBzdXJlCj4gdGhp
cyBmdW5jdGlvbiBjb3VsZCBiZSBlbmhhbmNlZC4KCk9yIGZpbmQgYSB3YXkgdG8gcmVtb3ZlIGl0
ID8gOikKCgotLSAKIDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3JnIOKUgiBPcGVu
IHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86ICA8aHR0cDovL3d3
dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8CjxodHRwOi8vdHdpdHRlci5j
b20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8t
YmxvZy8+IEJsb2cKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
