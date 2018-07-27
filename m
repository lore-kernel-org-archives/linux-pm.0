From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 03/23] thermal: armada: remove misleading comments
Date: Fri, 27 Jul 2018 18:03:08 +0200
Message-ID: <ed966280-9200-4993-268d-61096ed41807@linaro.org>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-4-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180716144206.30985-4-miquel.raynal@bootlin.com>
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
To: Miquel Raynal <miquel.raynal@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

T24gMTYvMDcvMjAxOCAxNjo0MSwgTWlxdWVsIFJheW5hbCB3cm90ZToKPiBPbiBvbGRlciB2ZXJz
aW9ucyBvZiB0aGlzIHRoZXJtYWwgSVAsIFRTRU4gcmVmZXJyZWQgYXMgdGhlIGludGVybmFsCj4g
c2Vuc29yIGluIHRoZSB0aGVybWFsIElQIHdoaWxlIEVYVF9UU0VOIHJlZmVycmVkIGFzIHNlbnNv
cnMgb3V0c2lkZSBvZgo+IHRoaXMgSVAsIGllIGluIHRoZSBDUFVzIG1vc3Qgb2YgdGhlIHRpbWUu
IFRoZSBiaXQgbmFtZXMgaW4gdGhlCj4gc3BlY2lmaWNhdGlvbnMgZG8gbm90IGZvbGxvdyB0aGlz
IHJ1bGUgYW55bW9yZSwgc28gcmVtb3ZlIHRoZXNlIGNvbW1lbnRzCj4gdGhhdCBhcmUgbWlzbGVh
ZGluZy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJv
b3RsaW4uY29tPgoKUmV2aWV3ZWQtYnk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0Bs
aW5hcm8ub3JnPgoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIg
T3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6
Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0
ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGlu
YXJvLWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
