From: =?UTF-8?Q?S=c3=a9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
Date: Tue, 5 Jun 2018 09:07:00 +0200
Message-ID: <717f24e1-3846-7685-b440-0754da883c2a@armadeus.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180523042953.kcp2h5xtwjrjponn@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180523042953.kcp2h5xtwjrjponn@vireshk-i7>
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
To: Shawn Guo <shawnguo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

T24gMDUvMjMvMjAxOCAwNjoyOSBBTSwgVmlyZXNoIEt1bWFyIHdyb3RlOgo+IE9uIDIyLTA1LTE4
LCAwODoyOCwgU8OpYmFzdGllbiBTenltYW5za2kgd3JvdGU6Cj4+IENoZWNrIHRoZSBtYXggc3Bl
ZWQgc3VwcG9ydGVkIGZyb20gdGhlIGZ1c2VzIGZvciBpLk1YNlVMTCBhbmQgdXBkYXRlIHRoZQo+
PiBvcGVyYXRpbmcgcG9pbnRzIHRhYmxlIGFjY29yZGluZ2x5Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBTw6liYXN0aWVuIFN6eW1hbnNraSA8c2ViYXN0aWVuLnN6eW1hbnNraUBhcm1hZGV1cy5jb20+
Cj4+IC0tLQo+Pgo+PiBDaGFuZ2VzIGZvciB2MzoKPj4gIC0gbm9uZQo+IAo+IEBTYXNjaGEgYW5k
IFNoYXduOiBDYW4geW91IGd1eXMgcGxlYXNlIEFjayB0aGlzIHNlcmllcyBpZiB0aGVyZSBpcwo+
IG5vdGhpbmcgd3Jvbmcgd2l0aCBpdCA/Cj4gCgpwaW5nLi4uCgotLSAKU8OpYmFzdGllbiBTenlt
YW5za2kKU29mdHdhcmUgZW5naW5lZXIsIEFybWFkZXVzIFN5c3RlbXMKVGVsOiArMzMgKDApOSA3
MiAyOSA0MSA0NApGYXg6ICszMyAoMCk5IDcyIDI4IDc5IDI2CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
