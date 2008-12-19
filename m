From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 0/3] pm: device parallel resume mechanism
Date: Fri, 19 Dec 2008 14:34:08 +0800
Message-ID: <1229668448.562.88.camel__14849.238159559$1229668688$gmane$org@rzhang-dt>
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
To: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org
Cc: "Barnes, Jesse" <jesse.barnes@intel.com>
List-Id: linux-pm@vger.kernel.org

77u/SGksIGFsbCwKCu+7v1RoZSByZXN1bWUgcHJvY2VzcyBjYW4gYmUgc3BsaXQgaW50byAzIHBh
cnRzLCBCSU9TIHJlc3VtZSB0aW1lLCBrZXJuZWwKcmVzdW1lIHRpbWUgYW5kIFgvYXBwbGljYXRp
b24gcmVzdW1lIHRpbWUuCkFuZCBkZXZpY2UgcmVzdW1lIHRha2VzIG1vc3Qgb2YgdGhlIGtlcm5l
bCByZXN1bWUgdGltZS4KdGhpcyBwYXRjaCBzZXQgaW50cm9kdWNlcyBhIG5ldyBtZWNoYW5pc20g
dG8gcmVzdW1lIGRldmljZSBpbiBwYXJhbGxlbAp3aGljaCBjYW4gcmVkdWNlIHRoZSBkZXZpY2Ug
cmVzdW1lIHRpbWUgYSBsb3QuCgpJbiB0aGlzIHByb3Bvc2FsLCBzb21lIGRldmljZXMgY2FuIGNy
ZWF0ZSBpdHMgb3duIHdvcmtxdWV1ZSBmb3IKcGFyYWxsZWwgcmVzdW1lLiBBbmQgZm9yIGFsbCB0
aGUgb3RoZXIgZGV2aWNlcyB0aGF0IGRlcGVuZHMgb24gdGhpcwpkZXZpY2UsIHRoZWlyIHJlc3Vt
ZSBtZXRob2RzIGFyZSBxdWV1ZWQgaW4gdGhlIHNhbWUgd29ya3F1ZXVlLgpBbmQgd2UgZmx1c2gg
YWxsIHRoZSB3b3JrcXVldWVzIGJlZm9yZSByZXN1bWluZyBYL2FwcGxpY2F0aW9ucy4KCkFzIHRo
ZSBkZXZpY2VzIHZhcnkgZnJvbSBkaWZmZXJlbnQgcGxhdGZvcm1zLiBpdCdzIGhhcmQgdG8gZ2l2
ZSBhbiBleGFjdApudW1iZXIgb2YgaG93IG11Y2ggdGltZSBpdCBjYW4gcmVkdWNlLgpIZXJlIGFy
ZSBzb21lIG9mIG15IHRlc3QgcmVzdWx0czoKMS4gZWVlcGM5MDEsIGtlcm5lbCByZXN1bWUgdGlt
ZSBjYW4gYmUgcmVkdWNlZCBmcm9tIGFib3V0IDIuMSBzZWNvbmRzIHRvCjEuNiBzZWNvbmRzLgoy
LiBhIFNhbnRhUm9zYSB0ZXN0Ym94LCBrZXJuZWwgcmVzdW1lIHRpbWUgY2FuIGJlIHJlZHVjZWQg
ZnJvbSBhYm91dAozLjVzIHRvIDJzLgoKcGxlYXNlIHJldmlldyB0aGlzIHBhdGNoLiBBbnkgY29t
bWVudHMgYXJlIHdlbGNvbWUuIDopCgp0aGFua3MsCnJ1aQoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1w
bUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
