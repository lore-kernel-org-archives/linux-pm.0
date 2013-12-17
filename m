From: "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>
Subject: Re: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
Date: Tue, 17 Dec 2013 12:26:12 +0000
Message-ID: <D8D77E89-793D-4A52-AB38-769BC47BAF33@freescale.com>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
 <20131217025616.GC6691@S2101-09.ap.freescale.net>
 <20131217105347.75954ad3@ipc1.ka-ro>,
 <20131217121358.GM6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131217121358.GM6691@S2101-09.ap.freescale.net>
Content-Language: zh-CN
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
List-Id: linux-pm@vger.kernel.org

DQoNClNlbnQgZnJvbSBBbnNvbidzIGlQaG9uZQ0KDQo+IOWcqCAyMDEz5bm0MTLmnIgxN+aXpe+8
jDIwOjEz77yMIlNoYXduIEd1byIgPHNoYXduLmd1b0BsaW5hcm8ub3JnPiDlhpnpgZPvvJoNCj4g
DQo+IE9uIFR1ZSwgRGVjIDE3LCAyMDEzIGF0IDEwOjUzOjQ3QU0gKzAxMDAsIExvdGhhciBXYcOf
bWFubiB3cm90ZToNCj4+Pj4gKyAgICBpZiAoc29jX29wcF9pbmRleCA+PSBzb2Nfb3BwX2NvdW50
KSB7DQo+Pj4gDQo+Pj4gQ2FuIHNvY19vcHBfaW5kZXggYmUgcG9zc2libHkgZ3JlYXRlciB0aGFu
IHNvY19vcHBfY291bnQ/ICBPdGhlcndpc2UsDQo+Pj4gdGhlIGNvbmRpdGlvbiBjaGVjayBiZWxv
dyBpcyBnb29kIGVub3VnaD8NCj4+PiANCj4+PiAgICBpZiAoc29jX29wcF9pbmRleCA9PSBzb2Nf
b3BwX2NvdW50KQ0KPj4gaXQgZG9lbid0IGhhcm0gdG8gYmUgb24gdGhlIHNhZmUgc2lkZSBhbmQg
dXNlID49IGFueXdheSENCj4gDQo+IFdlbGwsIGl0IG1heSBjb25mdXNlIHJlYWRlci4gIEF0IGxl
YXN0LCBpdCB0b29rIG1lIHNvbWUgdGltZSB1bmRlcnN0YW5kDQo+IGhvdyB0aGF0ICI+IiBjb25k
aXRpb24gd2lsbCBoYXBwZW4uICBBbmQgaXQgdHVybnMgb3V0IG5ldmVyLg0KDQppdCBkb2VzIG5v
dCBtYXR0ZXIgbm93LCBzaW5jZSBpbiBWMiBwYXRjaCwgaSB1c2UgaW5kZXggcGFzc2VkIGZyb20N
CmZyZXEgdGFibGUsIG5vIG5lZWQgdG8gbG9vayB1cCB0aGUgc29jIG9wcC4gcGxlYXNlIGhlbHAg
cmV2aWV3IFYyIHBhdGNoIHNldCwgdGhhbmtzLg0KDQpBbnNvbi4NCg0KDQo+IA0KPiBTaGF3bg0K
PiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
