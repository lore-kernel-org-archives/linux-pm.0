From: Ayan Kumar Halder <ayan.halder@arm.com>
Subject: [PATCH v3 0/5] Enhance support for system and runtime power
 management on malidp.
Date: Tue, 15 May 2018 17:04:14 +0100
Message-ID: <1526400259-7573-1-git-send-email-ayan.halder@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nd@arm.com
List-Id: linux-pm@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgZW5oYW5jZXMgYW5kIGZpeGVzIGNlcnRhaW4gaXNzdWVzIHJlbGV2
YW50IHRvIHN5c3RlbSBhbmQKcnVudGltZSBwb3dlciBtYW5hZ2VtZW50IG9uIG1hbGlkcC4KCi0t
LQpDaGFuZ2VzIGluIHYzOgotIFNxdWFzaGVkIHNvbWUgY29tbWl0cy4gCi0gRml4ZWQgYW4gaXNz
dWUgcmVsYXRlZCB0byB3cml0ZWJhY2suCiAgUmVwb3J0ZWQtYnk6IEFsZXhhbmRydS1Db3NtaW4g
R2hlb3JnaGUgPEFsZXhhbmRydS1Db3NtaW4uR2hlb3JnaGVAYXJtLmNvbT4KCkNoYW5nZXMgaW4g
djI6Ci0gUmVtb3ZlZCB0aGUgY2hhbmdlIGlkcyBhbmQgbW9kaWZpZWQgc29tZSBjb21taXQgbWVz
c2FnZXMKCi0tLQpBeWFuIEt1bWFyIEhhbGRlciAoNSk6CiAgZHJtL2FybS9tYWxpZHA6IE1vZGlm
aWVkIHRoZSBwcm90b3R5cGUgb2YgbWFsaWRwIGlycSBkZS1pbml0aWFsaXplcnMKICBkcm0vYXJt
L21hbGlkcDogU3BsaXQgbWFsaWRwIGludGVycnVwdCBpbml0aWFsaXphdGlvbiBmdW5jdGlvbnMu
CiAgZHJtL2FybS9tYWxpZHA6IEVuYWJsZS9kaXNhYmxlIGludGVycnVwdHMgaW4gcnVudGltZSBw
bQogIGRybS9hcm0vbWFsaWRwOiBTZXQgdGhlIG91dHB1dF9kZXB0aCByZWdpc3RlciBpbiBtb2Rl
c2V0CiAgZHJtL2FybS9tYWxpZHA6IEFkZGVkIHRoZSBsYXRlIHN5c3RlbSBwbSBmdW5jdGlvbnMK
CiBkcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9kcnYuYyB8IDM1ICsrKysrKysrKysrKysrKysr
KysrKysrLS0tLQogZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBfaHcuYyAgfCA1MiArKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYXJtL21h
bGlkcF9ody5oICB8ICA3ICsrKystLQogMyBmaWxlcyBjaGFuZ2VkLCA3MCBpbnNlcnRpb25zKCsp
LCAyNCBkZWxldGlvbnMoLSkKCi0tIAoyLjcuNApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwK
