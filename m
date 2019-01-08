From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 0/4] ARM: dts: s5pv210: Enable cpufreq support
Date: Tue,  8 Jan 2019 21:05:05 +0100
Message-ID: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
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
YXRjaCBlbmFibGVzIHJlcXVpcmVkIGtlcm5lbCBjb25maWcgb3B0aW9ucy4KClBhd2XFgiBDaG1p
ZWwgKDQpOgogIEFSTTogZHRzOiBzNXB2MjEwOiBBZGQgZG1jIG5vZGVzCiAgY3B1ZnJlcTogczVw
djIxMDogRG9uJ3QgZmxvb2Qga2VybmVsIGxvZyBhZnRlciBjcHVmcmVxIGNoYW5nZQogIGNwdWZy
ZXE6IHM1cHYyMTA6IERlZmVyIHByb2JlIGlmIGdldHRpbmcgcmVndWxhdG9ycyBmYWlsCiAgQVJN
OiBkZWZjb25maWc6IHM1cHYyMTA6IEFkZCBjcHVmcmVxIHN1cHBvcnQKCiBhcmNoL2FybS9ib290
L2R0cy9zNXB2MjEwLmR0c2kgICAgIHwgMTIgKysrKysrKysrKwogYXJjaC9hcm0vY29uZmlncy9z
NXB2MjEwX2RlZmNvbmZpZyB8ICA2ICsrKysrCiBkcml2ZXJzL2NwdWZyZXEvczVwdjIxMC1jcHVm
cmVxLmMgIHwgMzUgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAzIGZpbGVzIGNoYW5n
ZWQsIDM5IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
