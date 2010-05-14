From: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH 0/8] Suspend block api (version 7)
Date: Thu, 13 May 2010 21:11:05 -0700
Message-ID: <1273810273-3039-1-git-send-email-arve__458.401817786758$1273810330$gmane$org@android.com>
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
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBhIHN1c3BlbmQtYmxvY2sgYXBpIHRoYXQgcHJvdmlkZXMg
dGhlIHNhbWUKZnVuY3Rpb25hbGl0eSBhcyB0aGUgYW5kcm9pZCB3YWtlbG9jayBhcGkuIFRoaXMg
dmVyc2lvbiBoYXMgc29tZQpjaGFuZ2VzIGZyb20sIG9yIHJlcXVlc3RlZCBieSwgUmFmYWVsLiBU
aGUgbW9zdCBub3RhYmxlIGNoYW5nZXMgYXJlOgotIERFRklORV9TVVNQRU5EX0JMT0NLRVIgYW5k
IHN1c3BlbmRfYmxvY2tlcl9yZWdpc3RlciBoYXZlIGJlZW4gYWRkZWQKICBmb3Igc3RhdGljYWxs
eSBhbGxvY2F0ZWQgc3VzcGVuZCBibG9ja2Vycy4gCi0gc3VzcGVuZF9ibG9ja2VyX2Rlc3Ryb3kg
aXMgbm93IGNhbGxlZCBzdXNwZW5kX2Jsb2NrZXJfdW5yZWdpc3RlcgotIFRoZSB1c2VyIHNwYWNl
IG1hbmRhdG9yeSBfSU5JVCBpb2N0bCBoYXMgYmVlbiByZXBsYWNlZCB3aXRoIGFuCiAgb3B0aW9u
YWwgX1NFVF9OQU1FIGlvY3RsLgoKSSBrZXB0IHRoZSBhY2sgYW5kIHJldmlld2VkIGJ5IHRhZ3Mg
b24gdHdvIG9mIHRoZSBwYXRjaGVzIGV2ZW4gdGhvdWdoCnRoZXJlIHdlcmUgYSBmZXcgY29zbWV0
aWMgY2hhbmdlcy4KCi0tCkFydmUgSGrDuG5uZXbDpWcgPGFydmVAYW5kcm9pZC5jb20+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWls
aW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
