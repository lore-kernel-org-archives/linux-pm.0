From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 1/2] drm/amdgpu: remove unnecessary save/restore of
 pdev->d3_delay
Date: Mon, 30 Jan 2017 14:40:59 -0600
Message-ID: <20170130204059.31891.74930.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170130203822.31891.22461.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170130203822.31891.22461.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?b?S8O2bmln?= <christian.koenig@amd.com>
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Maarten Lankhorst <maarten.lankhorst@canonical.com>
List-Id: linux-pm@vger.kernel.org

UmVtb3ZlIHVubmVjZXNzYXJ5IHNhdmUvcmVzdG9yZSBvZiBwZGV2LT5kM19kZWxheS4KClRoZSBv
bmx5IGFzc2lnbm1lbnRzIHRvIHBkZXYtPmQzX2RlbGF5IGFyZSBpbiByYWRlb25fc3dpdGNoZXJv
b19zZXRfc3RhdGUoKQphbmQgc29tZSBxdWlya3MsIG5vbmUgb2Ygd2hpY2ggc2hvdWxkIGJlIHJl
bGV2YW50IGluIHRoZQphbWRncHVfc3dpdGNoZXJvb19zZXRfc3RhdGUoKSBwYXRoLgoKU2lnbmVk
LW9mZi1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAgICA0IC0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYwppbmRleCA2MGJkNGFmZTQ1YzguLjNhNDAzYTg3ZWM2MiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMTA0MiwxNiArMTA0MiwxMiBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfc3dpdGNoZXJvb19zZXRfc3RhdGUoc3RydWN0IHBjaV9kZXYg
KnBkZXYsIGVudW0gdmdhX3N3aXRjaGVybwogCQlyZXR1cm47CiAKIAlpZiAoc3RhdGUgPT0gVkdB
X1NXSVRDSEVST09fT04pIHsKLQkJdW5zaWduZWQgZDNfZGVsYXkgPSBkZXYtPnBkZXYtPmQzX2Rl
bGF5OwotCiAJCXByaW50ayhLRVJOX0lORk8gImFtZGdwdTogc3dpdGNoZWQgb25cbiIpOwogCQkv
KiBkb24ndCBzdXNwZW5kIG9yIHJlc3VtZSBjYXJkIG5vcm1hbGx5ICovCiAJCWRldi0+c3dpdGNo
X3Bvd2VyX3N0YXRlID0gRFJNX1NXSVRDSF9QT1dFUl9DSEFOR0lORzsKIAogCQlhbWRncHVfZGV2
aWNlX3Jlc3VtZShkZXYsIHRydWUsIHRydWUpOwogCi0JCWRldi0+cGRldi0+ZDNfZGVsYXkgPSBk
M19kZWxheTsKLQogCQlkZXYtPnN3aXRjaF9wb3dlcl9zdGF0ZSA9IERSTV9TV0lUQ0hfUE9XRVJf
T047CiAJCWRybV9rbXNfaGVscGVyX3BvbGxfZW5hYmxlKGRldik7CiAJfSBlbHNlIHsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
