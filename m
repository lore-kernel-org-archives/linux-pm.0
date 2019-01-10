From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 0/4] ARM: dts: s5pv210: Enable cpufreq support
Date: Thu, 10 Jan 2019 21:52:11 +0100
Message-ID: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kgene@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux@armlinux.org.uk, krzk@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-pm@vger.kernel.org

VGhpcyBwYXRjaHNldCBlbmFibGVzIGNwdWZyZXEgc3VwcG9ydCB1c2luZyBzNXB2MjEwLWNwdWZy
ZXEgZHJpdmVyLgoKRmlyc3QgcGF0Y2ggYWRkcyBtaXNzaW5nIGRtYyBub2Rlcywgd2hpY2ggYXJl
IHJlcXVpcmVkIGJ5IGRyaXZlci4KClNlY29uZCBwYXRjaCBpcyBjb3NtZXRpYywgaXQgc3RvcHMg
ZHJpdmVyIGZyb20gZmxvb2Rpbmcga2VybmVsIGxvZyB3aXRoCiBtZXNzYWdlcywgYWZ0ZXIgZXZl
cnkgY2hhbmdlIG9mIGZyZXEuCgpUaGlyZCBwYXRjaCBhZGRzIGRlZmVyIHByb2JlIHN1cHBvcnQg
Zm9yIHJlZ3VsYXRvcnMsIG5lZWRlZCBieSBkcml2ZXIuCkl0IHdhcyBvYnNlcnZlZCwgdGhhdCB0
aG9zZSByZWd1bGF0b3JzIGNhbiBiZSBubyB5ZXQgaW5pdGlhbGl6ZWQsIHdoZW4KIGRyaXZlciBp
cyBwcm9iZWQsIHNvIHdlIHNob3VsZCB3YWl0IHRpbGwgd2UgY2FuIGdldCB0aGVtLgoKTGFzdCBw
YXRjaCBlbmFibGVzIHJlcXVpcmVkIGtlcm5lbCBjb25maWcgb3B0aW9ucy4KCkNoYW5nZXMgZnJv
bSB2MToKICAtIEFkZGVkIEFja2VkLWJ5IHRvIG9uZSBvZiBwYXRjaGVzCiAgLSBGaXggY29tcGls
YXRpb24gZXJyb3IgYWZ0ZXIgY2hhbmdlcyBpbiBkcml2ZXIKICAtIFJlb3JnYW5pemUgY29kZSAo
c28gaXQncyBzbWFsbGVyKSwgaW5zaWRlIHBhdGNoIHdoaWNoIGxvZ3MgaW5mb3JtYXRpb24KICAg
IGFib3V0IGRlZmVyZWQgcHJvYmUgb2YgcmVndWxhdG9ycwoKUGF3ZcWCIENobWllbCAoNCk6CiAg
QVJNOiBkdHM6IHM1cHYyMTA6IEFkZCBkbWMgbm9kZXMKICBjcHVmcmVxOiBzNXB2MjEwOiBEb24n
dCBmbG9vZCBrZXJuZWwgbG9nIGFmdGVyIGNwdWZyZXEgY2hhbmdlCiAgY3B1ZnJlcTogczVwdjIx
MDogRGVmZXIgcHJvYmUgaWYgZ2V0dGluZyByZWd1bGF0b3JzIGZhaWwKICBBUk06IGRlZmNvbmZp
ZzogczVwdjIxMDogQWRkIGNwdWZyZXEgc3VwcG9ydAoKIGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYy
MTAuZHRzaSAgICAgfCAxMiArKysrKysrKysrKwogYXJjaC9hcm0vY29uZmlncy9zNXB2MjEwX2Rl
ZmNvbmZpZyB8ICA2ICsrKysrKwogZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jICB8
IDM0ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAzOCBp
bnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCi0tIAoyLjE3LjEKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
