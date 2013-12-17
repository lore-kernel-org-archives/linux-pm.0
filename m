From: "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>
Subject: Re: [PATCH V2 2/2] cpufreq: imx6q: correct VDDSOC/PU voltage
 scaling when cpufreq is changed
Date: Tue, 17 Dec 2013 13:27:13 +0000
Message-ID: <4E25F2ED-7CAE-495E-838D-1527184F2159@freescale.com>
References: <1387318102-11070-1-git-send-email-b20788@freescale.com>
 <1387318102-11070-2-git-send-email-b20788@freescale.com>,<20131217132312.GB3185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20131217132312.GB3185@sirena.org.uk>
Content-Language: zh-CN
Sender: cpufreq-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

DQoNClNlbnQgZnJvbSBBbnNvbidzIGlQaG9uZQ0KDQo+INTaIDIwMTPE6jEy1MIxN8jVo6wyMToy
M6OsIk1hcmsgQnJvd24iIDxicm9vbmllQGtlcm5lbC5vcmc+INC0tcCjug0KPiANCj4+IE9uIFR1
ZSwgRGVjIDE3LCAyMDEzIGF0IDA1OjA4OjIyUE0gLTA1MDAsIEFuc29uIEh1YW5nIHdyb3RlOg0K
Pj4gDQo+PiAgICBpZiAobmV3X2ZyZXEgPiBvbGRfZnJlcSkgew0KPj4gKyAgICAgICAgaWYgKHJl
Z3VsYXRvcl9pc19lbmFibGVkKHB1X3JlZykpIHsNCj4+ICsgICAgICAgICAgICByZXQgPSByZWd1
bGF0b3Jfc2V0X3ZvbHRhZ2VfdG9sKHB1X3JlZywgaW14Nl9zb2Nfdm9sdFtpbmRleF0sIDApOw0K
PiANCj4gQXMgSSBwb2ludGVkIG91dCB3aGlsZSByZXZpZXdpbmcgdGhlIHJlZ3VsYXRvciBkcml2
ZXIgdGhpcyBpcyByYWN5LA0KPiBub3RoaW5nIHN0b3BzIHRoZSByZWd1bGF0b3Igc3RhdGUgYmVp
bmcgY2hhbmdlZCBhZnRlciB5b3UgcmVhZCBpdCBhbmQgaWYNCj4geW91IHNraXAgc2V0dGluZyB0
aGUgdm9sdGFnZSB0aGVuIHdoZW4gc29tZXRoaW5nIGNvbWVzIGFsb25nIGFuZCBlbmFibGVzDQo+
IHRoZSByZWd1bGF0b3IgbGF0ZXIgaXQgd2lsbCBiZSBlbmFibGVkIHdpdGggYSBwb3NzaWJseSBp
bmNvcnJlY3QNCj4gdm9sdGFnZS4NCg0KeWVzLCB5b3UgYXJlIGNvcnJlY3QsIEkgd2lsbCByZW1v
dmUgdGhpcyBQVSBzdGF0dXMgY2hlY2sgaW4gVjMgcGF0Y2guDQoNCkFuc29u
