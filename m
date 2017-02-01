From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/2] drm/amdgpu: remove unnecessary save/restore of
 pdev->d3_delay
Date: Wed, 01 Feb 2017 10:22:18 -0600
Message-ID: <20170201162218.24314.91452.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170201162020.24314.27094.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170201162020.24314.27094.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
LW9mZi1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KQWNrZWQtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAgICA0IC0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYwppbmRleCA2MGJkNGFmZTQ1YzguLjNhNDAzYTg3ZWM2MiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMTA0MiwxNiArMTA0MiwxMiBAQCBzdGF0
aWMgdm9pZCBhbWRncHVfc3dpdGNoZXJvb19zZXRfc3RhdGUoc3RydWN0IHBjaV9kZXYgKnBkZXYs
IGVudW0gdmdhX3N3aXRjaGVybwogCQlyZXR1cm47CiAKIAlpZiAoc3RhdGUgPT0gVkdBX1NXSVRD
SEVST09fT04pIHsKLQkJdW5zaWduZWQgZDNfZGVsYXkgPSBkZXYtPnBkZXYtPmQzX2RlbGF5Owot
CiAJCXByaW50ayhLRVJOX0lORk8gImFtZGdwdTogc3dpdGNoZWQgb25cbiIpOwogCQkvKiBkb24n
dCBzdXNwZW5kIG9yIHJlc3VtZSBjYXJkIG5vcm1hbGx5ICovCiAJCWRldi0+c3dpdGNoX3Bvd2Vy
X3N0YXRlID0gRFJNX1NXSVRDSF9QT1dFUl9DSEFOR0lORzsKIAogCQlhbWRncHVfZGV2aWNlX3Jl
c3VtZShkZXYsIHRydWUsIHRydWUpOwogCi0JCWRldi0+cGRldi0+ZDNfZGVsYXkgPSBkM19kZWxh
eTsKLQogCQlkZXYtPnN3aXRjaF9wb3dlcl9zdGF0ZSA9IERSTV9TV0lUQ0hfUE9XRVJfT047CiAJ
CWRybV9rbXNfaGVscGVyX3BvbGxfZW5hYmxlKGRldik7CiAJfSBlbHNlIHsKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
