From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
Date: Fri, 9 Jun 2017 15:46:38 +0200
Message-ID: <20170609154638.3b64e6d0@karo-electronics.de>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
 <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
 <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
 <1497005895.28352.88.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497005895.28352.88.camel@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Zhang Rui <rui.zhang@intel.com>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

SGksCgpPbiBGcmksIDkgSnVuIDIwMTcgMTM6NTg6MTUgKzAzMDAgTGVvbmFyZCBDcmVzdGV6IHdy
b3RlOgo+IE9uIFRodSwgMjAxNy0wNi0wOCBhdCAxMzo0NSAtMDMwMCwgRmFiaW8gRXN0ZXZhbSB3
cm90ZToKPiA+IE9uIFRodSwgSnVuIDgsIDIwMTcgYXQgMToyNiBQTSwgTGVvbmFyZCBDcmVzdGV6
ICB3cm90ZToKPiA+IAo+ID4gPiAKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB0ZW1wbW9uOiB0ZW1wbW9uIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJs
ZSA9ICJmc2wsaW14NnVsLXRlbXBtb24iLCAiZnNsLGlteDZzeC10ZW1wbW9uIjsKPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaW50ZXJydXB0cyA9IDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnNsLHRlbXBtb24gPSA8JmFuYXRvcD47Cj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGZzbCx0ZW1wbW9uLWRhdGEgPSA8Jm9jb3RwPjsKPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xvY2tz
ID0gPCZjbGtzIElNWDZVTF9DTEtfUExMM19VU0JfT1RHPjsKPiA+IERvZXMgdGhlIElNWDZVTF9D
TEtfUExMM19VU0JfT1RHIGNsb2NrIHJlYWxseSBjb250cm9sIHRlbXBtb24/IFBsZWFzZQo+ID4g
ZG91YmxlIGNoZWNrLgo+IAo+IFllcywgYXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhlIHRlbXBtb24g
YmxvY2sgdXNlcyB0aGUgNDgwIE1oeiBQTEwzIGNsb2NrCj4gZGlyZWN0bHkuIFRoaXMgaXMgc2lt
aWxhciB0byBvdGhlciBpbXg2IFNPQ3MuIFRoaXMgUExMIGlzIHVzZWQgZm9yCj4gc3R1ZmYgbGlr
ZSBVU0IgYnV0IG5vdCBvbmx5IHRoYXQuIE15IHVuZGVyc3RhbmRpbmcgaXMgdGhlIF9VU0JfT1RH
Cj4gc3VmZml4IGlzIGRlc2NyaXB0aXZlLCBzaW1pbGFyIHRvIFBMTDRfQVVESU8gYW5kIFBMTDZf
RU5FVC4gT3RoZXIgbm9uLQo+IHVzYiBjb21wb25lbnRzIHVzZSBQTEwzIChsaWtlIFVBUlQpIGJ1
dCB0aHJvdWdoIG90aGVyIGdhdGVzL2RpdmlkZXJzLgo+IAo+IFNldHRpbmcgdGhpcyB0b8KgSU1Y
NlVMX0NMS19EVU1NWSB3aWxsIGNhdXNlIHRlbXBlcmF0dXJlIHJlYWRzIHRvIGZhaWwuCj4gRXZl
biBpZiBQTEwzIHVzdWFsbHkgZW5kcyB1cCBiZWluZyBjb25zdGFudGx5IGVuYWJsZWQgYmVjYXVz
ZSBvZiB1YXJ0cwo+IHRoaXMgaXMgbm90IHRydWUgYXQgaW14X3RoZXJtYWxfcHJvYmUgdGltZSAo
b3IgdWFydHMgY2FuIGJlIGRpc2FibGVkKS4KPgpTaW5jZSB0aGUgZHJpdmVyIGlzIGFjY2Vzc2lu
ZyB0aGUgT0NPVFAgcmVnaXN0ZXJzIGl0IGRlZmluaXRlbHkgbmVlZHMKdGhlIElNWDZVTF9DTEtf
T0NPVFAgdG9vIQoKCkxvdGhhciBXYcOfbWFubgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
