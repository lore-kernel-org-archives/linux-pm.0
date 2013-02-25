From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: [PATCH v2] cpufreq: highbank: do not initialize array with a loop
Date: Mon, 25 Feb 2013 07:53:47 -0600
Message-ID: <512B6CEB.1030203@calxeda.com>
References: <1361725277-5125-1-git-send-email-emilio@elopez.com.ar>
 <1361790465-21760-1-git-send-email-emilio@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1361790465-21760-1-git-send-email-emilio@elopez.com.ar>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

T24gMDIvMjUvMjAxMyAwNTowNyBBTSwgRW1pbGlvIEzDs3BleiB3cm90ZToKPiBBcyB1bmluaXRp
YWxpemVkIGFycmF5IG1lbWJlcnMgd2lsbCBiZSBpbml0aWFsaXplZCB0byB6ZXJvLCB3ZSBjYW4K
PiBhdm9pZCB1c2luZyBhIGZvciBsb29wIGJ5IHNldHRpbmcgYSB2YWx1ZSB0byBpdC4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBFbWlsaW8gTMOzcGV6IDxlbWlsaW9AZWxvcGV6LmNvbS5hcj4KPiAtLS0K
PiAKPiBOb3RlIHRoYXQgSSBkb24ndCBvd24gYW55IGRldmljZSB1c2luZyB0aGlzIGRyaXZlciwg
aXQgaGFzIG9ubHkgYmVlbiBjb21waWxlCj4gdGVzdGVkLCBidXQgaXQgc2hvdWxkbid0IGNhdXNl
IGFueSBpc3N1ZXMuCj4gCj4gQ2hhbmdlcyB2MSAtPiB2MjoKPiAgICogTW92ZSBmcmVxIC8gMTAw
MDAwMCB0byB0aGUgYXJyYXkgZGVmaW5pdGlvbiBhcyBzdWdnZXN0ZWQgYnkgVmlyZXNoIEt1bWFy
Cj4gCj4gIGRyaXZlcnMvY3B1ZnJlcS9oaWdoYmFuay1jcHVmcmVxLmMgfCA4ICstLS0tLS0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNyBkZWxldGlvbnMoLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2hpZ2hiYW5rLWNwdWZyZXEuYyBiL2RyaXZlcnMvY3B1
ZnJlcS9oaWdoYmFuay1jcHVmcmVxLmMKPiBpbmRleCA2NmUzYTcxLi5iNjFiNWEzIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9oaWdoYmFuay1jcHVmcmVxLmMKPiArKysgYi9kcml2ZXJz
L2NwdWZyZXEvaGlnaGJhbmstY3B1ZnJlcS5jCj4gQEAgLTI4LDEzICsyOCw3IEBACj4gIAo+ICBz
dGF0aWMgaW50IGhiX3ZvbHRhZ2VfY2hhbmdlKHVuc2lnbmVkIGludCBmcmVxKQo+ICB7Cj4gLQlp
bnQgaTsKPiAtCXUzMiBtc2dbSEJfQ1BVRlJFUV9JUENfTEVOXTsKPiAtCj4gLQltc2dbMF0gPSBI
Ql9DUFVGUkVRX0NIQU5HRV9OT1RFOwo+IC0JbXNnWzFdID0gZnJlcSAvIDEwMDAwMDA7Cj4gLQlm
b3IgKGkgPSAyOyBpIDwgSEJfQ1BVRlJFUV9JUENfTEVOOyBpKyspCj4gLQkJbXNnW2ldID0gMDsK
PiArCXUzMiBtc2dbSEJfQ1BVRlJFUV9JUENfTEVOXSA9IHtIQl9DUFVGUkVRX0NIQU5HRV9OT1RF
LCBmcmVxIC8gMTAwMDAwMH07Cj4gIAo+ICAJcmV0dXJuIHBsMzIwX2lwY190cmFuc21pdChtc2cp
Owo+ICB9Cj4gClRoYW5rcyBmb3IgdGhlIGltcHJvdmVtZW50LgoKQWNrZWQtQnk6IE1hcmsgTGFu
Z3Nkb3JmIDxtYXJrLmxhbmdzZG9yZkBjYWx4ZWRhLmNvbT4KCi0tTWFyayBMYW5nc2RvcmYKQ2Fs
eGVkYSwgSW5jLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
