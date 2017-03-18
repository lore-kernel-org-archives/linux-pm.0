From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 1/2] dt-bindings: thermal: add support for Raspberry Pi thermal
Date: Sat, 18 Mar 2017 01:01:31 +0100
Message-ID: <20170318000132.9212-1-zajec5@gmail.com>
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
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Ray Jui <rjui@broadcom.com>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

RnJvbTogUmFmYcWCIE1pxYJlY2tpIDxyYWZhbEBtaWxlY2tpLnBsPgoKVGhpcyBjb21taXQgZG9j
dW1lbnRzIGJpbmRpbmcgZm9yIEJDTTI4MzUgU29DIHRoZXJtYWwgdXNlZCBpbiBSYXNwYmVycnkK
UGkgZGV2aWNlcy4KClNpZ25lZC1vZmYtYnk6IFJhZmHFgiBNacWCZWNraSA8cmFmYWxAbWlsZWNr
aS5wbD4KLS0tCiAuLi4vYmluZGluZ3MvdGhlcm1hbC9yYXNwYmVycnlwaSxiY20yODM1LXRoZXJt
YWwgICAgICAgIHwgMTcgKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3RoZXJtYWwvcmFzcGJlcnJ5cGksYmNtMjgzNS10aGVybWFsCgpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvcmFzcGJlcnJ5cGksYmNt
MjgzNS10aGVybWFsIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwv
cmFzcGJlcnJ5cGksYmNtMjgzNS10aGVybWFsCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAwMDAwMC4uZmJmZmE5MjkxYmE5Ci0tLSAvZGV2L251bGwKKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvcmFzcGJlcnJ5cGksYmNtMjgzNS10aGVybWFs
CkBAIC0wLDAgKzEsMTcgQEAKKyogQnJvYWRjb20gQkNNMjgzNSBTb0MgUmFzcGJlcnJ5IFBpIFRo
ZXJtYWwKKworVGhpcyBiaW5kaW5nIGRlc2NyaWJlcyB0aGVybWFsIHNlbnNvciB0aGF0IGlzIHBh
cnQgb2YgQkNNMjgzNSBTb0MuCisKK1JlcXVpcmVkIHByb3BlcnRpZXM6CistIGNvbXBhdGlibGUg
OiBNdXN0IGJlICJyYXNwYmVycnlwaSxiY20yODM1LXRoZXJtYWwiCistIGZpcm13YXJlIDogUmVm
ZXJlbmNlIHRvIHRoZSBSYXNwYmVycnkgUGkgZmlybXdhcmUgZGV2aWNlIG5vZGUsIHNlZQorCXJh
c3BiZXJyeXBpLGJjbTI4MzUtZmlybXdhcmUgZm9yIGRldGFpbHMKKy0gI3RoZXJtYWwtc2Vuc29y
LWNlbGxzIDogU2hvdWxkIGJlIDwwPgorCitFeGFtcGxlOgorCit0aGVybWFsIHsKKwljb21wYXRp
YmxlID0gInJhc3BiZXJyeXBpLGJjbTI4MzUtdGhlcm1hbCI7CisJZmlybXdhcmUgPSA8JmZpcm13
YXJlPjsKKwkjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MD47Cit9OwotLSAKMi4xMS4wCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
