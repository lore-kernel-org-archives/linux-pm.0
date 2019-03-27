From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
Subject: [PATCH] cpufreq: scpi: fix use after free
Date: Wed, 27 Mar 2019 23:06:42 +0100
Message-ID: <20190327220642.8117-1-vincent.stehle@laposte.net>
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
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
List-Id: linux-pm@vger.kernel.org

RnJlZSB0aGUgcHJpdiBzdHJ1Y3R1cmUgb25seSBhZnRlciB3ZSBhcmUgZG9uZSB1c2luZyBpdC4K
CkZpeGVzOiAxNjkwZDhiYjkxZTM3MGFiICgiY3B1ZnJlcTogc2NwaS9zY21pOiBGaXggZnJlZWlu
ZyBvZiBkeW5hbWljIE9QUHMiKQpTaWduZWQtb2ZmLWJ5OiBWaW5jZW50IFN0ZWhsw6kgPHZpbmNl
bnQuc3RlaGxlQGxhcG9zdGUubmV0PgpDYzogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJt
LmNvbT4KQ2M6ICJSYWZhZWwgSi4gV3lzb2NraSIgPHJqd0Byand5c29ja2kubmV0PgpDYzogVmly
ZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2NwdWZyZXEv
c2NwaS1jcHVmcmVxLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvc2NwaS1jcHVmcmVxLmMg
Yi9kcml2ZXJzL2NwdWZyZXEvc2NwaS1jcHVmcmVxLmMKaW5kZXggM2Y0OTQyNzc2NmI4OC4uMmI1
MWUwNzE4YzlmNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jcHVmcmVxL3NjcGktY3B1ZnJlcS5jCisr
KyBiL2RyaXZlcnMvY3B1ZnJlcS9zY3BpLWNwdWZyZXEuYwpAQCAtMTg5LDggKzE4OSw4IEBAIHN0
YXRpYyBpbnQgc2NwaV9jcHVmcmVxX2V4aXQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kp
CiAKIAljbGtfcHV0KHByaXYtPmNsayk7CiAJZGV2X3BtX29wcF9mcmVlX2NwdWZyZXFfdGFibGUo
cHJpdi0+Y3B1X2RldiwgJnBvbGljeS0+ZnJlcV90YWJsZSk7Ci0Ja2ZyZWUocHJpdik7CiAJZGV2
X3BtX29wcF9yZW1vdmVfYWxsX2R5bmFtaWMocHJpdi0+Y3B1X2Rldik7CisJa2ZyZWUocHJpdik7
CiAKIAlyZXR1cm4gMDsKIH0KLS0gCjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
