From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH -mm] PM: fix 2.6.26-rc5-mm3 build error with
	CONFIG_PM_TEST_SUSPEND=y
Date: Sun, 15 Jun 2008 16:28:32 +0200
Message-ID: <1213540112-2918-1-git-send-email-righi.andrea__40946.0851028145$1213627738$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <>
References: <>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Andrea Righi <righi.andrea@gmail.com>, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

a2VybmVsL3Bvd2VyL21haW4uYzogSW4gZnVuY3Rpb24g4oCYdGVzdF9zdXNwZW5k4oCZOgprZXJu
ZWwvcG93ZXIvbWFpbi5jOjY4ODogd2FybmluZzogcGFzc2luZyBhcmd1bWVudCAyIG9mIOKAmGNs
YXNzX2ZpbmRfZGV2aWNl4oCZIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZQprZXJuZWwv
cG93ZXIvbWFpbi5jOjY4ODogZXJyb3I6IHRvbyBmZXcgYXJndW1lbnRzIHRvIGZ1bmN0aW9uIOKA
mGNsYXNzX2ZpbmRfZGV2aWNl4oCZCm1ha2VbMl06ICoqKiBba2VybmVsL3Bvd2VyL21haW4ub10g
RXJyb3IgMQptYWtlWzFdOiAqKiogW2tlcm5lbC9wb3dlcl0gRXJyb3IgMgptYWtlOiAqKiogW2tl
cm5lbF0gRXJyb3IgMgoKU2lnbmVkLW9mZi1ieTogQW5kcmVhIFJpZ2hpIDxyaWdoaS5hbmRyZWFA
Z21haWwuY29tPgotLS0KIGtlcm5lbC9wb3dlci9tYWluLmMgfCAgICAyICstCiAxIGZpbGVzIGNo
YW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJu
ZWwvcG93ZXIvbWFpbi5jIGIva2VybmVsL3Bvd2VyL21haW4uYwppbmRleCBlOTM3Y2M4Li4yYmYz
ZDViIDEwMDY0NAotLS0gYS9rZXJuZWwvcG93ZXIvbWFpbi5jCisrKyBiL2tlcm5lbC9wb3dlci9t
YWluLmMKQEAgLTY4NSw3ICs2ODUsNyBAQCBzdGF0aWMgaW50IF9faW5pdCB0ZXN0X3N1c3BlbmQo
dm9pZCkKIAl9CiAKIAkvKiBSVENzIGhhdmUgaW5pdGlhbGl6ZWQgYnkgbm93IHRvbyAuLi4gY2Fu
IHdlIHVzZSBvbmU/ICovCi0JY2xhc3NfZmluZF9kZXZpY2UocnRjX2NsYXNzLCAmcG9ueSwgaGFz
X3dha2VhbGFybSk7CisJY2xhc3NfZmluZF9kZXZpY2UocnRjX2NsYXNzLCBOVUxMLCAmcG9ueSwg
aGFzX3dha2VhbGFybSk7CiAJaWYgKHBvbnkpCiAJCXJ0YyA9IHJ0Y19jbGFzc19vcGVuKHBvbnkp
OwogCWlmICghcnRjKSB7Ci0tIAoxLjUuNC4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
