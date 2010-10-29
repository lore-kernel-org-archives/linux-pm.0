From: Kevin Winchester <kjwinchester@gmail.com>
Subject: [PATCH] power: Fix typo in status comparison causing
	warning
Date: Thu, 28 Oct 2010 21:29:52 -0300
Message-ID: <1288312192-28909-1-git-send-email-kjwinchester__15199.7026442134$1288312318$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>Pavel Machek <pavel@ucw.cz>"Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Winchester <kjwinchester@gmail.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

R0NDIHZlcnNpb24gNC41LjEgZ2l2ZXMgdGhlIGZvbGxvd2luZyB3YXJuaW5nOgoKCWRyaXZlcnMv
YmFzZS9wb3dlci9ydW50aW1lLmM6IEluIGZ1bmN0aW9uIOKAmHJwbV9jaGVja19zdXNwZW5kX2Fs
bG93ZWTigJk6Cglkcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jOjE0NjoyNTogd2FybmluZzog
Y29tcGFyaXNvbiBiZXR3ZWVuIOKAmGVudW0gZHBtX3N0YXRl4oCZIGFuZCDigJhlbnVtIHJwbV9z
dGF0dXPigJkKCndoaWNoIHNlZW1zIHRvIGJlIGEgdHlwbyBpbiB0aGF0IGRldi0+cG93ZXIucnVu
dGltZV9zdGF0dXMKc2hvdWxkIGJlIGNvbXBhcmVkIGluc3RlYWQgb2YgZGV2LT5wb3dlci5zdGF0
dXMuCgpTaWduZWQtb2ZmLWJ5OiBLZXZpbiBXaW5jaGVzdGVyIDxrandpbmNoZXN0ZXJAZ21haWwu
Y29tPgotLS0KIGRyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMgfCAgICAyICstCiAxIGZpbGVz
IGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jIGIvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUu
YwppbmRleCAxMjZjYTQ5Li4wMmM2NTJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIv
cnVudGltZS5jCisrKyBiL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMKQEAgLTE0Myw3ICsx
NDMsNyBAQCBzdGF0aWMgaW50IHJwbV9jaGVja19zdXNwZW5kX2FsbG93ZWQoc3RydWN0IGRldmlj
ZSAqZGV2KQogCiAJLyogUGVuZGluZyByZXN1bWUgcmVxdWVzdHMgdGFrZSBwcmVjZWRlbmNlIG92
ZXIgc3VzcGVuZHMuICovCiAJZWxzZSBpZiAoKGRldi0+cG93ZXIuZGVmZXJyZWRfcmVzdW1lCi0J
CQkmJiBkZXYtPnBvd2VyLnN0YXR1cyA9PSBSUE1fU1VTUEVORElORykKKwkJCSYmIGRldi0+cG93
ZXIucnVudGltZV9zdGF0dXMgPT0gUlBNX1NVU1BFTkRJTkcpCiAJICAgIHx8IChkZXYtPnBvd2Vy
LnJlcXVlc3RfcGVuZGluZwogCQkJJiYgZGV2LT5wb3dlci5yZXF1ZXN0ID09IFJQTV9SRVFfUkVT
VU1FKSkKIAkJcmV0dmFsID0gLUVBR0FJTjsKLS0gCjEuNy4zLjIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51
eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
